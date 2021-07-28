"""
k: an index from subspace
indices: array of indices from comspace
"""
@inline function subspace_mul_kernel_diagonal!(S::AbstractVector{T}, indices, U, k::Int, offset::Int) where T
    @inbounds for i in axes(U, 1)
        idx_i = k + indices[i] + offset
        S[idx_i] = U[i, i] * S[idx_i]
    end
    return
end

@inline function subspace_mul_kernel_diagonal_4x4!(S::AbstractVector{T}, indices, U, k::Int, offset::Int) where T
    # TODO
    #
    # @inbounds begin
    #     Base.Cartesian.@nexprs 4 i -> begin
    #         y[i] = zero(T)
    #         Base.Cartesian.@nexprs 4 j -> begin
    #             idx_j = k + indices[j] + offset
    #             y[i] += U[i, j] * S[idx_j]
    #         end
    #     end

    #     Base.Cartesian.@nexprs 4 i -> begin
    #         idx_i = k + indices[i] + offset
    #         S[idx_i] = y[i]
    #     end
    # end
    # return
end