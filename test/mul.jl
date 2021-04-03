using YaoLocations
using BenchmarkTools
using BQCESubroutine
using StrideArrays
using LoopVectorization
using ThreadingUtilities
using ArrayInterface
using BQCESubroutine: BitSubspace, bsubspace, bcomspace

@inline function subspace_mul_kernel!(S, C_re, C_im, indices, U_re, U_im, s::Int, subspace, Bmax::Int, offset::Int)
    k = subspace[s]
    for _b ∈ 0:(Bmax-1) >>> 3
        BQCESubroutine.subspace_mul_kernel!(S, C_re, C_im, indices, U_re, U_im, k, _b, Bmax, offset)
    end
end

struct SubspaceMatrixMul{T, D} end

function (k::SubspaceMatrixMul{T, D})(p::Ptr{UInt}) where {T, D}
    P = Tuple{Ptr{T}, Ptr{T}, Ptr{T}, Ptr{Int}, Ptr{BitSubspace}, Tuple{Int, Int}, UnitRange{Int}, Int}
    _, (S_ptr, U_re_ptr, U_im_ptr, indices_ptr, subspace_ptr, S_size, thread_range, offset) =
        ThreadingUtilities.load(p, P, 5*sizeof(UInt))

    S = StrideArray(PtrArray(S_ptr, (StaticInt{2}(), S_size...)))
    U_re = StrideArray(PtrArray(U_re_ptr, (D, D)))
    U_im = StrideArray(PtrArray(U_im_ptr, (D, D)))
    indices = StrideArray(PtrArray(indices_ptr, (D, )))
    subspace = ccall(:jl_value_ptr, Ref{Base.RefValue{BitSubspace}}, (Ptr{Cvoid},), subspace_ptr)[]

    C_re = StrideArray{T}(undef, (D, StaticInt{8}()))
    C_im = StrideArray{T}(undef, (D, StaticInt{8}()))

    for s in thread_range
        subspace_mul_kernel!(S, C_re, C_im, indices, U_re, U_im, s, subspace, S_size[1], offset)
    end
    return
end

function subspace_mm_ptr(::Matrix{Complex{T}}, indices) where T
    D = ArrayInterface.static_length(indices)
    sig = SubspaceMatrixMul{T, D}()
    @cfunction($sig, Cvoid, (Ptr{UInt}, ))
end

function setup_subspace_mm(p::Ptr{UInt}, S::Matrix{Complex{T}}, indices, U_re, U_im, subspace_ref::Ref{BitSubspace}, l::Int, f::Int, offset::Int) where T
    D = StrideArrays.static_length(indices)
    S_ptr = Base.unsafe_convert(Ptr{T}, S)
    U_re_ptr = pointer(U_re)
    U_im_ptr = pointer(U_im)
    indices_ptr = Base.unsafe_convert(Ptr{Int}, indices)
    subspace_ptr = Base.unsafe_convert(Ptr{BitSubspace}, subspace_ref)

    fptr = subspace_mm_ptr(S, indices)
    fptr_offset = ThreadingUtilities.store!(p, fptr, sizeof(UInt))
    content = (S_ptr, U_re_ptr, U_im_ptr, indices_ptr, subspace_ptr, size(S), l:f, offset)
    ThreadingUtilities.store!(p, content, fptr_offset)
    return
end

function launch_subspace_mm(tid, S, indices, U_re, U_im, subspace, l, f, offset=0)
    ThreadingUtilities.launch(setup_subspace_mm, tid, S, indices, U_re, U_im, subspace, l, f, offset)
end

function div_thread(tid, len, rem)
    f = (tid - 1) * len + 1
    l = f + len - 1

    if rem > 0
        if tid <= rem
            f = f + (tid - 1)
            l = l + tid
        else
            f = f + rem
            l = l + rem
        end
    end
    return f, l
end

function threaded_subspace_mm!(S::Matrix{Complex{T}}, indices, U, subspace, offset=0) where T
    D = ArrayInterface.static_length(indices)
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    @inbounds @simd ivdep for i in 1:length(U)
        U_re[i] = real(U[i])
        U_im[i] = imag(U[i])
    end

    subspace_ref = Ref(subspace)
    total = length(subspace)
    nthreads = Threads.nthreads()
    len, rem = divrem(total, nthreads)

    GC.@preserve S U_re U_im subspace_ref begin
        for tid in 1:nthreads-1
            f, l = div_thread(tid, len, rem)
            launch_subspace_mm(tid, S, indices, U_re, U_im, subspace_ref, f, l, offset)
        end

        # execute on main thread
        f, l = div_thread(nthreads, len, rem)
        C_re = StrideArray{T}(undef, (D, StaticInt{8}()))
        C_im = StrideArray{T}(undef, (D, StaticInt{8}()))

        for s in f:l
            subspace_mul_kernel!(reinterpret(reshape, T, S), C_re, C_im, indices, U_re, U_im, s, subspace, size(S, 1), offset)
        end

        for tid in 1:nthreads-1
            ThreadingUtilities.wait(tid)
        end
    end
    return S
end

T = Float64
n = 5
S = rand(ComplexF64, 1000, 1<<n);
U = rand(ComplexF64, 1<<3, 1<<3);
locs = Locations((1, 3, 5))
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
indices = StrideArray{Int}(undef, (StaticInt{length(comspace)}(), ))
@simd ivdep for i in eachindex(indices)
    indices[i] = comspace[i] + 1
end

S1 = threaded_subspace_mm!(copy(S), indices, U, subspace)
S2 = BQCESubroutine.subspace_mul_generic!(copy(S), indices, U, subspace)
S3 = BQCESubroutine.threaded_subspace_mul_generic!(copy(S), indices, U, subspace)
S1 ≈ S2
S1 ≈ S3

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