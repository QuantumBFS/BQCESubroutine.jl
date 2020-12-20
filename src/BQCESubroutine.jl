module BQCESubroutine

export broutine!, @broutine

using MatchCore
using ExprTools
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, AbstractLocations, merge_locations
using LinearAlgebra
using LoopVectorization
using PaddedMatrices

macro _threads(ex)
    if Threads.nthreads() > 1
        esc(Expr(:macrocall, Expr(:(.), :Threads, QuoteNode(Symbol("@threads"))), __source__, ex))
    else
        esc(ex)
    end
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

include("codegen/broutine.jl")
include("statevector.jl")

end
