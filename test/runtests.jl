using BQCESubroutine
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test

@testset "broutine" begin
    include("broutine.jl")
    include("schedule.jl")
end
