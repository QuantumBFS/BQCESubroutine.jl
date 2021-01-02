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
    push!(ex.args, codegen_broutine2x2_generic(x))

    # repeat gate multi qubit routines
    if isdiag(x.expr)
        push!(ex.args, codegen_broutine2x2_diag(x))
    elseif isperm(x.expr)
        push!(ex.args, codegen_broutine2x2_perm(x))
    else
        push!(ex.args, codegen_broutine2x2_dense(x))
    end
    return ex
end

function mm_kernel(st, x::BitRoutine, indices::Vector)
    @gensym temp
    entries = Expr(:block)
    assigns = Expr(:block)
    values = [:($st[$idx]) for idx in indices]

    for i in 1:size(x.expr, 1)
        t = Symbol(temp, :_, i)
        e = sym_mul(x.expr[i, 1], values[1])
        for j in 2:size(x.expr, 2)
            e = sym_plus(e, sym_mul(x.expr[i, j], values[j]))
        end
        e == values[i] && continue
        push!(entries.args, Expr(:(=), t, e))
        push!(assigns.args, Expr(:(=), values[i], t))
    end

    return Expr(:block, entries.args..., assigns.args...)
end

function nexprs(f, n::Int)
    ex = Expr(:block)
    for k in 1:n
        push!(ex.args, f(k))
    end
    return ex
end

function broutine2x2_jloop(f, st, step_2, step_1)
    @gensym j
    quote
        for $j in 0:$step_2:size($st, 1) - $step_1
            $(f(j))
        end
    end
end

function broutine2x2_iloop(f, n, j, step_1)
    @gensym i
    quote
        for $i in $j:$n:$j+$step_1-1
            $(f(i))
        end
    end
end

function expand(f_kernel, max, st, step_1, step_2)
    ret = Expr(:block)
    for k in 0:max
        n = 1 << k
        expanded = broutine2x2_jloop(st, step_2, step_1) do j
            nexprs(n) do i
                f_kernel(:($j+$i))
            end
        end
        push!(ret.args, quote
            if $step_1 == $n
                $expanded
                return $st
            end
        end)
    end

    push!(ret.args, broutine2x2_jloop(st, step_2, step_1) do j
        broutine2x2_iloop(1<<max, j, step_1) do i
            nexprs(1<<max) do k
                f_kernel(:($i+$k))
            end
        end
    end)
    return ret
end

function codegen_broutine2x2_generic(brt::BitRoutine)
    @gensym st locs ctrl
    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVecOrMat), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), brt.args...],
        :body => quote
            if length($locs) == 1
                U11 = $(brt.expr[1, 1]); U12 = $(brt.expr[1, 2]);
                U21 = $(brt.expr[2, 1]); U22 = $(brt.expr[2, 2]);
                $_broutine2x2!($st, (U11, U12, U21, U22), $locs)
            else
                $multi_broutine2x2!($st, $(Val(brt.name)), $locs)
            end
            return $st
        end,
    )

    ctrl_def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :broutine!),
        :args => Any[:($st::AbstractVecOrMat), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), :($ctrl::$CtrlLocations), brt.args...],
        :body => quote
            if length($locs) == 1
                U11 = $(brt.expr[1, 1]); U12 = $(brt.expr[1, 2]);
                U21 = $(brt.expr[2, 1]); U22 = $(brt.expr[2, 2]);
                $_broutine2x2!($st, (U11, U12, U21, U22), $locs, $ctrl)
            else
                $multi_broutine2x2!($st, $(Val(brt.name)), $locs, $ctrl)
            end
            return $st
        end,
    )

    isempty(brt.typevars) || (def[:whereparams] = [brt.typevars...])
    isempty(brt.typevars) || (ctrl_def[:whereparams] = [brt.typevars...])

    return quote
        $(combinedef(def))
        $(combinedef(ctrl_def))
    end
end

