########################
# multi-threading task
########################

@inline function subspace_mul_generic_task!(S::AbstractVector{T}, indices, U::AbstractMatrix, subspace, range, offset) where T
    D = StrideArrays.static_length(indices)
    y = StrideArray{T}(undef, (D, ))
    if D == 4
        for s in range
            k = subspace[s]
            subspace_mul_kernel_generic_4x4!(S, y, indices, U, k, offset)
        end
    else
        for s in range
            k = subspace[s]
            subspace_mul_kernel_generic!(S, y, indices, U, k, offset)
        end
    end
    return
end

@inline function subspace_mul_generic_task!(S::AbstractMatrix{T}, indices, U::AbstractMatrix, subspace, range, offset) where T
    D = StrideArrays.static_length(indices)
    stride = size(S, 1)
    y = StrideArray{T}(undef, (D, ))
    if D == 4
        for (b, s) in range
            k = subspace[s]
            subspace_mul_kernel_generic_4x4!(S, y, indices, U, k, b, offset)
        end
    else
        for (b, s) in range
            k = subspace[s]
            subspace_mul_kernel_generic!(S, y, indices, U, k, b, offset)
        end
    end
    return
end

@inline function subspace_mul_complex_task!(Sr::AbstractMatrix{T}, indices, U, subspace, range::CartesianPartition, offset) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    y = StrideArray{T}(undef, (D, )), StrideArray{T}(undef, (D, ))

    for s in range
        k = subspace[s]
        subspace_mul_kernel_complex!(Sr, y, indices, U, k, offset)
    end
    return
end

@inline function subspace_mul_complex_task!(Sr::AbstractArray{T, 3}, indices, U, subspace, range::CartesianPartition, offset) where {T <: Base.HWReal}
    D = ArrayInterface.static_length(indices)
    C = StrideArray{T}(undef, (D, StaticInt{8}())), StrideArray{T}(undef, (D, StaticInt{8}()))
    Bmax = size(Sr, 2)

    for (_b, s) in range
        k = subspace[s]
        subspace_mul_kernel_complex!(Sr, C, indices, U, k, _b, Bmax, offset)
    end
    return
end
