using Test
using LinearAlgebra
using BQCESubroutine
using BQCESubroutine.Utilities
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using BQCESubroutine: ctrl_offset
using YaoArrayRegister
using BenchmarkTools
using LoopVectorization
using BQCESubroutine: perm_kernel, BitRoutine, multi_broutine2x2!, subspace_mul_kernel, BitRoutine
using MatchCore

@smatch :(A = B) begin
    :($D = $D) => D
    :($B = $C) => (B, C)
    _ => nothing
end
