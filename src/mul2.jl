@inline function subspace_mul_kernel!(S::AbstractArray{T, 3}, C_re, C_im, indices, U_re, U_im, k::Int, _b::Int, Bmax::Int, offset::Int) where T
    b = _b << 3;
    bmax = b + 8
    if bmax ≤ Bmax # full static block
        @avx for n ∈ 1:8, m ∈ axes(U_re, 1)
            C_re_m_n = zero(T)
            C_im_m_n = zero(T)
            for i ∈ axes(U_re, 2)
                j = k + indices[i] + offset
                C_re_m_n += U_re[m,i] * S[1,n+b,j] - U_im[m,i] * S[2,n+b,j]
                C_im_m_n += U_re[m,i] * S[2,n+b,j] + U_im[m,i] * S[1,n+b,j]
            end
            C_re[m,n] = C_re_m_n
            C_im[m,n] = C_im_m_n
        end
        @avx for n ∈ 1:8, m ∈ axes(U_re, 1)
            S_m = k + indices[m] + offset
            S[1,n+b,S_m] = C_re[m,n]
            S[2,n+b,S_m] = C_im[m,n]
        end
        # AmulB!(C_re, C_im, U_re, U_im, 
    else # dynamic block
        Nmax = 8 + Bmax - bmax
        @avx for n ∈ 1:Nmax, m ∈ axes(U_re, 1)
            C_re_m_n = zero(T)
            C_im_m_n = zero(T)
            for i ∈ axes(U_re, 2)
                j = k + indices[i] + offset
                C_re_m_n += U_re[m,i] * S[1,n+b,j] - U_im[m,i] * S[2,n+b,j]
                C_im_m_n += U_re[m,i] * S[2,n+b,j] + U_im[m,i] * S[1,n+b,j]
            end
            C_re[m,n] = C_re_m_n
            C_im[m,n] = C_im_m_n
        end
        @avx for n ∈ 1:Nmax, m ∈ axes(U_re, 1)
            S_m = k + indices[m] + offset
            S[1,n+b,S_m] = C_re[m,n]
            S[2,n+b,S_m] = C_im[m,n]
        end
    end
    return
end

function subspace_mul_generic!(S::Matrix{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    C_re = StrideArray{T}(undef, (D, StaticInt{8}()))
    C_im = StrideArray{T}(undef, (D, StaticInt{8}()))
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    Ur = reinterpret(reshape, T, U)

    @inbounds @simd ivdep for i in 1:length(U_re)
        U_re[i] = Ur[2i-1]
        U_im[i] = Ur[2i]
    end

    Sr = reinterpret(reshape, T, S)
    Bmax = size(S,1)
    for k in subspace, _b ∈ 0:(Bmax-1) >>> 3
        subspace_mul_kernel!(Sr, C_re, C_im, indices, U_re, U_im, k, _b, Bmax, offset)
    end
    return S
end

struct SubspaceMulGeneric{T, D} end

function (k::SubspaceMulGeneric{T, D})(p::Ptr{UInt}) where {T, D}
    P = Tuple{Ptr{T}, Ptr{T}, Ptr{T}, Ptr{Int}, Ptr{BitSubspace},
        Tuple{Int, Int}, UnitRange{Int}, Int}
    _, (S_ptr, U_re_ptr, U_im_ptr, indices_ptr, subspace_ptr,
            S_size, range, offset) =
        ThreadingUtilities.load(p, P, 5*sizeof(UInt))

    S = StrideArray(PtrArray(S_ptr, (StaticInt{2}(), S_size...)))
    U_re = StrideArray(PtrArray(U_re_ptr, (D, D)))
    U_im = StrideArray(PtrArray(U_im_ptr, (D, D)))
    indices = StrideArray(PtrArray(indices_ptr, (D, )))
    subspace = ccall(:jl_value_ptr, Ref{Base.RefValue{BitSubspace}}, (Ptr{Cvoid},), subspace_ptr)[]

    subspace_mul_generic_task!(S, indices, U_re, U_im, subspace, range, offset)
    return
end

@inline function subspace_mul_generic_task!(Sr::AbstractArray{T, 3}, indices, U_re, U_im, subspace, range, offset) where T
    D = ArrayInterface.static_length(indices)
    C_re = StrideArray{T}(undef, (D, StaticInt{8}()))
    C_im = StrideArray{T}(undef, (D, StaticInt{8}()))
    Bmax = size(Sr, 2)
    stride = ((Bmax-1) >>> 3) + 1

    for idx in range
        s, _b = get_indices(idx, stride)
        k = subspace[s]
        subspace_mul_kernel!(Sr, C_re, C_im, indices, U_re, U_im, k, _b, Bmax, offset)
    end
    return Sr
end

function subspace_mul_generic_ptr(::AbstractMatrix{Complex{T}}, indices) where T
    D = ArrayInterface.static_length(indices)
    sig = SubspaceMulGeneric{T, D}()
    @cfunction($sig, Cvoid, (Ptr{UInt}, ))
end

function setup_subspace_mul_generic(p::Ptr{UInt}, S::Matrix{Complex{T}}, indices, U_re, U_im,
        subspace_ref::Ref{BitSubspace}, range, offset::Int) where T

    D = StrideArrays.static_length(indices)
    S_ptr = Base.unsafe_convert(Ptr{T}, S)
    U_re_ptr = pointer(U_re)
    U_im_ptr = pointer(U_im)
    indices_ptr = Base.unsafe_convert(Ptr{Int}, indices)
    subspace_ptr = Base.unsafe_convert(Ptr{BitSubspace}, subspace_ref)

    fptr = subspace_mul_generic_ptr(S, indices)
    fptr_offset = ThreadingUtilities.store!(p, fptr, sizeof(UInt))
    content = (S_ptr, U_re_ptr, U_im_ptr, indices_ptr, subspace_ptr,
        size(S), range, offset)
    ThreadingUtilities.store!(p, content, fptr_offset)
    return
end

function launch_subspace_mul_generic(tid, S, indices, U_re, U_im, subspace,
        range, offset=0)

    ThreadingUtilities.launch(setup_subspace_mul_generic, tid, S, indices, U_re,
        U_im, subspace, range, offset)
end

function get_indices(idx, stride)
    # subspace indices start from 1
    # batch indices start from 0
    x, y = divrem(idx-1, stride)
    return x+1, y
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
    return f:l
end

function threaded_subspace_mul_generic!(S::Matrix{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = ArrayInterface.static_length(indices)
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    @inbounds @simd ivdep for i in 1:length(U)
        U_re[i] = real(U[i])
        U_im[i] = imag(U[i])
    end

    subspace_ref = Ref(subspace)
    Bmax = size(S, 1)
    # evenly distribute both dimension
    # this will provide better performance
    # when there is a small subspace large batch
    total = length(subspace) * (((Bmax-1)>>>3)+1)
    nthreads = Threads.nthreads()
    len, rem = divrem(total, nthreads)
    Sr = reinterpret(reshape, T, S)

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
    return S
end
