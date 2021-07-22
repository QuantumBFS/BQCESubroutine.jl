
# generic methods
function subspace_mul_generic!(S::AbstractVector{T}, indices, U::AbstractMatrix, subspace, offset=0) where {T}
    D = StrideArrays.static_length(indices)
    y = StrideArray{T}(undef, (D, ))
    if D == 4
        for k in subspace
            subspace_mul_kernel_generic_4x4!(S, y, indices, U, k, offset)
        end
    else
        for k in subspace
            subspace_mul_kernel_generic!(S, y, indices, U, k, offset)
        end
    end
    return S
end

function subspace_mul_generic!(S::AbstractMatrix{T}, indices, U::AbstractMatrix, subspace, offset=0) where {T}
    D = StrideArrays.static_length(indices)
    y = StrideArray{T}(undef, (D, ))
    if D == 4
        for k in subspace, b in axes(S, 1)
            subspace_mul_kernel_generic_4x4!(S, y, indices, U, k, b, offset)
        end
    else
        for k in subspace, b in axes(S, 1)
            subspace_mul_kernel_generic!(S, y, indices, U, k, b, offset)
        end
    end
    return S
end

# specialization on Complex{<:Base.HWReal}
@inline split_op(U::AbstractMatrix{<:Real}, indices) = U

@inline function split_op(U::AbstractMatrix{Complex{T}}, indices) where {T <: Real}
    D = ArrayInterface.static_length(indices)
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    @inbounds @simd ivdep for i in 1:length(U)
        U_re[i] = real(U[i])
        U_im[i] = imag(U[i])
    end
    return U_re, U_im
end

function subspace_mul_generic!(S::Vector{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    y = (StrideArray{T}(undef, (D, )), StrideArray{T}(undef, (D, )))
    U = split_op(U, indices)
    Sr = reinterpret(reshape, T, S)
    for k in subspace
        subspace_mul_kernel_complex!(Sr, y, indices, U, k, offset)
    end
    return S
end

function subspace_mul_generic!(S::Matrix{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = StrideArrays.static_length(indices)
    C = (StrideArray{T}(undef, (D, StaticInt{8}())), StrideArray{T}(undef, (D, StaticInt{8}())))
    U = split_op(U, indices)

    Sr = reinterpret(reshape, T, S)
    Bmax = size(S,1)
    for k in subspace, _b ∈ 0:(Bmax-1) >>> 3
        subspace_mul_kernel_complex!(Sr, C, indices, U, k, _b, Bmax, offset)
    end
    return S
end

function threaded_subspace_mul_generic!(S::AbstractVecOrMat, indices, U::AbstractMatrix, subspace, offset=0)
    nthreads = Threads.nthreads()
    space = CartesianSpace(S, subspace)
    @batch for tid in 1:nthreads
        range = schedule_task(space, tid, nthreads)
        subspace_mul_generic_task!(S, indices, U, subspace, range, offset)
    end
    return S
end

function threaded_subspace_mul_generic!(S::VecOrMat{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    nthreads = Threads.nthreads()
    space = CartesianSpace(S, subspace)
    Sr = reinterpret(reshape, T, S)
    U = split_op(U, indices)

    @batch for tid in 1:nthreads
        range = schedule_task(space, tid, nthreads)
        subspace_mul_complex_task!(Sr, indices, U, subspace, range, offset)
    end
    return S
end
