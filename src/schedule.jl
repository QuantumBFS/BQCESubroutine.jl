struct CartesianSpace{N}
    dims::NTuple{N, Int}
    offsets::NTuple{N, Int}
end

Base.length(s::CartesianSpace) = prod(s.dims)
Base.eltype(::CartesianSpace{N}) where N = NTuple{N, Int}

function Base.iterate(s::CartesianSpace, st=1)
    st > length(s) && return
    return s[st], st + 1
end

function Base.getindex(s::CartesianSpace{1}, idx::Int)
    return idx + s.offsets[1]
end

function Base.getindex(s::CartesianSpace{2}, idx::Int)
    i2, i1 = divrem(idx - 1, s.dims[1])
    return i1 + s.offsets[1], i2 + s.offsets[2]
end

function Base.getindex(s::CartesianSpace{3}, idx::Int)
    i2, i1 = divrem(idx - 1, s.dims[1])
    i3, i2 = divrem(i2, s.dims[2])
    return i1 + s.offsets[1], i2 + s.offsets[2], i3 + s.offsets[3]
end

function Base.getindex(s::CartesianSpace{4}, idx::Int)
    i2, i1 = divrem(idx - 1, s.dims[1])
    i3, i2 = divrem(i2, s.dims[2])
    i4, i3 = divrem(i3, s.dims[3])
    return i1 + s.offsets[1], i2 + s.offsets[2], i3 + s.offsets[3], i4 + s.offsets[4]
end

function CartesianSpace(xs::AbstractUnitRange...)
    CartesianSpace(length.(xs), first.(xs))
end

struct CartesianPartition{N}
    space::CartesianSpace{N}
    from::Int
    to::Int
end

function schedule_task(s::CartesianSpace, tid::Int, nthreads::Int)
    len, rem = divrem(length(s), nthreads)
    f = (tid - 1) * len + 1
    l = f + len - 1

    if rem > 0
        if tid <= rem
            f = f + (tid - 1)
            l = l + tid
        else
            f = f + rem
            l = l + rem
        end
    end
    return CartesianPartition(s, f, l)
end

Base.length(it::CartesianPartition) = it.to - it.from + 1
Base.eltype(it::CartesianPartition) = eltype(it.space)
Base.getindex(it::CartesianPartition, idx::Int) = it.space[idx]
function Base.iterate(it::CartesianPartition, st::Int=it.from)
    st > it.to && return
    return it.space[st], st + 1
end

CartesianSpace(::AbstractVector, subspace) = CartesianSpace(1:length(subspace))
CartesianSpace(S::AbstractMatrix, subspace) = CartesianSpace(1:size(S, 1), 1:length(subspace))
function CartesianSpace(S::AbstractMatrix{Complex{T}}, subspace) where {T <: Base.HWReal}
    return CartesianSpace(0:(size(S,1)-1) >>> 3, 1:length(subspace))
end
