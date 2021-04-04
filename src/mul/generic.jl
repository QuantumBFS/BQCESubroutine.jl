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

################
# multhreading
################
# struct SubspaceMulGeneric{P} end

# @generated function subspace_mul_generic_ptr(::AbstractArray{T, N}, indices, subspace) where {T, N}
#     # S_ptr, U_ptr, indices_ptr, subspace_ptr
#     # S_size, range, offset
#     P = Tuple{Ptr{T}, Ptr{T}, Ptr{Int}, Ptr{subspace},
#         NTuple{N, Int}, UnitRange{Int}, Int}
#     sig = SubspaceMulGeneric{P}()
#     :(@cfunction($sig, Cvoid, (Ptr{UInt}, )))
# end

# function (k::SubspaceMulGeneric{P})(p::Ptr{UInt}) where {P}
#     _, (S_ptr, U_ptr, indices_ptr, subspace_ptr,
#             S_size, range, offset) =
#         ThreadingUtilities.load(p, P, 5*sizeof(UInt))

#     S = PtrArray(S_ptr, S_size)
#     U_re = StrideArray(PtrArray(U_re_ptr, (D, D)))
#     U_im = StrideArray(PtrArray(U_im_ptr, (D, D)))
#     indices = StrideArray(PtrArray(indices_ptr, (D, )))
#     subspace = ccall(:jl_value_ptr, Ref{Base.RefValue{BitSubspace}}, (Ptr{Cvoid},), subspace_ptr)[]

#     subspace_mul_generic_task!(S, indices, U_re, U_im, subspace, range, offset)
#     return
# end


# function subspace_mul_generic_ptr(S::AbstractArray{T}, indices) where {T}
#     D = ArrayInterface.static_length(indices)
#     # S_ptr, U_ptr, indices_ptr, subspace_ptr
#     # S_size, range, offset
#     P = Tuple{Ptr{T}, Ptr{T}, Ptr{Int}, Ptr{BitSubspace},
#         size_type(S), UnitRange{Int}, Int}
#     sig = SubspaceMulGeneric{D, P}()
#     @cfunction($sig, Cvoid, (Ptr{UInt}, ))
# end

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
