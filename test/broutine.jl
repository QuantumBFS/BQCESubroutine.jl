using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BQCESubroutine: ctrl_offset
using YaoArrayRegister
using Test

function naive_broutine!(st, U, locs)
    n = log2dim1(st)
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    indices = [idx + 1 for idx in comspace]
    for k in subspace
        idx = indices .+ k
        st[idx] = U * st[idx]
    end
    return st
end

function naive_broutine!(st, U, locs, ctrl)
    n = log2dim1(st)
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, locs)
    offset = ctrl_offset(ctrl)
    indices = [idx + 1 for idx in comspace]
    for k in subspace
        idx = indices .+ k .+ offset
        st[idx] = U * st[idx]
    end
    return st
end

function naive_broutine_multi!(st, U, locs)
    for loc in locs
        naive_broutine!(st, U, loc)
    end
    return st
end


@testset "generic broutine" begin
    st = rand(ComplexF64, 1 << 15)
    U = rand(ComplexF64, 2, 2)
    @testset "2x2 i=$i" for i in 1:15
        locs = Locations(i)
        ctrl = CtrlLocations((mod1(i+2, 15), mod1(i+4, 15)))
        @test broutine!(copy(st), U, locs) ≈ naive_broutine!(copy(st), U, locs)
        @test broutine!(copy(st), U, locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
    end

    st = rand(ComplexF64, 1 << 10)
    U = rand(ComplexF64, 4, 4)
    @testset "4x4 i=$i" for i in 1:10
        locs = Locations((i, mod1(i+1, 10)))
        locs = sort(locs)
        ctrl = CtrlLocations((mod1(i+2, 10), mod1(i+4, 10)))
        @test broutine!(copy(st), U, locs) ≈ naive_broutine!(copy(st), U, locs)
        @test broutine!(copy(st), U, locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
    end

    st = rand(ComplexF64, 1 << 10)
    U = rand(ComplexF64, 8, 8)
    @testset "8x8 i=$i" for i in 1:10
        locs = Locations((i, mod1(i+1, 10), mod1(i+2, 10)))
        locs = sort(locs)
        ctrl = CtrlLocations((mod1(i+3, 10), mod1(i+4, 10)))
        @test broutine!(copy(st), U, locs) ≈ naive_broutine!(copy(st), U, locs)
        @test broutine!(copy(st), U, locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
    end

    st = rand(ComplexF64, 1 << 10)
    U = rand(ComplexF64, 16, 16)
    @testset "8x8 i=$i" for i in 1:10
        locs = Locations((i, mod1(i+1, 10), mod1(i+2, 10), mod1(i+3, 10)))
        locs = sort(locs)
        ctrl = CtrlLocations((mod1(i+4, 10), mod1(i+5, 10)))
        @test broutine!(copy(st), U, locs) ≈ naive_broutine!(copy(st), U, locs)
        @test broutine!(copy(st), U, locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
    end
end

@testset "basic broutine $G" for G in [:X, :Y, :Z, :H, :T, :S, :Sdag, :Tdag]
    U = getfield(BQCESubroutine, Symbol(:B, G))
    st = rand(ComplexF64, 1 << 10)

    @testset "$i=>$G" for i in 1:10
        locs = Locations(i)
        @test broutine!(copy(st), Val(G), locs) ≈ naive_broutine!(copy(st), U, locs)
    end

    @testset "($i, $(mod1(i+1, 10)))=>$G" for i in 1:10
        locs = sort(Locations((i, mod1(i+2, 10))))
        @test broutine!(copy(st), Val(G), locs) ≈ naive_broutine_multi!(copy(st), U, locs)
    end

    @testset "@ctrl $(mod1(i+1, 10)) $i=>$G" for i in 1:10
        locs = Locations(i)
        ctrl = CtrlLocations(mod1(i+1, 10))
        @test broutine!(copy(st), Val(G), locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
    end
end


using BenchmarkTools
locs = Locations((3, ));
ctrl = CtrlLocations((4, 5));
flag = (1, 1);
st = rand(ComplexF64, 1<<15);

@benchmark broutine!($(copy(st)), Val(:X), $locs, $ctrl)
@benchmark instruct!($(copy(st)), Val(:X), $(plain(locs)), $(plain(ctrl)), $flag)
