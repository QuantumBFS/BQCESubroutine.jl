# export JULIA_NUM_THREADS=128

using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations

function X_gate_loc_1_128_threads_MWE!(st::AbstractVector{T} where T, nqubits::Int)
    space = BQCESubroutine.bsubspace(nqubits, (1,))
    var"##step_1_l#1030" = 1
    Threads.@threads for base in space
        for var"##idx#1027_1" in 0:0
            var"##I#1036_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(base, var"##idx#1027_1"), 1)
            var"##I#1036_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(base, var"##idx#1027_1"), var"##step_1_l#1030"), 1)
            var"##T#1037_1" = st[var"##I#1036_2"]
            var"##T#1037_2" = st[var"##I#1036_1"]
            st[var"##I#1036_1"] = var"##T#1037_1"
            st[var"##I#1036_2"] = var"##T#1037_2"
        end
    end
    return st
end

Threads.nthreads()
@testset "N=$N" for N in 1:15
    loc = 1
    st = rand(Float64, 1<<N);
    locs = BQCESubroutine.Locations(loc);
    st0 = X_gate_loc_1_128_threads_MWE!(copy(st), N);
    st1 = broutine!(copy(st), [0 1; 1 0], locs);
    println("N=$N, loc=$loc, |err| = ", norm(st0-st1))
    @test st0 ≈ st1
end;
