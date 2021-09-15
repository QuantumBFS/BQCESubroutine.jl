macro broutine(ex)
    esc(broutine_m(__module__, ex))
end

function basic_broutine! end
function multi_broutine2x2! end
function threaded_basic_broutine! end
function threaded_multi_broutine2x2! end

struct BitRoutine
    name::Symbol
    sz::Int
    isperm::Bool
    isdiag::Bool
    args::Vector{Any}
    expr::Hoistable
    typevars::Vector{Any}
end

function BitRoutine(m::Module, ex::Expr)
    def = splitdef(ex; throw=false)
    if def === nothing
        ex.head === :(=) || error("invalid syntax, expect function or matrix, got: $ex")
        name, mat = ex.args
        name isa Symbol || error("invalid syntax, matrix name must be a Symbol, got: $name")
        mat.head === :vcat || error("invalid syntax, expect matrix, got: $mat")
        M = match_matrix_expr(m, mat)
        sz = LinearAlgebra.checksquare(M)
        return BitRoutine(name, sz, isperm(M), isdiag(M), [], Hoistable(M), [])
    else
        haskey(def, :name) || error("routine definition cannot be annoymous")
        haskey(def, :args) || error("do not declare constant gate as function")
        haskey(def, :body) || error("empty routine definition")
        def[:name] isa Symbol || error("routine name must be Symbol")

        body = def[:body]::Expr
        if body.head === :block
            body = last(body.args)
        end
        M = match_matrix_expr(m, body)
        sz = LinearAlgebra.checksquare(M)
        return BitRoutine(def[:name], sz, isperm(M), isdiag(M), def[:args],
            Hoistable(M), get(def, :whereparams, []))
    end
end

function match_matrix_expr(m::Module, ex::Expr)
    ex.head === :vcat || error("not a matrix expression")
    size = length(ex.args)
    expr = Matrix{Any}(undef, size, size)
    for (i, row) in enumerate(ex.args)
        row.head === :row || error("not a matrix expression")
        for (j, each) in enumerate(row.args)
            expr[i, j] = eval_interp(m, each)
        end
    end
    return expr
end

function should_hoist(ex)
    @match ex begin
        ::Symbol ||
        :(-$(::Symbol)) ||
        ::Number => false
        _ => true
    end
end

function should_hoist_pow(ex)
    @match ex begin
        ::Symbol ||
        :(-$(::Symbol)) ||
        :(exp(im * π / $k)) ||
        :(exp(π * im / $k)) ||
        ::Number => false
        _ => true
    end
end

function hoist_entries!(brt::BitRoutine)
    for i in 1:size(brt), j in 1:size(brt)
        if should_hoist_pow(brt.expr.origin[(i, j)])
            hoist!(brt.expr, i, j)
        end
    end
end

Base.size(brt::BitRoutine) = brt.sz

function Base.show(io::IO, brt::BitRoutine)
    print(io, brt.name)
    if isempty(brt.args)
        print(io, " = ")
    else
        print(io, "(", join(brt.args, ", "), ") ")
        if !isempty(brt.typevars)
            print(io, "where {", join(brt.typevars, ", "), "} ")
        end
        print(io, "= ")
    end

    print(io, "[")
    for i in 1:size(brt)
        for j in 1:size(brt)
            print(io, brt.expr[i, j])
            if j != size(brt)
                print(io, " ")
            elseif i != size(brt)
                print(io, ";")
            end
        end

        if i != size(brt)
            print(io, " ")
        end
    end
    print(io, "]")
end

Base.@kwdef mutable struct BitContext
    hoisted_vars::VarDefs = VarDefs()
    kernel_vars::VarDefs = VarDefs()

    st::Symbol = gensym(:st)
    locs::Symbol = gensym(:locs)
    ctrl::Union{Nothing, Symbol} = nothing

    # options
    batch::Bool = false
    threading::Bool = false
    # compile params
    # expand the loop with stride 1 << expand_sz
    expand_sz::Int = 3
end

step_l(i::Int) = Symbol(:step, :_, i, :_l)
step_h(i::Int) = Symbol(:step, :_, i, :_h)
step_l(ctx::BitContext, i::Int) = getproperty(ctx.hoisted_vars, step_l(i))
step_h(ctx::BitContext, i::Int) = getproperty(ctx.hoisted_vars, step_h(i))
space_length(ctx::BitContext) = ctx.batch ? :(size($(ctx.st), 2)) : :(size($(ctx.st), 1))
refst(ctx::BitContext, i, b = nothing) = b === nothing ? :($(ctx.st)[$i]) : :($(ctx.st)[$b, $i])

