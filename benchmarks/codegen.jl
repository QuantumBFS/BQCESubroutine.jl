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

@broutine X = [0 1;1 0]
@broutine H = [1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]
@macroexpand @broutine Y = [0 -im;im 0]
st = rand(ComplexF64, 1<<20);
locs = Locations(3)
broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
@benchmark broutine!(st, Val(:X), locs) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BX, locs) setup=(st=rand(ComplexF64, 1 << 20))

broutine!(copy(st), Val(:Y), locs) ≈ broutine!(copy(st), BY, locs)
@benchmark broutine!(st, Val(:Y), locs) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BY, locs) setup=(st=rand(ComplexF64, 1 << 20))

broutine!(copy(st), Val(:H), locs) ≈ broutine!(copy(st), BH, locs)
@benchmark broutine!(st, Val(:H), $(Locations(3))) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BH, $(Locations(3))) setup=(st=rand(ComplexF64, 1 << 20))


# julia> @benchmark broutine!(st, Val(:X), locs) setup=(st=rand(ComplexF64, 1 << 20))
# BenchmarkTools.Trial: 
#   memory estimate:  0 bytes
#   allocs estimate:  0
#   --------------
#   minimum time:     515.595 μs (0.00% GC)
#   median time:      634.566 μs (0.00% GC)
#   mean time:        628.234 μs (0.00% GC)
#   maximum time:     836.395 μs (0.00% GC)
#   --------------
#   samples:          1250
#   evals/sample:     1