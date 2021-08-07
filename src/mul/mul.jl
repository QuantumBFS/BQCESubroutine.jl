include("kernel/kernel.jl")
include("tasks/tasks.jl")
include("generic.jl")

function subspace_mul!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    if size(U, 1) == 4
        return subspace_mul4x4!(st, comspace, U, subspace, offset)
    elseif size(U, 1) == 8
        return subspace_mul8x8!(st, comspace, U, subspace, offset)
    else
        # force compiler to specialize on comspace size
        indices = StrideArray{Int}(undef, (length(comspace), ))
        @simd ivdep for i in eachindex(indices)
            indices[i] = comspace[i] + 1
        end
        return subspace_mul_generic!(st, indices, U, subspace, offset)
    end
end

# specialize on the X gate
function subspace_mul!(st::AbstractVector{T}, loc::Int, U::Val{:X_test}, offset=0) where T
    n = log2dim(st)
    loc_bit = 1 << (loc-1)
    k = 0

    while true
        idx_1 = k + offset + 1
        idx_2 = (k | loc_bit) + offset + 1
        
        tmp = st[idx_1]
        st[idx_1] = st[idx_2]
        st[idx_2] = tmp

        k += 1
        if k & loc_bit != 0
            k += loc_bit
        end
        if k >= 1<<n
            break
        end
    end
end

function subspace_mul!(st::AbstractMatrix, comspace, U::AbstractMatrix{T}, subspace, offset=0) where T
    # NOTE: avx version seems to be faster at 8 already
    if size(U, 1) == 4
        return subspace_mul4x4!(st, comspace, U, subspace, offset)
    else
        # force compiler to specialize on comspace size
        indices = StrideArray{Int}(undef, (length(comspace), ))
        @simd ivdep for i in eachindex(indices)
            indices[i] = comspace[i] + 1
        end
        return subspace_mul_generic!(st, indices, U, subspace, offset)
    end
end

# NOTE:
# expanded kernel is slower than avx kernel in multithreading
# thus we don't need to do any manual loop unroll.
function threaded_subspace_mul!(S::AbstractVecOrMat, comspace, U, subspace, offset=0)
    indices = StrideArray{Int}(undef, (length(comspace), ))
    @simd ivdep for i in eachindex(indices)
        indices[i] = comspace[i] + 1
    end
    return subspace_mul_generic!(S, indices, U, subspace, offset)
end

function subspace_mul4x4!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end

    @inbounds for k in subspace
        Base.Cartesian.@nextract 4 idx i-> k + indices_i + offset

        Base.Cartesian.@nexprs 4 i -> begin
            y_i = zero(T)
            Base.Cartesian.@nexprs 4 j -> begin
                y_i += U_i_j * st[idx_j]
            end
        end

        Base.Cartesian.@nexprs 4 i -> begin
            st[idx_i] = y_i
        end
    end
    return st
end

function subspace_mul8x8!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    Base.Cartesian.@nextract 8 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 8 U i->begin
        Base.Cartesian.@nextract 8 U_i j->U[i, j]
    end

    @inbounds for k in subspace
        Base.Cartesian.@nextract 8 idx i-> k + indices_i + offset
        Base.Cartesian.@nexprs 8 i -> begin
            y_i = zero(T)
            Base.Cartesian.@nexprs 8 j -> begin
                y_i += U_i_j * st[idx_j]
            end
        end

        Base.Cartesian.@nexprs 8 i -> begin
            st[idx_i] = y_i
        end
    end
    return st
end

function subspace_mul4x4!(st::AbstractMatrix{T}, comspace, U::AbstractMatrix, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end
    
    @inbounds for k in subspace
        Base.Cartesian.@nextract 4 idx i-> k + indices_i + offset

        for b in 1:size(st, 1)
            Base.Cartesian.@nexprs 4 i -> begin
                y_i = zero(T)
                Base.Cartesian.@nexprs 4 j -> begin
                    y_i += U_i_j * st[b, idx_j]
                end
            end

            Base.Cartesian.@nexprs 4 i -> begin
                st[b, idx_i] = y_i
            end
        end
    end
    return st
end