function multi_broutine2x2! end

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
function diag_kernel(brt::BitRoutine, st, locs)
    U11 = brt.expr[1, 1]
    U22 = brt.expr[2, 2]

    @gensym l mask alpha
    init = quote
        $l = length($locs)
        $mask = $bmask(Int, $plain($locs))
    end

    if U11 == U22 # this does not need k
        if U11 isa Number && isone(U11)
            kernel = (m, p)->nothing
        else
            push!(parepare.args, :($alpha = $U11^l))
            kernel = (m, p)->:($st[$(p...)] = $alpha * $st[$(p...)])
        end
    else
        kernel = (m, p)->begin
            ex = :($st[$(p...)] = $U11^($l-k) * $U22^k * $st[$(p...)])
            ex = elim_double_const_pow(ex)
            ex = elim_const_pow(ex)
            ex = elim_identity(ex)
            ex = elim_exp_pi(ex)
            ex = quote
                k = count_ones($m & $mask)
                $ex
            end
        end
    end

    loop(m) = kernel(m, (:($m+1), ))
    loop(m, b) = kernel(m, (b,:($m+1)))

    return init, loop
end

function codegen_broutine2x2_diag(brt::BitRoutine)
    @gensym st locs m b
    
    init, kernel = diag_kernel(brt, st, locs)
    vdef = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
        :args => Any[:($st::AbstractVector), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :body => quote
            $init
            $(broutine2x2_loop(kernel, st, 8))
            return $st
        end,
    )

    mdef = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
        :args => Any[:($st::AbstractMatrix), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :body => quote
            $init
            $(broutine2x2_loop_m(kernel, st, 8))
            return $st
        end,
    )

    if !isempty(brt.typevars)
        vdef[:whereparams] = [brt.typevars...]
        mdef[:whereparams] = [brt.typevars...]
    end

    return quote
        $(combinedef(vdef))
        $(combinedef(mdef))
    end
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
function perm_kernel(brt::BitRoutine, st, locs)
    @gensym l mask do_mask alpha tmp i j isodd_l
    U12 = brt.expr[1, 2]
    U21 = brt.expr[2, 1]

    init = quote
        $l = length($locs)
        $mask = bmask(Int, $plain($locs))
        $do_mask = bmask(Int, first($plain($locs)))
    end

    if U12 == U21
        if U12 isa Number && isone(U12)
            kernel = (m, p, q)->quote
                $tmp = $st[$(q...)]
                $st[$(q...)] = $st[$(p...)]
                $st[$(p...)] = $tmp
            end
        else
            push!(init.args, :($alpha = $U21^$l))
            kernel = (m, p, q)->quote
                $tmp = $st[$(q...)]
                $st[$(q...)] = $alpha * $st[$(p...)]
                $st[$(p...)] = $alpha * $tmp
            end
        end
    elseif (U21 isa Number && U12 == -U21) || (U12 == :(-$U21))
        push!(init.args, :($isodd_l = isodd($l)))
        if !(U12 isa Number && isone(U12))
            push!(init.args, :($alpha = $U12^$l))
        end

        if U12 isa Number && isone(U12)
            kernel = (m, p, q)->quote
                k = count_ones($m & $mask)
                $tmp = $st[$(q...)]
                if isodd(k)
                    $st[$(q...)] = -$st[$(p...)]
                    if $isodd_l # (l-k) even
                        $st[$(p...)] = $tmp
                    else
                        $st[$(p...)] = -$tmp
                    end
                else
                    $st[$(q...)] = $st[$(p...)]
                    if $isodd_l # (l-k) old
                        $st[$(p...)] = -$tmp
                    else
                        $st[$(p...)] = $tmp
                    end
                end
            end
        else
            kernel = (m, p, q)->quote
                k = count_ones($m & $mask)
                $tmp = $st[$(q...)]
                if isodd(k)
                    $st[$(q...)] = -$alpha * $st[$(p...)]
                    if $isodd_l # (l-k) even
                        $st[$(p...)] = $alpha * $tmp
                    else
                        $st[$(p...)] = -$alpha * $tmp
                    end
                else
                    $st[$(q...)] = $alpha * $st[$(p...)]
                    if $isodd_l # (l-k) old
                        $st[$(p...)] = -$alpha * $tmp
                    else
                        $st[$(p...)] = $alpha * $tmp
                    end
                end
            end
        end
    else
        kernel = (m, p, q)->quote
            k = count_ones($m & $mask)
            $tmp = $st[$(q...)]
            $st[$(q...)] = $U12^k * $U21^($l-k) * $st[$(p...)]
            $st[$(p...)] = $U21^k * $U12^($l-k) * $tmp
        end
    end

    function loop(m)
        quote
            if $anyone($m, $do_mask)
                $i = $m + 1
                $j = ($m ⊻ $mask) + 1
                $(kernel(m, (i, ), (j, )))
            end
        end
    end

    function loop(m, b)
        quote
            if $anyone($m, $do_mask)
                $i = $m + 1
                $j = ($m ⊻ $mask) + 1
                $(kernel(m, (b, i), (b, j)))
            end
        end
    end
    return init, loop
