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
using CUDA

include("utils2.jl")
include("schedule.jl")
include("subspace/bit.jl")
include("mul/mul.jl")
include("mul/mul_X_test.jl")
include("mul/mul_X_test_gpu.jl")
include("routine/bit.jl")
include("threading.jl")

# include("utils.jl")
# using .Utilities

include("codegen/utils.jl")
include("codegen/broutine.jl")
# include("mul.jl")
include("statevector.jl")

end
