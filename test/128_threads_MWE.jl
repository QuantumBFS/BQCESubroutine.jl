# export JULIA_NUM_THREADS=128

using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations

function X_gate_loc_N_128_threads_MWE_version_1!(st::AbstractVector{T} where T, nqubits::Int)
    space = BQCESubroutine.bsubspace(nqubits, (nqubits,))
    var"##step_1_l#1030" = 1<<(nqubits-1)
    Threads.@threads for base in space
        for var"##idx#1027_1" in 0:0
            var"##I#1036_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(base, var"##idx#1027_1"), 1)
            var"##I#1036_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(base, var"##idx#1027_1"), var"##step_1_l#1030"), 1)
            var"##T#1037_1" = st[var"##I#1036_2"]
            var"##T#1037_2" = st[var"##I#1036_1"]
            st[var"##I#1036_1"] = var"##T#1037_1"
            st[var"##I#1036_2"] = var"##T#1037_2"
        end
    end
    return st
end

function X_gate_loc_N_128_threads_MWE_version_2!(var"##st#390"::AbstractVector{T} where T, ::Val{:X}, var"##locs#391"::YaoLocations.Locations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#392" = (YaoLocations.plain)(var"##locs#391")
                var"##nqubits#393" = (BQCESubroutine.log2i)(size(var"##st#390", 1))
                var"##nlocs_needed#394" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                var"##step_1_l#398" = 1 << (var"##plain_locs#392"[1] - 1)
                var"##step_1_h#399" = 1 << var"##plain_locs#392"[1]
            end
            begin
            end
            begin
                eval(Expr(:inbounds, true))
                local var"#505#val" = begin
                            begin
                                var"##m#397" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#393", var"##nlocs_needed#394"), 1))
                                #println(var"##nqubits#393", " ", var"##nlocs_needed#394", " ", var"##m#397")
                                Threads.@threads for var"##base#396" = (BQCESubroutine.bsubspace)(var"##nqubits#393", (1:var"##m#397"..., var"##plain_locs#392"...))
                                    for var"##idx#395_1" = 0:Base.FastMath.sub_fast(1 << var"##m#397", 1)
                                        #println(var"##base#396", " ", var"##idx#395_1")
                                        begin
                                            nothing
                                            begin
                                                var"##I#404_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#396", var"##idx#395_1"), 1)
                                                var"##I#404_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#396", var"##idx#395_1"), var"##step_1_l#398"), 1)
                                                var"##T#405_1" = var"##st#390"[var"##I#404_2"]
                                                var"##T#405_2" = var"##st#390"[var"##I#404_1"]
                                                var"##st#390"[var"##I#404_1"] = var"##T#405_1"
                                                var"##st#390"[var"##I#404_2"] = var"##T#405_2"
                                            end
                                        end
                                    end
                                end
                            end
                            return var"##st#390"
                        end
                eval(Expr(:inbounds, :pop))
                var"#505#val"
            end
        end
    end
    return var"##st#390"
end

Threads.nthreads()
@testset "N=$N" for N in 4:15
    loc = N
    st = rand(Float64, 1<<N);
    locs = BQCESubroutine.Locations(loc);
    #st0 = X_gate_loc_N_128_threads_MWE_version_1!(copy(st), N);
    st0 = X_gate_loc_N_128_threads_MWE_version_2!(copy(st), Val(:X), locs);
    st1 = broutine!(copy(st), [0 1; 1 0], locs);
    println("N=$N, loc=$loc, |err| = ", norm(st0-st1))
    @test st0 ≈ st1
end;
