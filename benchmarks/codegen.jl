using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using BQCESubroutine: broutine2x2!
using BQCESubroutine: BitRoutine

x = BitRoutine(:(X = [0 1;1 0]))

@broutine X = [0 1;1 0]

st = rand(ComplexF64, 1 << 20);
locs = Locations(3)
broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
@benchmark broutine!($(copy(st)), Val(:X), $locs)
@benchmark broutine!($(copy(st)), [0 1;1 0], $locs)
@benchmark instruct!($(copy(st)), Val(:X), $(Tuple(locs)))

@broutine Y = [0 -im;im 0]
broutine!(copy(st), Val(:Y), locs) ≈ broutine!(copy(st), BY, locs)
@benchmark broutine!($(copy(st)), Val(:Y), $locs)
@benchmark broutine!($(copy(st)), $BY, $locs)
@benchmark instruct!($(copy(st)), Val(:Y), $(Tuple(locs)))

@broutine Rx(θ::Real) = [cos(θ / 2) -im*sin(θ / 2); -im*sin(θ / 2) cos(θ / 2)]

broutine!(copy(st), Val(:Rx), locs, 0.2) ≈ broutine!(copy(st), BRx(0.2), locs)
@benchmark broutine!($(copy(st)), Val(:Rx), $locs, 0.2)
@benchmark broutine!($(copy(st)), BRx(0.2), $locs)
@benchmark instruct!($(copy(st)), Val(:Rx), $(Tuple(locs)), 0.2)

locs = Locations((3, 4, 5))

broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
@benchmark broutine!($(copy(st)), Val(:X), $locs)
@benchmark broutine!($(copy(st)), [0 1;1 0], $locs)
@benchmark instruct!($(copy(st)), Val(:X), $(Tuple(locs)))

broutine!(copy(st), Val(:Y), locs) ≈ broutine!(copy(st), BY, locs)
broutine!(copy(st), Val(:Y), locs) ≈ instruct!(copy(st), Val(:Y), Tuple(locs))
instruct!(copy(st), Val(:Y), Tuple(locs)) ≈ broutine!(copy(st), BY, locs)

@benchmark broutine!($(copy(st)), Val(:Y), $locs)
@benchmark broutine!($(copy(st)), $BY, $locs)
@benchmark instruct!($(copy(st)), Val(:Y), $(Tuple(locs)))

@broutine Z = [1 0;0 -1]
broutine!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), BZ, locs)
@benchmark broutine!($(copy(st)), Val(:Z), $locs)
@benchmark broutine!($(copy(st)), $BZ, $locs)
@benchmark instruct!($(copy(st)), Val(:Z), $(Tuple(locs)))

@broutine S = [1 0;0 im]
broutine!(copy(st), Val(:S), locs) ≈ broutine!(copy(st), BS, locs)
@benchmark broutine!($(copy(st)), Val(:S), $locs)
@benchmark broutine!($(copy(st)), $BS, $locs)
@benchmark instruct!($(copy(st)), Val(:S), $(Tuple(locs)))

st = rand(ComplexF64, 1<<10, 100);
