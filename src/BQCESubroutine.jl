module BQCESubroutine

export broutine!, @broutine

using MatchCore
using ExprTools
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, AbstractLocations, merge_locations
using LinearAlgebra
using LoopVectorization
using PaddedMatrices

const BQCES_nthreads = Ref(1)

function set_nthreads(n::Int)
    BQCES_nthreads[] = n
    return
end

macro _threads(ex)
    return quote
        if (Threads.nthreads() > 1) && (length(st) > 4096)
            $(Expr(:macrocall, Expr(:(.), :Threads, QuoteNode(Symbol("@threads"))), __source__, ex))
        else
            $ex
        end
    end |> esc
end

"""
    broutine!(st, op, locs[, ctrl, theta])

Qubit-based quantum circuit subroutine.

# Args

- `st`: the raw storage type.
- `op`: the operator
- `locs`: a `Locations`, location of the operator
- `ctrl`: optional. A `CtrlLocations`, location of the control qubits.
- `theta`: optional. A `Number`, parameters of the operator.
"""
function broutine! end

include("utils.jl")

using .Utilities

include("codegen/utils.jl")
include("codegen/broutine.jl")
include("mul.jl")
include("statevector.jl")

end
