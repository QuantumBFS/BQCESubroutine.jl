module BQCESubroutine

export broutine!, @broutine

using MLStyle
using ExprTools
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, AbstractLocations, merge_locations
using LinearAlgebra
using LoopVectorization
using PaddedMatrices

"""
    broutine!(st, op, locs[, ctrl, args...])

Qubit-based quantum circuit subroutine.

# Args

- `st`: the raw storage type.
- `op`: the operator
- `locs`: a `Locations`, location of the operator
- `ctrl`: optional. A `CtrlLocations`, location of the control qubits.
- `args`: optional. parameters of the operator.
"""
function broutine! end

include("utils.jl")
include("threading.jl")

using .Utilities

include("codegen/utils.jl")
include("codegen/broutine.jl")
include("mul.jl")
include("statevector.jl")

end
