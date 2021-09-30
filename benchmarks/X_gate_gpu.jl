using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

N = 5
loc = 1
X = [0 1; 1 0]
locs = Locations(loc)
st = rand(Float64, 1<<N);
st0 = BQCESubroutine.subspace_mul!(copy(st), Val(:X_test_gpu), loc);
st1 = broutine!(copy(st), [0 1; 1 0], locs);
st0 ≈ st1
