using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!
using Polyester

@testset "BX N=$N" for N in [1, 2, 3, 4, 5, 15, 20]
    for i in 1:N
        st = rand(Float64, 1<<N);
        locs = BQCESubroutine.Locations(i);
        st0 = broutine!(copy(st), Val(:X), locs);
        st1 = broutine!(copy(st), [0 1; 1 0], locs);
        @test st0 ≈ st1
    end
end;

@testset "BPSWAP N=$N" for N in [2, 3, 4, 5, 15, 20]
    for i in 1:N, j in i+1:N
        st = rand(ComplexF64, 1<<N);
        locs = BQCESubroutine.Locations([i, j]);
        θ = 2π * rand();
        st0 = broutine!(copy(st), Val(:PSWAP), locs, θ);
        st1 = broutine!(copy(st), BQCESubroutine.BPSWAP(θ), locs);
        #println("N=$N, i=$i, j=$j, |err|=", norm(st0-st1))
        @test st0 ≈ st1
    end
end;