function def_strides!(ctx::BitContext, brt::BitRoutine)
    @def ctx.hoisted_vars plain_locs = $plain($(ctx.locs))
    for i in 1:log2i(size(brt))
        def!(ctx.hoisted_vars, step_l(i), :(1 << ($plain_locs[$i] - 1)) )
        def!(ctx.hoisted_vars, step_h(i), :(1 << $plain_locs[$i]) )
    end
    return ctx
end

function codegen_method(f_body, ctx::BitContext, brt::BitRoutine, name::Symbol)
    T = ctx.batch ? AbstractMatrix : AbstractVector
    args = Any[:($(ctx.st)::$T), :(::Val{$(QuoteNode(brt.name))}), :($(ctx.locs)::$Locations)]
    ctx.ctrl === nothing || push!(args, :($(ctx.ctrl)::$CtrlLocations))
    ctx.threading && (name = Symbol(:threaded_, name))
    append!(args, brt.args)
    def = Dict{Symbol, Any}(
        :name => GlobalRef(BQCESubroutine, name),
        :args => args,
        :body => quote
            $(f_body())
            return $(ctx.st)
        end,
    )
    isempty(brt.typevars) || (def[:whereparams] = [brt.typevars...])
    return combinedef(def)
end

function broutine_m(m::Module, ex::Expr)
    brt = BitRoutine(m, ex)
    hoist_entries!(brt)
    # NOTE: we need to leave name space
    # for other type of qubits, e.g qutrits
    const_name = Symbol(:B, brt.name)
    body = Expr(:vcat)
    for i in 1:size(brt)
        row = Expr(:row)
        for j in 1:size(brt)
            push!(row.args, brt.expr.origin[(i, j)])
        end
        push!(body.args, row)
    end

    binding = if isempty(brt.args)
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

    ret = Expr(:block)
    for batch in [false, true], ctrl in [nothing, gensym(:ctrl)], threading in [false, true]
        expand_sz = threading ? 0 : 3
        push!(ret.args, codegen_broutine(
            BitContext(;ctrl, batch, threading, expand_sz), brt)
        )
        push!(ret.args, codegen_basic_broutine(
            BitContext(;ctrl, batch, threading, expand_sz), brt)
        )
        # generate multi-gate routine for 2x2
        if size(brt) == 2
            push!(ret.args, codegen_broutine2x2_multi(
                BitContext(;ctrl, batch, threading, expand_sz), brt)
            )
        end
    end
    push!(ret.args, binding)
    return ret
end

function forward_routine(to::Symbol, ctx::BitContext, brt::BitRoutine)
    call = Expr(:call, GlobalRef(BQCESubroutine, to),
            ctx.st, Val(brt.name), ctx.locs)
    ctx.ctrl isa Symbol && push!(call.args, ctx.ctrl)
    append!(call.args, brt.args)
    return call
end

function codegen_broutine(ctx::BitContext, brt::BitRoutine)
    ctx.threading && return # do not generate threading version
    return codegen_method(ctx, brt, :broutine!) do
        basic_ret = Expr(:block)
        assertion = :(@assert length($(ctx.locs)) == $(log2i(size(brt))) "number of locations mismatch operator size")
        if size(brt) == 2
            multi = forward_routine(:multi_broutine2x2!, ctx, brt)
            push!(basic_ret.args, :(length($(ctx.locs)) == 1 || return $multi) )
        else
            push!(basic_ret.args, assertion)
        end
        push!(basic_ret.args, forward_routine(:basic_broutine!, ctx, brt))
        push!(basic_ret.args, :(return $(ctx.st)))

        threaded_ret = Expr(:block)
        if size(brt) == 2
            multi = forward_routine(:threaded_multi_broutine2x2!, ctx, brt)
            push!(threaded_ret.args, :(length($(ctx.locs)) == 1 || return $multi) )
        else
            push!(threaded_ret.args, assertion)
        end
        push!(threaded_ret.args, forward_routine(:threaded_basic_broutine!, ctx, brt))
        push!(threaded_ret.args, :(return $(ctx.st)))
        return quote
            if $BQCESubroutine.ENABLE_THREADS[] && Threads.nthreads() > 1
                $threaded_ret
            end
            $basic_ret
        end
    end
