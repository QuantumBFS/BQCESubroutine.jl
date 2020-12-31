macro _threads(ex)
    return quote
        if (Threads.nthreads() > 1) && (length(st) > 4096)
            $(Expr(:macrocall, Expr(:(.), :Threads, QuoteNode(Symbol("@threads"))), __source__, ex))
        else
            $ex
        end
    end |> esc
end

for N in [8, 16, 32, 64, 128]
    T = Symbol(:Int, N)
    UT = Symbol(:UInt, N)
    @eval begin
        log2i(x::$T) =
            !signbit(x) ? ($(N - 1) - leading_zeros(x)) :
            throw(ErrorException("nonnegative expected ($x)"))
        log2i(x::$UT) = $(N - 1) - leading_zeros(x)
    end
end

bmask(args...) = bmask(Int, args...)
bmask(::Type{T}) where {T<:Integer} = zero(T)
bmask(::Type{T}, positions::Int...) where {T<:Integer} = bmask(T, positions)

function bmask(::Type{T}, itr) where {T<:Integer}
    isempty(itr) && return 0
    ret = zero(T)
    for b in itr
        ret += one(T) << (b - 1)
    end
    return ret
end

@inline function bmask(::Type{T}, range::UnitRange{Int})::T where {T<:Integer}
    ((one(T) << (range.stop - range.start + 1)) - one(T)) << (range.start - 1)
end

@inline lmove(b::Int, mask::Int, k::Int)::Int = (b & ~mask) << k + (b & mask)

@inline function _group_shift(masks::Vector{Int}, shift_len::Vector{Int}, k::Int, k_prv::Int)
    # if current position in the contiguous region
    # since these bits will be moved together with
    # the first one, we don't need to generate a
    # new mask
    if k == k_prv + 1
        shift_len[end] += 1
    else
        # we generate a bit mask where the 1st to k-th bits are 1
        push!(masks, bmask(0:k-1))
        push!(shift_len, 1)
    end
end

@inline function group_shift(locations)
    masks = Int[]
    shift_len = Int[]
    k_prv = -1
    for k in locations
        _group_shift(masks, shift_len, k, k_prv)
        k_prv = k
    end
    return masks, shift_len
end

@inline function complement_group_shift(n::Int, locations)
    masks = Int[]
    shift_len = Int[]
    k_prv = -1
    for k in 1:n
        k in locations && continue
        _group_shift(masks, shift_len, k, k_prv)
        k_prv = k
    end
    return masks, shift_len
end

struct BitSubspace
    n::Int # number of bits in fullspace
    sz_subspace::Int # size of the subspace
    n_shifts::Int # number of shifts
    masks::Vector{Int} # shift masks
    shift_len::Vector{Int} # length of each shift
end

function Base.getindex(s::BitSubspace, i::Int)
    index = i - 1
    @inbounds for k in 1:s.n_shifts
        index = lmove(index, s.masks[k], s.shift_len[k])
    end
    return index
end

Base.firstindex(s::BitSubspace) = 1
Base.lastindex(s::BitSubspace) = s.sz_subspace
Base.length(s::BitSubspace) = s.sz_subspace
Base.eltype(::BitSubspace) = Int

function Base.iterate(s::BitSubspace, st::Int = 1)
    st <= length(s) || return
    return s[st], st + 1
end

function bsubspace(n::Int, locs)
    @assert issorted(locs)
    masks, shift_len = group_shift(locs)
    BitSubspace(n, 1 << (n - length(locs)), length(masks), masks, shift_len)
end

function bcomspace(n::Int, locs)
    @assert issorted(locs)
    masks, shift_len = complement_group_shift(n, locs)
    BitSubspace(n, 1 << length(locs), length(masks), masks, shift_len)
end

log2dim1(x) = log2i(size(x, 1))

function broutine!(st::AbstractVector, U::AbstractMatrix, locs::NTuple{N, Int}) where N
    n = log2dim1(st)
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    indices = [idx + 1 for idx in comspace]
    for k in subspace
        idx = indices .+ k
        st[idx] = U * st[idx]
    end
    return st
end

