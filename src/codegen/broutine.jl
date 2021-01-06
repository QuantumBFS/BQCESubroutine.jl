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
        :body => f_body(st, locs),
    )
    isempty(brt.typevars) || (def[:whereparams] = [brt.typevars...])
    return combinedef(def)
end

function codegen_broutine(brt::BitRoutine)
    @gensym step
    ret = Expr(:block)
    for batch in [nothing, gensym(:batch)], ctrl in [nothing, gensym(:ctrl)]
        mt = codegen_method(brt, :broutine!, batch, ctrl) do st, locs
            init, kernel = generic_kernel(brt, st, locs, ctrl, step)
            quote
                $init
                $(subspace_loop(kernel, brt, st, step, batch))
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

function _generic_kernel(brt::BitRoutine, st, locs, step)
    @gensym M raw_locs
    init = quote
        @assert length($locs) == $(2size(brt)) "number of locations mismatch operator size"
        $raw_locs = $plain(sort($locs))
    end

    step_l(i) = Symbol(step, :_, i, :_l)
    step_h(i) = Symbol(step, :_, i, :_h)
    U(i, j) = brt.expr[i, j] isa Number ? brt.expr[i, j] : Symbol(M, :_, i, j)

    for i in 1:log2i(size(brt))
        push!(init.args, :($(step_l(i)) = 1 << ($raw_locs[$i] - 1)))
        push!(init.args, :($(step_h(i)) = 1 << $raw_locs[$i]))
    end

    for i in 1:size(brt), j in 1:size(brt)
        brt.expr[i, j] isa Number && continue
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

function subspace_loop(f, brt::BitRoutine, st, step, b = nothing, max = 4)
    @gensym m
    n = log2i(size(brt))
    step_l(i) = Symbol(step, :_, i, :_l)
    step_h(i) = Symbol(step, :_, i, :_h)
    idx(i) = Symbol(m, :_, i)

    N = b === nothing ? :(size($st, 1)) : :(size($st, 2))
    head = quote
        $(idx(1)) = 0:$(step_h(n)):$N-$(step_h(n))
    end

    # b2 in b1:step_1_h:b1+step_2_l-step_1_h
    for i in 2:n
        step_i_h = step_h(n-i+1)
        step_i_1_l = step_l(n-i+2)
        push!(head.args, :($(idx(i)) = $(idx(i-1)):$step_i_h:$(idx(i-1))+$step_i_1_l-$step_i_h))
    end

    # b3 in b2:b2+step_1_l-1
    if b === nothing
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

# function broutine_m(m::Module, ex::Expr)
#     brt = BitRoutine(ex)

#     broutines = if size(brt) == 2
#         codegen_broutine2x2(brt)
#     elseif size(brt) == 4
#         codegen_broutine4x4_generic(brt)
#     else
#         error("size not supported yet")
#     end

#     # NOTE: we need to leave name space
#     # for other type of qubits, e.g qutrits
#     const_name = Symbol(:B, brt.name)
#     body = Expr(:vcat)
#     for row in eachrow(brt.expr)
#         push!(body.args, Expr(:row, row...))
#     end
#     con = if isempty(brt.args)
#         :(const $(const_name) = $body)
#     else
#         def = Dict{Symbol, Any}(
#             :name => const_name,
#             :args => brt.args,
#             :whereparams => brt.typevars,
#             :body => body
#         )
#         combinedef(def)
#     end

#     return quote
#         $broutines
#         $con
#     end
# end

# function isperm(x::Matrix)
#     all(count(x->!isa(x, Number) || !iszero(x), col) == 1 for col in eachcol(x))
# end

# function isdiag(x::Matrix)
#     for i in 1:size(x, 1), j in 1:size(x, 2)
#         e = x[i, j]
#         if i != j
#             e isa Number && iszero(e) && continue
#             return false
#         end
#     end
#     return true
# end

# function codegen_broutine2x2(x::BitRoutine)
#     ex = Expr(:block)
#     push!(ex.args, codegen_broutine2x2_generic(x))

