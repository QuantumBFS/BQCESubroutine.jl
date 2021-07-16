@inline function subspace_mul_kernel_diagonal!(S::AbstractVector{T}, y, indices, U, k::Int, offset::Int) where T
	@inbounds for i in axes(U, 1)
		idx_i = k + indices[i] + offset
		S[idx_i] = U[i, i] * S[idx_i]
    end
    return
end