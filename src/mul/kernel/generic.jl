"""
k: an index from subspace
indices: array of indices from comspace
"""
# real U, single real state
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

# real U, single real state, specialize on the X gate
@inline function subspace_mul_kernel_generic!(S::AbstractVector{T}, y, indices, U::Val{:X_test}, k::Int, offset::Int) where T
    idx_1 = k + indices[1] + offset
    idx_2 = k + indices[2] + offset
    S[idx_1], S[idx_2] = S[idx_2], S[idx_1]
end

# real U, multiple real states
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

# Diagonal real U, single real state
@inline function subspace_mul_kernel_generic!(S::AbstractVector{T}, y, indices, U::Diagonal, k::Int, offset::Int) where T
    @inbounds for i in axes(U, 1)
        idx_i = k + indices[i] + offset
        S[idx_i] = U[i, i] * S[idx_i]
    end
    return
end

# Diagonal real U, multiple real states
@inline function subspace_mul_kernel_generic!(S::AbstractMatrix{T}, y, indices, U::Diagonal, k::Int, b::Int, offset::Int) where T
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

@inline function subspace_mul_kernel_generic_4x4!(S::AbstractVector{T}, y, indices, U::Diagonal, k::Int, offset::Int) where T
    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            idx_i = k + indices[i] + offset
            S[idx_i] = U[i, i] * S[idx_i]
        end
    end
    return
end

@inline function subspace_mul_kernel_generic_4x4!(S::AbstractMatrix{T}, y, indices, U::Diagonal, k::Int, b::Int, offset::Int) where T
    @inbounds begin
        Base.Cartesian.@nexprs 4 i -> begin
            idx_i = k + indices[i] + offset
            S[b, idx_i] = U[i, i] * S[b, idx_i]
        end
    end
    return
end
