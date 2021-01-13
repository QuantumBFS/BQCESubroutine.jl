using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using PaddedMatrices
using MatchCore
using MLStyle
using BQCESubroutine: BitContext, BitRoutine, multi_broutine2x2!
using BQCESubroutine: diag_kernel, perm_kernel, generic_kernel, threaded_subspace_loop
using BQCESubroutine: codegen_broutine2x2_multi, codegen_broutine, hoist_entries!, codegen_basic_broutine
using BQCESubroutine: threaded_basic_broutine!, basic_broutine!, threaded_multi_broutine2x2!

st = rand(ComplexF64, 1 << 10);
locs = Locations((9, 10))
threaded_basic_broutine!(copy(st), Val(:PSWAP), locs, 2.0) ≈ basic_broutine!(copy(st), Val(:PSWAP), locs, 2.0)
broutine!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), BQCESubroutine.BZ, locs)
threaded_basic_broutine!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), BQCESubroutine.BZ, locs)
threaded_basic_broutine!(copy(st), Val(:Z), locs) ≈ basic_broutine!(copy(st), Val(:Z), locs)

threaded_multi_broutine2x2!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), BQCESubroutine.BZ, locs)
threaded_multi_broutine2x2!(copy(st), Val(:Z), locs) ≈ multi_broutine2x2!(copy(st), Val(:Z), locs)

@code_lowered broutine!(st, Val(:Z), Locations(24))
BQCESubroutine.set_nthreads(12)
@benchmark broutine!(st, Val(:Z), Locations(24)) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark threaded_basic_broutine!(st, Val(:Z), Locations(25)) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark basic_broutine!(st, Val(:Z), Locations(25)) setup=(st=rand(ComplexF64, 1 << 25))

BQCESubroutine.disable_threads()
@benchmark broutine!(st, Val(:Z), Locations(25)) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark instruct!(st, Val(:Z), (25, )) setup=(st=rand(ComplexF64, 1 << 25))

@benchmark threaded_basic_broutine!(st, Val(:Z), Locations(25)) setup=(st=rand(ComplexF64, 1 << 25))

@benchmark threaded_multi_broutine2x2!(st, Val(:Z), Locations((23, 24))) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark multi_broutine2x2!(st, Val(:Z), Locations((23, 24))) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark instruct!(st, Val(:Z), (23, 24)) setup=(st=rand(ComplexF64, 1 << 25))


@broutine X = [0 1;1 0]

threaded_basic_broutine!(copy(st), Val(:X), locs) ≈ broutine!(copy(st), BX, locs)
multi_broutine2x2!(copy(st), Val(:X), locs)≈ broutine!(copy(st), BX, locs)
threaded_multi_broutine2x2!(copy(st), Val(:X), locs) ≈ multi_broutine2x2!(copy(st), Val(:X), locs)


ctx = BitContext(;threading=true, expand_sz = 0)
brt = BitRoutine(Main, :(Z = [1 0;0 -1]))
codegen_basic_broutine(ctx, brt)|>flatten_block

function BQCESubroutine.threaded_basic_broutine!(var"##st#297"::AbstractVector{T} where T, ::Val{:Z}, var"##locs#298"::Locations)
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:162 =#
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:258 =#
    nothing
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:259 =#
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:296 =#
    var"##plain_locs#299" = (YaoLocations.plain)(var"##locs#298")
    var"##nqubits#300" = (BQCESubroutine.Utilities.log2i)(size(var"##st#297", 1))
    var"##nlocs_needed#301" = (BQCESubroutine.Utilities.log2i)(BQCESubroutine.BQCES_nthreads[] - 1) + 1
    var"##step_1_l#305" = 1 << (var"##plain_locs#299"[1] - 1)
    var"##step_1_h#306" = 1 << var"##plain_locs#299"[1]
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:297 =#
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:298 =#
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:561 =# @fastmath #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:560 =# @inbounds(begin
                if var"##nlocs_needed#301" ≤ var"##nqubits#300" - var"##plain_locs#299"[1]
                    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:455 =#
                    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:414 =#
                    if var"##step_1_l#305" == 1
                        #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:415 =#
                        Threads.@threads for var"##idx#302_1" = 0:var"##step_1_h#306":size(var"##st#297", 1) - var"##step_1_h#306"
                                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:312 =#
                                nothing
                                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:313 =#
                                var"##I#307_2" = ((var"##idx#302_1" + 0) + var"##step_1_l#305") + 1
                                var"##T#308_2" = -(var"##st#297"[var"##I#307_2"])
                                var"##st#297"[var"##I#307_2"] = var"##T#308_2"
                            end
                        #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:416 =#
                        return var"##st#297"
                    end
                    Threads.@threads for var"##idx#302_1" = 0:var"##step_1_h#306":size(var"##st#297", 1) - var"##step_1_h#306"
                            for var"##idx#302_2" = var"##idx#302_1":1:(var"##idx#302_1" + var"##step_1_l#305") - 1
                                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:426 =#
                                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:312 =#
                                nothing
                                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:313 =#
                                var"##I#309_2" = ((var"##idx#302_2" + 0) + var"##step_1_l#305") + 1
                                var"##T#310_2" = -(var"##st#297"[var"##I#309_2"])
                                var"##st#297"[var"##I#309_2"] = var"##T#310_2"
                            end
                        end
                    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:456 =#
                    return var"##st#297"
                end
                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:478 =#
                var"##m#304" = (var"##nqubits#300" - var"##nlocs_needed#301") - 1
                #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:479 =#
                Threads.@threads for var"##base#303" = (BQCESubroutine.Utilities.bsubspace)(var"##nqubits#300", (1:var"##m#304"..., var"##plain_locs#299"...))
                        #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:480 =#
                        for var"##idx#302_1" = 0:1 << var"##m#304" - 1
                            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:481 =#
                            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:312 =#
                            nothing
                            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:313 =#
                            var"##I#311_2" = ((var"##base#303" + var"##idx#302_1") + var"##step_1_l#305") + 1
                            var"##T#312_2" = -(var"##st#297"[var"##I#311_2"])
                            var"##st#297"[var"##I#311_2"] = var"##T#312_2"
                        end
                    end
                return var"##st#297"
            end)
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:163 =#
    return var"##st#297"
end