function Base.show(io::IO, ::MIME"text/plain", s::BitSubspace)
    indent = get(io, :indent, 0)
    println(io, " "^indent, s.sz_subspace, "-element BitSubspace:")
    if s.sz_subspace < 5
        for k in 1:s.sz_subspace
            print(io, " "^(indent+1), string(s[k]; base=2, pad=s.n))
            if k != s.sz_subspace
                println(io)
            end
        end
    else # never print more than 4 elements
        println(io, " "^(indent+1), string(s[1]; base=2, pad=s.n))
        println(io, " "^(indent+1), string(s[2]; base=2, pad=s.n))
        println(io, " "^(indent+1), "⋮")
        println(io, " "^(indent+1), string(s[end-1]; base=2, pad=s.n))
        print(io, " "^(indent+1), string(s[end]; base=2, pad=s.n))
    end
end

function subspace_mul!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    # pretend this is deleted
    # if size(U, 1) == 2
    #     subspace_mul2x2!(st, comspace, U, subspace, offset)
    # else
    if size(U, 1) == 4
        subspace_mul4x4!(st, comspace, U, subspace, offset)
    elseif size(U, 1) == 8
        subspace_mul8x8!(st, comspace, U, subspace, offset)
    else
        subspace_mul_generic!(st, comspace, U, subspace, offset)
    end
    return st
end

# pretend this is deleted
# function subspace_mul2x2!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
#     indices_1 = comspace[1] + 1
#     indices_2 = comspace[2] + 1
#     @inbounds for k in subspace
#         idx_1 = indices_1 + k + offset
#         idx_2 = indices_2 + k + offset

#         T1 = U[1, 1] * st[idx_1] + U[1, 2] * st[idx_2]
#         T2 = U[2, 1] * st[idx_1] + U[2, 2] * st[idx_2]

#         st[idx_1] = T1
#         st[idx_2] = T2
#     end
#     return st
# end

function subspace_mul4x4!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end

    for k in subspace
        Base.Cartesian.@nextract 4 idx i-> k + indices_i + offset

        Base.Cartesian.@nexprs 4 i -> begin
            y_i = zero(T)
            Base.Cartesian.@nexprs 4 j -> begin
                y_i += U_i_j * st[idx_j]
            end
        end

        Base.Cartesian.@nexprs 4 i -> begin
            st[idx_i] = y_i
        end
    end
    return st
end

function subspace_mul8x8!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    Base.Cartesian.@nextract 8 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 8 U i->begin
        Base.Cartesian.@nextract 8 U_i j->U[i, j]
    end

    @inbounds for k in subspace
        Base.Cartesian.@nextract 8 idx i-> k + indices_i + offset

        Base.Cartesian.@nexprs 8 i -> begin
            y_i = zero(T)
            Base.Cartesian.@nexprs 8 j -> begin
                y_i += U_i_j * st[idx_j]
            end
        end

        Base.Cartesian.@nexprs 8 i -> begin
            st[idx_i] = y_i
        end
    end
    return st
end

function subspace_mul_generic!(st::AbstractVector{T}, indices, U, subspace, offset=0) where T
    y = similar(st, (size(U, 1), ))
    idx = similar(indices)

    @inbounds for k in subspace
        for i in 1:size(U, 1)
            idx[i] = indices[i] + k + offset
        end

        for i in 1:size(U, 1)
            y[i] = zero(T)
            for j in 1:size(U, 2)
                y[i] += U[i, j] * st[idx[j]]
            end
        end

        for i in 1:size(U, 1)
            st[idx[i]] = y[i]
        end
    end
    return st
end

function broutine2x2!(st::AbstractVector{T}, U::AbstractMatrix, locs::Tuple{Int}) where T
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    step_1 = 1 << (first(locs) - 1)
    step_2 = 1 << first(locs)

    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 1)-step_1
            ST1 = U11 * st[j + 1] + U12 * st[j + 1 + step_1]
            ST2 = U21 * st[j + 1] + U22 * st[j + 1 + step_1]

            st[j + 1] = ST1
            st[j + 1 + step_1] = ST2
        end
    elseif step_1 == 2
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 2 i->begin
                ST1 = U11 * st[j + i] + U12 * st[j + i + step_1]
                ST2 = U21 * st[j + i] + U22 * st[j + i + step_1]
                st[j + i] = ST1
                st[j + i + step_1] = ST2    
            end
        end
    elseif step_1 == 4
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 4 i->begin
                ST1 = U11 * st[j + i] + U12 * st[j + i + step_1]
                ST2 = U21 * st[j + i] + U22 * st[j + i + step_1]
                st[j + i] = ST1
                st[j + i + step_1] = ST2    
            end
        end
    elseif step_1 == 8
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 8 i->begin
                ST1 = U11 * st[j + i] + U12 * st[j + i + step_1]
                ST2 = U21 * st[j + i] + U22 * st[j + i + step_1]
                st[j + i] = ST1
                st[j + i + step_1] = ST2    
            end
        end
    else
        for j in 0:step_2:size(st, 1)-step_1
            for i in j:8:j+step_1-1
                Base.Cartesian.@nexprs 8 k->begin
                    ST1 = U11 * st[i + k] + U12 * st[i + step_1 + k]
                    ST2 = U21 * st[i + k] + U22 * st[i + step_1 + k]
                    st[i + k] = ST1
                    st[i + step_1 + k] = ST2
                end
            end
        end
    end
    return st