#     # repeat gate multi qubit routines
#     if isdiag(x.expr)
#         push!(ex.args, codegen_broutine2x2_diag(x))
#     elseif isperm(x.expr)
#         push!(ex.args, codegen_broutine2x2_perm(x))
#     else
#         push!(ex.args, codegen_broutine2x2_dense(x))
#     end
#     return ex
# end

# function subspace_mul_kernel(st, brt::BitRoutine)
#     @gensym temp U
#     init = Expr(:block)

#     for i in 1:size(brt.expr, 1), j in 1:size(brt.expr, 2)
#         if !(brt.expr[i, j] isa Number)
#             push!(init.args, :($(Symbol(U, i, j)) = $(brt.expr[i, j])))
#         end
#     end

#     return init, function kernel(indices, b = nothing)
#         entries = Expr(:block)
#         assigns = Expr(:block)
#         if b === nothing
#             values = [:($st[$idx]) for idx in indices]
#         else
#             values = [:($st[$b, $idx]) for idx in indices]
#         end

#         for i in 1:size(brt.expr, 1)
#             t = Symbol(temp, :_, i)
#             Ui1 = brt.expr[i, 1] isa Number ? brt.expr[i, 1] : Symbol(U, i, 1)
#             e = sym_mul(Ui1, values[1])

#             for j in 2:size(brt.expr, 2)
#                 Uij = brt.expr[i, j] isa Number ? brt.expr[i, j] : Symbol(U, i, j)
#                 e = sym_plus(e, sym_mul(Uij, values[j]))
#             end

#             e == values[i] && continue
#             push!(entries.args, Expr(:(=), t, e))
#             push!(assigns.args, Expr(:(=), values[i], t))
#         end
#         return Expr(:block, entries.args..., assigns.args...)
#     end
# end

# function broutine2x2_jloop(f, st, step_2, step_1)
#     @gensym j
#     quote
#         @fastmath @inbounds for $j in 0:$step_2:size($st, 1) - $step_1
#             $(f(j))
#         end
#     end
# end

# function broutine2x2_jloop(f, st, step_2, step_1, b)
#     @gensym j
#     quote
#         @fastmath @inbounds for $j in 0:$step_2:size($st, 2) - $step_1, $b in 1:size($st, 1)
#             $(f(j))
#         end
#     end
# end

# function broutine2x2_iloop(f, n, j, step_1)
#     @gensym i
#     quote
#         for $i in $j:$n:$j+$step_1-1
#             $(f(i))
#         end
#     end
# end

# function expand(f_kernel, max, st, step_1, step_2, b...)
#     ret = Expr(:block)
#     for k in 0:max
#         n = 1 << k
#         expanded = broutine2x2_jloop(st, step_2, step_1, b...) do j
#             nexprs(n) do i
#                 f_kernel(:($j+$i))
#             end
#         end
#         push!(ret.args, quote
#             if $step_1 == $n
#                 $expanded
#                 return $st
#             end
#         end)
#     end

#     push!(ret.args, broutine2x2_jloop(st, step_2, step_1, b...) do j
#         broutine2x2_iloop(1<<max, j, step_1) do i
#             nexprs(1<<max) do k
#                 f_kernel(:($i+$k))
#             end
#         end
#     end)
#     return ret
# end

# function codegen_broutine2x2_generic(brt::BitRoutine)
#     @gensym st locs ctrl step_1 step_2 b raw raw_ctrl ctrl_mask flag_mask

#     init, kernel = subspace_mul_kernel(st, brt)

#     ret = Expr(:block)
#     for (T, _b) in [:AbstractVector=>(), :AbstractMatrix=>(b, )]
#         def_body = expand(4, st, step_1, step_2, _b...) do k
#             kernel([k, :($k + $step_1)], _b...)
#         end

#         def = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :broutine!),
#         :args => Any[:($st::$T), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), brt.args...],
#         :body => quote
#                 if length($locs) == 1
#                     $init
#                     $step_1 = 1 << (first($plain($locs)) - 1)
#                     $step_2 = 1 << first($plain($locs))
#                     $def_body
#                 else
#                     $multi_broutine2x2!($st, $(Val(brt.name)), $locs, $(brt.args...))
#                 end
#                 return $st
#             end,
#         )

