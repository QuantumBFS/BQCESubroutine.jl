module Utilities

export log2i, log2dim, group_shift, lmove, bsubspace, bcomspace,
    bmask, anyone, literal_pow, ismatch, Hoistable, VarDefs,
    hoist!, hoisted_expr, def!, block, @def, @defnew, eval_interp, var_exprs,
    flatten_block

using OrderedCollections
using YaoLocations: plain, AbstractLocations

function block(f, it)
    ret = Expr(:block)
    for xs in it
        push!(ret.args, f(xs...))
    end
    return ret
end

function flatten_block(ex)
    ex isa Expr || return ex
    ex.head === :block && return _flatten_block(ex)
    return Expr(ex.head, map(flatten_block, ex.args)...)
end

function _flatten_block(ex)
    ex isa Expr || return ex
    ex.head === :block || return ex
    ret = Expr(:block)
    for stmt in ex.args
        if stmt isa Expr && stmt.head === :block
            append!(ret.args, flatten_block(stmt).args)
        else
            push!(ret.args, flatten_block(stmt))
        end
    end
    return ret
end

function eval_interp(m::Module, ex)
    ex isa Expr || return ex
    ex.head === :$ && return Base.eval(m, ex.args[1])
    return Expr(ex.head, map(x->eval_interp(m, x), ex.args)...)
end

struct Hoistable
    origin::OrderedDict{Any, Any}
    hoisted::OrderedDict{Any, Any}
end

function Hoistable(X::Matrix)
    origin = OrderedDict()
    for i in axes(X, 1), j in axes(X, 2)
        origin[(i, j)] = X[i, j]
    end
    return Hoistable(origin, OrderedDict())
end

function hoist!(h::Hoistable, key, others...)
    key = isempty(others) ? key : (key, others...)
    haskey(h.hoisted, key) && return h.hoisted[key]
    @gensym hoisted
    h.hoisted[key] = hoisted
    return hoisted
end

function Base.getindex(h::Hoistable, key, others...)
    key = isempty(others) ? key : (key, others...)
    haskey(h.hoisted, key) && return h.hoisted[key]
    return h.origin[key]
end

function hoisted_expr(h::Hoistable)
    ret = Expr(:block)
    for (key, sym) in h.hoisted
        push!(ret.args, :($sym = $(h.origin[key])))
    end
    return ret
end

struct VarDefs
    mangled::OrderedDict{Symbol, Symbol}
    symbols::OrderedDict{Symbol, Any}
end

VarDefs() = VarDefs(OrderedDict{Symbol, Symbol}(), OrderedDict{Symbol, Any}())

function def!(defs::VarDefs, sym, expr; force=false)
    mangled = getfield(defs, :mangled)
    symbols = getfield(defs, :symbols)
    force || haskey(symbols, sym) && return defs
    symbols[sym] = expr
    mangled[sym] = gensym(sym)
    return defs
end

macro def(defs, ex::Expr)
    ex.head === :(=) || error("expect an assignment expr")
    quote
        $def!($defs, $(QuoteNode(ex.args[1])), $(Expr(:quote, ex.args[2])))
        $(ex.args[1]) = $defs.$(ex.args[1])
    end |> esc
end

macro defnew(defs, ex::Expr)
    ex.head === :(=) || error("expect an assignment expr")
    quote
        $def!($defs, $(QuoteNode(ex.args[1])), $(Expr(:quote, ex.args[2])); force=true)
        $(ex.args[1]) = $defs.$(ex.args[1])
    end |> esc
end

function var_exprs(defs::VarDefs)
    mangled = getfield(defs, :mangled)
    symbols = getfield(defs, :symbols)
    isempty(symbols) && return
    ret = Expr(:block)
    for (sym, expr) in symbols
        push!(ret.args, Expr(:(=), mangled[sym], expr))
    end
    return ret
end

function Base.getproperty(defs::VarDefs, name::Symbol)
    mangled = getfield(defs, :mangled)
    haskey(mangled, name) && return mangled[name]
    error("$name is not defined")
end

function Base.show(io::IO, defs::VarDefs)
    mangled = getfield(defs, :mangled)
    symbols = getfield(defs, :symbols)
    println(io, "global variables:")
    for (k, (sym, expr)) in enumerate(symbols)
        print(io, "  ", mangled[sym], ": ", sym, " = ", expr)
        if k != length(symbols)
            println(io)
        end
    end
end

@inline function literal_pow(::Val{:im}, p::Int)
    m = mod(p, 4)
    return if m == 0
        Complex{Int}(1, 0)
    elseif m == 1
        Complex{Int}(0, 1)
    elseif m == 2
        Complex{Int}(-1, 0)
    else
        Complex{Int}(0, -1)
    end
end
# fast pow of ``exp(im * pi / d)^x``
@generated function literal_pow(::Val{:exp}, ::Val{d}, x::Int) where d
    root = Expr(:if)
    curr = root
    for k in 0:(2d-2)
        push!(curr.args, :(m == $k))
        push!(curr.args, exp(im * π * k / d))
        next = Expr(:elseif)
        push!(curr.args, next)
        curr = next
    end

    push!(curr.args, :(m == $(2d-2)))
    push!(curr.args, exp(im * π * (2d-2) / d))
    push!(curr.args, exp(im * π * (2d-1) / d))

    return quote
        m = mod(x, 2d)
        $root
    end
end

"""
    log2i(x::Integer) -> Integer

Return log2(x), this integer version of `log2` is fast but only valid for number equal to 2^n.
"""
function log2i end

