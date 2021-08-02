using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations

# TODO: complex + diagonal ?
# TODO: check if (dense) Matrix is diagonal?

N = 15
M = 4

st = rand(Float64, 1<<N)
U = Diagonal(rand(Float64, 1<<M))
U_dense = Matrix(U)
locs = Locations(1:M)

st1 = broutine!(copy(st), U, locs)          # @benchmark
st2 = broutine!(copy(st), U_dense, locs)    # @benchmark

@test st1 ≈ st2
