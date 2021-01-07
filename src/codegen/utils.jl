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

function elim_double_const_pow(ex)
    @smatch ex begin
        :($D = 1^$p * $B^$q * $C) => :($D = $B^$q * $C)
        :($D = A^$p * 1^$q * $C) => :($D = $A^$p * $C)
        :($D = $A^$p * $&A^$q * $C) => :($D = $A^($p+$q) * $C)
        :($D = $A^$p * (-$&A)^$q * $C) => :($D = (-1)^$q * $A^($p+$q) * $C)
        :($D = (-$A)^$p * ($&A)^$q * $C) => :($D = (-1)^$p * $A^($p+$q) * $C)
        :($D = $A^$p * $B^$q * $C) => :($D = $A^$p * ($B^$q * $C))
        ::Expr => Expr(ex.head, map(elim_double_const_pow, ex.args)...)
        _ => ex
    end
end

function elim_const_pow(ex)
    m = gensym(:m)
    @smatch ex begin
        :($D = 1^$p * $C) => :($D = $C)
        :($D = (-1)^$p * $C) => quote
            if isodd($p)
                $D = -$C
            else
                $D = $C
            end
        end
        :($D = im^$p * $C) => quote
            $m = mod($p, 4)
            if $m == 0
                $D = $C
            elseif $m == 1
                $D = im * $C
            elseif $m == 2
                $D = -$C
            else
                $D = -im*$C
            end
        end
        :($D = (-im)^$p * $C) => quote
            $m = mod($p, 4)
            if $m == 0
                $D = $C
            elseif $m == 1
                $D = -im * $C
            elseif $m == 2
                $D = -$C
            else
                $D = im*$C
            end
        end
        ::Expr => Expr(ex.head, map(elim_const_pow, ex.args)...)
        _ => ex
    end
end

function elim_exp_pi(ex)
    @smatch ex begin
        :(exp(im * π / $k)^$p) => 
            :(fast_expi_pi_pow(Val($k), $p))
        ::Expr => Expr(ex.head, map(elim_exp_pi, ex.args)...)
        _ => ex
    end
end

function elim_identity(ex)
    @smatch ex begin
        :($A = $&A) => nothing
        :(1 * $x) => x
        :(-1 * $x) || :(-(1) * $x) => :(-$x)
        :($a+($b-$a)) => b
        ::Expr => Expr(ex.head, map(elim_identity, ex.args)...)
        _ => ex
    end
end
