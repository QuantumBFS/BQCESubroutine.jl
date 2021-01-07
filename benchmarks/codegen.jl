using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using BQCESubroutine: broutine2x2!
using BQCESubroutine: BitRoutine, generic_kernel, subspace_loop, codegen_broutine
using PaddedMatrices

@broutine X = [0 1;1 0]
@broutine H = [1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]
@macroexpand @broutine Y = [0 -im;im 0]
st = rand(ComplexF64, 1<<20);
locs = Locations(3)

broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
@benchmark broutine!(st, Val(:X), $(Locations(3)), $(CtrlLocations(4))) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BX, locs) setup=(st=rand(ComplexF64, 1 << 20))

broutine!(copy(st), Val(:Y), locs) ≈ broutine!(copy(st), BY, locs)
@benchmark broutine!(st, Val(:Y), locs) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BY, locs) setup=(st=rand(ComplexF64, 1 << 20))

broutine!(copy(st), Val(:H), locs) ≈ broutine!(copy(st), BH, locs)
@benchmark broutine!(st, Val(:H), $(Locations(3))) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BH, $(Locations(3))) setup=(st=rand(ComplexF64, 1 << 20))

function broutine_!(st::AbstractVector{Complex{T}}, ::Val{:S}, locs::Locations) where T
    # U11_re = StrideArray{T}(undef, (StaticInt{length(locs)+1}(), ))
    # U11_im = StrideArray{T}(undef, (StaticInt{length(locs)+1}(), ))
    U22_re = StrideArray{T}(undef, (StaticInt{length(locs)+1}(), ))
    U22_im = StrideArray{T}(undef, (StaticInt{length(locs)+1}(), ))
    @simd ivdep for k in 0:length(locs)
        # a = 1^k
        b = im^k
        # U11_re[k+1] = real(a)
        # U11_im[k+1] = imag(a)
        U22_re[k+1] = real(b)
        U22_im[k+1] = imag(b)
    end

    l = length(locs)
    mask = bmask(Int, plain(locs))
    str = reinterpret(reshape, T, st)

    @fastmath @inbounds for m in 0:(size(st, 1) - 1)
        k = count_ones(m & mask)
        # (a+b*im) * (c + d * im)
        # (ac - bd) + (ad + bc)
        # U11^(l-k) * U22^k
        C_re = U22_re[k+1]
        C_im = U22_im[k+1]

        Y_re = C_re * str[1, m+1] - C_im * str[2, m+1]
        Y_im = C_re * str[2, m+1] + C_im * str[1, m+1]

        str[1, m+1] = Y_re
        str[2, m+1] = Y_im
    end
    return st
end

using BQCESubroutine: perm_kernel, elim_identity, elim_double_const_pow, elim_const_pow, _generic_kernel

@macroexpand @broutine X = [0 1;1 0]

@macroexpand @broutine Z = [1 0;0 -1]
brt = BitRoutine(:(X = [0 1;1 0]))
init, kernel = _generic_kernel(brt, :st, :locs, :step)
kernel(:m, nothing)

st = rand(ComplexF64, 1 << 10)
locs = Locations(3)
broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
locs = Locations((3, 5))
broutine!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), BQCESubroutine.BZ, locs)

init, kernel = perm_kernel(brt, :st, :locs)

ex = kernel(:m, nothing)


f(U12, U21) = quote
    k = count_ones(m & mask)
    tmp = S1
    S1 = $U12^k * $U21^(l-k) * S2
    S2 = $U21^k * $U12^(l-k) * tmp
end

elim_double_const_pow(f(:im, :(-im)))|>elim_identity|>elim_const_pow