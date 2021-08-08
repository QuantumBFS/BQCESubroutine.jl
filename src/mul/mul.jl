include("kernel/kernel.jl")
include("tasks/tasks.jl")
include("generic.jl")

function subspace_mul!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    if size(U, 1) == 4
        return subspace_mul4x4!(st, comspace, U, subspace, offset)
    elseif size(U, 1) == 8
        return subspace_mul8x8!(st, comspace, U, subspace, offset)
    else
        # force compiler to specialize on comspace size
        indices = StrideArray{Int}(undef, (length(comspace), ))
        @simd ivdep for i in eachindex(indices)
            indices[i] = comspace[i] + 1
        end
        return subspace_mul_generic!(st, indices, U, subspace, offset)
    end
end

# specialize on the X gate
function subspace_mul!(st::AbstractVector{T}, U::Val{:X_test}, loc::Int) where T
    n = log2dim(st)

    if loc == 1
        for k in 0:2:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 1
            @inbounds @swap st[idx_1+1] st[idx_2+1]
        end
    elseif loc == 2
        for k in 0:4:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 0b10
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b01
            idx_2 = k | 0b11
            @inbounds @swap st[idx_1+1] st[idx_2+1]
        end
    elseif loc == 3
        for k in 0:8:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 0b100
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b001
            idx_2 = k | 0b101
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b010
            idx_2 = k | 0b110
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b011
            idx_2 = k | 0b111
            @inbounds @swap st[idx_1+1] st[idx_2+1]
        end
    elseif loc == 4
        for k in 0:16:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 0b1000
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0001
            idx_2 = k | 0b1001
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0010
            idx_2 = k | 0b1010
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0011
            idx_2 = k | 0b1011
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0100
            idx_2 = k | 0b1100
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0101
            idx_2 = k | 0b1101
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0110
            idx_2 = k | 0b1110
            @inbounds @swap st[idx_1+1] st[idx_2+1]
            idx_1 = k | 0b0111
            idx_2 = k | 0b1111
            @inbounds @swap st[idx_1+1] st[idx_2+1]
        end
    else
        loc_bit = 1 << (loc-1)
        for k_highbits in 0 : (1<<loc) : ((1<<n)-1)
            for k in k_highbits : 8 : ((k_highbits | loc_bit) - 1)
                idx_1 = k
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b001
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b010
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b011
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b100
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b101
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b110
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
                idx_1 = k | 0b111
                idx_2 = idx_1 | loc_bit
                @inbounds @swap st[idx_1+1] st[idx_2+1]
            end
        end
    end
end

function subspace_mul!(st::AbstractMatrix, comspace, U::AbstractMatrix{T}, subspace, offset=0) where T
    # NOTE: avx version seems to be faster at 8 already
    if size(U, 1) == 4
        return subspace_mul4x4!(st, comspace, U, subspace, offset)
    else
        # force compiler to specialize on comspace size
        indices = StrideArray{Int}(undef, (length(comspace), ))
        @simd ivdep for i in eachindex(indices)
            indices[i] = comspace[i] + 1
        end
        return subspace_mul_generic!(st, indices, U, subspace, offset)
    end
end

# NOTE:
# expanded kernel is slower than avx kernel in multithreading
# thus we don't need to do any manual loop unroll.
function threaded_subspace_mul!(S::AbstractVecOrMat, comspace, U, subspace, offset=0)
    indices = StrideArray{Int}(undef, (length(comspace), ))
    @simd ivdep for i in eachindex(indices)
        indices[i] = comspace[i] + 1
    end
    return subspace_mul_generic!(S, indices, U, subspace, offset)
end

function subspace_mul4x4!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end

    @inbounds for k in subspace
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

function subspace_mul4x4!(st::AbstractMatrix{T}, comspace, U::AbstractMatrix, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end
    
    @inbounds for k in subspace
        Base.Cartesian.@nextract 4 idx i-> k + indices_i + offset

        for b in 1:size(st, 1)
            Base.Cartesian.@nexprs 4 i -> begin
                y_i = zero(T)
                Base.Cartesian.@nexprs 4 j -> begin
                    y_i += U_i_j * st[b, idx_j]
                end
            end

            Base.Cartesian.@nexprs 4 i -> begin
                st[b, idx_i] = y_i
            end
        end
    end
    return st
end
