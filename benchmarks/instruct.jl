using Test
using LinearAlgebra
using BQCESubroutine
using BQCESubroutine.Utilities
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using BQCESubroutine: ctrl_offset
using YaoArrayRegister
using BenchmarkTools

include(joinpath(dirname(dirname(pathof(BQCESubroutine))), "benchmarks", "sets.jl"))
using .BenchmarkSets

function improve(brt, inst)
    d = Dict()
    for k in keys(inst)
        d[k] = improve(brt[k], inst[k])
    end
    return d
end

function improve(brt::BenchmarkTools.Trial, inst::BenchmarkTools.Trial)
    return minimum(inst).time/minimum(brt).time
end

@benchmarkset "$N-bits" for N in 5:5:20
    @benchmarkset "$(1<<M)x$(1<<M)" for M in [1,2,3,4]
        U = rand(ComplexF64, 1<<M, 1<<M)

        locs = Locations(unique([1,2,3, N-1, N-2, N-3])[1:M])
        locs = sort(locs)
        ctrl = CtrlLocations(setdiff(1:N, locs.storage)[1])
        @info "generating generic benchmark N=$N M=$M"
        @info "parameters" locs ctrl
        @benchmarkset "vector" begin
            @bench "gate" broutine!(st, $U, $locs) setup=(st=rand(ComplexF64, 1 << $N))
            @bench "ctrl" broutine!(st, $U, $locs, $ctrl) setup=(st=rand(ComplexF64, 1 << $N))
        end

        @benchmarkset "matrix" begin
            @bench "gate" broutine!(st, $U, $locs) setup=(st=rand(ComplexF64, 100, 1 << $N))
            @bench "ctrl" broutine!(st, $U, $locs, $ctrl) setup=(st=rand(ComplexF64, 100, 1 << $N))
        end
    end
end

# tune!(SUITE;verbose=true)
# BenchmarkTools.save("params.json", params(SUITE));
loadparams!(SUITE, BenchmarkTools.load("params.json")[1], :evals, :samples)
broutine_results = run(SUITE; verbose = true, seconds = 10)

@benchmarkset "$N-bits" for N in 5:5:20
    @benchmarkset "$(1<<M)x$(1<<M)" for M in [1,2,3,4]
        U = rand(ComplexF64, 1<<M, 1<<M)

        locs = Locations(unique([1,2,3, N-1, N-2, N-3])[1:M])
        locs = sort(locs)
        ctrl = CtrlLocations(setdiff(1:N, locs.storage)[1])
        @info "generating generic benchmark N=$N M=$M"
        @info "parameters" locs ctrl
        @benchmarkset "vector" begin
            @bench "gate" instruct!(st, $U, $(Tuple(locs))) setup=(st=rand(ComplexF64, 1 << $N))
            @bench "ctrl" instruct!(st, $U, $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, )) setup=(st=rand(ComplexF64, 1 << $N))
        end

        @benchmarkset "matrix" begin
            @bench "gate" instruct!(st, $U, $(Tuple(locs))) setup=(st=transpose(rand(ComplexF64, 100, 1 << $N)))
            @bench "ctrl" instruct!(st, $U, $(Tuple(locs)), $(Tuple(ctrl.storage)), (1, )) setup=(st=transpose(rand(ComplexF64, 100, 1 << $N)))
        end
    end
end

# tune!(SUITE;verbose=true)
# BenchmarkTools.save("params.json", params(SUITE));
loadparams!(SUITE, BenchmarkTools.load("params.json")[1], :evals, :samples)
instruct_results = run(SUITE; verbose = true, seconds = 10)


d = improve(broutine_results, instruct_results)
xaxis = []
speedups = Float64[]
for k1 in keys(d), k2 in keys(d[k1]), k3 in keys(d[k1][k2]), k4 in keys(d[k1][k2][k3])
    r = d[k1][k2][k3][k4]
    @info "$k1-$k2-$k3-$k4"
    push!(speedups, r)
    push!(xaxis, "$k1-$k2-$k3-$k4")
end

using UnicodePlots
UnicodePlots.barplot(xaxis, speedups; xscale=log10)

@benchmarkset "$N-bits" for N in 5:5:20
    @benchmarkset "$G" for G in [:X, :Y, :Z, :H, :T, :S, :Sdag, :Tdag]
        @info "generating benchmark for $G gate"
        @benchmarkset "i=$i" for i in unique([1,2,3, N-1, N-2, N-3])
            locs = Locations(i)
            @bench "gate" broutine!(st, $(Val(G)), $locs) setup=(st=rand(ComplexF64, 1 << $N))
            
            locs = sort(Locations((i, mod1(i+2, N))))
            @bench "multi" broutine!(st, $(Val(G)), $locs) setup=(st=rand(ComplexF64, 1 << $N))
            
            locs = Locations(i)
            ctrl = CtrlLocations(mod1(i+1, N))
            @bench "ctrl" broutine!(st, $(Val(G)), $locs, $ctrl) setup=(st=rand(ComplexF64, 1 << $N))
        end
    end
end

@sync for k1 in keys(SUITE)
    for k2 in keys(SUITE[k1])
        for k3 in keys(SUITE[k1][k2])
            Threads.@spawn tune!(SUITE[k1][k2][k3]; verbose=true)
        end
    end
end

tune!(SUITE;verbose=true)
# BenchmarkTools.save("gate_params.json", params(SUITE));
loadparams!(SUITE, BenchmarkTools.load("gate_params.json")[1], :evals, :samples)
broutine_results = run(SUITE; verbose = true, seconds = 10)

@benchmarkset "$N-bits" for N in 5:5:20
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

loadparams!(SUITE, BenchmarkTools.load("gate_params.json")[1], :evals, :samples)
instruct_results = run(SUITE; verbose = true, seconds = 10)

d = improve(broutine_results, instruct_results)
xaxis = []
speedups = Float64[]
for k1 in keys(d), k2 in keys(d[k1]), k3 in keys(d[k1][k2]), k4 in keys(d[k1][k2][k3])
    r = d[k1][k2][k3][k4]
    if r < 1
        @info "$k1-$k2-$k3-$k4"
        push!(speedups, r)
        push!(xaxis, "$k1-$k2-$k3-$k4")
    end
end

using UnicodePlots
UnicodePlots.barplot(xaxis, speedups)

n = 20
locs = Locations(19)
@benchmark broutine!(st, Val(:Z), $locs) setup=(st=rand(ComplexF64, 1 << $n))
@benchmark instruct!(st, Val(:Z), $(Tuple(locs))) setup=(st=rand(ComplexF64, 1 << $n))