end

function broutine!(st::AbstractVector, U::AbstractMatrix, locs::NTuple{N, Int}) where N
    size(U, 1) == 2 && return broutine2x2!(st, U, locs)
    n = log2dim1(st)
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace)
    return st
end

function threaded_broutine!(st::AbstractVector, U::AbstractMatrix, locs::NTuple{N, Int}) where N
    n = log2dim1(st)
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    indices = [idx + 1 for idx in comspace]
    @inbounds @views Threads.@threads for k in subspace
        idx = indices .+ k
        st[idx] = U * st[idx]
    end
    return st
end

ctrl_offset(locs, configs) = bmask(locs[i] for (i, u) in enumerate(configs) if u != 0)
ismatch(index::T, mask::T, target::T) where {T<:Integer} = (index & mask) == target

function broutine2x2!(st::AbstractVector, U::AbstractMatrix, locs::Tuple{Int}, ctrl_locs::NTuple{M, Int}, ctrl_configs::NTuple{M, Int}) where {N, M}
    step_1 = 1 << (first(locs) - 1)
    step_2 = 1 << first(locs)
    ctrl_mask = bmask(ctrl_locs)
    flag_mask = reduce(+, 1 << (ctrl_locs[i] - 1) for i in 1:length(ctrl_locs) if ctrl_configs[i] == 1)
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];

    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 1)-step_1
            if ismatch(j, ctrl_mask, flag_mask)
                ST1 = U11 * st[j+1] + U12 * st[j + step_1 + 1]
                ST2 = U21 * st[j+1] + U22 * st[j + step_1 + 1]
    
                st[j + 1] = ST1
                st[j + step_1 + 1] = ST2
            end
        end
    elseif step_1 == 2
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 2 i->begin
                if ismatch(j+i-1, ctrl_mask, flag_mask)
                    ST1 = U11 * st[j+i] + U12 * st[j + step_1 + i]
                    ST2 = U21 * st[j+i] + U22 * st[j + step_1 + i]
        
                    st[j + i] = ST1
                    st[j + step_1 + i] = ST2
                end
            end
        end
    elseif step_1 == 4
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 4 i->begin
                if ismatch(j+i-1, ctrl_mask, flag_mask)
                    ST1 = U11 * st[j+i] + U12 * st[j + step_1 + i]
                    ST2 = U21 * st[j+i] + U22 * st[j + step_1 + i]
        
                    st[j + i] = ST1
                    st[j + step_1 + i] = ST2
                end
            end
        end
    elseif step_1 == 8
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 8 i->begin
                if ismatch(j+i-1, ctrl_mask, flag_mask)
                    ST1 = U11 * st[j+i] + U12 * st[j + step_1 + i]
                    ST2 = U21 * st[j+i] + U22 * st[j + step_1 + i]
        
                    st[j + i] = ST1
                    st[j + step_1 + i] = ST2
                end
            end
        end
    else
        for j in 0:step_2:size(st, 1)-step_1
            for i in j:8:j+step_1-1
                Base.Cartesian.@nexprs 8 k->begin
                    if ismatch(i+k-1, ctrl_mask, flag_mask)
                        ST1 = U11 * st[i+k] + U12 * st[i + step_1 + k]
                        ST2 = U21 * st[i+k] + U22 * st[i + step_1 + k]
                        st[i + k] = ST1
                        st[i + step_1 + k] = ST2
                    end 
                end
            end
        end
    end
    return st
end

