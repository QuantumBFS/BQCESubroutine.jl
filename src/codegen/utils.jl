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

function sym_mul(a, b)
    @match (a, b) begin
        ( 0, B) => 0
        ( 1, B) => B
        (-1, B::Number) => -B
        (-1, B) => :(-$B)

        (A,  0) => 0
        (A,  1) => A
        (A::Number, -1) => -A
        (A, -1) => :(-$A)

        _ => :($a * $b)
    end
end

function sym_plus(a, b)
    @match (a, b) begin
        (0, 0) => 0
        (0, B) => B
        (A, 0) => A
        _ => :($a+$b)
    end
end

function nexprs(f, n::Int)
    ex = Expr(:block)
    for k in 1:n
        push!(ex.args, f(k))
    end
    return ex
end

function isperm(x::Matrix)
    all(count(x->!isa(x, Number) || !iszero(x), col) == 1 for col in eachcol(x))
end

function isdiag(x::Matrix)
    for i in 1:size(x, 1), j in 1:size(x, 2)
        e = x[i, j]
        if i != j
            e isa Number && iszero(e) && continue
            return false
        end
    end
    return true
end
