using Test
using LinearAlgebra
using BQCESubroutine
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using BQCESubroutine: ctrl_offset, bcomspace, bsubspace, broutine2x2!, broutine!
using ThreadingUtilities

function naive_broutine!(st::AbstractVector, U, locs)
    n = log2dim(st)
    subspace = bsubspace(n, sort(locs))
    comspace = bcomspace(n, sort(locs))
    indices = [idx + 1 for idx in comspace]
    for k in subspace
        idx = indices .+ k
        st[idx] = U * st[idx]
    end
    return st
end

function naive_broutine!(st::AbstractMatrix, U, locs)
    n = log2dim(st)
    subspace = bsubspace(n, sort(locs))
    comspace = bcomspace(n, sort(locs))
    indices = [idx + 1 for idx in comspace]
    for b in 1:size(st, 1)
        for k in subspace
            idx = indices .+ k
            st[b, idx] = U * st[b, idx]
        end
    end
    return st
end

function naive_broutine!(st::AbstractVector, U, locs, ctrl)
    n = log2dim(st)
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, sort(locs))
    offset = ctrl_offset(ctrl)
    indices = [idx + 1 for idx in comspace]
    for k in subspace
        idx = indices .+ k .+ offset
        st[idx] = U * st[idx]
    end
    return st
end

function naive_broutine!(st::AbstractMatrix, U, locs, ctrl)
    n = log2dim(st)
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, sort(locs))
    offset = ctrl_offset(ctrl)
    indices = [idx + 1 for idx in comspace]
    for b in 1:size(st, 1)
        for k in subspace
            idx = indices .+ k .+ offset
            st[b, idx] = U * st[b, idx]
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
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), rand(ComplexF64, 5, 1 << N)]
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
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), rand(ComplexF64, 5, 1 << N)]
        U = getfield(BQCESubroutine, Symbol(:B, G))

        @testset "$i=>$G" for i in 1:N
            locs = Locations(i)
            @test isapprox(broutine!(copy(st), Val(G), locs), naive_broutine!(copy(st), U, locs); rtol=1e-8)
        end

        @testset "($i, $(mod1(i+1, N)))=>$G" for i in 1:N
            locs = sort(Locations((i, mod1(i+2, N))))
            S1 = broutine!(copy(st), Val(G), locs)
            S2 = naive_broutine_multi!(copy(st), U, locs)
            @test isapprox(S1, S2; rtol=1e-8)
        end

        @testset "@ctrl $(mod1(i+1, N)) $i=>$G" for i in 1:N
            locs = Locations(i)
            ctrl = CtrlLocations(mod1(i+1, N))
            @test isapprox(broutine!(copy(st), Val(G), locs, ctrl), naive_broutine!(copy(st), U, locs, ctrl); rtol=1e-8)
        end
    end
end

@testset "parameterize gate $G" for G in [:Rx, :Ry, :Rz]
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), rand(ComplexF64, 5, 1 << N)]
        U = getfield(BQCESubroutine, Symbol(:B, G))(0.2)

        @testset "$i=>$G" for i in 1:N
            locs = Locations(i)
            @test broutine!(copy(st), Val(G), locs, 0.2) ≈ naive_broutine!(copy(st), U, locs)
        end

        @testset "($i, $(mod1(i+1, N)))=>$G" for i in 1:N
            locs = sort(Locations((i, mod1(i+2, N))))
            @test broutine!(copy(st), Val(G), locs, 0.2) ≈ naive_broutine_multi!(copy(st), U, locs)
        end

        @testset "@ctrl $(mod1(i+1, N)) $i=>$G" for i in 1:N
            locs = Locations(i)
            ctrl = CtrlLocations(mod1(i+1, N))
            @test broutine!(copy(st), Val(G), locs, ctrl, 0.2) ≈ naive_broutine!(copy(st), U, locs, ctrl)
        end
    end
end

@testset "parameterize gate PSWAP" begin
    U = BQCESubroutine.BPSWAP(0.2)
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), rand(ComplexF64, 5, 1 << N)]
        @testset "$((i, mod1(i+1, N)))=>PSWAP" for i in 1:N
            locs = Locations((i, mod1(i+1, N)))
            @test broutine!(copy(st), Val(:PSWAP), locs, 0.2) ≈ naive_broutine!(copy(st), U, locs)
        end

        @testset "@ctrl $(mod1(i+1, N)) $i=>PSWAP" for i in 1:N
            locs = sort(Locations((i, mod1(i+1, N))))
            ctrl = CtrlLocations(mod1(i+2, N))
            @test broutine!(copy(st), Val(:PSWAP), locs, ctrl, 0.2) ≈ naive_broutine!(copy(st), U, locs, ctrl)
        end
    end
end

@testset "gate SWAP" begin
    U = BQCESubroutine.BSWAP
    @testset "size(st)=$(size(st))" for st in [rand(ComplexF64, 1 << N), rand(ComplexF64, 5, 1 << N)]
        @testset "$((i, mod1(i+1, N)))=>SWAP" for i in 1:N
            locs = Locations((i, mod1(i+1, N)))
            @test broutine!(copy(st), Val(:SWAP), locs) ≈ naive_broutine!(copy(st), U, locs)
        end

        @testset "@ctrl $(mod1(i+1, N)) $i=>SWAP" for i in 1:N
            locs = sort(Locations((i, mod1(i+1, N))))
            ctrl = CtrlLocations(mod1(i+2, N))
            @test broutine!(copy(st), Val(:SWAP), locs, ctrl) ≈ naive_broutine!(copy(st), U, locs, ctrl)
        end
    end
end

@testset "diagonal" begin
    #@testset "dtype=$(dtype), size(st)=$(size(st))" for dtype in [Float64, ComplexF64], st in [rand(dtype, 1 << N), rand(dtype, 5, 1 << N)]
    @testset "dtype=$(dtype), size(st)=$(size(st))" for dtype in [Float64], st in [rand(dtype, 1 << N), rand(dtype, 5, 1 << N)]
        @testset "$(1<<M) x $(1<<M)" for M in [1,2,3,4]
            U = Diagonal(rand(dtype, 1<<M))
            U_dense = Matrix(U)
            @testset "i=$i" for i in 1:N
                locs = Locations([mod1(i+k, N) for k in 0:M-1])
                locs = sort(locs)
                ctrl = CtrlLocations((mod1(i+M, N), mod1(i+M+2, N)))
                @test broutine!(copy(st), U, locs) ≈ broutine!(copy(st), U_dense, locs)
                @test broutine!(copy(st), U, locs, ctrl) ≈ broutine!(copy(st), U_dense, locs, ctrl)
            end
        end
    end
end
