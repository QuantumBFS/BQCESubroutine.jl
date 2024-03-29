using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

N = 20
#st_mat = rand(Float64, 5, 1<<N)
X = [0 1; 1 0]
locs = Locations(19)

nthreads = Threads.nthreads()
println("nthreads=$(nthreads), N=$(N), loc=$(YaoLocations.plain(locs)[begin])")

if nthreads == 1
    BQCESubroutine.disable_threads()
    print("(:X)      "); st = rand(Float64, 1<<N);
    @btime st0 = broutine!(st, Val(:X), locs)
    print("(:X_test) "); st = rand(Float64, 1<<N);
    @btime st0 = broutine!(st, Val(:X_test), locs)
else
    BQCESubroutine.enable_threads()
    print("(:X)      "); st = rand(Float64, 1<<N)
    @btime st0 = threaded_basic_broutine!(st, Val(:X), locs)
    print("(:X_test) "); st = rand(Float64, 1<<N)
    @btime st0 = broutine!(st, Val(:X_test), locs)
end

# BQCESubroutine.enable_threads()
# st0 = broutine!(copy(st), Val(:X), locs)
# st1 = BQCESubroutine.threaded_basic_broutine!(copy(st), Val(:X), locs)
# st2 = broutine!(copy(st), Val(:X_test), locs)
# st3 = broutine!(copy(st), X, locs)
# @test st2 ≈ st3
# @test st2 ≈ st0
# @test st2 ≈ st1