end

function codegen_basic_broutine(ctx::BitContext, brt::BitRoutine)
    return codegen_method(ctx, brt, :basic_broutine!) do
        return quote
            $(sort_locations(ctx, log2i(size(brt))))
            $(broutine_loop(ctx, brt))
        end
    end
end

function codegen_broutine2x2_multi(ctx::BitContext, brt::BitRoutine)
    # NOTE:
    # no benefit if it's parameterized
    # it will make our loop kernel too complicated
    if !isempty(brt.args) || (!brt.isdiag && !brt.isperm)
        @gensym loc
        name = ctx.threading ? :threaded_broutine! : :broutine!
        fn = GlobalRef(BQCESubroutine, name)
        return codegen_method(ctx, brt, :multi_broutine2x2!) do
            quote
                for $loc in $(ctx.locs)
                    $fn($(ctx.st), $(Val(brt.name)), $loc, $(brt.args...))
                end
                return $(ctx.st)
            end
        end
    end

    return codegen_method(ctx, brt, :multi_broutine2x2!) do
        broutine_loop(ctx, brt, true)
    end
end

function broutine_loop(ctx::BitContext, brt::BitRoutine, multi::Bool=false)
    lexpr = if brt.isdiag && multi
        diagonal_loop(diag_kernel(ctx, brt), ctx)
    elseif brt.isperm && multi
        subspace_loop(perm_kernel(ctx, brt), ctx, brt)
    else
        subspace_loop(generic_kernel(ctx, brt), ctx, brt)
    end
    return quote
        $(hoisted_var_exprs(ctx))
        $(hoisted_expr(brt.expr))
        $(fastmath_inbounds(lexpr))
    end |> fast_eval
end

function batch_loop(f_kernel, ctx::BitContext)
    ctx.batch || return f_kernel(nothing)
    return expand_loop(f_kernel, 1, :(size($(ctx.st), 1)), ctx.expand_sz)
end

kernel_expr(f_kernel, ctx::BitContext) = m->kernel_expr(f_kernel, ctx, m)

function kernel_expr(f_kernel, ctx::BitContext, m)
    ex = f_kernel(m)
    return quote
        $(kernel_var_exprs(ctx))
        $(ex)
    end
end

function diagonal_loop(f_kernel, ctx::BitContext)
    kernel = kernel_expr(f_kernel, ctx)

    @gensym m
    expanded = expand_loop(kernel, 0, :($(space_length(ctx)) - 1), ctx.expand_sz, ctx.threading)
    if ctx.threading
        src = :(
            Threads.@threads for $m = 0:($(space_length(ctx)) - 1)
                $(kernel(m))
            end
        )
    else
        src = Expr(:for, :($m = 0:($(space_length(ctx)) - 1)), kernel(m))
    end

    ctx.batch && return src
    sz = space_length(ctx)
    ctx.threading && return quote
        if $sz > Threads.nthreads() * ($(1 << ctx.expand_sz))
            $expanded
        else
            $src
        end
    end

    return quote
        if $sz > $(1 << ctx.expand_sz)
            $expanded
        else
            $src
        end
    end
end

# NOTE: given nthreads find optimal threading region
#    1. insert an extra location at p so that 2^(n-p-1) ≤ nthreads ≤ 2^(n-p)
# there are 3 cases in the 2 qubit case xxx0yyy0zzz
#    1. xxx ≥ nthreads
#    2. xxx < nthreads && xxxyyy ≥ nthreads
#    3. xxxyyy < nthreads && xxxyyyzzz ≥ nthreads
# the general case is similar, basically we want to find the place to insert
# a slice to the entire hilbert space to parallel it with multithreading
# the reason why we don't need to do polyhydra analysis here is that we
# know our full space is a bit-string based hilbert space in advance, so
# the optimal separation is trivial to find.
# we also don't do runtime slicing since we will assume the compiled kernels
# are always specified on small matrices.
function subspace_loop(f_kernel, ctx::BitContext, brt::BitRoutine)
    ctx.threading && return threaded_subspace_loop(f_kernel, ctx, brt)
    kernel = kernel_expr(f_kernel, ctx)
    @gensym m
    n = log2i(size(brt))
    idx(i) = Symbol(m, :_, i)
    lheads = subspace_loop_head(idx, ctx, brt)
    lhead = Expr(:block, lheads...)

    # b3 in b2:b2+step_1_l-1
    # expand inner subspace loop if it has no batch dim
    if !ctx.batch && ctx.expand_sz > 0
        return subspace_step_expanded(identity, kernel, lheads, idx, ctx, brt)
    else
        push!(lhead.args, :($(idx(n+1)) = $(idx(n)):$(idx(n))+$(step_l(ctx, 1))-1))
        return Expr(:for, lhead, kernel(idx(n+1)))
    end
