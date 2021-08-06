using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations

# @broutine X = [0 1; 1 0]

N = 15
st = rand(Float64, 1<<N)
st_mat = rand(Float64, 5, 1<<N)
X = [0 1; 1 0]
locs = Locations(3)

st1 = broutine!(copy(st), Val(:X_test), locs)     # @benchmark
st2 = broutine!(copy(st), X, locs)                # @benchmark
@test st1 ≈ st2
