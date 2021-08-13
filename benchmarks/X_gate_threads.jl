using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

N = 20
st = rand(Float64, 1<<N)
st_mat = rand(Float64, 5, 1<<N)
X = [0 1; 1 0]
locs = Locations(19)

nthreads = Threads.nthreads()
println("nthreads=$(nthreads), N=$(N), loc=$(YaoLocations.plain(locs)[begin])")

if nthreads == 1
    BQCESubroutine.disable_threads()
    print("(:X)      ")
    @btime st0 = broutine!(copy(st), Val(:X), locs) setup=(st = rand(Float64, 1<<N))
    print("(:X_test) ")
    @btime st0 = broutine!(copy(st), Val(:X_test), locs) setup=(st = rand(Float64, 1<<N))
else
    BQCESubroutine.enable_threads()
    print("(:X)      ")
    @btime st0 = threaded_basic_broutine!(copy(st), Val(:X), locs) setup=(st = rand(Float64, 1<<N))
    print("(:X_test) ")
    @btime st0 = broutine!(copy(st), Val(:X_test), locs) setup=(st = rand(Float64, 1<<N))
end

# BQCESubroutine.enable_threads()
# st0 = broutine!(copy(st), Val(:X), locs)
# st1 = BQCESubroutine.threaded_basic_broutine!(copy(st), Val(:X), locs)
# st2 = broutine!(copy(st), Val(:X_test), locs)
# st3 = broutine!(copy(st), X, locs)
# @test st2 ≈ st3
# @test st2 ≈ st0
# @test st2 ≈ st1

"""
nthreads=1, N=20, loc=19
(:X)        1.034 ms (2 allocations: 8.00 MiB)
(:X_test)   1.185 ms (2 allocations: 8.00 MiB)
nthreads=2, N=20, loc=19
(:X)        1.184 ms (14 allocations: 8.00 MiB)
(:X_test)   1.101 ms (2 allocations: 8.00 MiB)
nthreads=3, N=20, loc=19
(:X)        1.204 ms (44 allocations: 8.00 MiB)
(:X_test)   1.099 ms (2 allocations: 8.00 MiB)
nthreads=4, N=20, loc=19
(:X)        1.187 ms (49 allocations: 8.00 MiB)
(:X_test)   1.104 ms (2 allocations: 8.00 MiB)
nthreads=5, N=20, loc=19
(:X)        1.277 ms (53 allocations: 8.00 MiB)
(:X_test)   1.101 ms (2 allocations: 8.00 MiB)
nthreads=6, N=20, loc=19
(:X)        1.231 ms (58 allocations: 8.00 MiB)
(:X_test)   1.092 ms (2 allocations: 8.00 MiB)
nthreads=7, N=20, loc=19
(:X)        1.234 ms (63 allocations: 8.00 MiB)
(:X_test)   1.136 ms (2 allocations: 8.00 MiB)
nthreads=8, N=20, loc=19
(:X)        1.399 ms (68 allocations: 8.00 MiB)
(:X_test)   1.165 ms (2 allocations: 8.00 MiB)
nthreads=9, N=20, loc=19
(:X)        1.237 ms (72 allocations: 8.01 MiB)
(:X_test)   1.153 ms (2 allocations: 8.00 MiB)
nthreads=10, N=20, loc=19
(:X)        1.314 ms (77 allocations: 8.01 MiB)
(:X_test)   1.142 ms (2 allocations: 8.00 MiB)
nthreads=11, N=20, loc=19
(:X)        1.230 ms (82 allocations: 8.01 MiB)
(:X_test)   1.276 ms (2 allocations: 8.00 MiB)
nthreads=12, N=20, loc=19
(:X)        1.276 ms (87 allocations: 8.01 MiB)
(:X_test)   1.150 ms (2 allocations: 8.00 MiB)
"""

