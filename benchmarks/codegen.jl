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
using BQCESubroutine: diag_kernel, perm_kernel, generic_kernel
using BQCESubroutine: codegen_broutine2x2_multi, codegen_broutine, hoist_entries!

@macroexpand @broutine Y = [0 -im;im 0]
# basic-20-bits-Y-i=1-multi
@benchmark broutine!(st, $(Val(:Z)), $(Locations([1, 3]))) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark instruct!(st, Val(:Z), (1, 3)) setup=(st=rand(ComplexF64, 1 << 20))

@benchmark broutine!(st, Val(:Y), Locations(17), CtrlLocations(5)) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark instruct!(st, Val(:Y), (17, ), (5, ), (1, )) setup=(st=rand(ComplexF64, 1 << 20))

INST["basic"] = @benchmarkset "$N-bits" for N in 5:5:20
    @benchmarkset "$G" for G in [:X, :Y, :Z, :H, :T, :S, :Sdag, :Tdag]
        @info "generating benchmark for $G gate"
        @benchmarkset "i=$i" for i in unique([1,2,3, N-1, N-2, N-3])
            locs = Locations(i)
            @bench "gate" instruct!(st, $(Val(G)), $(Tuple(locs))) setup=(st=rand(ComplexF64, 1 << $N))
            
            if G in [:X, :Y, :Z]
                locs = sort(Locations((i, mod1(i+2, N))))
                @bench "multi" instruct!(st, $(Val(G)), $(Tuple(locs))) setup=(st=rand(ComplexF64, 1 << $N))

                locs = Locations(i)
                ctrl = CtrlLocations(mod1(i+1, N))
                @bench "ctrl" instruct!(st, $(Val(G)), $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, )) setup=(st=rand(ComplexF64, 1 << $N))    
            end
        end
    end
end

ctx = BitContext()
brt = BitRoutine(Main, :(Z = [1 0;0 -1]))
hoist_entries!(brt)
ctx =  BitContext()
ctx.expand_sz = 0
eval(codegen_broutine2x2_multi(ctx, brt))

@benchmark multi_broutine2x2!(st, Val(:YY), $(Locations([1, 3]))) setup=(st=rand(ComplexF64, 1 << 20))

eval(codegen_broutine(ctx, brt))
# @broutine Y = [0 -im;im 0]
# @broutine Z = [1 0;0 -1]
@macroexpand @broutine H = [1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]
# @broutine T = [1 0;0 exp(im * π / 4)]
# @broutine S = [1 0;0 im]
# @broutine Sdag = [1 0;0 -im]
# @broutine Tdag = [1 0;0 exp(-im * π / 4)]
# @broutine Rx(θ::Real) = [cos(θ / 2) -im*sin(θ / 2); -im*sin(θ / 2) cos(θ / 2)]
# @broutine Ry(θ::Real) = [cos(θ / 2) -sin(θ / 2); sin(θ / 2) cos(θ / 2)]
# @broutine Rz(θ::Real) = [exp(-im * θ / 2) 0; 0 exp(im * θ / 2)]

function BQCESubroutine.multi_broutine2x2!(var"##st#459"::AbstractVector{T} where T, ::Val{:YY}, var"##locs#460"::Locations)
    var"##nlocs#461" = length(var"##locs#460")
    var"##mask#462" = (BQCESubroutine.Utilities.bmask)((YaoLocations.plain)(var"##locs#460"))
    var"##step_1_l#464" = 1 << (((YaoLocations.plain)(var"##locs#460"))[1] - 1)
    var"##step_1_h#465" = 1 << ((YaoLocations.plain)(var"##locs#460"))[1]
    var"##alpha#470" = (BQCESubroutine.Utilities.literal_pow)(Val{:im}(), var"##nlocs#461")
    var"##isodd_nlocs#471" = isodd(var"##nlocs#461")
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:157 =#
    for var"##m#472_1" = 0:var"##step_1_h#465":size(var"##st#459", 1) - var"##step_1_h#465", var"##m#472_2" = var"##m#472_1":(var"##m#472_1" + var"##step_1_l#464") - 1
        var"##i#473" = var"##m#472_2" + 1
        var"##j#474" = (var"##m#472_2" ⊻ var"##mask#462") + 1
        var"##k#475" = count_ones(var"##m#472_2" & var"##mask#462")
        var"##tmp#476" = var"##st#459"[var"##i#473"]
        #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:566 =#
        if isodd(var"##k#475")
            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:567 =#
            var"##st#459"[var"##i#473"] = -var"##alpha#470" * var"##st#459"[var"##j#474"]
            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:568 =#
            # var"##st#459"[var"##j#474"] = if var"##isodd_nlocs#471"
            #         var"##alpha#470" * var"##tmp#476"
            #     else
            #         -var"##alpha#470" * var"##tmp#476"
            #     end
        else
            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:570 =#
            # var"##st#459"[var"##i#473"] = var"##alpha#470" * var"##st#459"[var"##j#474"]
            #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:571 =#
            # var"##st#459"[var"##j#474"] = if var"##isodd_nlocs#471"
            #         -var"##alpha#470" * var"##tmp#476"
            #     else
            #         var"##alpha#470" * var"##tmp#476"
            #     end
        end
    end
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:158 =#
    return var"##st#459"
end

function BQCESubroutine.multi_broutine2x2!(st::AbstractVector{T} where T, ::Val{:YY}, locs::Locations)
    nlocs = length(locs)
    mask = (BQCESubroutine.Utilities.bmask)((YaoLocations.plain)(locs))
    step_1_l = 1 << (((YaoLocations.plain)(locs))[1] - 1)
    step_1_h = 1 << ((YaoLocations.plain)(locs))[1]
    alpha = (BQCESubroutine.Utilities.literal_pow)(Val{:im}(), nlocs)
    isodd_nlocs = isodd(nlocs)
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:157 =#
    for m_1 = 0:step_1_h:size(st, 1) - step_1_h, m_2 = m_1:(m_1 + step_1_l) - 1
        i = m_2 + 1
        j = (m_2 ⊻ mask) + 1
        st[i] = -alpha * st[j]
        #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:566 =#
        # if isodd(k)
        #     #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:567 =#
        #     st[i] = -alpha * st[j]
        #     #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:568 =#
        #     st[j] = if isodd_nlocs
        #             alpha * tmp
        #         else
        #             -alpha * tmp
        #         end
        # else
        #     #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:570 =#
        #     st[i] = alpha * st[j]
        #     #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:571 =#
        #     st[j] = if isodd_nlocs
        #             -alpha * tmp
        #         else
        #             alpha * tmp
        #         end
        # end
    end
    #= /home/roger/julia_code/BQCESubroutine/src/codegen/broutine.jl:158 =#
    return st
end

st = rand(ComplexF64, 1<<20)
@allocated multi_broutine2x2!(st, Val(:YY), Locations([1, 3]))

@code_warntype multi_broutine2x2!(st, Val(:YY), Locations((1, 3)))

literal_pow(Val{:im}(), 2)|>typeof