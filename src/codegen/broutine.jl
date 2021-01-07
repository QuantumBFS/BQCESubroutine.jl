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
        return BitRoutine(def[:name], def[:args],
            match_matrix_expr(body), get(def, :whereparams, []))
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

function codegen_method(f_body, brt::BitRoutine, name::Symbol, batch, ctrl)
    @gensym st locs
    T = batch === nothing ? AbstractVector : AbstractMatrix
    args = Any[:($st::$T), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations)]
    ctrl === nothing || push!(args, :($ctrl::$CtrlLocations))
    append!(args, brt.args)

    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, name),
        :args => args,
        :body => quote
            $(f_body(st, locs))
            return $st
        end,
    )
    isempty(brt.typevars) || (def[:whereparams] = [brt.typevars...])
    return combinedef(def)
end

function broutine_m(m::Module, ex::Expr)
    brt = BitRoutine(ex)

    # generate multi-gate routine for 2x2
    broutines = if size(brt) == 2
        codegen_broutine2x2_multi(brt)
    else
        nothing
    end

    # NOTE: we need to leave name space
    # for other type of qubits, e.g qutrits
    const_name = Symbol(:B, brt.name)
    body = Expr(:vcat)
    for row in eachrow(brt.expr)
        push!(body.args, Expr(:row, row...))
    end
    con = if isempty(brt.args)
        :(const $(const_name) = $body)
    else
        def = Dict{Symbol, Any}(
            :name => const_name,
            :args => brt.args,
            :whereparams => brt.typevars,
            :body => body
        )
        combinedef(def)
    end

    return quote
        $(codegen_broutine(brt))
        $broutines
        $con
    end
end

function codegen_broutine2x2_multi(brt::BitRoutine)
    # NOTE:
    # no benefit if it's parameterized
    # it will make our loop kernel too complicated
    if !isempty(brt.args)
        return codegen_broutine2x2_dense(brt)
    end

    if isdiag(brt.expr)
        return codegen_broutine2x2_diag(brt)
    elseif isperm(brt.expr)
        return codegen_broutine2x2_perm(brt)
    else
        return codegen_broutine2x2_dense(brt)
    end
end

function codegen_broutine(brt::BitRoutine)
    @gensym step
    ret = Expr(:block)
    for batch in [nothing, gensym(:batch)], ctrl in [nothing, gensym(:ctrl)]
        mt = codegen_method(brt, :broutine!, batch, ctrl) do st, locs
            init, kernel = generic_kernel(brt, st, locs, ctrl, step)
            multi = Expr(:call, GlobalRef(BQCESubroutine, :multi_broutine2x2!),
                st, :(Val($(QuoteNode(brt.name)))), locs)
            ctrl === nothing || push!(multi.args, ctrl)
            append!(multi.args, brt.args)

            body = Expr(:block)
            size(brt) == 2 && push!(body.args, :(length($locs) == 1 || return $multi))
            push!(body.args, init)
            push!(body.args, :(@fastmath @inbounds $(subspace_loop(kernel, brt, st, step, batch))) )
            return body
        end
        push!(ret.args, mt)
    end
    return ret
end

function codegen_broutine2x2_diag(brt::BitRoutine)
    @gensym batch

    ret = Expr(:block)
    for b in [nothing, batch]
        mt = codegen_method(brt, :multi_broutine2x2!, b, nothing) do st, locs
            init, kernel = diag_kernel(brt, st, locs)
            quote
                $init
                $(broutine2x2_loop(kernel, st, 1, b))
            end
        end
        push!(ret.args, mt)
    end
    return ret
end

function codegen_broutine2x2_perm(brt::BitRoutine)
    @gensym step
    
    ret = Expr(:block)
    for batch in [nothing, gensym(:batch)]
        mt = codegen_method(brt, :multi_broutine2x2!, batch, nothing) do st, locs
            init, kernel = perm_kernel(brt, st, locs)
            quote
                $init
                $(Symbol(step, :_, 1, :_l)) = 1 << (first($plain($locs)) - 1)
                $(Symbol(step, :_, 1, :_h)) = 1 << first($plain($locs))
                @fastmath @inbounds $(subspace_loop(kernel, brt, st, step, batch))
            end
        end
        push!(ret.args, mt)
    end

    return ret
end

function generic_kernel(brt::BitRoutine, st, locs, ctrl, step)
    init, kernel = _generic_kernel(brt, st, locs, step)
    if ctrl === nothing
        return init, kernel
    else
        ctrl_init, ctrl_kernel = generic_ctrl_kernel(kernel, ctrl)
        init = quote
            $init
            $ctrl_init
        end
        return init, ctrl_kernel
    end
end

ishoisted(x) = !(x isa Number || x isa Symbol || x == :(-im))

