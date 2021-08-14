using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!

N = 27
#st_mat = rand(Float64, 5, 1<<N)
X = [0 1; 1 0]
locs = Locations(26)

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


# nthreads=1, N=20, loc=1
# (:X)        393.020 μs (0 allocations: 0 bytes)
# (:X_test)   416.215 μs (0 allocations: 0 bytes)
# nthreads=2, N=20, loc=1
# (:X)        392.456 μs (10 allocations: 976 bytes)
# (:X_test)   228.165 μs (0 allocations: 0 bytes)
# nthreads=3, N=20, loc=1
# (:X)        237.750 μs (15 allocations: 1.41 KiB)
# (:X_test)   172.577 μs (0 allocations: 0 bytes)
# nthreads=4, N=20, loc=1
# (:X)        176.847 μs (20 allocations: 1.84 KiB)
# (:X_test)   135.359 μs (0 allocations: 0 bytes)
# nthreads=5, N=20, loc=1
# (:X)        156.637 μs (26 allocations: 2.33 KiB)
# (:X_test)   132.398 μs (0 allocations: 0 bytes)
# nthreads=6, N=20, loc=1
# (:X)        221.977 μs (31 allocations: 2.77 KiB)
# (:X_test)   143.198 μs (0 allocations: 0 bytes)


# nthreads=1, N=20, loc=2
# (:X)        286.745 μs (0 allocations: 0 bytes)
# (:X_test)   303.868 μs (0 allocations: 0 bytes)
# nthreads=2, N=20, loc=2
# (:X)        1.159 ms (11 allocations: 1008 bytes)
# (:X_test)   174.305 μs (0 allocations: 0 bytes)
# nthreads=3, N=20, loc=2
# (:X)        784.214 μs (16 allocations: 1.44 KiB)
# (:X_test)   126.767 μs (0 allocations: 0 bytes)
# nthreads=4, N=20, loc=2
# (:X)        611.036 μs (20 allocations: 1.84 KiB)
# (:X_test)   112.259 μs (0 allocations: 0 bytes)
# nthreads=5, N=20, loc=2
# (:X)        445.028 μs (25 allocations: 2.30 KiB)
# (:X_test)   98.634 μs (0 allocations: 0 bytes)
# nthreads=6, N=20, loc=2
# (:X)        396.393 μs (31 allocations: 2.77 KiB)
# (:X_test)   103.864 μs (0 allocations: 0 bytes)


# nthreads=1, N=20, loc=19
# (:X)        467.459 μs (0 allocations: 0 bytes)
# (:X_test)   463.887 μs (0 allocations: 0 bytes)
# nthreads=2, N=20, loc=19
# (:X)        321.675 μs (10 allocations: 976 bytes)
# (:X_test)   246.473 μs (0 allocations: 0 bytes)
# nthreads=3, N=20, loc=19
# (:X)        310.752 μs (42 allocations: 2.50 KiB)
# (:X_test)   170.051 μs (0 allocations: 0 bytes)
# nthreads=4, N=20, loc=19
# (:X)        160.359 μs (46 allocations: 2.91 KiB)
# (:X_test)   129.819 μs (0 allocations: 0 bytes)
# nthreads=5, N=20, loc=19
# (:X)        187.570 μs (50 allocations: 3.31 KiB)
# (:X_test)   122.218 μs (0 allocations: 0 bytes)
# nthreads=6, N=20, loc=19
# (:X)        203.632 μs (56 allocations: 3.78 KiB)
# (:X_test)   155.127 μs (0 allocations: 0 bytes)


# nthreads=1, N=27, loc=1
# (:X)        82.911 ms (0 allocations: 0 bytes)
# (:X_test)   82.250 ms (0 allocations: 0 bytes)
# nthreads=2, N=27, loc=1
# (:X)        77.728 ms (11 allocations: 1008 bytes)
# (:X_test)   77.931 ms (0 allocations: 0 bytes)
# nthreads=3, N=27, loc=1
# (:X)        79.764 ms (16 allocations: 1.44 KiB)
# (:X_test)   79.565 ms (0 allocations: 0 bytes)
# nthreads=4, N=27, loc=1
# (:X)        80.638 ms (21 allocations: 1.88 KiB)
# (:X_test)   80.327 ms (0 allocations: 0 bytes)
# nthreads=5, N=27, loc=1
# (:X)        85.968 ms (26 allocations: 2.33 KiB)
# (:X_test)   85.183 ms (0 allocations: 0 bytes)
# nthreads=6, N=27, loc=1
# (:X)        83.232 ms (31 allocations: 2.77 KiB)
# (:X_test)   86.126 ms (0 allocations: 0 bytes)