end

function codegen_broutine2x2_perm(brt::BitRoutine)
    @gensym st locs
    init, kernel = perm_kernel(brt, st, locs)
    vdef = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
        :args => Any[:($st::AbstractVector), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :body => quote
            $init
            $(broutine2x2_loop(kernel, st, 8))
            return $st
        end,
    )

    mdef = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
        :args => Any[:($st::AbstractMatrix), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
        :body => quote
            $init
            $(broutine2x2_loop_m(kernel, st, 8))
            return $st
        end,
    )

    if !isempty(brt.typevars)
        vdef[:whereparams] = [brt.typevars...]
        mdef[:whereparams] = [brt.typevars...]
    end
    return quote
        $(combinedef(vdef))
        $(combinedef(mdef))
    end
end

function broutine2x2_loop_expanded(f_kernel, st, N::Int)
    @gensym m _m Mmax mmax
    expanded = nexprs(N) do k
        f_kernel(:($m + $k - 1))
    end

    return quote
        $Mmax = size($st, 1) - 1
        for $_m in 0:($Mmax >>> $(log2i(N)))
            $m = $_m << $(log2i(N))
            $mmax = $m + $(N-1)
            if $mmax ≤ $Mmax
                $expanded
            else
                for $_m in $m:$Mmax
                    $(f_kernel(_m))
                end
            end
        end
    end
end

function broutine2x2_loop_expanded(f_kernel, st, N::Int, b)
    @gensym m _m Mmax mmax
    expanded = nexprs(N) do k
        f_kernel(:($m + $k - 1), b)
    end

    return quote
        $Mmax = size($st, 2) - 1
        for $_m in 0:($Mmax >>> $(log2i(N)))
            $m = $_m << $(log2i(N))
            $mmax = $m + $(N-1)
            if $mmax ≤ $Mmax
                for $b in 1:size($st, 1)
                    $expanded
                end
            else
                for $_m in $m:$Mmax, $b in 1:size($st, 1)
                    $(f_kernel(_m, b))
                end
            end
        end
    end
end

function broutine2x2_loop(f_kernel, st, N::Int)
    @gensym m
    return quote
        @inbounds if size($st, 1) > 8
            $(broutine2x2_loop_expanded(f_kernel, st, N))
        else
            for $m in 0:(size($st, 1) - 1)
                $(f_kernel(m))
            end
        end
    end
end

function broutine2x2_loop_m(f_kernel, st, N::Int)
    @gensym m b
    return quote
        @inbounds if size($st, 2) > 8
            $(broutine2x2_loop_expanded(f_kernel, st, N, b))
        else
            for $m in 0:(size($st, 2) - 1)
                $(f_kernel(m, b))
            end
        end
    end
end

function codegen_broutine2x2_dense(brt::BitRoutine)
    U12 = brt.expr[1, 2]
    U21 = brt.expr[2, 1]
    @gensym T st loc locs gt
    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
        :args => Any[:($st::AbstractVecOrMat{$T}), :($gt::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
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
