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

BQCESubroutine.disable_threads()
st0 = broutine!(copy(st), Val(:X), locs)
st1 = broutine!(copy(st), Val(:X_test), locs)
st2 = broutine!(copy(st), X, locs)
@test st1 ≈ st2
@test st1 ≈ st0

BQCESubroutine.disable_threads()
# @benchmark broutine!(st, Val(:X), locs) setup=(st = rand(Float64, 1<<N))
# @benchmark broutine!(st, Val(:X_test), locs) setup=(st = rand(Float64, 1<<N))
# @benchmark broutine!(st, X, locs) setup=(st = rand(Float64, 1<<N))
