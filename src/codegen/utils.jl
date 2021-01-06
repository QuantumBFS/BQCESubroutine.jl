_iszero(x) = false
_iszero(x::Number) = iszero(x)

function sym_mul(a, b)
    if a isa Number
        iszero(a) && return 0
        isone(a) && return b
    end

    return :($a * $b)
end

function sym_plus(a, b)
    if _iszero(a) && _iszero(b)
        0
    elseif _iszero(a) && !_iszero(b)
        b
    elseif !_iszero(a) && _iszero(b)
        a
    else
        :($a + $b)
    end
end

function nexprs(f, n::Int)
    ex = Expr(:block)
    for k in 1:n
        push!(ex.args, f(k))
    end
    return ex
end
