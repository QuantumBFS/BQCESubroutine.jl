using BQCESubroutine
using YaoLocations
using Polyester
using LoopVectorization
using BenchmarkTools
using Test

include("BX_vec.jl")
# include("BX_mat.jl")
# include("BCX_vec.jl")
# include("BCX_mat.jl")

function naive_broutine!(st::AbstractVector, U, locs)
    n = BQCESubroutine.log2dim(st)
    subspace = BQCESubroutine.bsubspace(n, sort(locs))
    comspace = BQCESubroutine.bcomspace(n, sort(locs))
    indices = [idx + 1 for idx in comspace]
    for k in subspace
        idx = indices .+ k
        st[idx] = U * st[idx]
    end
    return st
end

const BX = [0 1; 1 0]

N = 25

@testset "BX" begin
    @testset "loc = $loc" for loc in 1:N
        st = rand(ComplexF64, 1<<N)
        locs = Locations(loc)
        @test isapprox(BQCESubroutine.basic_broutine!(copy(st), Val(:X), locs), naive_broutine!(copy(st), BX, locs))
        @test isapprox(BQCESubroutine.basic_broutine!(copy(st), Val(:X_test), locs), naive_broutine!(copy(st), BX, locs))
        @test isapprox(BQCESubroutine.threaded_basic_broutine!(copy(st), Val(:X), locs), naive_broutine!(copy(st), BX, locs))
    end
end

for loc in 1:N
    println("loc = $loc")
    locs = Locations(loc)
    bb = @benchmark BQCESubroutine.basic_broutine!(st, Val(:X), $locs) setup=(st=rand(ComplexF64, 1<<N))
    # btest = @benchmark BQCESubroutine.basic_broutine!(st, Val(:X_test), $locs) setup=(st=rand(ComplexF64, 1<<N))

    plain_locs = (YaoLocations.plain)(locs)
    nqubits = N
    nthreads = Threads.nthreads()
    if loc <= 3
        subspace = BQCESubroutine.bsubspace(nqubits, Locations(1:loc))
    else
        subspace = BQCESubroutine.bsubspace(nqubits, Locations((1, 2, 3, loc)))
    end
    step_1_l = 1 << (loc - 1)
    space = BQCESubroutine.CartesianSpace(1:length(subspace))
    iter = BQCESubroutine.schedule_task(space, rand(1:nthreads), nthreads)

    bt = @benchmark BQCESubroutine.threaded_basic_broutine!(st, Val(:X), $locs) setup=(st=rand(ComplexF64, 1<<N))
    bk = @benchmark threaded_basic_broutine_kernel!(st, Val(:X), $iter, $step_1_l, $subspace) setup=(st=rand(ComplexF64, 1<<N))
    # println("  time: basic = $(mean(bb).time/1e6) ms, test = $(mean(btest).time/1e6) ms, threaded = $(mean(bt).time/1e6) ms, kernel = $(mean(bk).time/1e6) ms")
    println("  time: basic = $(mean(bb).time/1e6) ms, threaded = $(mean(bt).time/1e6) ms, kernel = $(mean(bk).time/1e6) ms")
end