"""
nthreads=1, N=20, loc=1
(:X)        1.099 ms (2 allocations: 8.00 MiB)
(:X_test)   1.170 ms (2 allocations: 8.00 MiB)
nthreads=2, N=20, loc=1
(:X)        1.198 ms (13 allocations: 8.00 MiB)
(:X_test)   1.090 ms (2 allocations: 8.00 MiB)
nthreads=3, N=20, loc=1
(:X)        1.174 ms (18 allocations: 8.00 MiB)
(:X_test)   1.086 ms (2 allocations: 8.00 MiB)
nthreads=4, N=20, loc=1
(:X)        1.181 ms (23 allocations: 8.00 MiB)
(:X_test)   1.097 ms (2 allocations: 8.00 MiB)
nthreads=5, N=20, loc=1
(:X)        1.197 ms (27 allocations: 8.00 MiB)
(:X_test)   1.082 ms (2 allocations: 8.00 MiB)
nthreads=6, N=20, loc=1
(:X)        1.207 ms (33 allocations: 8.00 MiB)
(:X_test)   1.087 ms (2 allocations: 8.00 MiB)
nthreads=7, N=20, loc=1
(:X)        1.207 ms (38 allocations: 8.00 MiB)
(:X_test)   1.122 ms (2 allocations: 8.00 MiB)
nthreads=8, N=20, loc=1
(:X)        1.262 ms (43 allocations: 8.00 MiB)
(:X_test)   1.160 ms (2 allocations: 8.00 MiB)
"""


"""
nthreads=1, N=20, loc=1
(:X)        1.138 ms (2 allocations: 8.00 MiB)
(:X_test)   1.134 ms (2 allocations: 8.00 MiB)
nthreads=2, N=20, loc=1
(:X)        1.208 ms (13 allocations: 8.00 MiB)
(:X_test)   1.102 ms (2 allocations: 8.00 MiB)
nthreads=3, N=20, loc=1
(:X)        1.163 ms (18 allocations: 8.00 MiB)
(:X_test)   1.094 ms (2 allocations: 8.00 MiB)
nthreads=4, N=20, loc=1
(:X)        1.163 ms (23 allocations: 8.00 MiB)
(:X_test)   1.078 ms (2 allocations: 8.00 MiB)
nthreads=5, N=20, loc=1
(:X)        1.182 ms (28 allocations: 8.00 MiB)
(:X_test)   1.076 ms (2 allocations: 8.00 MiB)
nthreads=6, N=20, loc=1
(:X)        1.194 ms (33 allocations: 8.00 MiB)
(:X_test)   1.091 ms (2 allocations: 8.00 MiB)
nthreads=7, N=20, loc=1
(:X)        1.252 ms (38 allocations: 8.00 MiB)
(:X_test)   1.266 ms (2 allocations: 8.00 MiB)
nthreads=8, N=20, loc=1
(:X)        1.221 ms (43 allocations: 8.00 MiB)
(:X_test)   1.115 ms (2 allocations: 8.00 MiB)
nthreads=9, N=20, loc=1
(:X)        1.313 ms (48 allocations: 8.00 MiB)
(:X_test)   1.129 ms (2 allocations: 8.00 MiB)
nthreads=10, N=20, loc=1
(:X)        1.250 ms (53 allocations: 8.00 MiB)
(:X_test)   1.344 ms (2 allocations: 8.00 MiB)
"""

"""
nthreads=1, N=20, loc=1
  1.108 ms (2 allocations: 8.00 MiB)
nthreads=2, N=20, loc=1
  1.021 ms (13 allocations: 8.00 MiB)
nthreads=3, N=20, loc=1
  1.158 ms (18 allocations: 8.00 MiB)
nthreads=4, N=20, loc=1
  1.080 ms (23 allocations: 8.00 MiB)
nthreads=5, N=20, loc=1
  1.165 ms (28 allocations: 8.00 MiB)
nthreads=6, N=20, loc=1
  1.189 ms (33 allocations: 8.00 MiB)
"""

"""
n=27, loc=15
nthreads = 1
  478.007 ms (2 allocations: 1.00 GiB)
nthreads = 2
  373.456 ms (13 allocations: 1.00 GiB)
nthreads = 3
  507.799 ms (18 allocations: 1.00 GiB)
nthreads = 4
  401.522 ms (23 allocations: 1.00 GiB)
nthreads = 5
  521.116 ms (28 allocations: 1.00 GiB)
nthreads = 6
  414.089 ms (33 allocations: 1.00 GiB)
nthreads = 7
  429.090 ms (39 allocations: 1.00 GiB)
nthreads = 8
  423.105 ms (43 allocations: 1.00 GiB)
nthreads = 9
  559.256 ms (49 allocations: 1.00 GiB)
nthreads = 10
  426.913 ms (53 allocations: 1.00 GiB)
"""
