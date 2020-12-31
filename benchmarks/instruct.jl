using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using StaticArrays
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using BQCESubroutine: broutine2x2!

n = 1
st = rand(ComplexF64, 1 << 15)
y = similar(st, (1 << n))
U = rand(ComplexF64, 1 << n, 1 << n)
SU = @SMatrix rand(ComplexF64, 1 << n, 1 << n)

locs = Locations(3)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!($(rand(ComplexF64, 1 << 15)), $U, $locs)
@benchmark instruct!($(rand(ComplexF64, 1 << 15)), $U, $(Tuple(locs)))

@benchmark instruct!($(rand(ComplexF64, 1 << 15)), $U, $(Tuple(locs)))

locs = Locations(4)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!($(rand(ComplexF64, 1 << 15)), $U, $locs)
@benchmark instruct!($(rand(ComplexF64, 1 << 15)), $U, $(Tuple(locs)))

locs = Locations(13)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!($(rand(ComplexF64, 1 << 15)), $U, $locs)
@benchmark instruct!($(rand(ComplexF64, 1 << 15)), $U, $(Tuple(locs)))

locs = Locations(2)
ctrl = CtrlLocations(5)
broutine!(copy(st), U, locs, ctrl) ≈ instruct!(copy(st), U, Tuple(locs), Tuple(ctrl.storage), (1, ))
@benchmark broutine!($(copy(st)), $U, $locs, $ctrl)
@benchmark instruct!($(copy(st)), $U, $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, ))

locs = Locations(3)
ctrl = CtrlLocations(5)
broutine!(copy(st), U, locs, ctrl) ≈ instruct!(copy(st), U, Tuple(locs), Tuple(ctrl.storage), (1, ))
@benchmark broutine!($(copy(st)), $U, $locs, $ctrl)
@benchmark instruct!($(copy(st)), $U, $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, ))


n = 1
st = rand(ComplexF64, 1 << 15, 100);
U = rand(ComplexF64, 1 << n, 1 << n)

locs = Locations(3)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!($(copy(st)), $U, $locs)
@benchmark instruct!($(copy(st)), $U, $(Tuple(locs)))

locs = Locations(4)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!($(copy(st)), $U, $locs)
@benchmark instruct!($(copy(st)), $U, $(Tuple(locs)))

locs = Locations(10)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!($(copy(st)), $U, $locs)
@benchmark instruct!($(copy(st)), $U, $(Tuple(locs)))

locs = Locations(8)
ctrl = CtrlLocations(5)
broutine!(copy(st), U, locs, ctrl) ≈ instruct!(copy(st), U, Tuple(locs), Tuple(ctrl.storage), (1, ))
@benchmark broutine!($(copy(st)), $U, $locs, $ctrl)
@benchmark instruct!($(copy(st)), $U, $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, ))

U = ComplexF64[0 1;1 0]
@benchmark broutine!($(copy(st)), $U, $locs, $ctrl)
@benchmark instruct!($(copy(st)), Val(:X), $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, ))

locs = Locations(3)
broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), [0 1;1 0], locs)
instruct!(copy(st), Val(:X), Tuple(locs)) ≈ broutine!(copy(st), [0 1;1 0], locs)

@benchmark broutine!($(copy(st)), Val(:X), $locs)
@benchmark broutine!($(copy(st)), [0 1;1 0], $locs)
@benchmark instruct!($(copy(st)), Val(:X), $(Tuple(locs)))
