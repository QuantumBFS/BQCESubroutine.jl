using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

nthreads = Threads.nthreads()
println("nthreads = $(nthreads)")

N = 25
st = rand(Float64, 1<<N)
st_mat = rand(Float64, 5, 1<<N)
X = [0 1; 1 0]
locs = Locations(15)

if nthreads == 1
    BQCESubroutine.disable_threads()
    st0 = broutine!(copy(st), Val(:X), locs)
    @btime st0 = broutine!(copy(st), Val(:X), locs) setup=(st = rand(Float64, 1<<N))
else
    BQCESubroutine.enable_threads()
    st0 = threaded_basic_broutine!(copy(st), Val(:X), locs)
    @btime st0 = threaded_basic_broutine!(copy(st), Val(:X), locs) setup=(st = rand(Float64, 1<<N))
end

# BQCESubroutine.enable_threads()
# st0 = broutine!(copy(st), Val(:X), locs)
# st1 = BQCESubroutine.threaded_basic_broutine!(copy(st), Val(:X), locs)
# st2 = broutine!(copy(st), Val(:X_test), locs)
# st3 = broutine!(copy(st), X, locs)
# @test st2 ≈ st3
# @test st2 ≈ st0
# @test st2 ≈ st1