end

"""
Return a `Vector` of the range `Expr`s of nested for-loop indices `idx(1)`, `idx(2)`, ..., `idx(n)`,
where `n` is the number of qubits the gate operates on.
Note that the innermost for-loop (`idx(n+1)`) is not included.
"""
function subspace_loop_head(idx, ctx::BitContext, brt::BitRoutine)
    def_strides!(ctx, brt)
    n = log2i(size(brt))
    lheads = []
    push!(lheads, :($(idx(1)) = 0:$(step_h(ctx, n)):$(space_length(ctx))-$(step_h(ctx, n))))

    #=    b2 in b1:step_1_h:b1+step_2_l-step_1_h
           ___________ step_h(n)
          | __________ step_l(n)   == step_i_1_l
          ||  ________ step_h(n-1) == step_i_h
    loc:  |x |x x
         0000000000
         0100000000
         1000000000
         1100000000
    =#
    for i in 2:n
        step_i_h = step_h(ctx, n-i+1)
        step_i_1_l = step_l(ctx, n-i+2)
        push!(lheads, :($(idx(i)) = $(idx(i-1)):$step_i_h:$(idx(i-1))+$step_i_1_l-$step_i_h))
    end
    return lheads
end

"""
Return a block `Expr` containing one big nested for-loop whose innermost loop (inside `inner`) is unrolled.
The innermost loop is fully unrolled if it contains no more than `1 << ctx.expand_sz` iterations.
"""
function subspace_step_expanded(outer, kernel, inner::Vector, idx, ctx::BitContext, brt::BitRoutine)
    n = log2i(size(brt))
    ret = Expr(:block)

    loop_expr(x) = if isempty(inner)
        outer(x)
    else
        outer(Expr(:for, Expr(:block, inner...), x))
    end

    for p in 0:ctx.expand_sz
        ex = nexprs(1 << p) do k
            kernel(:($(idx(n)) + $(k - 1)))
        end

        push!(ret.args, quote
            if $(step_l(ctx, 1)) == $(1 << p)
                $(loop_expr(ex))
                return $(ctx.st)
            end
        end)
    end

    ex = nexprs(1 << ctx.expand_sz) do k
        kernel(:($(idx(n+1)) + $(k - 1)))
    end

    lbody = :(for $(idx(n+1)) in $(idx(n)):$(1<<ctx.expand_sz):$(idx(n))+$(step_l(ctx, 1))-1
        $ex
    end)

    push!(ret.args, loop_expr(lbody))
    return ret
end