#         ctrl_def_body = expand(4, st, step_1, step_2, _b...) do k
#             quote
#                 if $ismatch($k-1, $ctrl_mask, $flag_mask)
#                     $(kernel([k, :($k + $step_1)], _b...))
#                 end
#             end
#         end

#         ctrl_def = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :broutine!),
#         :args => Any[:($st::$T), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), :($ctrl::$CtrlLocations), brt.args...],
#         :body => quote
#                 if length($locs) == 1
#                     $init
#                     $raw = first($plain($locs))
#                     $step_1 = 1 << ($raw - 1)
#                     $step_2 = 1 << $raw
#                     $raw_ctrl = $plain($ctrl)
#                     $ctrl_mask = bmask($raw_ctrl)
#                     $flag_mask = reduce(+, one(Int) << ($raw_ctrl[i] - 1) for i in 1:length($ctrl) if $ctrl.flags[i])
#                     $ctrl_def_body
#                 else
#                     $multi_broutine2x2!($st, $(Val(brt.name)), $locs, $ctrl, $(brt.args...))
#                 end
#                 return $st
#             end,
#         )

#         isempty(brt.typevars) || (def[:whereparams] = [brt.typevars...])
#         isempty(brt.typevars) || (ctrl_def[:whereparams] = [brt.typevars...])

#         push!(ret.args, combinedef(def))
#         push!(ret.args, combinedef(ctrl_def))
#     end

#     return ret
# end

# function codegen_broutine4x4_generic(brt::BitRoutine)
#     @gensym st locs loc_1 loc_2 ctrl step_1 step_2 step_3 step_4 b b1 b2 b3 i1 i2 i3 i4
#     @gensym raw_ctrl ctrl_mask flag_mask

#     init, kernel = subspace_mul_kernel(st, brt)
#     indices = [i1,i2,i3,i4]
    
#     vinit = quote
#         @assert length($locs) == 2 "number of locations mismatch"
#         $init
#         $loc_1 = first($plain($locs))
#         $loc_2 = last($plain($locs))

#         if $loc_1 > $loc_2
#             $loc_1 = last($plain($locs))
#             $loc_2 = first($plain($locs))
#         end

#         $step_1 = 1 << $loc_1
#         $step_2 = 1 << ($loc_1 - 1)
#         $step_3 = 1 << $loc_2
#         $step_4 = 1 << ($loc_2 - 1)
#     end

#     vdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :broutine!),
#         :args => Any[:($st::AbstractVector), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), brt.args...],
#         :body => quote
#             $vinit
#             @fastmath @inbounds for $b1 in 0:$step_3:size($st, 1)-$step_3
#                 for $b2 in $b1:$step_1:$b1+$step_4-$step_1, $b3 in $b2:$b2+$step_2-1
#                     $i1 = $b3+1
#                     $i2 = $b3+$step_2+1
#                     $i3 = $b3+$step_4+1
#                     $i4 = $b3+$step_2+$step_4+1
#                     $(kernel(indices))
#                 end
#             end
#             return $st
#         end,
#     )

#     mdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :broutine!),
#         :args => Any[:($st::AbstractMatrix), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), brt.args...],
#         :body => quote
#             $vinit
#             @fastmath @inbounds for $b1 in 0:$step_3:size($st, 2)-$step_3
#                 for $b2 in $b1:$step_1:$b1+$step_4-$step_1, $b3 in $b2:$b2+$step_2-1, $b in axes($st, 1)
#                     $i1 = $b3+1
#                     $i2 = $b3+$step_2+1
#                     $i3 = $b3+$step_4+1
#                     $i4 = $b3+$step_2+$step_4+1
#                     $(kernel(indices, b))
#                 end
#             end
#             return $st
#         end,
#     )

#     ctrl_init = quote
#         $raw_ctrl = $plain($ctrl)
#         $ctrl_mask = bmask($raw_ctrl)
#         $flag_mask = reduce(+, one(Int) << ($raw_ctrl[i] - 1) for i in 1:length($ctrl) if $ctrl.flags[i])
#     end

