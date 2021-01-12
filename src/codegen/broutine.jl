macro broutine(ex)
    esc(broutine_m(__module__, ex))
end

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

mutable struct BitContext
    hoisted_vars::VarDefs
    kernel_vars::VarDefs

    st::Symbol
    locs::Symbol
    ctrl

    # options
    batch::Bool
    # compile params
    # expand the loop with stride 1 << expand_sz
    expand_sz::Int
end

BitContext(;ctrl=nothing, batch=false) =
    BitContext(VarDefs(), VarDefs(), gensym(:st), gensym(:locs), ctrl, batch, 3)

step_l(i::Int) = Symbol(:step, :_, i, :_l)
step_h(i::Int) = Symbol(:step, :_, i, :_h)
step_l(ctx::BitContext, i::Int) = getproperty(ctx.hoisted_vars, step_l(i))
step_h(ctx::BitContext, i::Int) = getproperty(ctx.hoisted_vars, step_h(i))
space_length(ctx::BitContext) = ctx.batch ? :(size($(ctx.st), 2)) : :(size($(ctx.st), 1))
refst(ctx::BitContext, i, b = nothing) = b === nothing ? :($(ctx.st)[$i]) : :($(ctx.st)[$b, $i])

function def_strides!(ctx::BitContext, brt::BitRoutine)
    for i in 1:log2i(size(brt))
        def!(ctx.hoisted_vars, step_l(i), :(1 << ($plain($(ctx.locs))[$i] - 1)) )
        def!(ctx.hoisted_vars, step_h(i), :(1 << $plain($(ctx.locs))[$i]) )
    end
    return ctx
end

function codegen_method(f_body, ctx::BitContext, brt::BitRoutine, name::Symbol)
    T = ctx.batch ? AbstractMatrix : AbstractVector
    args = Any[:($(ctx.st)::$T), :(::Val{$(QuoteNode(brt.name))}), :($(ctx.locs)::$Locations)]
    ctx.ctrl === nothing || push!(args, :($(ctx.ctrl)::$CtrlLocations))
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
    for batch in [false, true], ctrl in [nothing, gensym(:ctrl)]
        push!(ret.args, codegen_broutine(BitContext(;ctrl, batch), brt))
        # generate multi-gate routine for 2x2
        if size(brt) == 2
            ctx = BitContext(;ctrl, batch)
            push!(ret.args, codegen_broutine2x2_multi(ctx, brt))
        end
    end
    push!(ret.args, binding)
    return ret
end

function codegen_broutine(ctx::BitContext, brt::BitRoutine)
    return codegen_method(ctx, brt, :broutine!) do
        body = Expr(:block)
        push!(body.args, sort_locations(ctx, log2i(size(brt))))
        # NOTE: multi-gate only supports non-ctrl routine
        if ctx.ctrl === nothing
            multi = Expr(:call, GlobalRef(BQCESubroutine, :multi_broutine2x2!),
                ctx.st, Val(brt.name), ctx.locs)
            append!(multi.args, brt.args)
            size(brt) == 2 && push!(body.args, :(length($(ctx.locs)) == 1 || return $multi))
        end
        push!(body.args, :(@assert length($(ctx.locs)) == $(log2i(size(brt))) "number of locations mismatch operator size"))
        push!(body.args, loop(ctx, brt))
        return body
    end
end

function codegen_broutine2x2_multi(ctx::BitContext, brt::BitRoutine)
    # NOTE:
    # no benefit if it's parameterized
    # it will make our loop kernel too complicated
    if !isempty(brt.args) || (!brt.isdiag && !brt.isperm)
        @gensym loc
        return codegen_method(ctx, brt, :multi_broutine2x2!) do
            quote
                for $loc in $(ctx.locs)
                    $(GlobalRef(BQCESubroutine, :broutine!))($(ctx.st), $(Val(brt.name)), $loc, $(brt.args...))
                end
                return $(ctx.st)
            end
        end
    end

    def_nlocs!(ctx)
    def_bmask!(ctx)
    return codegen_method(ctx, brt, :multi_broutine2x2!) do
        loop(ctx, brt, true)
    end
end