function _generic_kernel(brt::BitRoutine, st, locs, step)
    @gensym M raw_locs
    init = quote
        @assert length($locs) == $(log2i(size(brt))) "number of locations mismatch operator size"
        $raw_locs = $plain(sort($locs))
    end

    step_l(i) = Symbol(step, :_, i, :_l)
    step_h(i) = Symbol(step, :_, i, :_h)
    U(i, j) = ishoisted(brt.expr[i, j]) ? Symbol(M, :_, i, j) : brt.expr[i, j]

    for i in 1:log2i(size(brt))
        push!(init.args, :($(step_l(i)) = 1 << ($raw_locs[$i] - 1)))
        push!(init.args, :($(step_h(i)) = 1 << $raw_locs[$i]))
    end

    for i in 1:size(brt), j in 1:size(brt)
        !ishoisted(brt.expr[i, j]) && continue
        push!(init.args, :($(Symbol(M, :_, i, j)) = $(brt.expr[i, j])))
    end

    return init, function kernel(m, b)
        @gensym index T
        ret = Expr(:block)
        indices = []
        for flag in 0:size(brt)-1
            idx = m
            for i in 1:log2i(size(brt))
                if (flag >>> (i-1)) & 1 == 1
                    idx = :($idx + $(step_l(i)))
                end
            end
            push!(indices, idx)
        end
        
        values = []
        for idx in 0:size(brt)-1
            index_i = Symbol(index, :_, idx+1)
            if b === nothing
                push!(values, :($st[$index_i]))
            else
                push!(values, :($st[$b, $index_i]))
            end
        end

        entries = []
        assigns = []
        for i in 1:size(brt.expr, 1)
            t = Symbol(T, :_, i)
            e = sym_mul(U(i, 1), values[1])

            for j in 2:size(brt.expr, 2)
                e = sym_plus(e, sym_mul(U(i, j), values[j]))
            end

            e == values[i] && continue

            push!(ret.args, :($(Symbol(index, :_, i)) = $(indices[i]) + 1))
            push!(entries, Expr(:(=), t, e))
            push!(assigns, Expr(:(=), values[i], t))
        end

        append!(ret.args, entries)
        append!(ret.args, assigns)

        b === nothing && return ret
        return Expr(:for, :($b = axes($st, 1)), ret)
    end
end

function subspace_loop(f, brt::BitRoutine, st, step, b = nothing, max = 3)
    @gensym m
    n = log2i(size(brt))
    step_l(i) = Symbol(step, :_, i, :_l)
    step_h(i) = Symbol(step, :_, i, :_h)
    idx(i) = Symbol(m, :_, i)

    N = b === nothing ? :(size($st, 1)) : :(size($st, 2))
    head = Expr(:block, :($(idx(1)) = 0:$(step_h(n)):$N-$(step_h(n))))

    # b2 in b1:step_1_h:b1+step_2_l-step_1_h
    for i in 2:n
        step_i_h = step_h(n-i+1)
        step_i_1_l = step_l(n-i+2)
        push!(head.args, :($(idx(i)) = $(idx(i-1)):$step_i_h:$(idx(i-1))+$step_i_1_l-$step_i_h))
    end

    # b3 in b2:b2+step_1_l-1
    if b === nothing && max > 0
        ret = Expr(:block)
        for p in 0:max
            ex = nexprs(1 << p) do k
                f(:($(idx(n)) + $(k - 1)), b)
            end

            push!(ret.args, quote
                if $(step_l(1)) == $(1 << p)
                    $(Expr(:for, head, ex))
                    return $st
                end
            end)
        end

        ex = nexprs(1 << max) do k
            f(:($(idx(n+1)) + $(k - 1)), b)
        end
        push!(ret.args, Expr(:for, head, :(
            for $(idx(n+1)) in $(idx(n)):$(1<<max):$(idx(n))+$(step_l(1))-1
                $ex
            end
        )))
        push!(ret.args, :(return $st))
        return ret
    else
        push!(head.args, :($(idx(n+1)) = $(idx(n)):$(idx(n))+$(step_l(1))-1))
        return Expr(:for, head, f(idx(n+1), b))
    end
end