function threaded_subspace_loop(f_kernel, ctx::BitContext, brt::BitRoutine)
    @def ctx.hoisted_vars plain_locs = $plain($(ctx.locs))
    @def ctx.hoisted_vars nqubits = $log2i($(space_length(ctx)))
    @def ctx.hoisted_vars nlocs_needed = $log2i(Threads.nthreads()-1) + 1
    # nthreads      1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 ...
    # nlocs_needed  0  1  2  2  3  3  3  3  4  4  4  4  4  4  4  4  5 ...

    @gensym idx base m

    kernel = kernel_expr(f_kernel, ctx)
    index(i) = Symbol(idx, :_, i)
    index_base(i) = :($base + $(index(i)))

    n = log2i(size(brt))
    lheads = subspace_loop_head(index, ctx, brt)

    ret = Expr(:block)
    tbody = subspace_step_expanded(kernel, lheads[2:end], index, ctx, brt) do x
        # Expr(:for, lheads[1], x)
        :(@batch $(Expr(:for, lheads[1], x)))
    end
    
    # If the outermost loop is sufficient to show best performance of multithreading
    # (i.e., xxx ≥ nthreads in "xxx0yyy0zzz")
    push!(ret.args, :(
        if $nlocs_needed ≤ $nqubits - $plain_locs[$n]
            $tbody
            return $(ctx.st)
        end
    ))

    if n == 1
        push!(ret.args, threaded_subspace_loop_2x2_nontrivial(f_kernel, ctx, brt))
        return ret
    end

    for t in 1:n-1
        tbody = subspace_step_expanded(idx->kernel(:($base + $idx)), lheads[t+1:end], index, ctx, brt) do x
            subspace_locs = Expr(:tuple, :(1:$m...), [:(plain_locs[$(n-k+1)]) for k in 1:t]...)
            subspace_head = :($base = $bsubspace($nqubits, $subspace_locs))
            # Expr(:for, subspace_head, x)
            :(@batch $(Expr(:for, subspace_head, x)))
        end

        push!(ret.args, :(
            if $nlocs_needed ≤ $nqubits - $plain_locs[$(n-t)] - $t
                $m = $nqubits - $nlocs_needed - $t
                $tbody
                return $(ctx.st)
            end
        ))
    end

    push!(ret.args, quote
        $m = $nqubits - $nlocs_needed - $n
        Threads.@threads for $base in $bsubspace($nqubits, (1:$m..., $plain_locs...))
            for $(index(1)) in 0:(1 << $m)-1
                $(kernel( index_base(1) ))
            end
        end
    end)
    push!(ret.args, :(return $(ctx.st)))
    return ret
end

"""
The gate operates on 1 qubit,
and with outermost loop only it is *insufficient* to show best performance of multithreading.
"""
function threaded_subspace_loop_2x2_nontrivial(f_kernel, ctx::BitContext, brt::BitRoutine)
    # @def ctx.hoisted_vars n_highlocs = Base.min($nlocs_needed, $nqubits - 1)
    # @def ctx.hoisted_vars n_lowlocs = $nqubits - $n_highlocs
    # @def ctx.hoisted_vars mask_highbits = -1 << $plain_locs[1]
    # @def ctx.hoisted_vars mask_lowbits = (1 << $plain_locs[1]) - 1

    @gensym n_highlocs n_lowlocs mask_highbits mask_lowbits
    @gensym k_continuous k_highbits k_lowbits
    @gensym k m_max m
    kernel = kernel_expr(f_kernel, ctx)

    return quote
        $n_highlocs = Base.min(ctx.hoisted_vars[:nlocs_needed], ctx.hoisted_vars[:nqubits] - 1)
        $n_lowlocs = ctx.hoisted_vars[:nqubits] - $n_highlocs
        $mask_highbits = -1 << ctx.hoisted_vars[:plain_locs][1]
        $mask_lowbits = (1 << ctx.hoisted_vars[:plain_locs][1]) - 1
        @batch for $k_continuous in 0 : 1<<$n_lowlocs : ((1<<n_highlocs)-1) << $n_lowlocs
            $k_highbits = $k_continuous & $mask_highbits
            $k_lowbits = ($k_continuous & $mask_lowbits) >>> 1
            $k = $k_highbits | $k_lowbits
            $m_max  = (1 << ($n_lowlocs-1)) - 1
            for $m in $k : $k | $m_max
                $(kernel(m))
            end
        end
    end
end

"""
Loop unrolling with a fully static block (exactly `1 << max` iterations)
and a dynamic block (less than `1 << max` iterations near the end)
"""
function expand_loop(f_kernel, lb, ub, max::Int=3, threading=false)
    @gensym idx1 idx2 idx3 Mmax mmax upperbound
    N = 1 << max
    expanded = nexprs(1 << max) do k
        f_kernel(:($idx1 + $(k - 1)))
    end

    lbody = :(for $idx2 in 0:($Mmax >>> $max)
        $idx1 = ($idx2 << $max) + $lb
        $mmax = $idx1 + $(N-1) - $lb
        if $mmax ≤ $Mmax
            $expanded
        else
            for $idx3 in $idx1:$upperbound
                $(f_kernel(idx3))
            end
        end
    end)

    threading && return quote
        $upperbound = $ub
        $Mmax = $ub - $lb
        Threads.@threads $lbody
    end

    return quote
        $upperbound = $ub
        $Mmax = $ub - $lb
        $lbody
    end
