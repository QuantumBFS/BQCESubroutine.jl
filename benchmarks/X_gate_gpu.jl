using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

N = 5
X = [0 1; 1 0]
locs = Locations(1)
st = rand(Float64, 1<<N);
st0 = broutine!(copy(st), Val(:X_test_gpu), locs);
st1 = broutine!(copy(st), [0 1; 1 0], locs);
st0 ≈ st1