function generic_ctrl_kernel(f_kernel, ctrl)
    @gensym raw_ctrl ctrl_mask flag_mask
    init = quote
        $raw_ctrl = $plain($ctrl)
        $ctrl_mask = bmask($raw_ctrl)
        $flag_mask = reduce(+, one(Int) << ($raw_ctrl[i] - 1) for i in 1:length($ctrl) if $ctrl.flags[i])
    end
    return init, function kernel(m, b)
        Expr(:if, :($ismatch($m, $ctrl_mask, $flag_mask)), f_kernel(m, b))
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
    @gensym l k mask alpha U11 U22
    init = quote
        $l = length($locs)
        $mask = $bmask(Int, $plain($locs))
    end

    if ishoisted(brt.expr[1, 1])
        push!(init.args, :($U11 = $(brt.expr[1, 1])) )
    else
        U11 = brt.expr[1, 1]
    end

    if ishoisted(brt.expr[2, 2])
        push!(init.args, :($U22 = $(brt.expr[2, 2])) )
    else
        U22 = brt.expr[2, 2]
    end

    # hoist common factor
    if U11 == U22 && !(U11 isa Number && isone(U11))
        push!(init.args, :($alpha = $U11^$l))
    end

    return init, function kernel(m, b)
        entry = b === nothing ? :($st[$m+1]) : :($st[$b, $m+1])
        if U11 == U22
            U11 isa Number && isone(U11) && return
            ex = :($entry = $alpha * $entry)
            b === nothing && return ex
            return Expr(:for, :($b in 1:size($st, 1)), ex)
        end

        ex = :($entry = $U11^($l-$k) * $U22^$k * $entry)
        ex = elim_double_const_pow(ex)
        ex = elim_const_pow(ex)
        ex = elim_identity(ex)
        ex = elim_exp_pi(ex)
        ex === nothing && return

        if b === nothing
            return quote
                $k = count_ones($m & $mask)
                $ex
            end
        else
            return quote
                $k = count_ones($m & $mask)
                for $b in 1:size($st, 1)
                    $ex
                end
            end
        end
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
    @gensym l mask alpha tmp i j k is_len_odd U12 U21 α β

    init = quote
        $l = length($locs)
        $mask = bmask(Int, $plain($locs))
    end

    if ishoisted(brt.expr[1, 2])
        push!(init.args, :($U12 = $(brt.expr[1, 2])))
    else
        U12 = brt.expr[1, 2]
    end

    if ishoisted(brt.expr[2, 1])
        push!(init.args, :($U21 = $(brt.expr[2, 1])))
    else
        U21 = brt.expr[2, 1]
    end

    # hoist common factor
    if U12 == U21 && !(U12 isa Number && isone(U12))
        push!(init.args, :($alpha = $U21^$l))
    elseif (U21 isa Number && U12 == -U21) || (U12 == :(-$U21)) || (U21 == :(-$U12))
        push!(init.args, :($is_len_odd = isodd($l)))
        if !(U12 isa Number && isone(U12))
            push!(init.args, :($alpha = $U12^$l))
        end
    end

    return init, function kernel(m, b)
        if b === nothing
            S1, S2 = :($st[$i]), :($st[$j])
        else
            S1, S2 = :($st[$b, $i]), :($st[$b, $j])
        end

        ex = if U12 == U21
            if U12 isa Number && isone(U12)
                alpha = 1
            end
            quote
                $tmp = $S1
                $S1 = $alpha * $S2
                $S2 = $alpha * $tmp
            end
        elseif (U21 isa Number && U12 == -U21) || (U12 == :(-$U21)) || (U21 == :(-$U12))
            if U12 isa Number && isone(U12)
                alpha = 1
            elseif U12 isa Number && isone(-U12)
                alpha = -1
            end

            s_pow(a, b) = quote
                $S1 = $a * $S2
                if $is_len_odd
                    $S2 = $b * $tmp
                else
                    $S2 = $a * $tmp
                end
            end

            quote
                $k = count_ones($m & $mask)
                $tmp = $S1
                if isodd($k)
                    $(s_pow(:(-$alpha), alpha))
                else
                    $(s_pow(alpha, :(-$alpha)))
                end
            end
        else
            quote
                $k = count_ones($m & $mask)
                $tmp = $S1
                $S1 = $U12^$k * $U21^($l-$k) * $S2
                $S2 = $U21^$k * $U12^($l-$k) * $tmp
            end
        end

        indices = quote
            $i = $m + 1
            $j = ($m ⊻ $mask) + 1
        end

        if b === nothing
            return quote
                $indices    
                $(elim_identity(ex))
            end
        else
            return quote
                $indices
                for $b in 1:size($st, 1)
                    $(elim_identity(ex))
                end
            end
        end
    end
end

space_length(st::AbstractVector) = size(st, 1)
space_length(st::AbstractMatrix) = size(st, 2)

function broutine2x2_loop_expanded(f_kernel, st, N::Int, b)
    @gensym m _m Mmax mmax
    expanded = nexprs(N) do k
        f_kernel(:($m + $k - 1), b)
    end

    return quote
        $Mmax = $space_length($st) - 1
        for $_m in 0:($Mmax >>> $(log2i(N)))
            $m = $_m << $(log2i(N))
            $mmax = $m + $(N-1)
            if $mmax ≤ $Mmax
                $expanded
            else
                for $_m in $m:$Mmax
                    $(f_kernel(_m, b))
                end
            end
        end
    end
end

function broutine2x2_loop(f_kernel, st, N::Int, b)
    @gensym m
    src = quote
        for $m in 0:($space_length($st) - 1)
            $(f_kernel(m, b))
        end
    end

    if b === nothing
        return src
    else
        return quote
            if $space_length($st) > 8
                $(broutine2x2_loop_expanded(f_kernel, st, N, b))
            else
                $src            
            end
        end
    end
end

function codegen_broutine2x2_dense(brt::BitRoutine)
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