for N in [8, 16, 32, 64, 128]
    T = Symbol(:Int, N)
    UT = Symbol(:UInt, N)
    @eval begin
        log2i(x::$T) =
            !signbit(x) ? ($(N - 1) - leading_zeros(x)) :
            throw(ErrorException("nonnegative expected ($x)"))
        log2i(x::$UT) = $(N - 1) - leading_zeros(x)
    end
end

log2dim(x::AbstractVector) = log2i(size(x, 1))
log2dim(x::AbstractMatrix) = log2i(size(x, 2))

@inline lmove(b::Int, mask::Int, k::Int)::Int = (b & ~mask) << k + (b & mask)

"""
    bmask(::Type{T}) where T <: Integer -> zero(T)
    bmask([T::Type], positions::Int...) -> T
    bmask([T::Type], range::UnitRange{Int}) -> T
Return an integer mask of type `T` where `1` is the position masked according to
`positions` or `range`. Directly use `T` will return an empty mask `0`.
"""
function bmask end

bmask(args...) = bmask(Int, args...)
bmask(::Type{T}) where {T<:Integer} = zero(T)
bmask(::Type{T}, positions::Int...) where {T<:Integer} = bmask(T, positions)

function bmask(::Type{T}, itr) where {T<:Integer}
    isempty(itr) && return 0
    ret = zero(T)
    for b in itr
        ret += one(T) << (b - 1)
    end
    return ret
end

@inline function bmask(::Type{T}, range::UnitRange{Int})::T where {T<:Integer}
    ((one(T) << (range.stop - range.start + 1)) - one(T)) << (range.start - 1)
end

"""
    anyone(index::Integer, mask::Integer) -> Bool
Return `true` if any masked position of index is 1.
# Example
`true` if any masked positions is 1.
```jldoctest
julia> anyone(0b1011, 0b1001)
true
julia> anyone(0b1011, 0b1100)
true
julia> anyone(0b1011, 0b0100)
false
```
"""
anyone(index::T, mask::T) where {T<:Integer} = (index & mask) != zero(T)

"""
    ismatch(index::Integer, mask::Integer, target::Integer) -> Bool

Return `true` if bits at positions masked by `mask` equal to `1` are equal to `target`.

## Example

```julia
julia> n = 0b11001; mask = 0b10100; target = 0b10000;

julia> ismatch(n, mask, target)
true
```
"""
ismatch(index::T, mask::T, target::T) where {T<:Integer} = (index & mask) == target

@inline function _group_shift(masks::Vector{Int}, shift_len::Vector{Int}, k::Int, k_prv::Int)
    # if current position in the contiguous region
    # since these bits will be moved together with
    # the first one, we don't need to generate a
    # new mask
    if k == k_prv + 1
        shift_len[end] += 1
    else
        # we generate a bit mask where the 1st to k-th bits are 1
        push!(masks, bmask(0:k-1))
        push!(shift_len, 1)
    end
end

group_shift(locations::AbstractLocations) = group_shift(plain(locations))
complement_group_shift(n::Int, locations::AbstractLocations) = complement_group_shift(n, plain(locations))

@inline function group_shift(locations)
    masks = Int[]
    shift_len = Int[]
    k_prv = -1
    for k in locations
        _group_shift(masks, shift_len, k, k_prv)
        k_prv = k
    end
    return masks, shift_len
end

@inline function complement_group_shift(n::Int, locations)
    masks = Int[]
    shift_len = Int[]
    k_prv = -1
    for k in 1:n
        k in locations && continue
        _group_shift(masks, shift_len, k, k_prv)
        k_prv = k
    end
    return masks, shift_len
end

struct BitSubspace
    n::Int # number of bits in fullspace
    sz_subspace::Int # size of the subspace
    n_shifts::Int # number of shifts
    masks::Vector{Int} # shift masks
    shift_len::Vector{Int} # length of each shift
end

function Base.getindex(s::BitSubspace, i::Int)
    index = i - 1
    @inbounds for k in 1:s.n_shifts
        index = lmove(index, s.masks[k], s.shift_len[k])
    end
    return index
end

Base.firstindex(s::BitSubspace) = 1
Base.lastindex(s::BitSubspace) = s.sz_subspace
Base.length(s::BitSubspace) = s.sz_subspace
Base.eltype(::BitSubspace) = Int

function Base.iterate(s::BitSubspace, st::Int = 1)
    st <= length(s) || return
    return s[st], st + 1
end

function bsubspace(n::Int, locs)
    @assert issorted(locs)
    masks, shift_len = group_shift(locs)
    BitSubspace(n, 1 << (n - length(locs)), length(masks), masks, shift_len)
end

function bcomspace(n::Int, locs)
    @assert issorted(locs)
    masks, shift_len = complement_group_shift(n, locs)
    BitSubspace(n, 1 << length(locs), length(masks), masks, shift_len)
end

function Base.show(io::IO, ::MIME"text/plain", s::BitSubspace)
    indent = get(io, :indent, 0)
    println(io, " "^indent, s.sz_subspace, "-element BitSubspace:")
    if s.sz_subspace < 5
        for k in 1:s.sz_subspace
            print(io, " "^(indent+1), string(s[k]; base=2, pad=s.n))
            if k != s.sz_subspace
                println(io)
            end
        end
    else # never print more than 4 elements
        println(io, " "^(indent+1), string(s[1]; base=2, pad=s.n))
        println(io, " "^(indent+1), string(s[2]; base=2, pad=s.n))
        println(io, " "^(indent+1), "⋮")
        println(io, " "^(indent+1), string(s[end-1]; base=2, pad=s.n))
        print(io, " "^(indent+1), string(s[end]; base=2, pad=s.n))
    end
end

end # Utilities
