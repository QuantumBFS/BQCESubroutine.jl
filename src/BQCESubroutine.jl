module BQCESubroutine

export broutine!, @broutine, log2dim, log2i

using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, AbstractLocations, merge_locations
using LinearAlgebra
using LoopVectorization
using StrideArrays
using StrideArrays: StrideArray
using CheapThreads: @batch
using ArrayInterface

include("utils2.jl")
include("schedule.jl")
include("subspace/bit.jl")
include("mul/mul.jl")
include("routine/bit.jl")
# include("utils.jl")
# include("threading.jl")

# using .Utilities

# include("codegen/utils.jl")
# include("codegen/broutine.jl")
# include("mul.jl")
# include("statevector.jl")

end
