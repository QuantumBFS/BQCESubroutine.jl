"""
k: an index from subspace
indices: array of indices from comspace
"""
@inline function subspace_mul_kernel_generic!(S::AbstractVector{T}, y, indices, U, k::Int, offset::Int) where T
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

@inline function subspace_mul_kernel_generic!(S::AbstractMatrix{T}, y, indices, U, k::Int, b::Int, offset::Int) where T
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

@inline function subspace_mul_kernel_generic!(S::AbstractVector{T}, y, indices, U::Diagonal{N, Vector{N}}, k::Int, offset::Int) where {T, N}
    @inbounds for i in axes(U, 1)
        idx_i = k + indices[i] + offset
        S[idx_i] = U[i, i] * S[idx_i]
    end
    return
end

@inline function subspace_mul_kernel_generic!(S::AbstractMatrix{T}, y, indices, U::Diagonal{N, Vector{N}}, k::Int, b::Int, offset::Int) where {T, N}
    @inbounds for i in axes(U, 1)
        idx_i = k + indices[i] + offset
        S[b, idx_i] = U[i, i] * S[b, idx_i]
    end
    return
end

@inline function subspace_mul_kernel_generic_4x4!(S::AbstractVector{T}, y, indices, U, k::Int, offset::Int) where T
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

@inline function subspace_mul_kernel_generic_4x4!(S::AbstractMatrix{T}, y, indices, U, k::Int, b::Int, offset::Int) where T
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

@inline function subspace_mul_kernel_generic_4x4!(S::AbstractVector{T}, y, indices, U::Diagonal{N, Vector{N}}, k::Int, offset::Int) where {T, N}
    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            idx_i = k + indices[i] + offset
            S[idx_i] = U[i, i] * S[idx_i]
        end
    end
    return
end

@inline function subspace_mul_kernel_generic_4x4!(S::AbstractMatrix{T}, y, indices, U::Diagonal{N, Vector{N}}, k::Int, b::Int, offset::Int) where {T, N}
    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            idx_i = k + indices[i] + offset
            S[b, idx_i] = U[i, i] * S[b, idx_i]
        end
    end
    return
end
