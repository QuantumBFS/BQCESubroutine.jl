using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using StaticArrays
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization

n = 3
st = rand(ComplexF64, 100, 1 << 8)
y = similar(st, (100, 1 << n))
U = rand(ComplexF64, 1 << n, 1 << n)
SU = @SMatrix rand(ComplexF64, 1 << n, 1 << n)
locs = Locations((1, 3, 4))

broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, locs.storage)

@benchmark broutine!($(rand(ComplexF64, 1 << 8, 100)), $U, $locs)
@benchmark broutine!($(transpose(rand(ComplexF64, 100, 1 << 8))), $U, $locs)
@benchmark instruct!($(rand(ComplexF64, 1 << 8, 100)), $U, $(locs.storage))
@benchmark instruct!($(transpose(rand(ComplexF64, 100, 1 << 8))), $U, $(locs.storage))
