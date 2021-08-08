"""
    broutine!(st, op, locs[, ctrl, args...])

Qubit-based quantum circuit subroutine.

# Args

- `st`: the raw storage type.
- `op`: the operator
- `locs`: a `Locations`, location of the operator
- `ctrl`: optional. A `CtrlLocations`, location of the control qubits.
- `args`: optional. parameters of the operator.
"""
function broutine! end

# level 1 - generic routines
function broutine!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations)
    # size(U, 1) == 2 && return broutine2x2!(st, U, locs)
    # NOTE: this is a very small overhead, and is very likely
    # to get optimized, we will always check these for the
    # sake of correctness.
    @assert log2dim(U) == length(locs) "operator dimension mismatch locs"
    n = log2dim(st)
    @assert n >= maximum(plain(locs)) "locs is too large"
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace)
    return st
end

# specialize on the X gate
function broutine!(st::AbstractVecOrMat, U::Val{:X_test}, locs::Locations)
    #println("broutine! Val{:X_test}")
    @assert 1 == length(locs) "operator dimension mismatch locs"
    n = log2dim(st)
    loc = plain(locs)[begin]
    @assert n >= loc "locs is too large"
    subspace_mul!(st, U, loc)
    return st
end

function broutine!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations, ctrl::CtrlLocations)
    size(U, 1) == 2 && return broutine2x2!(st, U, locs, ctrl)
    @assert log2dim(U) == length(locs) "operator dimension mismatch locs"
    n = log2dim(st)
    @assert n >= maximum(plain(locs)) "locs is too large"
    @assert isempty(intersect(locs, ctrl.storage)) "locs is overlapping with ctrl"
    # NOTE: this only adds a small constant overhead anyway
    # TODO: use StrideArray to optimize this away since its
    # stack allocated.
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace, ctrl_offset(ctrl))
    return st
end

# function broutine2x2!(S::AbstractMatrix, U::AbstractMatrix, locs::Locations)
#     step_1 = 1 << (plain(locs) - 1)
#     step_2 = 1 << plain(locs)
#     U11 = U[1, 1]; U12 = U[1, 2];
#     U21 = U[2, 1]; U22 = U[2, 2];

#     if step_1 == 1
#         @batch for j in 0:step_2:size(S, 2)-step_1
#             for b in 1:size(S, 1)
#                 ST1 = U11 * S[b, j+1] + U12 * S[b, j+step_1+1]
#                 ST2 = U21 * S[b, j+1] + U22 * S[b, j+step_1+1]

#                 S[b, j+1] = ST1
#                 S[b, j+step_1+1] = ST2
#             end
#         end
#         return S
#     end
#     error("")

#     @inbounds for j in 0:step_2:size(S, 2)-step_1, b in 1:size(S, 1)
#         for i in j:j+step_1-1
#             ST1 = U11 * S[b, i+1] + U12 * S[b, i+step_1+1]
#             ST2 = U21 * S[b, i+1] + U22 * S[b, i+step_1+1]

#             S[b, i+1] = ST1
#             S[b, i+step_1+1] = ST2
#         end
#     end
#     return S
# end
