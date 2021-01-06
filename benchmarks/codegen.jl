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
st = rand(ComplexF64, 1<<20);
locs = Locations(3)
broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
@benchmark broutine!(st, Val(:X), locs) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark broutine!(st, $BX, locs) setup=(st=rand(ComplexF64, 1 << 20))
