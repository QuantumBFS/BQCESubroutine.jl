module BQCESubroutine

export broutine!, @broutine, log2dim, log2i

using MLStyle
using Expronicon
using ExprTools
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, AbstractLocations, merge_locations
using LinearAlgebra
using LoopVectorization
using StrideArrays
using StrideArrays: StrideArray
using Polyester: @batch
using ArrayInterface

include("utils2.jl")
include("schedule.jl")
include("subspace/bit.jl")
include("mul/mul.jl")
include("routine/bit.jl")
include("threading.jl")

include("codegen/utils.jl")
include("codegen/broutine.jl")

# define concrete gates
# include("statevector.jl")

end
