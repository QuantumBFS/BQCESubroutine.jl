using BQCESubroutine.Utilities
using BenchmarkTools
using LoopVectorization
using StrideArrays
using YaoLocations

function subspace_mul!(st::AbstractMatrix, comspace, U::AbstractMatrix{T}, subspace) where T
    y = similar(st, (size(U, 1), ))
    indices = [b + 1 for b in comspace]::Vector{Int}
    idx = similar(indices)
    @inbounds for k in subspace, b in 1:size(st, 2)
        for i in 1:size(U, 1)
            idx[i] = k + indices[i] 
        end

        for i in 1:size(U, 1)
            y[i] = zero(T)
            for j in 1:size(U, 2)
                y[i] += U[i, j] * st[idx[j], b]
            end
        end

        for i in 1:size(U, 1)
            st[idx[i], b] = y[i]
        end
    end
    return st
end

function subspace_mul_avx!(st::AbstractMatrix, comspace, U::AbstractMatrix{Complex{T}}, subspace) where T
    indices = StrideArray{Int}(undef, (StrideArrays.static_length(comspace), ))
    @simd ivdep for i in eachindex(indices)
        indices[i] = comspace[i] + 1
    end

    C_re = StrideArray{T}(undef, (StrideArrays.static_length(indices), StaticInt{32}()))
    C_im = StrideArray{T}(undef, (StrideArrays.static_length(indices), StaticInt{32}()))
    U_re = StrideArray{T}(undef, (StrideArrays.size(U, StaticInt{1}()), StrideArrays.size(U, StaticInt{2}())))
    U_im = StrideArray{T}(undef, (StrideArrays.size(U, StaticInt{1}()), StrideArrays.size(U, StaticInt{2}())))
    Ur = reinterpret(reshape, T, U)

    @inbounds @simd ivdep for i ∈ eachindex(U_re)
        U_re[i] = Ur[1,i]
        U_im[i] = Ur[2,i]
    end
    str = reinterpret(reshape, T, st)
    Bmax = size(st,2)
    for k in subspace
        # idx = k .+ indices
        # _k = k - 1
        for _b ∈ 0:(Bmax-1) >>> 5
            b =    _b << 5;
            bmax = b + 32
            if bmax ≤ Bmax # full static block
                @avx for n ∈ 1:32, m ∈ axes(U, 1)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U, 2)
                        str_i = k + indices[i]
                        C_re_m_n += U_re[m,i] * str[1,str_i,n+b] - U_im[m,i] * str[2,str_i,n+b]
                        C_im_m_n += U_re[m,i] * str[2,str_i,n+b] + U_im[m,i] * str[1,str_i,n+b]
                    end
                    C_re[m,n] = C_re_m_n
                    C_im[m,n] = C_im_m_n
                end
                @avx for n ∈ 1:32, m ∈ axes(U, 1)
                    str_m = k + indices[m]
                    str[1,str_m,n+b] = C_re[m,n]
                    str[2,str_m,n+b] = C_im[m,n]
                end
                # AmulB!(C_re, C_im, U_re, U_im, 
            else # dynamic block
                Nmax = 32 + Bmax - bmax
                @avx for n ∈ 1:Nmax, m ∈ axes(U, 1)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U, 2)
                        str_i = k + indices[i]
                        C_re_m_n += U_re[m,i] * str[1,str_i,n+b] - U_im[m,i] * str[2,str_i,n+b]
                        C_im_m_n += U_re[m,i] * str[2,str_i,n+b] + U_im[m,i] * str[1,str_i,n+b]
                    end
                    C_re[m,n] = C_re_m_n
                    C_im[m,n] = C_im_m_n
                end
                @avx for n ∈ 1:Nmax, m ∈ axes(U, 1)
                    str_m = k + indices[m]
                    str[1,str_m,n+b] = C_re[m,n]
                    str[2,str_m,n+b] = C_im[m,n]
                end
            end
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

        for b in 1:size(st, 2)
            Base.Cartesian.@nexprs 4 i -> begin
                y_i = zero(T)
                Base.Cartesian.@nexprs 4 j -> begin
                    y_i += U_i_j * st[idx_j, b]
                end
            end

            Base.Cartesian.@nexprs 4 i -> begin
                st[idx_i, b] = y_i
            end
        end
    end
    return st
end

function subspace_mul8x8!(st::AbstractMatrix{T}, comspace, U::AbstractMatrix, subspace, offset=0) where T
    Base.Cartesian.@nextract 8 indices i -> comspace[i] + 1
    
    Base.Cartesian.@nextract 8 U i->begin
        Base.Cartesian.@nextract 8 U_i j->U[i, j]
    end

    @inbounds for k in subspace
        Base.Cartesian.@nextract 8 idx i-> k + indices_i + offset

        for b in 1:size(st, 2)
            Base.Cartesian.@nexprs 8 i -> begin
                y_i = zero(T)
                Base.Cartesian.@nexprs 8 j -> begin
                    y_i += U_i_j * st[idx_j, b]
                end
            end

            Base.Cartesian.@nexprs 8 i -> begin
                st[idx_i, b] = y_i
            end
        end
    end
    return st
end

using StaticArrays
n = 8
locs = Locations((1, 3))
st = rand(ComplexF64, 1 << n, 100)
U = rand(ComplexF64, 1 << 2, 1 << 2)
SU = @SMatrix rand(ComplexF64, 1 << 2, 1 << 2)
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)

subspace_mul4x4!(deepcopy(st), comspace, U, subspace) ≈ subspace_mul!(deepcopy(st), comspace, U, subspace)
subspace_mul8x8!(deepcopy(st), comspace, U, subspace) ≈ subspace_mul!(deepcopy(st), comspace, U, subspace)
subspace_mul_avx!(deepcopy(st), comspace, U, subspace) ≈ subspace_mul!(deepcopy(st), comspace, U, subspace)

@benchmark subspace_mul4x4!($(deepcopy(st)), $comspace, $SU, $subspace)
@benchmark subspace_mul8x8!($(deepcopy(st)), $comspace, $SU, $subspace)
@benchmark subspace_mul!($(deepcopy(st)), $comspace, $SU, $subspace)
@benchmark subspace_mul_avx!($(deepcopy(st)), $comspace, $SU, $subspace)
