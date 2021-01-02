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

# NOTE: for other non-standard type, we should manually specialize a subspace routine
#       similar to the complex number case.
# TODO: specialize for HwReal
function subspace_mul_generic!(st::AbstractMatrix{T}, indices, U::AbstractMatrix, subspace, offset=0) where T
    # TODO: this should be size(U, 1) x nthreads
    y = similar(st, (size(U, 1), ))
    idx = similar(indices)

    @inbounds for k in subspace
        for i in 1:size(U, 1)
            idx[i] = k + indices[i] + offset
        end

        for b in 1:size(st, 1)
            for i in 1:size(U, 1)
                y[i] = zero(T)
                for j in 1:size(U, 2)
                    y[i] += U[i, j] * st[b, idx[j]]
                end
            end

            for i in 1:size(U, 1)
                st[b, idx[i]] = y[i]
            end
        end
    end
    return st
end

function subspace_mul_generic!(st::Vector{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = PaddedMatrices.static_length(indices)
    y_re = StrideArray{T}(undef, (D, ))
    y_im = StrideArray{T}(undef, (D, ))
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    idx = StrideArray{eltype(indices)}(undef, (D, ))
    Ur = reinterpret(reshape, T, U)

    @inbounds @simd ivdep for i ∈ eachindex(U_re)
        U_re[i] = Ur[1,i]
        U_im[i] = Ur[2,i]
    end

    str = reinterpret(reshape, T, st)

    @inbounds for k in subspace
        for j in 1:size(U, 2)
            idx[j] = indices[j] + k + offset
        end

        @avx for i in axes(U, 1)
            y_re_i = zero(T)
            y_im_i = zero(T)
            for j in axes(U, 2)
                idx_j = idx[j]
                y_re_i += U_re[i, j] * str[1, idx_j] - U_im[i, j] * str[2, idx_j]
                y_im_i += U_re[i, j] * str[2, idx_j] + U_im[i, j] * str[1, idx_j]
            end
            y_re[i] = y_re_i
            y_im[i] = y_im_i
        end

        @avx for i in axes(U, 1)
            idx_i = indices[i] + k + offset
            str[1, idx_i] = y_re[i]
            str[2, idx_i] = y_im[i]
        end
    end
    return st
end

function subspace_mul_generic!(st::Matrix{Complex{T}}, indices, U::AbstractMatrix, subspace, offset=0) where {T <: Base.HWReal}
    D = PaddedMatrices.static_length(indices)
    C_re = StrideArray{T}(undef, (D, StaticInt{8}()))
    C_im = StrideArray{T}(undef, (D, StaticInt{8}()))
    U_re = StrideArray{T}(undef, (D, D))
    U_im = StrideArray{T}(undef, (D, D))
    Ur = reinterpret(reshape, T, U)

    @inbounds @simd ivdep for i ∈ eachindex(U_re)
        U_re[i] = Ur[1,i]
        U_im[i] = Ur[2,i]
    end

    str = reinterpret(reshape, T, st)
    Bmax = size(st,1)
    for k in subspace
        # idx = k .+ indices
        # _k = k - 1
        for _b ∈ 0:(Bmax-1) >>> 3
            b =    _b << 3;
            bmax = b + 8
            if bmax ≤ Bmax # full static block
                @avx for n ∈ 1:8, m ∈ axes(U_re, 1)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U_re, 2)
                        str_i = k + indices[i] + offset
                        C_re_m_n += U_re[m,i] * str[1,n+b,str_i] - U_im[m,i] * str[2,n+b,str_i]
                        C_im_m_n += U_re[m,i] * str[2,n+b,str_i] + U_im[m,i] * str[1,n+b,str_i]
                    end
                    C_re[m,n] = C_re_m_n
                    C_im[m,n] = C_im_m_n
                end
                @avx for n ∈ 1:8, m ∈ axes(U_re, 1)
                    str_m = k + indices[m] + offset
                    str[1,n+b,str_m] = C_re[m,n]
                    str[2,n+b,str_m] = C_im[m,n]
                end
                # AmulB!(C_re, C_im, U_re, U_im, 
            else # dynamic block
                Nmax = 8 + Bmax - bmax
                @avx for n ∈ 1:Nmax, m ∈ axes(U_re, 1)
                    C_re_m_n = zero(T)
                    C_im_m_n = zero(T)
                    for i ∈ axes(U_re, 2)
                        str_i = k + indices[i] + offset
                        C_re_m_n += U_re[m,i] * str[1,n+b,str_i] - U_im[m,i] * str[2,n+b,str_i]
                        C_im_m_n += U_re[m,i] * str[2,n+b,str_i] + U_im[m,i] * str[1,n+b,str_i]
                    end
                    C_re[m,n] = C_re_m_n
                    C_im[m,n] = C_im_m_n
                end
                @avx for n ∈ 1:Nmax, m ∈ axes(U_re, 1)
                    str_m = k + indices[m] + offset
                    str[1,n+b,str_m] = C_re[m,n]
                    str[2,n+b,str_m] = C_im[m,n]
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
    
    for k in subspace
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
