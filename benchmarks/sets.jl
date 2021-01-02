module BenchmarkSets

using BenchmarkTools
export @bench, @benchmarkset

const benchmark_stack = []

macro benchmarkset(title, ex)
    esc(benchmarkset_m(title, ex))
end

macro bench(title, xs...)
    esc(:(var"#suite#"[$title] = @benchmarkable $(xs...)))
end

function benchmarkset_m(title, ex::Expr)
    stack = GlobalRef(BenchmarkSets, :benchmark_stack)
    init = quote
        if isempty($stack)
            push!($stack, $BenchmarkGroup())
        end
    end
    exec = quote
        if length($stack) == 1
            SUITE = pop!($stack)
        end
        nothing
    end
    return if ex.head === :block
        quote
            $init
            $(benchmarkset_block(title, ex))
            $exec
        end
    elseif ex.head === :for
        quote
            $init
            $(Expr(ex.head, ex.args[1], benchmarkset_block(title, ex.args[2]))) 
            $exec
        end
    end
end

function benchmarkset_block(title, ex::Expr)
    stack = GlobalRef(BenchmarkSets, :benchmark_stack)
    quote
        let var"#root#" = last($stack)
            var"#root#"[$title] = var"#suite#" = BenchmarkGroup()
            push!($stack, var"#suite#")
            $ex
            pop!($stack)
        end
    end
end

end
