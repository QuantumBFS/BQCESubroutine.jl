macro broutine(ex)
    esc(broutine_m(__module__, ex))
end

struct BitRoutine
    name::Symbol
    args::Vector{Any}
    expr::Matrix{Any}
    typevars::Vector{Any}
end

function BitRoutine(ex::Expr)
    def = splitdef(ex; throw=false)
    if def === nothing
        ex.head === :(=) || error("invalid syntax, expect function or matrix, got: $ex")
        name, mat = ex.args
        name isa Symbol || error("invalid syntax, matrix name must be a Symbol, got: $name")
        mat.head === :vcat || error("invalid syntax, expect matrix, got: $mat")
        return BitRoutine(name, [], match_matrix_expr(mat), [])
    else
        haskey(def, :name) || error("routine definition cannot be annoymous")
        haskey(def, :args) || error("do not declare constant gate as function")
        haskey(def, :body) || error("empty routine definition")
        def[:name] isa Symbol || error("routine name must be Symbol")

        body = def[:body]::Expr
        if body.head === :block
            body = last(body.args)
        end
        return BitRoutine(def[:name], def[:args], match_matrix_expr(body), get(def, :whereparams, []))
    end
end

function match_matrix_expr(ex::Expr)
    ex.head === :vcat || error("not a matrix expression")
    size = length(ex.args)
    expr = Matrix{Any}(undef, size, size)
    for (i, row) in enumerate(ex.args)
        row.head === :row || error("not a matrix expression")
        for (j, each) in enumerate(row.args)
            expr[i, j] = each
        end
    end
    return expr
end

Base.size(x::BitRoutine) = size(x.expr, 1)

function Base.show(io::IO, x::BitRoutine)
    print(io, x.name)
    if isempty(x.args)
        print(io, " = ")
    else
        print(io, "(", join(x.args, ", "), ") ")
        if !isempty(x.typevars)
            print(io, "where {", join(x.typevars, ", "), "} ")
        end
        print(io, "= ")
    end

    print(io, "[")
    for i in 1:size(x.expr, 1)
        for j in 1:size(x.expr, 2)
            print(io, x.expr[i, j])
            if j != size(x.expr, 2)
                print(io, " ")
            elseif i != size(x.expr, 1)
                print(io, ";")
            end
        end

        if i != size(x.expr, 1)
            print(io, " ")
        end
    end
    print(io, "]")
end

function broutine_m(m::Module, ex::Expr)
    b = BitRoutine(ex)

    broutines = if size(b) == 2
        codegen_broutine2x2(m, b)
    else
        error("size not supported yet")
    end

    # NOTE: we need to leave name space
    # for other type of qubits, e.g qutrits
    const_name = Symbol(:B, b.name)
    body = Expr(:vcat)
    for row in eachrow(b.expr)
        push!(body.args, Expr(:row, row...))
    end
    con = if isempty(b.args)
        :(const $(const_name) = $body)
    else
        def = Dict{Symbol, Any}(
            :name => const_name,
            :args => b.args,
            :whereparams => b.typevars,
            :body => body
        )
        combinedef(def)
    end

    return quote
        $broutines
        $con
    end
end

function sym_mul(a, b)
    if a isa Number
        iszero(a) && return
        isone(a) && return b
    end

    return :($a * $b)
end

function sym_plus(a, b)
    if a === nothing && b === nothing
        0
    elseif a === nothing && b !== nothing
        b
    elseif a !== nothing && b === nothing
        a
    else
        :($a + $b)
    end
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

function codegen_broutine2x2(m::Module, x::BitRoutine)
    ex = Expr(:block)
    push!(ex.args, codegen_broutine2x2_generic(m, x))

    # repeat gate multi qubit routines
    if isdiag(x.expr)
        push!(ex.args, codegen_broutine2x2_diag(m, x))
    elseif isperm(x.expr)
        push!(ex.args, codegen_broutine2x2_perm(m, x))
    else
        push!(ex.args, codegen_broutine2x2_dense(m, x))
    end
    return ex
end

