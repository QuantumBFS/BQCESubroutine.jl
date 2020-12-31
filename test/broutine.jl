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
    for b in 1:size(st, 2)
        for k in subspace
            idx = indices .+ k
            st[idx, b] = U * st[idx, b]
        end
    end
    return st
end

function naive_broutine!(st, U, locs, ctrl)
    n = log2dim1(st)
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, locs)
    offset = ctrl_offset(ctrl)
    indices = [idx + 1 for idx in comspace]
    for b in 1:size(st, 2)
        for k in subspace
            idx = indices .+ k .+ offset
            st[idx, b] = U * st[idx, b]
        end
    end
    return st
end

function naive_broutine_multi!(st, U, locs)
    for loc in locs
        naive_broutine!(st, U, loc)
    end
    return st
end

const N = 10

@testset "generic broutine" begin
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), transpose(rand(ComplexF64, 5, 1 << N))]
        @testset "$(1<<M)x$(1<<M)" for M in [1,2,3,4]
            U = rand(ComplexF64, 1<<M, 1<<M)
            @testset "i=$i" for i in 1:N
                locs = Locations([mod1(i+k, N) for k in 0:M-1])
                locs = sort(locs)
                ctrl = CtrlLocations((mod1(i+M, N), mod1(i+M+2, N)))
                @test broutine!(copy(st), U, locs) ≈ naive_broutine!(copy(st), U, locs)
                @test broutine!(copy(st), U, locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
            end
        end
    end
end

@testset "basic broutine $G" for G in [:X, :Y, :Z, :H, :T, :S, :Sdag, :Tdag]
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), transpose(rand(ComplexF64, 5, 1 << N))]
        U = getfield(BQCESubroutine, Symbol(:B, G))

        @testset "$i=>$G" for i in 1:N
            locs = Locations(i)
            @test broutine!(copy(st), Val(G), locs) ≈ naive_broutine!(copy(st), U, locs)
        end

        @testset "($i, $(mod1(i+1, N)))=>$G" for i in 1:N
            locs = sort(Locations((i, mod1(i+2, N))))
            @test broutine!(copy(st), Val(G), locs) ≈ naive_broutine_multi!(copy(st), U, locs)
        end

        @testset "@ctrl $(mod1(i+1, N)) $i=>$G" for i in 1:N
            locs = Locations(i)
            ctrl = CtrlLocations(mod1(i+1, N))
            @test broutine!(copy(st), Val(G), locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
        end
    end
end