#     ctrl_vdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :broutine!),
#         :args => Any[:($st::AbstractVector), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), :($ctrl::$CtrlLocations), brt.args...],
#         :body => quote
#             $vinit
#             $ctrl_init

#             @fastmath @inbounds for $b1 in 0:$step_3:size($st, 1)-$step_3
#                 for $b2 in $b1:$step_1:$b1+$step_4-$step_1, $b3 in $b2:$b2+$step_2-1
#                     if $ismatch($b3, $ctrl_mask, $flag_mask)
#                         $i1 = $b3+1
#                         $i2 = $b3+$step_2+1
#                         $i3 = $b3+$step_4+1
#                         $i4 = $b3+$step_2+$step_4+1
#                         $(kernel(indices))
#                     end
#                 end
#             end
#             return $st
#         end,
#     )

#     ctrl_mdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :broutine!),
#         :args => Any[:($st::AbstractMatrix), :(::Val{$(QuoteNode(brt.name))}), :($locs::$Locations), :($ctrl::$CtrlLocations), brt.args...],
#         :body => quote
#             $vinit
#             $ctrl_init

#             @fastmath @inbounds for $b1 in 0:$step_3:size($st, 2)-$step_3
#                 for $b2 in $b1:$step_1:$b1+$step_4-$step_1, $b3 in $b2:$b2+$step_2-1, $b in axes($st, 1)
#                     if $ismatch($b3, $ctrl_mask, $flag_mask)
#                         $i1 = $b3+1
#                         $i2 = $b3+$step_2+1
#                         $i3 = $b3+$step_4+1
#                         $i4 = $b3+$step_2+$step_4+1
#                         $(kernel(indices, b))
#                     end
#                 end
#             end
#             return $st
#         end,
#     )

#     return quote
#         $(combinedef(vdef))
#         $(combinedef(mdef))
#         $(combinedef(ctrl_vdef))
#         $(combinedef(ctrl_mdef))
#     end
# end

# function multi_broutine2x2! end

# # U_{a1,b1}U_{a2,b2} st[b1,b2, ...]
# # U_{a1,0}U_{a2,0} st[0,0, ...] +
# # U_{a1,0}U_{a2,1} st[0,1, ...] +
# # U_{a1,1}U_{a2,0} st[1,0, ...] +
# # U_{a1,1}U_{a2,1} st[1,1, ...] +

# # diag element are in power of number ones/zeros
# # a1,a2 = 0,0
# # U_{0,0}U_{0,0} st[0,0, ...]
# # a1,a2 = 0,1
# # U_{0,0}U_{1,1} st[0,1, ...]
# # a1,a2 = 1,0
# # U_{1,1}U_{0,0} st[1,0, ...]
# # a1,a2 = 1,1
# # U_{1,1}U_{1,1} st[1,1, ...]
# function diag_kernel(brt::BitRoutine, st, locs)
#     @gensym l mask alpha U11 U22
#     init = quote
#         $l = length($locs)
#         $mask = $bmask(Int, $plain($locs))
#     end

#     if brt.expr[1, 1] isa Number
#         U11 = brt.expr[1, 1]
#     else
#         push!(init.args, :($U11 = $(brt.expr[1, 1])))
#     end

#     if brt.expr[2, 2] isa Number
#         U22 = brt.expr[2, 2]
#     else
#         push!(init.args, :($U22 = $(brt.expr[2, 2])))
#     end

#     if U11 == U22 # this does not need k
#         if U11 isa Number && isone(U11)
#             kernel = (m, p)->nothing
#         else
#             push!(parepare.args, :($alpha = $U11^l))
#             kernel = (m, p)->:($st[$(p...)] = $alpha * $st[$(p...)])
#         end
#     else
#         kernel = (m, p)->begin
#             ex = :($st[$(p...)] = $U11^($l-k) * $U22^k * $st[$(p...)])
#             ex = elim_double_const_pow(ex)
#             ex = elim_const_pow(ex)
#             ex = elim_identity(ex)
#             ex = elim_exp_pi(ex)
#             ex = quote
#                 k = count_ones($m & $mask)
#                 $ex
#             end
#         end
#     end