function codegen_broutine2x2_generic(m::Module, ex::BitRoutine)
    @gensym st locs ctrl T nqubits step_1 step_2 it_i it_j temp ctrl_mask flag_mask
    function kernel(i)
        values = [:($st[$i+1]), :($st[$i + $step_1 + 1])]
        entries = Expr(:block)
        assigns = Expr(:block)

        for p in 1:size(ex.expr, 1)
            a = sym_mul(ex.expr[p, 1], values[1])
            b = sym_mul(ex.expr[p, 2], values[2])
            t = Symbol(temp, p)
            e = sym_plus(a, b)
            e == values[p] && continue
            push!(entries.args, Expr(:(=), t, e))
            push!(assigns.args, Expr(:(=), values[p], t))
        end

        return quote
            $entries
            $assigns
        end
    end

    function loop_kernel(f, n, j)
        ret = Expr(:block, f(j))
        for k in 1:n-1
            push!(ret.args, f(:($j+$k)))
        end
        return ret
    end

    function jloop(ex)
        :(for $it_j in 0:$step_2:size($st, 1)-$step_1
            $ex
        end)
    end

    function expand(max, f)
        root = Expr(:if, :($step_1 == 1), jloop(f(it_j)))
        curr = root
        for k in 1:max
            n = 1 << k
            elif = Expr(:elseif, :($step_1 == $n), jloop(loop_kernel(f, n, it_j)))
            push!(curr.args, elif)
            curr = elif
        end
        push!(curr.args, jloop(:(
            for $it_i in $it_j:$(1<<max):$it_j+$step_1-1
                $(loop_kernel(f, 1<<max, it_i))
            end
        )))
        return root
    end

    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVector{$T}), :(::Val{$(QuoteNode(ex.name))}), :($locs::$Locations{Int}), ex.args...],
        :whereparams => [T, ex.typevars...],
        :body => quote
            $step_1 = 1 << ($plain($locs) - 1)
            $step_2 = 1 << ($plain($locs))

            $(expand(4, kernel))
            return $st
        end,
    )

    function ctrl_kernel(i)
        :(
            if $ismatch($i, $ctrl_mask, $flag_mask)
                $(kernel(i))
            end
        )
    end

    ctrl_def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVector{$T}), :(::Val{$(QuoteNode(ex.name))}), :($locs::$(Union{Locations{Int}, Locations{Tuple{Int}}})), :($ctrl::$CtrlLocations), ex.args...],
        :whereparams => [T, ex.typevars...],
        :body => quote
            raw = first($plain($locs))
            raw_ctrl = $plain($ctrl)
            $step_1 = 1 << (raw - 1)
            $step_2 = 1 << raw
            $ctrl_mask = bmask(raw_ctrl)
            $flag_mask = 0
            for i in 1:length($ctrl)
                if $ctrl.flags[i]
                    $flag_mask += one(Int) << (raw_ctrl[i] - 1)
                end
            end

            $(expand(4, ctrl_kernel))
            return $st
        end,
    )

    return quote
        $(combinedef(def))
        $(combinedef(ctrl_def))
    end
end

# U_{a1,b1}U_{a2,b2} st[b1,b2, ...]
# U_{a1,0}U_{a2,0} st[0,0, ...] +
# U_{a1,0}U_{a2,1} st[0,1, ...] +
# U_{a1,1}U_{a2,0} st[1,0, ...] +
# U_{a1,1}U_{a2,1} st[1,1, ...] +

# diag element are in power of number ones/zeros
# a1,a2 = 0,0
# U_{0,0}U_{0,0} st[0,0, ...]
# a1,a2 = 0,1
# U_{0,0}U_{1,1} st[0,1, ...]
# a1,a2 = 1,0
# U_{1,1}U_{0,0} st[1,0, ...]
# a1,a2 = 1,1
# U_{1,1}U_{1,1} st[1,1, ...]
function codegen_broutine2x2_diag(m::Module, brt::BitRoutine)
    U11 = brt.expr[1, 1]
    U22 = brt.expr[2, 2]
    @gensym T st locs l mask alpha m
    parepare = quote
        $l = length($locs)
        $mask = $bmask(Int, $plain($locs))
    end

    function kernel(m, p)
        if U11 == U22 # this does not need k
            if U11 isa Number && isone(U11)
                ex = nothing
            else
                push!(parepare.args, :($alpha = $U11^l))
                ex = :($st[$p] = $alpha * $st[$p])
            end
        else
            ex = :($st[$p] = $U11^($l-k) * $U22^k * $st[$p])
            ex = elim_double_const_pow(ex)
            ex = elim_const_pow(ex)
            ex = elim_identity(ex)
            ex = elim_exp_pi(ex)
            ex = quote
                k = count_ones($m & $mask)
                $ex
            end
        end
        return ex
    end

    N = 8
    expanded = Expr(:block, kernel(m, :($m+1)))
    for i in 1:(N-1)
        push!(expanded.args, kernel(:($m+$i), :($m+$(i+1))))
    end

    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVector{$T}), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :whereparams => [T, brt.typevars...],
        :body => quote
            $parepare
            @inbounds for $m in 0:length($st) - 1
                $(kernel(m, :($m+1)))
            end
            return $st
        end,
    )

    return combinedef(def)
end

# U_{a1,b1}U_{a2,b2} st[b1,b2, ...]
# U_{a1,0}U_{a2,0} st[0,0, ...] +
# U_{a1,0}U_{a2,1} st[0,1, ...] +
# U_{a1,1}U_{a2,0} st[1,0, ...] +
# U_{a1,1}U_{a2,1} st[1,1, ...] +