# nthreads=1, N=27, loc=26
# (:X)        90.445 ms (0 allocations: 0 bytes)
# (:X_test)   91.236 ms (0 allocations: 0 bytes)
# nthreads=2, N=27, loc=26
# (:X)        84.067 ms (11 allocations: 1008 bytes)
# (:X_test)   82.908 ms (0 allocations: 0 bytes)
# nthreads=3, N=27, loc=26
# (:X)        85.520 ms (50 allocations: 3.20 KiB)
# (:X_test)   81.942 ms (0 allocations: 0 bytes)
# nthreads=4, N=27, loc=26
# (:X)        83.138 ms (56 allocations: 3.67 KiB)
# (:X_test)   83.344 ms (0 allocations: 0 bytes)
# nthreads=5, N=27, loc=26
# (:X)        83.194 ms (59 allocations: 3.66 KiB)
# (:X_test)   84.787 ms (0 allocations: 0 bytes)
# nthreads=6, N=27, loc=26
# (:X)        84.699 ms (63 allocations: 4.06 KiB)
# (:X_test)   86.761 ms (0 allocations: 0 bytes)
# nthreads=7, N=27, loc=26
# (:X)        86.438 ms (68 allocations: 4.52 KiB)
# (:X_test)   86.593 ms (0 allocations: 0 bytes)
# nthreads=8, N=27, loc=26
# (:X)        88.098 ms (74 allocations: 4.98 KiB)
# (:X_test)   86.711 ms (0 allocations: 0 bytes)
# nthreads=9, N=27, loc=26
# (:X)        88.768 ms (78 allocations: 5.39 KiB)
# (:X_test)   88.009 ms (0 allocations: 0 bytes)
# nthreads=10, N=27, loc=26
# (:X)        91.170 ms (84 allocations: 5.86 KiB)
# (:X_test)   91.436 ms (0 allocations: 0 bytes)
# nthreads=11, N=27, loc=26
# (:X)        89.793 ms (90 allocations: 6.34 KiB)
# (:X_test)   90.596 ms (0 allocations: 0 bytes)
# nthreads=12, N=27, loc=26
# (:X)        93.518 ms (93 allocations: 6.72 KiB)
# (:X_test)   90.147 ms (0 allocations: 0 bytes)


# nthreads=1, N=30, loc=1
# (:X)        721.110 ms (0 allocations: 0 bytes)
# (:X_test)   712.518 ms (0 allocations: 0 bytes)
# nthreads=2, N=30, loc=1
# (:X)        685.586 ms (11 allocations: 1008 bytes)
# (:X_test)   653.881 ms (0 allocations: 0 bytes)
# nthreads=3, N=30, loc=1
# (:X)        658.853 ms (16 allocations: 1.44 KiB)
# (:X_test)   670.592 ms (0 allocations: 0 bytes)
# nthreads=4, N=30, loc=1
# (:X)        670.990 ms (21 allocations: 1.88 KiB)
# (:X_test)   688.172 ms (0 allocations: 0 bytes)
# nthreads=5, N=30, loc=1
# (:X)        679.900 ms (26 allocations: 2.33 KiB)
# (:X_test)   674.324 ms (0 allocations: 0 bytes)
# nthreads=6, N=30, loc=1
# (:X)        688.539 ms (31 allocations: 2.77 KiB)
# (:X_test)   697.369 ms (3 allocations: 96 bytes)


# nthreads=1, N=30, loc=29
# (:X)        776.729 ms (0 allocations: 0 bytes)
# (:X_test)   746.518 ms (0 allocations: 0 bytes)
# nthreads=2, N=30, loc=29
# (:X)        670.826 ms (11 allocations: 1008 bytes)
# (:X_test)   740.097 ms (0 allocations: 0 bytes)
# nthreads=3, N=30, loc=29
# (:X)        720.817 ms (53 allocations: 3.33 KiB)
# (:X_test)   712.385 ms (0 allocations: 0 bytes)
# nthreads=4, N=30, loc=29
# (:X)        715.219 ms (59 allocations: 3.80 KiB)
# (:X_test)   700.401 ms (0 allocations: 0 bytes)
# nthreads=5, N=30, loc=29
# (:X)        723.867 ms (64 allocations: 4.23 KiB)
# (:X_test)   743.391 ms (1 allocation: 32 bytes)
# nthreads=6, N=30, loc=29
# (:X)        729.739 ms (68 allocations: 4.64 KiB)
# (:X_test)   747.555 ms (2 allocations: 64 bytes)
