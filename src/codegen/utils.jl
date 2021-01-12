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
