@inline function subspace_mul_kernel!(S::AbstractVector{T}, indices, y, U, k::Int, offset::Int) where T
    @inbounds for i in axes(U, 1)
        y[i] = zero(T)
        for j in axes(U, 2)
            idx_j = k + indices[j] + offset
            y[i] += U[i, j] * S[idx_j]
        end
    end

    @inbounds for i in axes(U, 1)
        idx_i = k + indices[i] + offset
        S[idx_i] = y[i]
    end
    return
end

@inline function subspace_mul_kernel!(S::AbstractMatrix{T}, indices, y, U, k::Int, b::Int, offset::Int) where T
    @inbounds for i in axes(U, 1)
        y[i] = zero(T)
        for j in axes(U, 2)
            idx_j = k + indices[j] + offset
            y[i] += U[i, j] * S[b, idx_j]
        end
    end

    @inbounds for i in axes(U, 1)
        idx_i = k + indices[i] + offset
        S[b, idx_i] = y[i]
    end
    return
end

@inline function subspace_mul_kernel_4x4!(S::AbstractVector{T}, indices, y, U, k::Int, offset::Int) where T
    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            y[i] = zero(T)
            Base.Cartesian.@nexprs 4 j -> begin
                idx_j = k + indices[j] + offset
                y[i] += U[i, j] * S[idx_j]
            end
        end

        Base.Cartesian.@nexprs 4 i -> begin
            idx_i = k + indices[i] + offset
            S[idx_i] = y[i]
        end
    end
    return
end

@inline function subspace_mul_kernel_4x4!(S::AbstractMatrix{T}, indices, y, U, k::Int, b::Int, offset::Int) where T
    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            y[i] = zero(T)
            Base.Cartesian.@nexprs 4 j -> begin
                idx_j = k + indices[j] + offset
                y[i] += U[i, j] * S[b, idx_j]
            end
        end

        Base.Cartesian.@nexprs 4 i -> begin
            idx_i = k + indices[i] + offset
            S[b, idx_i] = y[i]
        end
    end
    return
end

function subspace_mul_generic!(st::AbstractVector{T}, indices, U, subspace, offset=0) where T
    y = similar(st, (size(U, 1), ))

    for k in subspace
        subspace_mul_kernel!(S, indices, y, U, k, offset)
    end
    return st
end

function subspace_mul_generic!(S::AbstractMatrix{T}, indices, U::AbstractMatrix, subspace, offset=0) where T
    y = similar(S, (size(U, 1), ))

    for k in subspace, b in axes(S, 1)
        subspace_mul_kernel!(S, indices, y, U, k, b, offset)
    end
    return S
end

@inline function subspace_mul_generic_task!(S::AbstractVector{T}, indices, U, subspace, range, offset) where {T}
    y = similar(st, (size(U, 1), ))

    for s in range
        k = subspace[s]
        subspace_mul_kernel!(S, indices, y, U, k, b, offset)
    end
    return Sr
end

@inline function subspace_mul_generic_task!(S::AbstractMatrix{T}, indices, U, subspace, range, offset) where {T}
    y = similar(st, (size(U, 1), ))
    stride = size(S, 1)

    for idx in range
        s, b = get_indices(idx, stride)
        k = subspace[s]
        subspace_mul_kernel!(S, indices, y, U, k, b, offset)
    end
    return Sr
end