#     loop(m) = kernel(m, (:($m+1), ))
#     loop(m, b) = kernel(m, (b,:($m+1)))

#     return init, loop
# end

# function codegen_broutine2x2_diag(brt::BitRoutine)
#     @gensym st locs m b
    
#     # NOTE:
#     # no benefit if it's parameterized
#     # it will make our loop kernel too complicated
#     if !isempty(brt.args)
#         return codegen_broutine2x2_dense(brt)
#     end

#     init, kernel = diag_kernel(brt, st, locs)
#     vdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
#         :args => Any[:($st::AbstractVector), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
#         :body => quote
#             $init
#             $(broutine2x2_loop(kernel, st, 8))
#             return $st
#         end,
#     )

#     mdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
#         :args => Any[:($st::AbstractMatrix), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
#         :body => quote
#             $init
#             $(broutine2x2_loop_m(kernel, st, 8))
#             return $st
#         end,
#     )

#     if !isempty(brt.typevars)
#         vdef[:whereparams] = [brt.typevars...]
#         mdef[:whereparams] = [brt.typevars...]
#     end

#     return quote
#         $(combinedef(vdef))
#         $(combinedef(mdef))
#     end
# end

# # U_{a1,b1}U_{a2,b2} st[b1,b2, ...]
# # U_{a1,0}U_{a2,0} st[0,0, ...] +
# # U_{a1,0}U_{a2,1} st[0,1, ...] +
# # U_{a1,1}U_{a2,0} st[1,0, ...] +
# # U_{a1,1}U_{a2,1} st[1,1, ...] +

# # a1,a2 = 0,0
# # U_{0,1}U_{0,1} st[1,1, ...]
# # a1,a2 = 0,1
# # U_{0,1}U_{1,0} st[1,0, ...]
# # a1,a2 = 1,0
# # U_{1,0}U_{0,1} st[0,1, ...]
# # a1,a2 = 1,1
# # U_{1,0}U_{1,0} st[0,0, ...]
# function perm_kernel(brt::BitRoutine, st, locs)
#     @gensym l mask alpha tmp i j isodd_l U12 U21

#     init = quote
#         $l = length($locs)
#         $mask = bmask(Int, $plain($locs))
#     end

#     if brt.expr[1, 2] isa Number
#         U12 = brt.expr[1, 2]
#     else
#         push!(init.args, :($U12 = $(brt.expr[1, 2])))
#     end

#     if brt.expr[2, 1] isa Number
#         U21 = brt.expr[2, 1]
#     else
#         push!(init.args, :($U21 = $(brt.expr[2, 1])))
#     end

#     if U12 == U21
#         if U12 isa Number && isone(U12)
#             kernel = (m, p, q)->quote
#                 $tmp = $st[$(q...)]
#                 $st[$(q...)] = $st[$(p...)]
#                 $st[$(p...)] = $tmp
#             end
#         else
#             push!(init.args, :($alpha = $U21^$l))
#             kernel = (m, p, q)->quote
#                 $tmp = $st[$(q...)]
#                 $st[$(q...)] = $alpha * $st[$(p...)]
#                 $st[$(p...)] = $alpha * $tmp
#             end
#         end
#     elseif (U21 isa Number && U12 == -U21) || (U12 == :(-$U21))
#         push!(init.args, :($isodd_l = isodd($l)))
#         if !(U12 isa Number && isone(U12))
#             push!(init.args, :($alpha = $U12^$l))
#         end