function loop(ctx::BitContext, brt::BitRoutine, multi::Bool=false)
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
    src = Expr(:for, :($m = 0:($(space_length(ctx)) - 1)), kernel(m))

    if ctx.batch
        return src
    else # expand inner loop for non-batch operations
        return quote
            if $(space_length(ctx)) > $(1 << ctx.expand_sz)
                $(expand_loop(kernel, 0, :($(space_length(ctx)) - 1), ctx.expand_sz))
            else
                $src
            end
        end
    end

    return src
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
function subspace_loop(f_kernel, ctx::BitContext, brt::BitRoutine, max = 3)
    kernel = kernel_expr(f_kernel, ctx)
    @gensym m
    n = log2i(size(brt))
    idx(i) = Symbol(m, :_, i)

    def_strides!(ctx, brt)
    lhead = Expr(:block, :($(idx(1)) = 0:$(step_h(ctx, n)):$(space_length(ctx))-$(step_h(ctx, n))))

    # b2 in b1:step_1_h:b1+step_2_l-step_1_h
    for i in 2:n
        step_i_h = step_h(ctx, n-i+1)
        step_i_1_l = step_l(ctx, n-i+2)
        push!(lhead.args, :($(idx(i)) = $(idx(i-1)):$step_i_h:$(idx(i-1))+$step_i_1_l-$step_i_h))
    end

    # b3 in b2:b2+step_1_l-1
    # expand inner subspace loop if it has no batch dim
    if !ctx.batch && ctx.expand_sz > 0
        ret = Expr(:block)
        for p in 0:ctx.expand_sz
            ex = nexprs(1 << p) do k
                kernel(:($(idx(n)) + $(k - 1)))
            end

            push!(ret.args, quote
                if $(step_l(ctx, 1)) == $(1 << p)
                    $(Expr(:for, lhead, ex))
                    return $(ctx.st)
                end
            end)
        end

        ex = nexprs(1 << ctx.expand_sz) do k
            kernel(:($(idx(n+1)) + $(k - 1)))
        end

        push!(ret.args, Expr(:for, lhead, :(
            for $(idx(n+1)) in $(idx(n)):$(1<<max):$(idx(n))+$(step_l(ctx, 1))-1
                $ex
            end
        )))
        return ret
    else
        push!(lhead.args, :($(idx(n+1)) = $(idx(n)):$(idx(n))+$(step_l(ctx, 1))-1))
        return Expr(:for, lhead, kernel(idx(n+1)))
    end
end

function expand_loop(f_kernel, lb, ub, max::Int=3)
    @gensym idx1 idx2 idx3 Mmax mmax upperbound
    N = 1 << max
    expanded = nexprs(1 << max) do k
        f_kernel(:($idx1 + $(k - 1)))
    end

    return quote
        $upperbound = $ub
        $Mmax = $ub - $lb
        for $idx2 in 0:($Mmax >>> $max)
            $idx1 = ($idx2 << $max) + $lb
            $mmax = $idx1 + $(N-1) - $lb
            if $mmax ≤ $Mmax
                $expanded
            else
                for $idx3 in $idx1:$upperbound
                    $(f_kernel(idx3))
                end
            end
        end
    end
end

function ctrl_expr(f_kernel, ctx::BitContext, m)
    if ctx.ctrl isa Symbol
        @gensym raw_ctrl ctrl_mask flag_mask
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
    @gensym raw_locs
    sz == 2 && return quote
        $raw_locs = $plain($(ctx.locs))
        $(ctx.locs) = if $raw_locs[1] < $raw_locs[2]
            $(ctx.locs)
        else
            Locations(($raw_locs[2], $raw_locs[1]))
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

def_nlocs!(ctx::BitContext) = def!(ctx.hoisted_vars, :nlocs, :(length($(ctx.locs))) )
def_bmask!(ctx::BitContext) = def!(ctx.hoisted_vars, :mask, :($bmask($plain($(ctx.locs)))) )

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
    nlocs = ctx.hoisted_vars.nlocs
    mask = ctx.hoisted_vars.mask

    return function kernel(m)
        return ctrl_expr(ctx, m) do
            batch_loop(ctx) do b
                entry = refst(ctx, :($m+1), b)
                U11 = brt.expr[1, 1]
                U22 = brt.expr[2, 2]
                return @match (U11, U22) begin
                    (1, 1) => nothing
                    (1, -1) => begin
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        @defnew ctx.kernel_vars isodd_k = isodd($k)
                        :($entry = $isodd_k ? -$entry : $entry)
                    end
                    (1, A) => begin
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        @defnew ctx.kernel_vars alpha = $A^$k
                        :($entry = $alpha * $entry)
                    end
                    (A, &A) => begin
                        @def ctx.hoisted_vars alpha = $A^$nlocs
                        :($entry = $alpha * $entry)
                    end
                    (A, B) => begin
                        @defnew ctx.kernel_vars k = count_ones($m & $mask)
                        :($entry = $A^($nlocs-$k) * $B^$k * $entry)
                    end
                end # @match
            end # batch_loop
        end # ctrl_expr
    end
end

function perm_kernel(ctx::BitContext, brt::BitRoutine)
    nlocs = ctx.hoisted_vars.nlocs
    mask = ctx.hoisted_vars.mask
    U12, U21 = brt.expr[1, 2], brt.expr[2, 1]

    function kernel(m)
        ctrl_expr(ctx, m) do
            batch_loop(ctx) do b
                @defnew ctx.kernel_vars i = $m + 1
                @defnew ctx.kernel_vars j = ($m ⊻ $mask) + 1
                @defnew ctx.kernel_vars k = count_ones($m & $mask)
                @gensym tmp
                S1, S2 = refst(ctx, i, b), refst(ctx, j, b)

                ex = @match (U12, U21) begin
                    (1, 1) => quote
                        $S1 = $S2
                        $S2 = $tmp
                    end
                    (A, :(-$(&A))) || (A::Number, &(-A)) => begin
                        @def ctx.hoisted_vars alpha = $A^$nlocs
                        @def ctx.hoisted_vars isodd_nlocs = isodd($nlocs)
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
                        @def ctx.hoisted_vars alpha = $A^$nlocs
                        @def ctx.hoisted_vars isodd_nlocs = isodd($nlocs)
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
                    _ => quote
                        $S1 = $U12^$k * $U21^($nlocs-$k) * $S2
                        $S2 = $U21^$k * $U12^($nlocs-$k) * $tmp
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
    @smatch ex begin
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
