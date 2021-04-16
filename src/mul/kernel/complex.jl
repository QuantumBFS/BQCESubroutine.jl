

@inline function subspace_mul_kernel_complex!(S::AbstractMatrix{T}, (y_re, y_im), indices, U::AbstractMatrix{T}, k::Int, offset::Int) where {T <: Base.HWReal}
    @avx for i in axes(U, 1)
        y_re_i = zero(T)
        y_im_i = zero(T)
        for j in axes(U, 2)
            idx_j = indices[j] + k + offset
            y_re_i += U[i, j] * S[1, idx_j]
            y_im_i += U[i, j] * S[2, idx_j]
        end
        y_re[i] = y_re_i
        y_im[i] = y_im_i
    end

    @avx for i in axes(U, 1)
        idx_i = indices[i] + k + offset
        S[1, idx_i] = y_re[i]
        S[2, idx_i] = y_im[i]
    end
end

@inline function subspace_mul_kernel_complex!(S::AbstractMatrix{T}, (y_re, y_im), indices, (U_re, U_im), k::Int, offset::Int) where {T <: Base.HWReal}
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

@inline function subspace_mul_kernel_complex!(S::AbstractArray{T, 3}, (C_re, C_im), indices, U::AbstractMatrix{T}, k::Int, _b::Int, Bmax::Int, offset::Int) where {T <: Base.HWReal}
    b = _b << 3;
    bmax = b + 8
    if bmax ≤ Bmax # full static block
        @avx for n ∈ 1:8, m ∈ axes(U, 1)
            C_re_m_n = zero(T)
            C_im_m_n = zero(T)
            for i ∈ axes(U, 2)
                j = k + indices[i] + offset
                C_re_m_n += U[m,i] * S[1,n+b,j]
                C_im_m_n += U[m,i] * S[2,n+b,j]
            end
            C_re[m,n] = C_re_m_n
            C_im[m,n] = C_im_m_n
        end
        @avx for n ∈ 1:8, m ∈ axes(U, 1)
            S_m = k + indices[m] + offset
            S[1,n+b,S_m] = C_re[m,n]
            S[2,n+b,S_m] = C_im[m,n]
        end
        # AmulB!(C_re, C_im, U, U_im, 
    else # dynamic block
        Nmax = 8 + Bmax - bmax
        @avx for n ∈ 1:Nmax, m ∈ axes(U, 1)
            C_re_m_n = zero(T)
            C_im_m_n = zero(T)
            for i ∈ axes(U, 2)
                j = k + indices[i] + offset
                C_re_m_n += U[m,i] * S[1,n+b,j]
                C_im_m_n += U[m,i] * S[2,n+b,j]
            end
            C_re[m,n] = C_re_m_n
            C_im[m,n] = C_im_m_n
        end
        @avx for n ∈ 1:Nmax, m ∈ axes(U, 1)
            S_m = k + indices[m] + offset
            S[1,n+b,S_m] = C_re[m,n]
            S[2,n+b,S_m] = C_im[m,n]
        end
    end
    return
end

@inline function subspace_mul_kernel_complex!(S::AbstractArray{T, 3}, (C_re, C_im), indices, (U_re, U_im), k::Int, _b::Int, Bmax::Int, offset::Int) where {T <: Base.HWReal}
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
