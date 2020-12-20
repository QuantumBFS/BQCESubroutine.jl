using BQCESubroutine: BQCESubroutine, Utilities
using BenchmarkTools
using LinearAlgebra
using YaoLocations
using Test

suite = BenchmarkGroup()
suite["generic broutine!"] = BenchmarkGroup()

macro suite(title, ex)
    return esc(suite_m(__module__, title, ex))
end

function suite_m(m::Module, title, ex)
    quote
        if !isdefined($m, :__suite_stack__)
            if !isdefined($m, :SUITE)
                global const SUITE = $BenchmarkGroup()
            end
            global const __suite_stack__ = [SUITE]
        end

        __suite__ = last(__suite_stack__)
        __suite__ = __suite__[$title] = $BenchmarkGroup()
        push!(__suite_stack__, __suite__)

        let
           $(record_benchmarkable(ex))
        end

        pop!(__suite_stack__)

        SUITE
    end
end

function record_benchmarkable(ex)
    ex isa Expr || return ex
    
    if ex.head === :block
        body = Expr(:block)
        count = 0
        for each in ex.args
            line = if each isa Expr && each.head === :macrocall && each.args[1] === Symbol("@benchmarkable")
                count += 1
                :(__suite__[$count] = $each)
            else
                each
            end
            push!(body.args, line)
        end
        return quote
            __suite__ = last(__suite_stack__)
            __suite__ = __suite__[$title] = $BenchmarkGroup()
            push!(__suite_stack__, __suite__)

            let
            $(record_benchmarkable(ex))
            end

            pop!(__suite_stack__)
        end
    elseif ex.head === :for
        error("not implemented")
    end

    return ret
end

@suite "generic broutine!" begin
    @suite "rand(ComplexF64, 1<<3)" begin
        st = rand(ComplexF64, 1 << 8)
        U = rand(ComplexF64, 1 << 3, 1 << 3)
        locs = Locations((1, 3, 4, 5, 6))[1:3]
        @benchmarkable broutine!(r, $U, $locs) setup=(r=copy($st))
    end
end

SUITE["generic broutine!"]["rand(ComplexF64, 1<<3)"][1]

tune!(SUITE)
results = run(SUITE, verbose = true, seconds = 1)
results["generic broutine!"]["rand(ComplexF64, 1<<3)"][1]