end

function ctrl_expr(f_kernel, ctx::BitContext, m)
    if ctx.ctrl isa Symbol
        def!(ctx.hoisted_vars, :ctrl_mask, :($bmask($plain($(ctx.ctrl)))) )
        def!(ctx.hoisted_vars, :flag_mask, :($ctrl_flag_mask($(ctx.ctrl))) )
    end

    ret = f_kernel()

    if ctx.ctrl isa Symbol
        ctrl_mask = ctx.hoisted_vars.ctrl_mask
        flag_mask = ctx.hoisted_vars.flag_mask
        ret = Expr(:if, :($ismatch($m, $ctrl_mask, $flag_mask)), ret)
    end
    return ret
end

function sort_locations(ctx::BitContext, sz::Int)
    sz == 1 && return

    if sz == 2
        @gensym plain_locs
        return quote
            $plain_locs = $plain($(ctx.locs))
            if $plain_locs[1] > $plain_locs[2]
                $(ctx.locs) = Locations(($plain_locs[2], $plain_locs[1]))
            end
        end
    end

    return :($(ctx.locs) = sort($(ctx.locs)))
end

const FASTMATH = Ref(true)
const INBOUNDS = Ref(true)

hoisted_var_exprs(ctx::BitContext) = var_exprs(ctx.hoisted_vars)
kernel_var_exprs(ctx::BitContext) = var_exprs(ctx.kernel_vars)

function fastmath_inbounds(ex::Expr)
    ex = INBOUNDS[] ? :(@inbounds $ex) : ex
    ex = FASTMATH[] ? :(@fastmath $ex) : ex
    return ex
end

function ctrl_flag_mask(ctrl::CtrlLocations)
    ret = 0
    for i in 1:length(ctrl)
        if ctrl.flags[i]
            ret += 1 << (plain(ctrl)[i] - 1)
        end
    end
    return ret
end

# Kernel
function generic_kernel(ctx::BitContext, brt::BitRoutine)
    return function kernel(m)
        @gensym I T
        index(i) = Symbol(I, :_, i)

        return ctrl_expr(ctx, m) do
            batch_loop(ctx) do b
                ret = Expr(:block)
                indices = []
                for flag in 0:size(brt)-1
                    idx = m
                    for i in 1:log2i(size(brt))
                        if ((flag >>> (i-1)) & 1) == 1
                            idx = :($idx + $(step_l(ctx, i)))
                        end
                    end
                    push!(indices, idx)
                end

                values = [refst(ctx, index(idx), b) for idx in 1:size(brt)]
                entries, assigns = [], []
                # NOTE:
                # we always want to hoist too complicated exprs
                # for generic kernels
                for i in 1:size(brt)
                    t = Symbol(T, :_, i)
                    should_hoist(brt.expr[i, 1]) && hoist!(brt.expr, i, 1)
                    e = sym_mul(brt.expr[i, 1], values[1])

                    for j in 2:size(brt)
                        should_hoist(brt.expr[i, j]) && hoist!(brt.expr, i, j)
                        e = sym_plus(e, sym_mul(brt.expr[i, j], values[j]))
                    end

                    e == values[i] && continue

                    push!(ret.args, :($(index(i)) = $(indices[i]) + 1))
                    push!(entries, Expr(:(=), t, e))
                    push!(assigns, Expr(:(=), values[i], t))
                end

                append!(ret.args, entries)
                append!(ret.args, assigns)
                return ret
            end
        end
    end
end

