# """
# k: an index from subspace
# indices: array of indices from comspace
# """
# @inline function subspace_mul_kernel_diagonal!(S::AbstractVector{T}, indices, U, k::Int, offset::Int) where T
#     @inbounds for i in axes(U, 1)
#         idx_i = k + indices[i] + offset
#         S[idx_i] = U[i, i] * S[idx_i]
#     end
#     return
# end

# @inline function subspace_mul_kernel_diagonal_4x4!(S::AbstractVector{T}, indices, U, k::Int, offset::Int) where T
#     @inbounds begin
#         Base.Cartesian.@nexprs 4 i -> begin
#             idx_i = k + indices[i] + offset
#             S[idx_i] = U[i, i] * S[idx_i]
#         end
#     end
#     return
# end
