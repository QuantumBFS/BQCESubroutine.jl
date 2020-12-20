# level 1 - generic routines
function subspace_mul!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    if size(U, 1) == 4
        return subspace_mul4x4!(st, comspace, U, subspace, offset)
    elseif size(U, 1) == 8
        return subspace_mul8x8!(st, comspace, U, subspace, offset)
    else
        # force compiler to specialize on comspace size
        indices = StrideArray{Int}(undef, (StaticInt{length(comspace)}(), ))
        @simd ivdep for i in eachindex(indices)
            indices[i] = comspace[i] + 1
        end
        return subspace_mul_generic!(st, indices, U, subspace, offset)
    end
end

function subspace_mul!(st::AbstractMatrix, comspace, U::AbstractMatrix{T}, subspace, offset=0) where T
    # NOTE: avx version seems to be faster at 8 already
    if size(U, 1) == 4
        return subspace_mul4x4!(st, comspace, U, subspace, offset)
    else
        # force compiler to specialize on comspace size
        indices = StrideArray{Int}(undef, (StaticInt{length(comspace)}(), ))
        @simd ivdep for i in eachindex(indices)
            indices[i] = comspace[i] + 1
        end
        return subspace_mul_generic!(st, indices, U, subspace, offset)
    end
end

# NOTE: avx version won't work with array type that does not provide pointer
# we restrict the state for that to be Array only for now
# thus we need a function to dispatch different methods
function subspace_mul_generic!(st::AbstractVector{T}, indices, U, subspace, offset=0) where T
    # TODO: this should be size(U, 1) x nthreads
    y = similar(st, (size(U, 1), ))
    idx = similar(indices)

    @inbounds for k in subspace
        for i in 1:size(U, 1)
            idx[i] = indices[i] + k + offset
        end

        for i in 1:size(U, 1)
            y[i] = zero(T)
            for j in 1:size(U, 2)
                y[i] += U[i, j] * st[idx[j]]
            end
        end

        for i in 1:size(U, 1)
            st[idx[i]] = y[i]
        end
    end
    return st
end

function subspace_mul_generic!(st::AbstractMatrix, indices, U::AbstractMatrix{T}, subspace, offset=0) where T
    # TODO: this should be size(U, 1) x nthreads
    y = similar(st, (size(U, 1), ))
    idx = similar(indices)
    @inbounds for k in subspace, b in 1:size(st, 2)
        for i in 1:size(U, 1)
            idx[i] = k + indices[i] + offset
        end

        for i in 1:size(U, 1)
            y[i] = zero(T)
            for j in 1:size(U, 2)
                y[i] += U[i, j] * st[idx[j], b]
            end
        end

        for i in 1:size(U, 1)
            st[idx[i], b] = y[i]
        end
    end
    return st
end

function subspace_mul_generic!(st::Matrix{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where T
    C_re = StrideArray{T}(undef, (PaddedMatrices.static_length(indices), StaticInt{8}()))
    C_im = StrideArray{T}(undef, (PaddedMatrices.static_length(indices), StaticInt{8}()))
    U_re = StrideArray{T}(undef, (PaddedMatrices.size(U, StaticInt{1}()), PaddedMatrices.size(U, StaticInt{2}())))
    U_im = StrideArray{T}(undef, (PaddedMatrices.size(U, StaticInt{1}()), PaddedMatrices.size(U, StaticInt{2}())))
    Ur = reinterpret(reshape, T, U)

    @inbounds @simd ivdep for i ∈ eachindex(U_re)
        U_re[i] = Ur[1,i]
        U_im[i] = Ur[2,i]
    end
    str = reinterpret(reshape, T, st)
    Bmax = size(st,2)
    for k in subspace
        # idx = k .+ indices
        # _k = k - 1
        for _b ∈ 0:(Bmax-1) >>> 3
            b =    _b << 3;
            bmax = b + 8
            if bmax ≤ Bmax # full static block
                @avx for n ∈ 1:8, m ∈ axes(U, 1)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U, 2)
                        str_i = k + indices[i] + offset
                        C_re_m_n += U_re[m,i] * str[1,str_i,n+b] - U_im[m,i] * str[2,str_i,n+b]
                        C_im_m_n += U_re[m,i] * str[2,str_i,n+b] + U_im[m,i] * str[1,str_i,n+b]
                    end
                    C_re[m,n] = C_re_m_n
                    C_im[m,n] = C_im_m_n
                end
                @avx for n ∈ 1:8, m ∈ axes(U, 1)
                    str_m = k + indices[m] + offset
                    str[1,str_m,n+b] = C_re[m,n]
                    str[2,str_m,n+b] = C_im[m,n]
                end
                # AmulB!(C_re, C_im, U_re, U_im, 
            else # dynamic block
                Nmax = 8 + Bmax - bmax
                @avx for n ∈ 1:Nmax, m ∈ axes(U, 1)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U, 2)
                        str_i = k + indices[i] + offset
                        C_re_m_n += U_re[m,i] * str[1,str_i,n+b] - U_im[m,i] * str[2,str_i,n+b]
                        C_im_m_n += U_re[m,i] * str[2,str_i,n+b] + U_im[m,i] * str[1,str_i,n+b]
                    end
                    C_re[m,n] = C_re_m_n
                    C_im[m,n] = C_im_m_n
                end
                @avx for n ∈ 1:Nmax, m ∈ axes(U, 1)
                    str_m = k + indices[m] + offset
                    str[1,str_m,n+b] = C_re[m,n]
                    str[2,str_m,n+b] = C_im[m,n]
                end
            end
        end
    end
    return st
