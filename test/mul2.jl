using YaoLocations
using BenchmarkTools
using BQCESubroutine
using StrideArrays
using LoopVectorization
using ThreadingUtilities
using ArrayInterface
using BQCESubroutine: BitSubspace, bsubspace, bcomspace

struct SubspaceMulComplexTask{D, T, UType, IType}
    S::Matrix{Complex{T}}
    indices::IType
    U_re::UType
    U_im::UType
    subspace::BitSubspace
    range::UnitRange{Int}
    offset::Int
end

function SubspaceMulComplexTask(S::Matrix{Complex{T}}, indices, U_re, U_im, subspace, range, offset) where T
    D = ArrayInterface.static_length(indices)
    UType = typeof(U_re)
    IType = typeof(indices)
    SubspaceMulComplexTask{D, T, UType, IType}(S, indices, U_re, U_im, subspace, range, offset)
end

struct SubspaceMulGeneric{TaskType} end

function (::SubspaceMulGeneric{T})(p::Ptr{UInt}) where {T}
    _, task_ptr = ThreadingUtilities.load(p, Ptr{T}, sizeof(UInt))

    task = ccall(:jl_value_ptr, Ref{Base.RefValue{T}}, (Ptr{Cvoid},), task_ptr)[]

    S = StrideArray(PtrArray(S_ptr, (StaticInt{2}(), S_size...)))
    U_re = StrideArray(PtrArray(U_re_ptr, (D, D)))
    U_im = StrideArray(PtrArray(U_im_ptr, (D, D)))
    indices = StrideArray(PtrArray(indices_ptr, (D, )))
    subspace = ccall(:jl_value_ptr, Ref{Base.RefValue{BitSubspace}}, (Ptr{Cvoid},), subspace_ptr)[]

    Sr = reinterpret(reshape, real(task.S) task.S)
    subspace_mul_generic_task!(S, indices, U_re, U_im, subspace, range, offset)
end

T = Float64
n = 10
S = rand(ComplexF64, 1000, 1<<n);
U = rand(ComplexF64, 1<<3, 1<<3);
locs = Locations((1, 3, 5))
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
indices = StrideArray{Int}(undef, (StaticInt{length(comspace)}(), ))
@simd ivdep for i in eachindex(indices)
    indices[i] = comspace[i] + 1
end
B, N = size(S); D = StaticInt{length(comspace)}() # force static
U_re = StrideArray{T}(undef, (D, D))
U_im = StrideArray{T}(undef, (D, D))
@inbounds @simd ivdep for i in 1:length(U)
    U_re[i] = real(U[i])
    U_im[i] = imag(U[i])
end

task = SubspaceMulComplexTask(S, indices, U_re, U_im, subspace, 1:length(subspace), offset)
task_ref = Ref(task)

S = StrideArray(PtrArray(S_ptr, (StaticInt{2}(), S_size...)))
p = ThreadingUtilities.taskpointer(2)
task_ptr = Base.unsafe_convert(Ptr{typeof(task)}, task_ref)
offset = ThreadingUtilities.store!(p, task_ptr, sizeof(UInt))
ThreadingUtilities.load(p, typeof(task_ptr), sizeof(UInt))

ntask = ccall(:jl_value_ptr, Ref{Base.RefValue{typeof(task)}}, (Ptr{Cvoid},), task_ptr)[]