function diag_kernel(ctx::BitContext, brt::BitRoutine)
    return function kernel(m)
        return ctrl_expr(ctx, m) do
            batch_loop(ctx) do b
                entry = refst(ctx, :($m+1), b)
                U11 = brt.expr[1, 1]
                U22 = brt.expr[2, 2]
                return @match (U11, U22) begin
                    (1, 1) => nothing
                    (1, -1) => begin
                        @def ctx.hoisted_vars plain_locs = $plain($(ctx.locs))
                        @def ctx.hoisted_vars mask = $bmask($plain_locs)
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        @defnew ctx.kernel_vars isodd_k = isodd($k)
                        :($isodd_k && ($entry = -$entry))
                    end
                    (1, A) => begin
                        @def ctx.hoisted_vars plain_locs = $plain($(ctx.locs))
                        @def ctx.hoisted_vars mask = $bmask($plain_locs)
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        @defnew ctx.kernel_vars alpha = $A^$k
                        :($entry = $alpha * $entry)
                    end
                    (A, &A) => begin
                        @def ctx.hoisted_vars nlocs = length($(ctx.locs))
                        @def ctx.hoisted_vars alpha = $A^$nlocs
                        :($entry = $alpha * $entry)
                    end
                    (A, B) => begin
                        @def ctx.hoisted_vars plain_locs = $plain($(ctx.locs))
                        @def ctx.hoisted_vars mask = $bmask($plain_locs)
                        @def ctx.hoisted_vars nlocs = length($(ctx.locs))
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        :($entry = $A^($nlocs-$k) * $B^$k * $entry)
                    end
                end # @match
            end # batch_loop
        end # ctrl_expr
    end
end

function perm_kernel(ctx::BitContext, brt::BitRoutine)
    U12, U21 = brt.expr[1, 2], brt.expr[2, 1]

    function kernel(m)
        ctrl_expr(ctx, m) do
            batch_loop(ctx) do b
                @def ctx.hoisted_vars plain_locs = $plain($(ctx.locs))
                @def ctx.hoisted_vars mask = $bmask($plain_locs)
                @defnew ctx.kernel_vars i = $m + 1
                @defnew ctx.kernel_vars j = ($m ⊻ $mask) + 1
                @gensym tmp
                S1, S2 = refst(ctx, i, b), refst(ctx, j, b)

                ex = @match (U12, U21) begin
                    (1, 1) => quote
                        $S1 = $S2
                        $S2 = $tmp
                    end
                    (A, :(-$(&A))) || (A::Number, &(-A)) => begin
                        @def ctx.hoisted_vars nlocs = length($(ctx.locs))
                        @def ctx.hoisted_vars alpha = $A^$nlocs
                        @def ctx.hoisted_vars isodd_nlocs = isodd($nlocs)
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        # step 1:
                        # $S1 = (-1)^($nlocs-$k) * $alpha * $S2
                        # $S2 = (-1)^$k * $alpha * $tmp
                        quote
                            if isodd($k)
                                $S1 = $isodd_nlocs ? $alpha * $S2 : -$alpha * $S2
                                $S2 = -$alpha * $tmp
                            else
                                $S1 = $isodd_nlocs ? -$alpha * $S2 : $alpha * $S2
                                $S2 = $alpha * $tmp
                            end
                       end
                    end
                    (:(-$A), &A) => begin
                        @def ctx.hoisted_vars nlocs = length($(ctx.locs))
                        @def ctx.hoisted_vars alpha = $A^$nlocs
                        @def ctx.hoisted_vars isodd_nlocs = isodd($nlocs)
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        # step 1:
                        # $S1 = (-1)^$k * $A^$nlocs * $S2
                        # $S2 = (-1)^($nlocs-$k) * $A^$nlocs * $tmp
                        quote
                            if isodd($k)
                                $S1 = -$alpha * $S2
                                $S2 = $isodd_nlocs ? $alpha * $tmp : -$alpha * $tmp
                            else
                                $S1 = $alpha * $S2
                                $S2 = $isodd_nlocs ? -$alpha * $tmp : $alpha * $tmp
                            end
                        end
                    end
                    _ => begin
                        @def ctx.hoisted_vars nlocs = length($(ctx.locs))
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        quote
                            $S1 = $U12^$k * $U21^($nlocs-$k) * $S2
                            $S2 = $U21^$k * $U12^($nlocs-$k) * $tmp
                        end
                    end
                end # @match

                return quote
                    $tmp = $S1
                    $ex
                end
            end # batch_loop
        end # ctrl_expr
    end # kernel
end

function fast_eval(ex)
    @match ex begin
        :(1^$p) => 1
        :((-1)^$p) => :(isodd($p) ? -1 : 1)
        :(im^$p) => :($literal_pow($(Val(:im)), $p))
        :((-im)^$p) => :($literal_pow($(Val(:im)), 3 * $p))
        :(exp(im * π / $k)^$p) => 
            :($literal_pow($(Val(:exp)), $(Val(k)), $p))
        ::Expr => Expr(ex.head, map(fast_eval, ex.args)...)
        _ => ex
    end
end