function broutine!(st::AbstractVector, U::AbstractMatrix, locs::NTuple{N, Int}, ctrl_locs::NTuple{M, Int}, ctrl_configs::NTuple{M, Int}) where {N, M}
    size(U, 1) == 2 && return broutine2x2!(st, U, locs, ctrl_locs, ctrl_configs)
    n = log2dim1(st)
    subspace = bsubspace(n, sort([locs..., ctrl_locs...]))
    comspace = bcomspace(n, locs)
    offset = ctrl_offset(ctrl_locs, ctrl_configs)
    subspace_mul!(st, comspace, U, subspace, offset)
    return st
end

function broutine!(st::AbstractVector{T}, ::Val{:X}, locs::Tuple{Int}) where T
    step_1 = 1 << (first(locs) - 1)
    step_2 = 1 << first(locs)

    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 1)-step_1
            tmp = st[j + 1]
            st[j + 1] = st[j + 1 + step_1]
            st[j + 1 + step_1] = tmp
        end
    elseif step_1 == 2
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 2 i->begin
                tmp = st[j + i]
                st[j + i] = st[j + i + step_1]
                st[j + i + step_1] = tmp
            end
        end
    elseif step_1 == 4
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 4 i->begin
                tmp = st[j + i]
                st[j + i] = st[j + i + step_1]
                st[j + i + step_1] = tmp
            end
        end
    elseif step_1 == 8
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 8 i->begin
                tmp = st[j + i]
                st[j + i] = st[j + i + step_1]
                st[j + i + step_1] = tmp
            end
        end
    else
        for j in 0:step_2:size(st, 1)-step_1
            for i in j:8:j+step_1-1
                Base.Cartesian.@nexprs 8 k->begin
                    tmp = st[i+k]
                    st[i+k] = st[i + step_1 + k]
                    st[i + step_1 + k] = tmp
                end
            end
        end
    end
    return st
end

function broutine!(st::AbstractVector{T}, ::Val{:Rz}, locs::Tuple{Int}, theta::Real) where T
    U11 = exp(-im * theta/2)
    U22 = exp(im * theta/2)
    step_1 = 1 << (first(locs) - 1)
    step_2 = 1 << first(locs)

    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 1)-step_1
            ST1 = U11 * st[j + 1]
            ST2 = U22 * st[j + 1 + step_1]

            st[j + 1] = ST1
            st[j + 1 + step_1] = ST2
        end
    elseif step_1 == 2
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 2 i->begin
                ST1 = U11 * st[j + i]
                ST2 = U22 * st[j + i + step_1]
                st[j + i] = ST1
                st[j + i + step_1] = ST2    
            end
        end
    elseif step_1 == 4
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 4 i->begin
                ST1 = U11 * st[j + i]
                ST2 = U22 * st[j + i + step_1]
                st[j + i] = ST1
                st[j + i + step_1] = ST2    
            end
        end
    elseif step_1 == 8
        for j in 0:step_2:size(st, 1)-step_1
            Base.Cartesian.@nexprs 8 i->begin
                ST1 = U11 * st[j + i]
                ST2 = U22 * st[j + i + step_1]
                st[j + i] = ST1
                st[j + i + step_1] = ST2    
            end
        end
    else
        for j in 0:step_2:size(st, 1)-step_1
            for i in j:8:j+step_1-1
                Base.Cartesian.@nexprs 8 k->begin
                    ST1 = U11 * st[i + k]
                    ST2 = U22 * st[i + step_1 + k]
                    st[i + k] = ST1
                    st[i + step_1 + k] = ST2
                end
            end
        end
    end
    return st
end

using CUDA

function broutine!(st::CuVector{T}, U::AbstractMatrix, locs::Tuple{Int}) where T
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    step_1 = 1 << (first(locs) - 1)
    step_2 = 1 << first(locs)

    function kernel(st)
        idx = (blockIdx().x - 1) * blockDim().x + threadIdx().x
        j = step_2 * idx - step_2
        for i in j+1:j+step_1
            ST1 = U11 * st[i] + U12 * st[i + step_1]
            ST2 = U21 * st[i] + U22 * st[i + step_1]

            st[i] = ST1
            st[i + step_1] = ST2
        end
        return
    end

    N = length(0:step_2:size(st, 1)-step_1)
    nblocks = ceil(Int, N/256)
    @cuda threads=256 blocks=nblocks kernel(st)
    return st
end

