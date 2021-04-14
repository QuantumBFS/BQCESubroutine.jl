@inline function subspace_mul_kernel!(S::AbstractMatrix{T}, y_re, y_im, indices, U_re, U_im, k::Int, offset::Int) where {T <: Base.HWReal}
    @avx for i in axes(U_re, 1)
        y_re_i = zero(T)
        y_im_i = zero(T)
        for j in axes(U_re, 2)
            idx_j = indices[j] + k + offset
            y_re_i += U_re[i, j] * S[1, idx_j] - U_im[i, j] * S[2, idx_j]
            y_im_i += U_re[i, j] * S[2, idx_j] + U_im[i, j] * S[1, idx_j]
        end
        y_re[i] = y_re_i
        y_im[i] = y_im_i
    end

    @avx for i in axes(U_re, 1)
        idx_i = indices[i] + k + offset
        S[1, idx_i] = y_re[i]
        S[2, idx_i] = y_im[i]
    end
end

@inline function subspace_mul_kernel!(S::AbstractArray{T, 3}, C_re, C_im, indices, U_re, U_im, k::Int, _b::Int, Bmax::Int, offset::Int) where {T <: Base.HWReal}
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

function subspace_mul_generic!(S::Vector{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    y_re = StrideArray{T}(undef, (D, ))
    y_im = StrideArray{T}(undef, (D, ))
    U_re, U_im = split_op(U, indices)
    Sr = reinterpret(reshape, T, S)
    for k in subspace
        subspace_mul_kernel!(Sr, y_re, y_im, indices, U_re, U_im, k, offset)
    end
    return S
end

function subspace_mul_generic!(S::Matrix{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    C_re = StrideArray{T}(undef, (D, StaticInt{8}()))
    C_im = StrideArray{T}(undef, (D, StaticInt{8}()))
    U_re, U_im = split_op(U, indices)

    Sr = reinterpret(reshape, T, S)
    Bmax = size(S,1)
    for k in subspace, _b ∈ 0:(Bmax-1) >>> 3
        subspace_mul_kernel!(Sr, C_re, C_im, indices, U_re, U_im, k, _b, Bmax, offset)
    end
    return S
end

@inline function subspace_mul_generic_task!(Sr::AbstractMatrix{T}, indices, U_re, U_im, subspace, range, offset) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    y_re = StrideArray{T}(undef, (D, ))
    y_im = StrideArray{T}(undef, (D, ))

    for s in range
        k = subspace[s]
        subspace_mul_kernel!(Sr, y_re, y_im, indices, U_re, U_im, k, offset)
    end
    return Sr
end

@inline function subspace_mul_generic_task!(Sr::AbstractArray{T, 3}, indices, U_re, U_im, subspace, range, offset) where {T <: Base.HWReal}
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

total_tasks(::AbstractVector, subspace) = length(subspace)
total_tasks(S::AbstractMatrix, subspace) = length(subspace) * (((size(S, 1)-1)>>>3)+1)

function threaded_subspace_mul_generic!(S::VecOrMat{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    nthreads = Threads.nthreads()
    len, rem = divrem(total_tasks(S, subspace), nthreads)
    Sr = reinterpret(reshape, T, S)
    U_re, U_im = split_op(U, indices)

    @batch for tid in 1:nthreads
        range = div_thread(tid, len, rem)
        subspace_mul_generic_task!(Sr, indices, U_re, U_im, subspace, range, offset)
    end
    return S
end

@inline function split_op(U::AbstractMatrix{Complex{T}}, indices) where {T <: Base.HWReal}
    D = ArrayInterface.static_length(indices)
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    @inbounds @simd ivdep for i in 1:length(U)
        U_re[i] = real(U[i])
        U_im[i] = imag(U[i])
    end
    return U_re, U_im
end