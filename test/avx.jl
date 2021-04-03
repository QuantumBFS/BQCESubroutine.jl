using StrideArrays
using ArrayInterface
using LoopVectorization
using YaoLocations
using BenchmarkTools
using BQCESubroutine
using StrideArrays
using BQCESubroutine.Utilities
using LoopVectorization
using ThreadingUtilities
using BQCESubroutine.Utilities: BitSubspace


function subspace_mul_generic!(S::AbstractStrideArray{<:Any, <:Any, T, 3}, indices, C, U::AbstractStrideArray{<:Any, <:Any, T, 3}, subspace, offset=0) where {T <: Base.HWReal}
    Bmax = size(S, 2)
    for s in 1:length(subspace)
        k = subspace[s]
        # idx = k .+ indices
        # _k = k - 1
        for _b ∈ 0:(Bmax-1) >>> 3
            b =    _b << 3;
            bmax = b + 8
            if bmax ≤ Bmax # full static block
                @avx for n ∈ 1:8, m ∈ axes(U, 2)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U, 3)
                        j = k + indices[i] + offset
                        C_re_m_n += U[1,m,i] * S[1,n+b,j] - U[2,m,i] * S[2,n+b,j]
                        C_im_m_n += U[1,m,i] * S[2,n+b,j] + U[2,m,i] * S[1,n+b,j]
                    end
                    C[1,m,n] = C_re_m_n
                    C[2,m,n] = C_im_m_n
                end
                @avx for n ∈ 1:8, m ∈ axes(U, 2)
                    j = k + indices[m] + offset
                    S[1,n+b,j] = C[1,m,n]
                    S[2,n+b,j] = C[2,m,n]
                end
                # AmulB!(C_re, C_im, U_re, U_im, 
            else # dynamic block
                Nmax = 8 + Bmax - bmax
                @avx for n ∈ 1:Nmax, m ∈ axes(U, 2)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U, 3)
                        j = k + indices[i] + offset
                        C_re_m_n += U[1,m,i] * S[1,n+b,j] - U[2,m,i] * S[2,n+b,j]
                        C_im_m_n += U[1,m,i] * S[2,n+b,j] + U[2,m,i] * S[1,n+b,j]
                    end
                    C[1,m,n] = C_re_m_n
                    C[2,m,n] = C_im_m_n
                end
                @avx for n ∈ 1:Nmax, m ∈ axes(U, 2)
                    j = k + indices[m] + offset
                    S[1,n+b,j] = C[1,m,n]
                    S[2,n+b,j] = C[2,m,n]
                end
            end
        end
    end
    return S
end

S = @StrideArray rand(Float64, 2, 100, 1<<20)
U = @StrideArray rand(Float64, 2, 8, 8)
C = StrideArray{Float64}(undef, (StaticInt{2}(), ArrayInterface.size(U, 2), StaticInt{8}()))
locs = Locations((1, 3, 5))
subspace = bsubspace(20, locs)
comspace = bcomspace(20, locs)
indices = StrideArray{Int}(undef, (StaticInt{length(comspace)}(), ))
@simd ivdep for i in eachindex(indices)
    indices[i] = comspace[i] + 1
end

@benchmark subspace_mul_generic!($(copy(S)), indices, C, U, subspace)

Sr = subspace_mul_generic!(copy(S), indices, U, subspace)
So = reinterpret(reshape, ComplexF64, S);
Uo = reinterpret(reshape, ComplexF64, U);
S2 = BQCESubroutine.subspace_mul_generic!(copy(So), indices, Uo, subspace)
reinterpret(reshape, ComplexF64, Sr) ≈ S2

@benchmark BQCESubroutine.subspace_mul_generic!($(rand(ComplexF64, 100, 1<<20)), $indices, $(rand(ComplexF64, 1<<3, 1<<3)), $subspace)
@benchmark subspace_mul_generic!($(copy(S)), indices, C, U, subspace)

S = @StrideArray rand(Float64, 2, 100, 1<<20)
U = @StrideArray rand(Float64, 2, 8, 8)

ArrayInterface.size(S)
ArrayInterface.size(U)
Base.@gc_preserve begin
@allocated C = StrideArray{Float64}(undef, (StaticInt{2}(), ArrayInterface.size(U, 2), StaticInt{8}()))
end

StrideArray{Float64}(undef, (StaticInt{2}(), ArrayInterface.size(U, 2), StaticInt{8}()))
