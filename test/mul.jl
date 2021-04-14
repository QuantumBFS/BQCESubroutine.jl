using YaoLocations
using BenchmarkTools
using BQCESubroutine
using StrideArrays
using LoopVectorization
using ThreadingUtilities
using ArrayInterface
using BQCESubroutine: BitSubspace, bsubspace, bcomspace

y_re = StrideArray{T}(undef, (StaticInt{2}(), ))

function subspace_mul4x4!(st::AbstractMatrix{T}, comspace, U::AbstractMatrix, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end
    
    @inbounds Threads.@threads for k in subspace
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


T = Float64
n = 10
S = rand(ComplexF64, 100, 1<<n);
U = rand(ComplexF64, 1<<2, 1<<2);
locs = Locations((1, 3))

subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
indices = StrideArray{Int}(undef, (length(comspace), ))
@simd ivdep for i in eachindex(indices)
    indices[i] = comspace[i] + 1
end

using SparseArrays
S = sprand(1000, 1000, 0.001)
isbitstype(BigFloat)
struct MyFoo
    a::Int
    b::Int
    c::Int
end
StrideArray{ComplexF64}(undef, (4, 4))

ref = Ref(S)

Base.unsafe_load(Ptr{typeof(S)}, ref)

S1 = BQCESubroutine.subspace_mul_generic!(copy(S), indices, U, subspace)
S2 = BQCESubroutine.threaded_subspace_mul_generic!(copy(S), indices, U, subspace)
S3 = subspace_mul4x4!(copy(S), comspace, U, subspace)

S1 ≈ S2
@benchmark BQCESubroutine.subspace_mul_generic!($(copy(S)), indices, $U, subspace)
@benchmark subspace_mul4x4!($(copy(S)), comspace, $U, subspace)
@benchmark BQCESubroutine.threaded_subspace_mul_generic!($(copy(S)), indices, $U, subspace)

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