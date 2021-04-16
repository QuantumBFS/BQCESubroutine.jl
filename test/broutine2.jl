using Test
using LoopVectorization
using LinearAlgebra
using BQCESubroutine
using CheapThreads
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using BQCESubroutine: ctrl_offset, bcomspace, bsubspace, broutine!, log2dim
using ThreadingUtilities
using BenchmarkTools

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

function broutine2x2!(S::AbstractMatrix{Complex{T}}, U::AbstractMatrix, locs::Locations) where T
    plain_locs = plain(locs)::Int
    step_1 = 1 << (plain(locs) - 1)
    step_2 = 1 << plain(locs)

    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];

    Hmax = size(S, 2)
    nthreads = Threads.nthreads()
    space = BQCESubroutine.CartesianSpace(0:step_1-1, 1:size(S, 1), 0:(Hmax>>>plain_locs)-1)
    
    if step_1 == 1
        @inbounds @batch for _j in 0:(Hmax>>>plain_locs)-1, b in axes(S, 1)
            j = _j << plain_locs
            
            ST1 = U11 * S[b, j+1] + U12 * S[b, j+step_1+1]
            ST2 = U21 * S[b, j+1] + U22 * S[b, j+step_1+1]

            S[b, j+1] = ST1
            S[b, j+step_1+1] = ST2
        end
        return S
    end

    if step_1 == 2
        @inbounds @batch for _j in 0:(Hmax>>>plain_locs)-1, b in axes(S, 1)
            j = _j << plain_locs
            Base.Cartesian.@nexprs 2 k->begin
                ST1 = U11 * S[b, j+k] + U12 * S[b, j+k+step_1]
                ST2 = U21 * S[b, j+k] + U22 * S[b, j+k+step_1]

                S[b, j+k] = ST1
                S[b, j+k+step_1] = ST2
            end
        end
        return S
    end
    @inbounds @batch for tid in 1:nthreads
        range = BQCESubroutine.schedule_task(space, tid, nthreads)
        broutine2x2_task!(S, (U11, U12, U21, U22), range, step_1, plain_locs)
    end

    # @inbounds @batch for j in 0:step_2:size(S, 2)-step_1, b in 1:size(S, 1), i in j:j+step_1-1
    #     ST1 = U11 * S[b, i+1] + U12 * S[b, i+step_1+1]
    #     ST2 = U21 * S[b, i+1] + U22 * S[b, i+step_1+1]

    #     S[b, i+1] = ST1
    #     S[b, i+step_1+1] = ST2
    # end
    return S
end

function broutine2x2_task!(S, (U11, U12, U21, U22), range, step_1, plain_locs)
    for (k, b, _j) in range
        j = _j << plain_locs
        i = j+k
        ST1 = U11 * S[b, i+1] + U12 * S[b, i+step_1+1]
        ST2 = U21 * S[b, i+1] + U22 * S[b, i+step_1+1]

        S[b, i+1] = ST1
        S[b, i+step_1+1] = ST2
    end 
end



N = 20
S = rand(ComplexF64, 1, 1 << N)
U = rand(ComplexF64, 2, 2)
locs = Locations(19)
S1 = broutine2x2!(copy(S), U, locs);
S2 = naive_broutine!(copy(S), U, locs)
S3 = broutine!(copy(S), U, locs)
S1 ≈ S2

@benchmark broutine2x2!(S, U, locs) setup=(S=$(copy(S)))
@benchmark broutine!(S, U, locs) setup=(S=$(copy(S)))

step_1 = 1 << 0
step_2 = 1 << 1

l1 = 0:2:size(S, 2)-step_1
length(l1)
size(S, 2) >>> 1

l2 = 0:(size(S, 2)>>>1)-1

l2[1] << 1
l2[2] << 1
l2[end] << 1

# S1 ≈ S2
# S1 ≈ S3

# 1 << 1

# @benchmark broutine2x2!($(copy(S)), U, locs)
# @benchmark broutine!($(copy(S)), U, locs)