end

function subspace_mul4x4!(st::AbstractVector{T}, comspace, U, subspace, offset=0) where T
    Base.Cartesian.@nextract 4 indices i -> comspace[i] + 1

    Base.Cartesian.@nextract 4 U i->begin
        Base.Cartesian.@nextract 4 U_i j->U[i, j]
    end

    for k in subspace
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

        for b in 1:size(st, 2)
            Base.Cartesian.@nexprs 4 i -> begin
                y_i = zero(T)
                Base.Cartesian.@nexprs 4 j -> begin
                    y_i += U_i_j * st[idx_j, b]
                end
            end

            Base.Cartesian.@nexprs 4 i -> begin
                st[idx_i, b] = y_i
            end
        end
    end
    return st
end

function broutine!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations)
    size(U, 1) == 2 && return broutine2x2!(st, U, locs)
    # NOTE: this is a very small overhead, and is very likely
    # to get optimized, we will always check these for the
    # sake of correctness.
    @assert log2dim1(U) == length(locs)
    n = log2dim1(st)
    @assert n >= maximum(plain(locs))
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace)
    return st
end

function broutine2x2!(st::AbstractVector{T}, U::AbstractMatrix, locs::Locations{Int}) where T
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    _broutine2x2!(st, (U11,U12,U21,U22), locs)
    return st
end

function broutine2x2!(st::AbstractVector{T}, U::AbstractMatrix, locs::Locations) where T
    # NOTE: general matrices have no advantage to do kron inside the kernel
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    for loc in locs
        _broutine2x2!(st, (U11,U12,U21,U22), loc)
    end
    return st
end

@inline function _broutine2x2!(st::AbstractVector{T}, (U11,U12,U21,U22), locs::Locations{Int}) where T
    step_1 = 1 << (plain(locs) - 1)
    step_2 = 1 << plain(locs)

    @inbounds for j in 0:step_2:size(st, 1)-step_1
        for i in j+1:j+step_1
            ST1 = U11 * st[i] + U12 * st[i + step_1]
            ST2 = U21 * st[i] + U22 * st[i + step_1]

            st[i] = ST1
            st[i + step_1] = ST2
        end
    end
    return st
end

# @inline function _broutine2x2!(st::AbstractMatrix{T}, (U11,U12,U21,U22), locs::Locations{Int}) where T
#     step_1 = 1 << (plain(locs) - 1)
#     step_2 = 1 << plain(locs)

#     @inbounds for b in 1:size(st, 2), j in 0:step_2:size(st, 1)-step_1
#         for i in j+1:j+step_1
#             ST1 = U11 * st[i, b] + U12 * st[i + step_1, b]
#             ST2 = U21 * st[i, b] + U22 * st[i + step_1, b]

#             st[i, b] = ST1
#             st[i + step_1, b] = ST2
#         end
#     end
#     return st
# end

function broutine2x2!(st::AbstractVector{T}, U::AbstractMatrix, locs::Locations, ctrl::CtrlLocations) where T
    raw = first(plain(locs))
    raw_ctrl = plain(ctrl)
    step_1 = 1 << (raw - 1)
    step_2 = 1 << raw
    ctrl_mask = bmask(raw_ctrl)
    flag_mask = reduce(+, one(Int) << (raw_ctrl[i] - 1) for i in 1:length(ctrl) if ctrl.flags[i])
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];

    @inbounds for j in 0:step_2:size(st, 1)-step_1
        for i in j:j+step_1-1
            if ismatch(i, ctrl_mask, flag_mask)
                ST1 = U11 * st[i+1] + U12 * st[i + step_1 + 1]
                ST2 = U21 * st[i+1] + U22 * st[i + step_1 + 1]
    
                st[i + 1] = ST1
                st[i + step_1 + 1] = ST2
            end
        end
    end
    return st
end

function ctrl_offset(ctrl::CtrlLocations)
    locs = plain(ctrl)
    mask = 0
    for i in 1:length(ctrl)
        if ctrl.flags[i]
            mask += (1 << (locs[i] - 1))
        end
    end
    return mask
end

function broutine!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations, ctrl::CtrlLocations)
    size(U, 1) == 2 && return broutine2x2!(st, U, locs, ctrl)
    @assert log2dim1(U) == length(locs)
    n = log2dim1(st)
    @assert n >= maximum(plain(locs))
    # NOTE: this only adds a small constant overhead anyway
    # TODO: use StrideArray to optimize this away since its
    # stack allocated.
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace, ctrl_offset(ctrl))
    return st
end

# level 2 - special matrix routines

# level 3 - intrinsic gate routines
@broutine X = [0 1;1 0]
@broutine Y = [0 -im;im 0]
@broutine Z = [1 0;0 -1]
@broutine H = [1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]
@broutine T = [1 0;0 exp(im * π / 4)]
@broutine S = [1 0;0 im]
@broutine Sdag = [1 0;0 -im]
@broutine Tdag = [1 0;0 exp(-im * π / 4)]
@broutine Rx(θ::Real) = [cos(θ / 2) -im*sin(θ / 2); -im*sin(θ / 2) cos(θ / 2)]
@broutine Ry(θ::Real) = [cos(θ / 2) -sin(θ / 2); sin(θ / 2) cos(θ / 2)]
@broutine Rz(θ::Real) = [exp(-im * θ / 2) 0; 0 exp(im * θ / 2)]