#         if U12 isa Number && isone(U12)
#             kernel = (m, p, q)->quote
#                 k = count_ones($m & $mask)
#                 $tmp = $st[$(q...)]
#                 if isodd(k)
#                     $st[$(q...)] = -$st[$(p...)]
#                     if $isodd_l # (l-k) even
#                         $st[$(p...)] = $tmp
#                     else
#                         $st[$(p...)] = -$tmp
#                     end
#                 else
#                     $st[$(q...)] = $st[$(p...)]
#                     if $isodd_l # (l-k) old
#                         $st[$(p...)] = -$tmp
#                     else
#                         $st[$(p...)] = $tmp
#                     end
#                 end
#             end
#         else
#             kernel = (m, p, q)->quote
#                 k = count_ones($m & $mask)
#                 $tmp = $st[$(q...)]
#                 if isodd(k)
#                     $st[$(q...)] = -$alpha * $st[$(p...)]
#                     if $isodd_l # (l-k) even
#                         $st[$(p...)] = $alpha * $tmp
#                     else
#                         $st[$(p...)] = -$alpha * $tmp
#                     end
#                 else
#                     $st[$(q...)] = $alpha * $st[$(p...)]
#                     if $isodd_l # (l-k) old
#                         $st[$(p...)] = -$alpha * $tmp
#                     else
#                         $st[$(p...)] = $alpha * $tmp
#                     end
#                 end
#             end
#         end
#     else
#         kernel = (m, p, q)->quote
#             k = count_ones($m & $mask)
#             $tmp = $st[$(q...)]
#             $st[$(q...)] = $U12^k * $U21^($l-k) * $st[$(p...)]
#             $st[$(p...)] = $U21^k * $U12^($l-k) * $tmp
#         end
#     end

#     function loop(m)
#         quote
#             $i = $m + 1
#             $j = ($m ⊻ $mask) + 1
#             $(kernel(m, (i, ), (j, )))
#         end
#     end

#     function loop(m, b)
#         quote
#             $i = $m + 1
#             $j = ($m ⊻ $mask) + 1
#             $(kernel(m, (b, i), (b, j)))
#         end
#     end
#     return init, loop
# end

# function codegen_broutine2x2_perm(brt::BitRoutine)
#     @gensym st locs step_2 step_1 m b
#     init, kernel = perm_kernel(brt, st, locs)

#     vdef_body = expand(4, st, step_1, step_2) do k
#         kernel(k)
#     end

#     mdef_body = expand(4, st, step_1, step_2, b) do k
#         kernel(k, b)
#     end

#     vdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
#         :args => Any[:($st::AbstractVector), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
#         :body => quote
#             $init
#             $step_2 = 1 << first($plain($locs))
#             $step_1 = 1 << (first($plain($locs)) - 1)
#             $vdef_body
#             return $st
#         end,
#     )

#     mdef = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
#         :args => Any[:($st::AbstractMatrix), :(::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
#         :body => quote
#             $init
#             $step_2 = 1 << first($plain($locs))
#             $step_1 = 1 << (first($plain($locs)) - 1)
#             $mdef_body
#             return $st
#         end,
#     )

#     if !isempty(brt.typevars)
#         vdef[:whereparams] = [brt.typevars...]
#         mdef[:whereparams] = [brt.typevars...]
#     end
#     return quote
#         $(combinedef(vdef))
#         $(combinedef(mdef))
#     end
# end

# function broutine2x2_loop_expanded(f_kernel, st, N::Int)
#     @gensym m _m Mmax mmax
#     expanded = nexprs(N) do k
#         f_kernel(:($m + $k - 1))
#     end

#     return quote
#         $Mmax = size($st, 1) - 1
#         for $_m in 0:($Mmax >>> $(log2i(N)))
#             $m = $_m << $(log2i(N))
#             $mmax = $m + $(N-1)
#             if $mmax ≤ $Mmax
#                 $expanded
#             else
#                 for $_m in $m:$Mmax
#                     $(f_kernel(_m))
#                 end
#             end
#         end
#     end
# end

# function broutine2x2_loop_expanded(f_kernel, st, N::Int, b)
#     @gensym m _m Mmax mmax
#     expanded = nexprs(N) do k
#         f_kernel(:($m + $k - 1), b)
#     end

#     return quote
#         $Mmax = size($st, 2) - 1
#         for $_m in 0:($Mmax >>> $(log2i(N)))
#             $m = $_m << $(log2i(N))
#             $mmax = $m + $(N-1)
#             if $mmax ≤ $Mmax
#                 for $b in 1:size($st, 1)
#                     $expanded
#                 end
#             else
#                 for $_m in $m:$Mmax, $b in 1:size($st, 1)
#                     $(f_kernel(_m, b))
#                 end
#             end
#         end
#     end
# end

