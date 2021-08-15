using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

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

function benchmark_loc(N)
    BQCESubroutine.enable_threads()
    nthreads = Threads.nthreads()
    for i in 1:N
        print("nthreads=$nthreads, N=$N, loc=$i, (:X)     ")
        @btime st1 = threaded_basic_broutine!(copy(st), Val(:X), Locations($i)) setup=(st = rand(Float64, 1<<$N))
        print("nthreads=$nthreads, N=$N, loc=$i, (:X_test)")
        @btime st1 = broutine!(copy(st), Val(:X_test), Locations($i)) setup=(st = rand(Float64, 1<<$N))
    end
end
benchmark_loc(27)

@benchmark st1 = broutine!(copy(st), Val(:X_test), Locations(9)) setup=(st = rand(Float64, 1<<27))