# a1,a2 = 0,0
# U_{0,1}U_{0,1} st[1,1, ...]
# a1,a2 = 0,1
# U_{0,1}U_{1,0} st[1,0, ...]
# a1,a2 = 1,0
# U_{1,0}U_{0,1} st[0,1, ...]
# a1,a2 = 1,1
# U_{1,0}U_{1,0} st[0,0, ...]
function codegen_broutine2x2_perm(m::Module, brt::BitRoutine)
    U12 = brt.expr[1, 2]
    U21 = brt.expr[2, 1]
    @gensym T st locs l mask do_mask isodd_l alpha i j m

    prepare = quote
        $l = length($locs)
        $mask = bmask(Int, $plain($locs))
        $do_mask = bmask(Int, first($plain($locs)))
    end

    if (U21 isa Number && U12 == -U21) || (U12 == :(-$U21))
        push!(prepare.args, :($isodd_l = isodd($l)))
        if !(U12 isa Number && isone(U12))
            push!(prepare.args, :($alpha = $U12^$l))
        end
    end

    kernel(p, q) = if U12 == U21
        if U12 isa Number && isone(U12)
            quote
                tmp = $st[$p]
                $st[$p] = $st[$q]
                $st[$q] = tmp
            end
        else
            push!(prepare.args, :($alpha = $U21^$l))
            quote
                tmp = $st[$p]
                $st[$p] = $alpha * $st[$q]
                $st[$q] = $alpha * tmp
            end
        end
    elseif (U21 isa Number && U12 == -U21) || (U12 == :(-$U21))
        if U12 isa Number && isone(U12)
            quote
                k = count_ones($m & $mask)
                tmp = $st[$p]
                if isodd(k)
                    $st[$p] = -$st[$q]
                    if $isodd_l # (l-k) even
                        $st[$q] = tmp
                    else
                        $st[$q] = -tmp
                    end
                else
                    $st[$p] = $st[$q]
                    if $isodd_l # (l-k) old
                        $st[$q] = -tmp
                    else
                        $st[$q] = tmp
                    end
                end
            end
        else
            quote
                k = count_ones($m & $mask)
                tmp = $st[$p]
                if isodd(k)
                    $st[$p] = -$alpha * $st[$q]
                    if $isodd_l # (l-k) even
                        $st[$q] = $alpha * tmp
                    else
                        $st[$q] = -$alpha * tmp
                    end
                else
                    $st[$p] = $alpha * $st[$q]
                    if $isodd_l # (l-k) old
                        $st[$q] = -$alpha * tmp
                    else
                        $st[$q] = $alpha * tmp
                    end
                end
            end
        end
    else
        quote
            k = count_ones($m & $mask)
            tmp = $st[$p]
            $st[$p] = $U21^k * $U12^($l-k) * $st[$q]
            $st[$q] = $U12^k * $U21^($l-k) * tmp
        end
    end

    function loop_kernel(m)
        quote
            if $anyone($m, $do_mask)
                $i = $m + 1
                $j = ($m ⊻ $mask) + 1
                $(kernel(i, j))
            end
        end
    end

    N = 1
    expanded_loop = Expr(:block, loop_kernel(m))
    for i in 1:(N-1)
        push!(expanded_loop.args, loop_kernel(:($m+$i)))
    end

    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVector{$T}), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :whereparams => [T, brt.typevars...],
        :body => quote
            $prepare
            @inbounds for $m in 0:$N:(length($st) - 1)
                $(loop_kernel(m))
            end
            return $st
        end,
    )

    return combinedef(def)
end

function codegen_broutine2x2_dense(m::Module, brt::BitRoutine)
    U12 = brt.expr[1, 2]
    U21 = brt.expr[2, 1]
    @gensym T st loc locs gt
    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVector{$T}), :($gt::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :whereparams => [T, brt.typevars...],
        :body => quote
            for $loc in $locs
                $(GlobalRef(BQCESubroutine, :broutine!))($st, $gt, $loc, $(brt.args...))
            end
            return $st
        end,
    )

    return combinedef(def)
end

function elim_double_const_pow(ex)
    m = gensym(:m)
    @smatch ex begin
        :($D = 1^$p * $B^$q * $C) => :($D = $B^$q * $C)
        :($D = A^$p * 1^$q * $C) => :($D = $A^$p * $C)
        :($D = $A^$p * $B^$q * $C) => begin
            if A == B
                :($D = $A^($p+$q) * $C)
            else
                :($D = $A^$p * ($B^$q * $C))
            end
        end
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
        :($A = $B) => begin
            if A == B
                nothing
            else
                ex
            end
        end
        ::Expr => Expr(ex.head, map(elim_identity, ex.args)...)
        _ => ex
    end
end
