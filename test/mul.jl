using YaoLocations
using BenchmarkTools
using BQCESubroutine
using StrideArrays
using LoopVectorization
using ThreadingUtilities
using ArrayInterface
using CheapThreads
using BQCESubroutine: BitSubspace, bsubspace, bcomspace


function subspace_mul4x4!(st::AbstractMatrix{T}, comspace, U::AbstractMatrix, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end
    
    @inbounds for k in subspace
        Base.Cartesian.@nextract 4 idx i-> k + indices_i + offset

        for b in 1:size(st, 1)
            Base.Cartesian.@nexprs 4 i -> begin
                y_i = zero(T)
                Base.Cartesian.@nexprs 4 j -> begin
                    y_i += U_i_j * st[b, idx_j]
                end
            end

            Base.Cartesian.@nexprs 4 i -> begin
                st[b, idx_i] = y_i
            end
        end
    end
    return st
end

@inline function subspace_mul4x4_task!(st::AbstractMatrix{T}, indices, U, subspace, range, offset) where T
    D = StrideArrays.static_length(indices)
    y = StrideArray{T}(undef, (D, ))

    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            indices_i = indices[i]
        end

        Base.Cartesian.@nexprs 4 i -> begin
            Base.Cartesian.@nexprs 4 j -> begin
                U_i_j = U[i][j]
            end
        end
    end

    @inbounds for (s, b) in range
        k = subspace[s]
        Base.Cartesian.@nextract 4 idx i-> k + indices_i + offset

        Base.Cartesian.@nexprs 4 i -> begin
            y[i] = zero(T)
            Base.Cartesian.@nexprs 4 j -> begin
                y[i] += U_i_j * st[b, idx_j]
            end
        end

        Base.Cartesian.@nexprs 4 i -> begin
            st[b, idx_i] = y[i]
        end
    end
    return
end

function threaded_subspace_mul4x4!(st::AbstractMatrix{T}, comspace, U::AbstractMatrix, subspace, offset=0) where T    
    space = BQCESubroutine.CartesianSpace(1:length(subspace), 1:size(st, 1))
    nthreads = Threads.nthreads()
    U = (U[1, 1], U[1, 2], U[1, 3], U[1, 4]),
        (U[2, 1], U[2, 2], U[2, 3], U[2, 4]),
        (U[3, 1], U[3, 2], U[3, 3], U[3, 4]),
        (U[4, 1], U[4, 2], U[4, 3], U[4, 4])

    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1
    indices = (indices_1, indices_2, indices_3, indices_4)

    @batch for tid in 1:nthreads
        range = BQCESubroutine.schedule_task(space, tid, nthreads)
        subspace_mul4x4_task!(st, indices, U, subspace, range, offset)
    end
    return st
end


T = Float64
n = 10
S = rand(ComplexF64, 100, 1<<n);
U = rand(ComplexF64, 1<<2, 1<<2);
locs = Locations((1, 3))

subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
inds = StrideArray{Int}(undef, (length(comspace), ))
@simd ivdep for i in eachindex(inds)
    inds[i] = comspace[i] + 1
end

S1 = BQCESubroutine.subspace_mul_generic!(copy(S), inds, U, subspace);
S2 = BQCESubroutine.threaded_subspace_mul_generic!(copy(S), inds, U, subspace)
S3 = subspace_mul4x4!(copy(S), comspace, U, subspace)
S4 = threaded_subspace_mul4x4!(copy(S), comspace, U, subspace)

S1 ≈ S2
S1 ≈ S3
S1 ≈ S4

@benchmark BQCESubroutine.subspace_mul_generic!($(copy(S)), inds, $U, subspace)
@benchmark subspace_mul4x4!($(copy(S)), comspace, $U, subspace)
@benchmark BQCESubroutine.threaded_subspace_mul_generic!($(copy(S)), inds, $U, subspace)
@benchmark threaded_subspace_mul4x4!($(copy(S)), comspace, $U, subspace)

n = 15
S = rand(ComplexF64, 1<<n);
U = rand(ComplexF64, 1<<3, 1<<3);
locs = Locations((1, 3, 5))
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
indices = StrideArray{Int}(undef, (StaticInt{length(comspace)}(), ))
@simd ivdep for i in eachindex(indices)
    indices[i] = comspace[i] + 1
end

S2 = BQCESubroutine.subspace_mul_generic!(copy(S), indices, U, subspace)
S3 = BQCESubroutine.threaded_subspace_mul_generic!(copy(S), indices, U, subspace)
S2 ≈ S3

using YaoArrayRegister

@benchmark instruct!($(copy(S)), $U, (1, 3, 5))

@benchmark BQCESubroutine.subspace_mul_generic!($(copy(S)), indices, U, subspace)
@benchmark BQCESubroutine.threaded_subspace_mul_generic!($(copy(S)), indices, U, subspace)

@benchmark BQCESubroutine.subspace_mul_generic!(S, $indices, $U, $subspace) setup=(S=$(copy(S)))
@benchmark BQCESubroutine.threaded_subspace_mul_generic!(S, $indices, $U, $subspace) setup=(S=$(copy(S))) samples=1000 evals=1
t = @benchmark threaded_subspace_mm!(S, $indices, $U, $subspace) setup=(S=$(copy(S))) samples=1000 evals=1

@time threaded_subspace_mm!(S, indices, U, subspace);
BQCESubroutine.subspace_mul_generic!(S, indices, U, subspace);


D = ArrayInterface.static_length(indices)
U_re = StrideArray{T}(undef, (D, D))
U_im = StrideArray{T}(undef, (D, D))
@inbounds @simd ivdep for i in 1:length(U)
    U_re[i] = real(U[i])
    U_im[i] = imag(U[i])
end

subspace_ref = Ref(subspace)
Bmax = size(S, 1)
total = length(subspace) * (((Bmax-1)>>>3)+1)
nthreads = 6
len, rem = divrem(total, nthreads)
S4 = copy(S)
Sr = reinterpret(reshape, T, S4)
offset = 0
range1 = BQCESubroutine.div_thread(1, len, rem)
range2 = BQCESubroutine.div_thread(2, len, rem)
range3 = BQCESubroutine.div_thread(3, len, rem)
range4 = BQCESubroutine.div_thread(4, len, rem)
range5 = BQCESubroutine.div_thread(5, len, rem)
range6 = BQCESubroutine.div_thread(6, len, rem)

BQCESubroutine.subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range1, offset)
BQCESubroutine.subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range2, offset)
BQCESubroutine.subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range3, offset)
BQCESubroutine.subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range4, offset)
BQCESubroutine.subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range5, offset)
BQCESubroutine.subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range6, offset)

p = ThreadingUtilities.taskpointer(1)
BQCESubroutine.setup_subspace_mul_generic(p, S, indices, U_re, U_im, subspace_ref, range1, 0)

f = BQCESubroutine.SubspaceMulGeneric{T, D}()
f(p)

BQCESubroutine.launch_subspace_mul_generic(1, S, indices, U_re, U_im, subspace_ref, range2, offset)
ThreadingUtilities.wait(1)

GC.@preserve S U_re U_im subspace_ref begin
    for tid in 1:nthreads-1
        range = div_thread(tid, len, rem)
        launch_subspace_mul_generic(tid, S, indices, U_re, U_im, subspace_ref, range, offset)
    end

    range = div_thread(nthreads, len, rem)
    subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range, offset)

    for tid in 1:nthreads-1
        ThreadingUtilities.wait(tid)
    end
end