function broutine!(st::CuVector{T}, U::AbstractMatrix, locs::Tuple{Int}, ctrl_locs::NTuple{M, Int}, ctrl_configs::NTuple{M, Int}) where {T, M}
    step_1 = 1 << (first(locs) - 1)
    step_2 = 1 << first(locs)
    ctrl_mask = bmask(ctrl_locs)
    flag_mask = reduce(+, 1 << (ctrl_locs[i] - 1) for i in 1:length(ctrl_locs) if ctrl_configs[i] == 1)
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];

    function kernel(st)
        idx = (blockIdx().x - 1) * blockDim().x + threadIdx().x
        j = step_2 * idx - step_2
        for i in j:j+step_1-1
            if ismatch(i, ctrl_mask, flag_mask)
                ST1 = U11 * st[i+1] + U12 * st[i + step_1 + 1]
                ST2 = U21 * st[i+1] + U22 * st[i + step_1 + 1]

                st[i + 1] = ST1
                st[i + step_1 + 1] = ST2
            end
        end
        return
    end

    N = length(0:step_2:size(st, 1)-step_1)
    nblocks = ceil(Int, N/256)
    @cuda threads=256 blocks=nblocks kernel(st)
    return st
end

using SymEngine

@vars α θ
st = Basic[1, α, 0, 0]
broutine!(st, [exp(-im * θ) 0; 0 exp(im * θ)], (1, ))

using BenchmarkTools

data = Dict(
    "X" => [],
    "T" => [],
    "H" => [],
    "CNOT" => [],
)

for n in 4:25
    st = rand(ComplexF64, 1<<n)
    t = @benchmark broutine!(r, $([0 1;1 0]), (3, )) setup=(r=copy($st))
    push!(data["X"], minimum(t).time)
end

for n in 4:25
    st = rand(ComplexF64, 1<<n)
    t = @benchmark broutine!(r, $([1 0;0 exp(im * π / 4)]), (3, )) setup=(r=copy($st))
    push!(data["T"], minimum(t).time)
end

for n in 4:25
    st = rand(ComplexF64, 1<<n)
    t = @benchmark broutine!(r, $([1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]), (3, )) setup=(r=copy($st))
    push!(data["H"], minimum(t).time)
end

for n in 4:25
    st = rand(ComplexF64, 1<<n)
    t = @benchmark broutine!(r, $([0 1;1 0]), (2, ), (3, ), (1, )) setup=(r=copy($st))
    push!(data["CNOT"], minimum(t).time)
end

using JSON
d = JSON.parse(read("../../Documents/quantum-benchmarks/qulacs/data/Linux-CPython-3.8-64bit/0002_data.json", String))

qulacs = Dict(
    "X" => [each["stats"]["min"] * 1e9 for each in d["benchmarks"] if each["group"] == "X"],
    "T" => [each["stats"]["min"] * 1e9 for each in d["benchmarks"] if each["group"] == "T"],
    "H" => [each["stats"]["min"] * 1e9 for each in d["benchmarks"] if each["group"] == "H"],
    "CNOT" => [each["stats"]["min"] * 1e9 for each in d["benchmarks"] if each["group"] == "CNOT"],
)

write("data.json", JSON.json(data))

using Plots
p1 = plot(4:25, [qulacs["X"], data["X"]]; title="X gate", yaxis=:log10, xlabel="nqubits", ylabel="ns")
p2 = plot(4:25, [qulacs["T"], data["T"]]; title="T gate", yaxis=:log10, xlabel="nqubits", ylabel="ns")
p3 = plot(4:25, [qulacs["H"], data["H"]]; title="H gate", yaxis=:log10, xlabel="nqubits", ylabel="ns")
p4 = plot(4:25, qulacs["CNOT"]./data["CNOT"]; title="CNOT gate", yaxis=:log10, xlabel="nqubits", ylabel="ns")
plt = plot(p1, p2, p3, p4; layout=4)
savefig("benchmark.png")

# sanity check
# using YaoArrayRegister

# st = rand(ComplexF64, 1 << 10)
# broutine!(copy(st), [0 1;1 0], (3, )) ≈ instruct!(copy(st), Val(:X), (3, ))
# broutine!(copy(st), [1 0;0 exp(im * π / 4)], (3, )) ≈ instruct!(copy(st), [1 0;0 exp(im * π / 4)], (3, ))
# H = [1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]
# broutine!(copy(st), H, (3, )) ≈ instruct!(copy(st), H, (3, ))
# broutine!(copy(st), [0 1;1 0], (2, ), (3, ), (1, )) ≈ instruct!(copy(st), Val(:X), (2, ), (3, ), (1, ))