# function broutine2x2_loop(f_kernel, st, N::Int)
#     @gensym m

#     src = quote
#         @fastmath @inbounds for $m in 0:(size($st, 1) - 1)
#             $(f_kernel(m))
#         end
#     end

#     if N == 0
#         return src
#     else
#         return return quote
#             @fastmath @inbounds if size($st, 1) > 8
#                 $(broutine2x2_loop_expanded(f_kernel, st, N))
#             else
#                 $src            
#             end
#         end
#     end
# end

# function broutine2x2_loop_m(f_kernel, st, N::Int)
#     @gensym m b

#     src = quote
#         @fastmath @inbounds for $m in 0:(size($st, 2) - 1)
#             $(f_kernel(m, b))
#         end
#     end

#     if N == 0
#         return src
#     else
#         return quote
#             @fastmath @inbounds if size($st, 2) > 8
#                 $(broutine2x2_loop_expanded(f_kernel, st, N, b))
#             else
#                 $src 
#             end    
#         end
#     end
# end

# function codegen_broutine2x2_dense(brt::BitRoutine)
#     U12 = brt.expr[1, 2]
#     U21 = brt.expr[2, 1]
#     @gensym T st loc locs gt
#     def = Dict{Symbol, Any}(
#         :name => GlobalRef(BQCESubroutine, :multi_broutine2x2!),
#         :args => Any[:($st::AbstractVecOrMat{$T}), :($gt::Val{$(QuoteNode(brt.name))}), :($locs::Locations), brt.args...],
#         :whereparams => [T, brt.typevars...],
#         :body => quote
#             for $loc in $locs
#                 $(GlobalRef(BQCESubroutine, :broutine!))($st, $gt, $loc, $(brt.args...))
#             end
#             return $st
#         end,
#     )

#     return combinedef(def)
# end

# function elim_double_const_pow(ex)
#     @smatch ex begin
#         :($D = 1^$p * $B^$q * $C) => :($D = $B^$q * $C)
#         :($D = A^$p * 1^$q * $C) => :($D = $A^$p * $C)
#         :($D = $A^$p * $B^$q * $C) => begin
#             if A == B
#                 :($D = $A^($p+$q) * $C)
#             else
#                 :($D = $A^$p * ($B^$q * $C))
#             end
#         end
#         ::Expr => Expr(ex.head, map(elim_double_const_pow, ex.args)...)
#         _ => ex
#     end
# end

# function elim_const_pow(ex)
#     m = gensym(:m)
#     @smatch ex begin
#         :($D = 1^$p * $C) => :($D = $C)
#         :($D = (-1)^$p * $C) => quote
#             if isodd($p)
#                 $D = -$C
#             else
#                 $D = $C
#             end
#         end
#         :($D = im^$p * $C) => quote
#             $m = mod($p, 4)
#             if $m == 0
#                 $D = $C
#             elseif $m == 1
#                 $D = im * $C
#             elseif $m == 2
#                 $D = -$C
#             else
#                 $D = -im*$C
#             end
#         end
#         :($D = (-im)^$p * $C) => quote
#             $m = mod($p, 4)
#             if $m == 0
#                 $D = $C
#             elseif $m == 1
#                 $D = -im * $C
#             elseif $m == 2
#                 $D = -$C
#             else
#                 $D = im*$C
#             end
#         end
#         ::Expr => Expr(ex.head, map(elim_const_pow, ex.args)...)
#         _ => ex
#     end
# end

# function elim_exp_pi(ex)
#     @smatch ex begin
#         :(exp(im * π / $k)^$p) => 
#             :(fast_expi_pi_pow(Val($k), $p))
#         ::Expr => Expr(ex.head, map(elim_exp_pi, ex.args)...)
#         _ => ex
#     end
# end

# function elim_identity(ex)
#     @smatch ex begin
#         :($A = $B) => begin
#             if A == B
#                 nothing
#             else
#                 ex
#             end
#         end
#         ::Expr => Expr(ex.head, map(elim_identity, ex.args)...)
#         _ => ex
#     end
# end
