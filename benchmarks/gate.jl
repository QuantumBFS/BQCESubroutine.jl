using Test
using LinearAlgebra
using BQCESubroutine
using BQCESubroutine.Utilities
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using BQCESubroutine: ctrl_offset
using YaoArrayRegister
using BenchmarkTools
using LoopVectorization

function broutine_z!(st::Vector{Complex{T}}, ::Val{:Z}, locs) where T
    step_1 = 1 << (plain(locs) - 1)
    step_2 = 1 << plain(locs)

    @inbounds for j in 0:step_2:size(st, 1)-step_1
        for i in j:j+step_1-1
            ST1 = st[i+1]
            ST2 = -st[i+step_1+1]
        
            st[i+1] = ST1
            st[i+step_1+1] = ST2
        end
    end
    return st
end

function broutine_z_expanded!(st::Vector{Complex{T}}, ::Val{:Z}, locs) where T
    step_1 = 1 << (plain(locs) - 1)
    step_2 = 1 << plain(locs)

    @inbounds for j in 0:step_2:size(st, 1)-step_1
        for i in j:16:j+step_1-1
            Base.Cartesian.@nexprs 16 k->begin
                ST1 = st[i+k]
                ST2 = -st[i+step_1+k]
            
                st[i+k] = ST1
                st[i+step_1+k] = ST2
            end
        end
    end
    return st
end

st=rand(ComplexF64, 1 << 20);
locs = Locations(10)
broutine_z!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), Val(:Z), locs)
broutine_z_avx!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), Val(:Z), locs)
broutine_z_expanded!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), Val(:Z), locs)
broutine_z_unroll!(copy(st), Val(:Z), locs) ≈ broutine!(copy(st), Val(:Z), locs)

@benchmark broutine!(st, Val(:Z), $locs) setup=(st=rand(ComplexF64, 1 << $n))
@benchmark broutine_z!(st, Val(:Z), $locs) setup=(st=rand(ComplexF64, 1 << $n))
@benchmark broutine_z_avx!(st, Val(:Z), $locs) setup=(st=rand(ComplexF64, 1 << $n))
@benchmark broutine_z_expanded!(st, Val(:Z), $locs) setup=(st=rand(ComplexF64, 1 << $n))
@benchmark broutine_z_unroll!(st, Val(:Z), $locs) setup=(st=rand(ComplexF64, 1 << $n))

step_1 = 2^(loc-1)
2^n - 2^(loc-1)

step_1 = 1 << 1
step_2 = 1 << 2

sz = 1 << 5
collect(0:4:sz-2)
31>>2
