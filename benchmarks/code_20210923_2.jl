using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations
using BQCESubroutine: threaded_basic_broutine!
using Polyester
using CPUSummary
using Static
using ArrayInterface


prog = 
quote
    function BQCESubroutine.broutine!(var"##st#788"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#789"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#789") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#788", Val{:PSWAP_test}(), var"##locs#789", θ)
                    return var"##st#788"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#789") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#788", Val{:PSWAP_test}(), var"##locs#789", θ)
                return var"##st#788"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#788"
    end
    function BQCESubroutine.basic_broutine!(var"##st#790"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#791"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#792" = (YaoLocations.plain)(var"##locs#791")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#792"[1] > var"##plain_locs#792"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#791" = Locations((var"##plain_locs#792"[2], var"##plain_locs#792"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#794" = (YaoLocations.plain)(var"##locs#791")
                    var"##step_1_l#795" = 1 << (var"##plain_locs#794"[1] - 1)
                    var"##step_1_h#796" = 1 << var"##plain_locs#794"[1]
                    var"##step_2_l#797" = 1 << (var"##plain_locs#794"[2] - 1)
                    var"##step_2_h#798" = 1 << var"##plain_locs#794"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#662#val" = begin
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#795", 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#793_1" = 0:var"##step_2_h#798":Base.FastMath.sub_fast(size(var"##st#790", 1), var"##step_2_h#798"), var"##m#793_2" = var"##m#793_1":var"##step_1_h#796":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#793_1", var"##step_2_l#797"), var"##step_1_h#796")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#799_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), 1)
                                                    var"##I#799_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), 1)
                                                    var"##I#799_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_2_l#797"), 1)
                                                    var"##I#799_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#800_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#799_1"])
                                                    var"##T#800_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#799_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#799_3"]))
                                                    var"##T#800_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#799_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#799_3"]))
                                                    var"##T#800_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#799_4"])
                                                    var"##st#790"[var"##I#799_1"] = var"##T#800_1"
                                                    var"##st#790"[var"##I#799_2"] = var"##T#800_2"
                                                    var"##st#790"[var"##I#799_3"] = var"##T#800_3"
                                                    var"##st#790"[var"##I#799_4"] = var"##T#800_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#790"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#795", 2)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#793_1" = 0:var"##step_2_h#798":Base.FastMath.sub_fast(size(var"##st#790", 1), var"##step_2_h#798"), var"##m#793_2" = var"##m#793_1":var"##step_1_h#796":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#793_1", var"##step_2_l#797"), var"##step_1_h#796")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#801_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), 1)
                                                    var"##I#801_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), 1)
                                                    var"##I#801_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_2_l#797"), 1)
                                                    var"##I#801_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#802_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#801_1"])
                                                    var"##T#802_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#801_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#801_3"]))
                                                    var"##T#802_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#801_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#801_3"]))
                                                    var"##T#802_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#801_4"])
                                                    var"##st#790"[var"##I#801_1"] = var"##T#802_1"
                                                    var"##st#790"[var"##I#801_2"] = var"##T#802_2"
                                                    var"##st#790"[var"##I#801_3"] = var"##T#802_3"
                                                    var"##st#790"[var"##I#801_4"] = var"##T#802_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#803_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), 1)
                                                    var"##I#803_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_1_l#795"), 1)
                                                    var"##I#803_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_2_l#797"), 1)
                                                    var"##I#803_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#804_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#803_1"])
                                                    var"##T#804_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#803_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#803_3"]))
                                                    var"##T#804_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#803_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#803_3"]))
                                                    var"##T#804_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#803_4"])
                                                    var"##st#790"[var"##I#803_1"] = var"##T#804_1"
                                                    var"##st#790"[var"##I#803_2"] = var"##T#804_2"
                                                    var"##st#790"[var"##I#803_3"] = var"##T#804_3"
                                                    var"##st#790"[var"##I#803_4"] = var"##T#804_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#790"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#795", 4)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#793_1" = 0:var"##step_2_h#798":Base.FastMath.sub_fast(size(var"##st#790", 1), var"##step_2_h#798"), var"##m#793_2" = var"##m#793_1":var"##step_1_h#796":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#793_1", var"##step_2_l#797"), var"##step_1_h#796")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#805_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), 1)
                                                    var"##I#805_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), 1)
                                                    var"##I#805_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_2_l#797"), 1)
                                                    var"##I#805_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#806_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#805_1"])
                                                    var"##T#806_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#805_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#805_3"]))
                                                    var"##T#806_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#805_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#805_3"]))
                                                    var"##T#806_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#805_4"])
                                                    var"##st#790"[var"##I#805_1"] = var"##T#806_1"
                                                    var"##st#790"[var"##I#805_2"] = var"##T#806_2"
                                                    var"##st#790"[var"##I#805_3"] = var"##T#806_3"
                                                    var"##st#790"[var"##I#805_4"] = var"##T#806_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#807_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), 1)
                                                    var"##I#807_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_1_l#795"), 1)
                                                    var"##I#807_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_2_l#797"), 1)
                                                    var"##I#807_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#808_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#807_1"])
                                                    var"##T#808_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#807_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#807_3"]))
                                                    var"##T#808_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#807_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#807_3"]))
                                                    var"##T#808_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#807_4"])
                                                    var"##st#790"[var"##I#807_1"] = var"##T#808_1"
                                                    var"##st#790"[var"##I#807_2"] = var"##T#808_2"
                                                    var"##st#790"[var"##I#807_3"] = var"##T#808_3"
                                                    var"##st#790"[var"##I#807_4"] = var"##T#808_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#809_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), 1)
                                                    var"##I#809_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), var"##step_1_l#795"), 1)
                                                    var"##I#809_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), var"##step_2_l#797"), 1)
                                                    var"##I#809_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#810_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#809_1"])
                                                    var"##T#810_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#809_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#809_3"]))
                                                    var"##T#810_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#809_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#809_3"]))
                                                    var"##T#810_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#809_4"])
                                                    var"##st#790"[var"##I#809_1"] = var"##T#810_1"
                                                    var"##st#790"[var"##I#809_2"] = var"##T#810_2"
                                                    var"##st#790"[var"##I#809_3"] = var"##T#810_3"
                                                    var"##st#790"[var"##I#809_4"] = var"##T#810_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#811_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), 1)
                                                    var"##I#811_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), var"##step_1_l#795"), 1)
                                                    var"##I#811_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), var"##step_2_l#797"), 1)
                                                    var"##I#811_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#812_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#811_1"])
                                                    var"##T#812_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#811_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#811_3"]))
                                                    var"##T#812_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#811_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#811_3"]))
                                                    var"##T#812_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#811_4"])
                                                    var"##st#790"[var"##I#811_1"] = var"##T#812_1"
                                                    var"##st#790"[var"##I#811_2"] = var"##T#812_2"
                                                    var"##st#790"[var"##I#811_3"] = var"##T#812_3"
                                                    var"##st#790"[var"##I#811_4"] = var"##T#812_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#790"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#795", 8)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#793_1" = 0:var"##step_2_h#798":Base.FastMath.sub_fast(size(var"##st#790", 1), var"##step_2_h#798"), var"##m#793_2" = var"##m#793_1":var"##step_1_h#796":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#793_1", var"##step_2_l#797"), var"##step_1_h#796")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#813_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), 1)
                                                    var"##I#813_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), 1)
                                                    var"##I#813_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_2_l#797"), 1)
                                                    var"##I#813_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 0), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#814_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#813_1"])
                                                    var"##T#814_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#813_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#813_3"]))
                                                    var"##T#814_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#813_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#813_3"]))
                                                    var"##T#814_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#813_4"])
                                                    var"##st#790"[var"##I#813_1"] = var"##T#814_1"
                                                    var"##st#790"[var"##I#813_2"] = var"##T#814_2"
                                                    var"##st#790"[var"##I#813_3"] = var"##T#814_3"
                                                    var"##st#790"[var"##I#813_4"] = var"##T#814_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#815_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), 1)
                                                    var"##I#815_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_1_l#795"), 1)
                                                    var"##I#815_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_2_l#797"), 1)
                                                    var"##I#815_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 1), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#816_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#815_1"])
                                                    var"##T#816_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#815_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#815_3"]))
                                                    var"##T#816_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#815_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#815_3"]))
                                                    var"##T#816_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#815_4"])
                                                    var"##st#790"[var"##I#815_1"] = var"##T#816_1"
                                                    var"##st#790"[var"##I#815_2"] = var"##T#816_2"
                                                    var"##st#790"[var"##I#815_3"] = var"##T#816_3"
                                                    var"##st#790"[var"##I#815_4"] = var"##T#816_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#817_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), 1)
                                                    var"##I#817_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), var"##step_1_l#795"), 1)
                                                    var"##I#817_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), var"##step_2_l#797"), 1)
                                                    var"##I#817_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 2), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#818_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#817_1"])
                                                    var"##T#818_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#817_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#817_3"]))
                                                    var"##T#818_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#817_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#817_3"]))
                                                    var"##T#818_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#817_4"])
                                                    var"##st#790"[var"##I#817_1"] = var"##T#818_1"
                                                    var"##st#790"[var"##I#817_2"] = var"##T#818_2"
                                                    var"##st#790"[var"##I#817_3"] = var"##T#818_3"
                                                    var"##st#790"[var"##I#817_4"] = var"##T#818_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#819_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), 1)
                                                    var"##I#819_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), var"##step_1_l#795"), 1)
                                                    var"##I#819_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), var"##step_2_l#797"), 1)
                                                    var"##I#819_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 3), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#820_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#819_1"])
                                                    var"##T#820_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#819_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#819_3"]))
                                                    var"##T#820_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#819_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#819_3"]))
                                                    var"##T#820_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#819_4"])
                                                    var"##st#790"[var"##I#819_1"] = var"##T#820_1"
                                                    var"##st#790"[var"##I#819_2"] = var"##T#820_2"
                                                    var"##st#790"[var"##I#819_3"] = var"##T#820_3"
                                                    var"##st#790"[var"##I#819_4"] = var"##T#820_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#821_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 4), 1)
                                                    var"##I#821_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 4), var"##step_1_l#795"), 1)
                                                    var"##I#821_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 4), var"##step_2_l#797"), 1)
                                                    var"##I#821_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 4), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#822_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#821_1"])
                                                    var"##T#822_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#821_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#821_3"]))
                                                    var"##T#822_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#821_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#821_3"]))
                                                    var"##T#822_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#821_4"])
                                                    var"##st#790"[var"##I#821_1"] = var"##T#822_1"
                                                    var"##st#790"[var"##I#821_2"] = var"##T#822_2"
                                                    var"##st#790"[var"##I#821_3"] = var"##T#822_3"
                                                    var"##st#790"[var"##I#821_4"] = var"##T#822_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#823_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 5), 1)
                                                    var"##I#823_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 5), var"##step_1_l#795"), 1)
                                                    var"##I#823_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 5), var"##step_2_l#797"), 1)
                                                    var"##I#823_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 5), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#824_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#823_1"])
                                                    var"##T#824_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#823_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#823_3"]))
                                                    var"##T#824_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#823_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#823_3"]))
                                                    var"##T#824_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#823_4"])
                                                    var"##st#790"[var"##I#823_1"] = var"##T#824_1"
                                                    var"##st#790"[var"##I#823_2"] = var"##T#824_2"
                                                    var"##st#790"[var"##I#823_3"] = var"##T#824_3"
                                                    var"##st#790"[var"##I#823_4"] = var"##T#824_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#825_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 6), 1)
                                                    var"##I#825_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 6), var"##step_1_l#795"), 1)
                                                    var"##I#825_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 6), var"##step_2_l#797"), 1)
                                                    var"##I#825_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 6), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#826_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#825_1"])
                                                    var"##T#826_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#825_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#825_3"]))
                                                    var"##T#826_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#825_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#825_3"]))
                                                    var"##T#826_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#825_4"])
                                                    var"##st#790"[var"##I#825_1"] = var"##T#826_1"
                                                    var"##st#790"[var"##I#825_2"] = var"##T#826_2"
                                                    var"##st#790"[var"##I#825_3"] = var"##T#826_3"
                                                    var"##st#790"[var"##I#825_4"] = var"##T#826_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#827_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 7), 1)
                                                    var"##I#827_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 7), var"##step_1_l#795"), 1)
                                                    var"##I#827_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 7), var"##step_2_l#797"), 1)
                                                    var"##I#827_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_2", 7), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#828_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#827_1"])
                                                    var"##T#828_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#827_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#827_3"]))
                                                    var"##T#828_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#827_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#827_3"]))
                                                    var"##T#828_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#827_4"])
                                                    var"##st#790"[var"##I#827_1"] = var"##T#828_1"
                                                    var"##st#790"[var"##I#827_2"] = var"##T#828_2"
                                                    var"##st#790"[var"##I#827_3"] = var"##T#828_3"
                                                    var"##st#790"[var"##I#827_4"] = var"##T#828_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#790"
                                    end
                                end
                                for var"##m#793_1" = 0:var"##step_2_h#798":Base.FastMath.sub_fast(size(var"##st#790", 1), var"##step_2_h#798"), var"##m#793_2" = var"##m#793_1":var"##step_1_h#796":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#793_1", var"##step_2_l#797"), var"##step_1_h#796")
                                    for var"##m#793_3" = var"##m#793_2":8:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#793_2", var"##step_1_l#795"), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                        begin
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#829_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 0), 1)
                                                    var"##I#829_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 0), var"##step_1_l#795"), 1)
                                                    var"##I#829_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 0), var"##step_2_l#797"), 1)
                                                    var"##I#829_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 0), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#830_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#829_1"])
                                                    var"##T#830_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#829_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#829_3"]))
                                                    var"##T#830_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#829_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#829_3"]))
                                                    var"##T#830_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#829_4"])
                                                    var"##st#790"[var"##I#829_1"] = var"##T#830_1"
                                                    var"##st#790"[var"##I#829_2"] = var"##T#830_2"
                                                    var"##st#790"[var"##I#829_3"] = var"##T#830_3"
                                                    var"##st#790"[var"##I#829_4"] = var"##T#830_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#831_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 1), 1)
                                                    var"##I#831_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 1), var"##step_1_l#795"), 1)
                                                    var"##I#831_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 1), var"##step_2_l#797"), 1)
                                                    var"##I#831_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 1), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#832_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#831_1"])
                                                    var"##T#832_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#831_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#831_3"]))
                                                    var"##T#832_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#831_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#831_3"]))
                                                    var"##T#832_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#831_4"])
                                                    var"##st#790"[var"##I#831_1"] = var"##T#832_1"
                                                    var"##st#790"[var"##I#831_2"] = var"##T#832_2"
                                                    var"##st#790"[var"##I#831_3"] = var"##T#832_3"
                                                    var"##st#790"[var"##I#831_4"] = var"##T#832_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#833_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 2), 1)
                                                    var"##I#833_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 2), var"##step_1_l#795"), 1)
                                                    var"##I#833_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 2), var"##step_2_l#797"), 1)
                                                    var"##I#833_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 2), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#834_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#833_1"])
                                                    var"##T#834_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#833_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#833_3"]))
                                                    var"##T#834_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#833_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#833_3"]))
                                                    var"##T#834_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#833_4"])
                                                    var"##st#790"[var"##I#833_1"] = var"##T#834_1"
                                                    var"##st#790"[var"##I#833_2"] = var"##T#834_2"
                                                    var"##st#790"[var"##I#833_3"] = var"##T#834_3"
                                                    var"##st#790"[var"##I#833_4"] = var"##T#834_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#835_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 3), 1)
                                                    var"##I#835_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 3), var"##step_1_l#795"), 1)
                                                    var"##I#835_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 3), var"##step_2_l#797"), 1)
                                                    var"##I#835_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 3), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#836_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#835_1"])
                                                    var"##T#836_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#835_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#835_3"]))
                                                    var"##T#836_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#835_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#835_3"]))
                                                    var"##T#836_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#835_4"])
                                                    var"##st#790"[var"##I#835_1"] = var"##T#836_1"
                                                    var"##st#790"[var"##I#835_2"] = var"##T#836_2"
                                                    var"##st#790"[var"##I#835_3"] = var"##T#836_3"
                                                    var"##st#790"[var"##I#835_4"] = var"##T#836_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#837_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 4), 1)
                                                    var"##I#837_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 4), var"##step_1_l#795"), 1)
                                                    var"##I#837_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 4), var"##step_2_l#797"), 1)
                                                    var"##I#837_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 4), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#838_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#837_1"])
                                                    var"##T#838_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#837_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#837_3"]))
                                                    var"##T#838_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#837_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#837_3"]))
                                                    var"##T#838_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#837_4"])
                                                    var"##st#790"[var"##I#837_1"] = var"##T#838_1"
                                                    var"##st#790"[var"##I#837_2"] = var"##T#838_2"
                                                    var"##st#790"[var"##I#837_3"] = var"##T#838_3"
                                                    var"##st#790"[var"##I#837_4"] = var"##T#838_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#839_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 5), 1)
                                                    var"##I#839_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 5), var"##step_1_l#795"), 1)
                                                    var"##I#839_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 5), var"##step_2_l#797"), 1)
                                                    var"##I#839_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 5), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#840_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#839_1"])
                                                    var"##T#840_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#839_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#839_3"]))
                                                    var"##T#840_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#839_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#839_3"]))
                                                    var"##T#840_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#839_4"])
                                                    var"##st#790"[var"##I#839_1"] = var"##T#840_1"
                                                    var"##st#790"[var"##I#839_2"] = var"##T#840_2"
                                                    var"##st#790"[var"##I#839_3"] = var"##T#840_3"
                                                    var"##st#790"[var"##I#839_4"] = var"##T#840_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#841_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 6), 1)
                                                    var"##I#841_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 6), var"##step_1_l#795"), 1)
                                                    var"##I#841_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 6), var"##step_2_l#797"), 1)
                                                    var"##I#841_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 6), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#842_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#841_1"])
                                                    var"##T#842_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#841_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#841_3"]))
                                                    var"##T#842_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#841_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#841_3"]))
                                                    var"##T#842_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#841_4"])
                                                    var"##st#790"[var"##I#841_1"] = var"##T#842_1"
                                                    var"##st#790"[var"##I#841_2"] = var"##T#842_2"
                                                    var"##st#790"[var"##I#841_3"] = var"##T#842_3"
                                                    var"##st#790"[var"##I#841_4"] = var"##T#842_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#843_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 7), 1)
                                                    var"##I#843_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 7), var"##step_1_l#795"), 1)
                                                    var"##I#843_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 7), var"##step_2_l#797"), 1)
                                                    var"##I#843_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#793_3", 7), var"##step_1_l#795"), var"##step_2_l#797"), 1)
                                                    var"##T#844_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#790"[var"##I#843_1"])
                                                    var"##T#844_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#790"[var"##I#843_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#790"[var"##I#843_3"]))
                                                    var"##T#844_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#790"[var"##I#843_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#790"[var"##I#843_3"]))
                                                    var"##T#844_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#790"[var"##I#843_4"])
                                                    var"##st#790"[var"##I#843_1"] = var"##T#844_1"
                                                    var"##st#790"[var"##I#843_2"] = var"##T#844_2"
                                                    var"##st#790"[var"##I#843_3"] = var"##T#844_3"
                                                    var"##st#790"[var"##I#843_4"] = var"##T#844_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#662#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#790"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#847"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#848"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#849" = (YaoLocations.plain)(var"##locs#848")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#849"[1] > var"##plain_locs#849"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#848" = Locations((var"##plain_locs#849"[2], var"##plain_locs#849"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#850" = (YaoLocations.plain)(var"##locs#848")
                    var"##nqubits#851" = (BQCESubroutine.log2i)(size(var"##st#847", 1))
                    var"##nlocs_needed#852" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#856" = 1 << (var"##plain_locs#850"[1] - 1)
                    var"##step_1_h#857" = 1 << var"##plain_locs#850"[1]
                    var"##step_2_l#858" = 1 << (var"##plain_locs#850"[2] - 1)
                    var"##step_2_h#859" = 1 << var"##plain_locs#850"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#663#val" = begin
                                if var"##nlocs_needed#852" ≤ Base.FastMath.sub_fast(var"##nqubits#851", var"##plain_locs#850"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#856", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#853_1" = 0:var"##step_2_h#859":Base.FastMath.sub_fast(size(var"##st#847", 1), var"##step_2_h#859")
                                                                for var"##idx#853_2" = var"##idx#853_1":var"##step_1_h#857":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#853_1", var"##step_2_l#858"), var"##step_1_h#857")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#860_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_2", 0), 1)
                                                                            var"##I#860_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_2", 0), var"##step_1_l#856"), 1)
                                                                            var"##I#860_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_2", 0), var"##step_2_l#858"), 1)
                                                                            var"##I#860_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_2", 0), var"##step_1_l#856"), var"##step_2_l#858"), 1)
                                                                            var"##T#861_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#847"[var"##I#860_1"])
                                                                            var"##T#861_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#847"[var"##I#860_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#847"[var"##I#860_3"]))
                                                                            var"##T#861_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#847"[var"##I#860_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#847"[var"##I#860_3"]))
                                                                            var"##T#861_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#847"[var"##I#860_4"])
                                                                            var"##st#847"[var"##I#860_1"] = var"##T#861_1"
                                                                            var"##st#847"[var"##I#860_2"] = var"##T#861_2"
                                                                            var"##st#847"[var"##I#860_3"] = var"##T#861_3"
                                                                            var"##st#847"[var"##I#860_4"] = var"##T#861_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                            begin
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                                (var"##inner##loop##", var"#664###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#859":Base.FastMath.sub_fast(size(var"##st#847", static(1)), var"##step_2_h#859"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#665###ITER_LENG##" = (ArrayInterface.static_length)(var"#664###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#666###LOOP_STEP##" = (ArrayInterface.static_step)(var"#664###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#667###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#664###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#857#1111", var"####step_2_l#858#1112", var"####step_1_l#856#1115", var"####hoisted#781#1119", var"####st#847#1120", var"####hoisted#782#1122", var"####hoisted#783#1123", var"####hoisted#784#1125", var"####hoisted#785#1126", var"####hoisted#786#1128"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#672#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#853_1#1109" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#853_2#1110" = var"####idx#853_1#1109":var"####step_1_h#857#1111":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#853_1#1109", var"####step_2_l#858#1112"), var"####step_1_h#857#1111")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        var"####I#860_1#1113" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_2#1110", 0), 1)
                                                                                                                        var"####I#860_2#1114" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_2#1110", 0), var"####step_1_l#856#1115"), 1)
                                                                                                                        var"####I#860_3#1116" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_2#1110", 0), var"####step_2_l#858#1112"), 1)
                                                                                                                        var"####I#860_4#1117" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_2#1110", 0), var"####step_1_l#856#1115"), var"####step_2_l#858#1112"), 1)
                                                                                                                        var"####T#861_1#1118" = Base.FastMath.mul_fast(var"####hoisted#781#1119", var"####st#847#1120"[var"####I#860_1#1113"])
                                                                                                                        var"####T#861_2#1121" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1122", var"####st#847#1120"[var"####I#860_2#1114"]), Base.FastMath.mul_fast(var"####hoisted#783#1123", var"####st#847#1120"[var"####I#860_3#1116"]))
                                                                                                                        var"####T#861_3#1124" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1125", var"####st#847#1120"[var"####I#860_2#1114"]), Base.FastMath.mul_fast(var"####hoisted#785#1126", var"####st#847#1120"[var"####I#860_3#1116"]))
                                                                                                                        var"####T#861_4#1127" = Base.FastMath.mul_fast(var"####hoisted#786#1128", var"####st#847#1120"[var"####I#860_4#1117"])
                                                                                                                        var"####st#847#1120"[var"####I#860_1#1113"] = var"####T#861_1#1118"
                                                                                                                        var"####st#847#1120"[var"####I#860_2#1114"] = var"####T#861_2#1121"
                                                                                                                        var"####st#847#1120"[var"####I#860_3#1116"] = var"####T#861_3#1124"
                                                                                                                        var"####st#847#1120"[var"####I#860_4#1117"] = var"####T#861_4#1127"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#672#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#665###ITER_LENG##", Polyester.min(var"#665###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#667###LOOPOFFSET##", var"#666###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#857", var"##step_2_l#858", var"##step_1_l#856", var"##hoisted#781", var"##st#847", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#847"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#853_1" = 0:var"##step_2_h#859":Base.FastMath.sub_fast(size(var"##st#847", 1), var"##step_2_h#859")
                                                        for var"##idx#853_2" = var"##idx#853_1":var"##step_1_h#857":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#853_1", var"##step_2_l#858"), var"##step_1_h#857")
                                                            for var"##idx#853_3" = var"##idx#853_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#853_2", var"##step_1_l#856"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#862_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_3", 0), 1)
                                                                            var"##I#862_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_3", 0), var"##step_1_l#856"), 1)
                                                                            var"##I#862_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_3", 0), var"##step_2_l#858"), 1)
                                                                            var"##I#862_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#853_3", 0), var"##step_1_l#856"), var"##step_2_l#858"), 1)
                                                                            var"##T#863_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#847"[var"##I#862_1"])
                                                                            var"##T#863_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#847"[var"##I#862_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#847"[var"##I#862_3"]))
                                                                            var"##T#863_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#847"[var"##I#862_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#847"[var"##I#862_3"]))
                                                                            var"##T#863_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#847"[var"##I#862_4"])
                                                                            var"##st#847"[var"##I#862_1"] = var"##T#863_1"
                                                                            var"##st#847"[var"##I#862_2"] = var"##T#863_2"
                                                                            var"##st#847"[var"##I#862_3"] = var"##T#863_3"
                                                                            var"##st#847"[var"##I#862_4"] = var"##T#863_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                    begin
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                        (var"##inner##loop##", var"#673###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#859":Base.FastMath.sub_fast(size(var"##st#847", static(1)), var"##step_2_h#859"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#674###ITER_LENG##" = (ArrayInterface.static_length)(var"#673###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#675###LOOP_STEP##" = (ArrayInterface.static_step)(var"#673###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#676###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#673###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#857#1131", var"####step_2_l#858#1132", var"####step_1_l#856#1134", var"####hoisted#781#1140", var"####st#847#1141", var"####hoisted#782#1143", var"####hoisted#783#1144", var"####hoisted#784#1146", var"####hoisted#785#1147", var"####hoisted#786#1149"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#681#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#853_1#1129" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#853_2#1130" = var"####idx#853_1#1129":var"####step_1_h#857#1131":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#853_1#1129", var"####step_2_l#858#1132"), var"####step_1_h#857#1131")
                                                                                                        for var"####idx#853_3#1133" = var"####idx#853_2#1130":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#853_2#1130", var"####step_1_l#856#1134"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        var"####I#862_1#1135" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_3#1133", 0), 1)
                                                                                                                        var"####I#862_2#1136" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_3#1133", 0), var"####step_1_l#856#1134"), 1)
                                                                                                                        var"####I#862_3#1137" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_3#1133", 0), var"####step_2_l#858#1132"), 1)
                                                                                                                        var"####I#862_4#1138" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#853_3#1133", 0), var"####step_1_l#856#1134"), var"####step_2_l#858#1132"), 1)
                                                                                                                        var"####T#863_1#1139" = Base.FastMath.mul_fast(var"####hoisted#781#1140", var"####st#847#1141"[var"####I#862_1#1135"])
                                                                                                                        var"####T#863_2#1142" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1143", var"####st#847#1141"[var"####I#862_2#1136"]), Base.FastMath.mul_fast(var"####hoisted#783#1144", var"####st#847#1141"[var"####I#862_3#1137"]))
                                                                                                                        var"####T#863_3#1145" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1146", var"####st#847#1141"[var"####I#862_2#1136"]), Base.FastMath.mul_fast(var"####hoisted#785#1147", var"####st#847#1141"[var"####I#862_3#1137"]))
                                                                                                                        var"####T#863_4#1148" = Base.FastMath.mul_fast(var"####hoisted#786#1149", var"####st#847#1141"[var"####I#862_4#1138"])
                                                                                                                        var"####st#847#1141"[var"####I#862_1#1135"] = var"####T#863_1#1139"
                                                                                                                        var"####st#847#1141"[var"####I#862_2#1136"] = var"####T#863_2#1142"
                                                                                                                        var"####st#847#1141"[var"####I#862_3#1137"] = var"####T#863_3#1145"
                                                                                                                        var"####st#847#1141"[var"####I#862_4#1138"] = var"####T#863_4#1148"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#681#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#674###ITER_LENG##", Polyester.min(var"#674###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#676###LOOPOFFSET##", var"#675###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#857", var"##step_2_l#858", var"##step_1_l#856", var"##hoisted#781", var"##st#847", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#847"
                                end
                                if var"##nlocs_needed#852" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#851", var"##plain_locs#850"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:502 =#
                                    var"##m#855" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#851", var"##nlocs_needed#852"), 2)######1
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#856", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#683#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#682#range" = (BQCESubroutine.bsubspace)(var"##nqubits#851", (1:var"##m#855"..., var"##plain_locs#850"[1], var"##plain_locs#850"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#683#threadsfor_fun"(var"#695#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#687#r" = var"#682#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#688#lenr" = Base.Threads.length(var"#687#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#695#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#689#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#690#len", var"#691#rem") = (var"#688#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#689#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#690#len", var"#691#rem") = Base.Threads.divrem(var"#688#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#690#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#689#tid" > var"#691#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#690#len", var"#691#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#692#f" = Base.Threads.firstindex(var"#687#r") + (var"#689#tid" - 1) * var"#690#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#693#l" = (var"#692#f" + var"#690#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#691#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#689#tid" <= var"#691#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#692#f" = var"#692#f" + (var"#689#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#693#l" = var"#693#l" + var"#689#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#692#f" = var"#692#f" + var"#691#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#693#l" = var"#693#l" + var"#691#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#694#i" = var"#692#f":var"#693#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#854" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#696#val" = var"#687#r"[var"#694#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#696#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                #for var"##idx#853_2" = var"##idx#853_1":var"##step_1_h#857":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#853_1", var"##step_2_l#858"), var"##step_1_h#857")
                                                                for var"##idx#853_2" = var"##base#854":var"##step_1_h#857":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##base#854", var"##step_2_l#858"), var"##step_1_h#857")
                                                                    begin
                                                                        #println(var"#682#range")
                                                                        println(var"##base#854", " ", var"##idx#853_2")
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#864_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_2", 0)), 1)
                                                                            var"##I#864_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_2", 0)), var"##step_1_l#856"), 1)
                                                                            var"##I#864_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_2", 0)), var"##step_2_l#858"), 1)
                                                                            var"##I#864_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_2", 0)), var"##step_1_l#856"), var"##step_2_l#858"), 1)
                                                                            var"##T#865_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#847"[var"##I#864_1"])
                                                                            var"##T#865_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#847"[var"##I#864_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#847"[var"##I#864_3"]))
                                                                            var"##T#865_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#847"[var"##I#864_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#847"[var"##I#864_3"]))
                                                                            var"##T#865_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#847"[var"##I#864_4"])
                                                                            var"##st#847"[var"##I#864_1"] = var"##T#865_1"
                                                                            var"##st#847"[var"##I#864_2"] = var"##T#865_2"
                                                                            var"##st#847"[var"##I#864_3"] = var"##T#865_3"
                                                                            var"##st#847"[var"##I#864_4"] = var"##T#865_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#683#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#683#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#847"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#698#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#697#range" = (BQCESubroutine.bsubspace)(var"##nqubits#851", (1:var"##m#855"..., var"##plain_locs#850"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#698#threadsfor_fun"(var"#710#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#702#r" = var"#697#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#703#lenr" = Base.Threads.length(var"#702#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#710#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#704#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#705#len", var"#706#rem") = (var"#703#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#704#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#705#len", var"#706#rem") = Base.Threads.divrem(var"#703#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#705#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#704#tid" > var"#706#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#705#len", var"#706#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#707#f" = Base.Threads.firstindex(var"#702#r") + (var"#704#tid" - 1) * var"#705#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#708#l" = (var"#707#f" + var"#705#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#706#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#704#tid" <= var"#706#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#707#f" = var"#707#f" + (var"#704#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#708#l" = var"#708#l" + var"#704#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#707#f" = var"#707#f" + var"#706#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#708#l" = var"#708#l" + var"#706#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#709#i" = var"#707#f":var"#708#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#854" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#711#val" = var"#702#r"[var"#709#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#711#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#853_2" = var"##idx#853_1":var"##step_1_h#857":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#853_1", var"##step_2_l#858"), var"##step_1_h#857")
                                                            for var"##idx#853_3" = var"##idx#853_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#853_2", var"##step_1_l#856"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#866_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_3", 0)), 1)
                                                                            var"##I#866_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_3", 0)), var"##step_1_l#856"), 1)
                                                                            var"##I#866_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_3", 0)), var"##step_2_l#858"), 1)
                                                                            var"##I#866_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", Base.FastMath.add_fast(var"##idx#853_3", 0)), var"##step_1_l#856"), var"##step_2_l#858"), 1)
                                                                            var"##T#867_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#847"[var"##I#866_1"])
                                                                            var"##T#867_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#847"[var"##I#866_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#847"[var"##I#866_3"]))
                                                                            var"##T#867_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#847"[var"##I#866_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#847"[var"##I#866_3"]))
                                                                            var"##T#867_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#847"[var"##I#866_4"])
                                                                            var"##st#847"[var"##I#866_1"] = var"##T#867_1"
                                                                            var"##st#847"[var"##I#866_2"] = var"##T#867_2"
                                                                            var"##st#847"[var"##I#866_3"] = var"##T#867_3"
                                                                            var"##st#847"[var"##I#866_4"] = var"##T#867_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            #= threadingconstructs.jl:85 =#
                                            if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                #= threadingconstructs.jl:86 =#
                                                (Base.Threads.Base).invokelatest(var"#698#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#698#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    return var"##st#847"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:510 =#
                                    var"##m#855" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#851", var"##nlocs_needed#852"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#713#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#712#range" = (BQCESubroutine.bsubspace)(var"##nqubits#851", (1:var"##m#855"..., var"##plain_locs#850"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#713#threadsfor_fun"(var"#725#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#717#r" = var"#712#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#718#lenr" = Base.Threads.length(var"#717#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#725#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#719#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#720#len", var"#721#rem") = (var"#718#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#719#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#720#len", var"#721#rem") = Base.Threads.divrem(var"#718#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#720#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#719#tid" > var"#721#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#720#len", var"#721#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#722#f" = Base.Threads.firstindex(var"#717#r") + (var"#719#tid" - 1) * var"#720#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#723#l" = (var"#722#f" + var"#720#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#721#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#719#tid" <= var"#721#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#722#f" = var"#722#f" + (var"#719#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#723#l" = var"#723#l" + var"#719#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#722#f" = var"#722#f" + var"#721#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#723#l" = var"#723#l" + var"#721#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#724#i" = var"#722#f":var"#723#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#854" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#726#val" = var"#717#r"[var"#724#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#726#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                                        for var"##idx#853_1" = 0:Base.FastMath.sub_fast(1 << var"##m#855", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                begin
                                                                    var"##I#868_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", var"##idx#853_1"), 1)
                                                                    var"##I#868_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", var"##idx#853_1"), var"##step_1_l#856"), 1)
                                                                    var"##I#868_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", var"##idx#853_1"), var"##step_2_l#858"), 1)
                                                                    var"##I#868_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#854", var"##idx#853_1"), var"##step_1_l#856"), var"##step_2_l#858"), 1)
                                                                    var"##T#869_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#847"[var"##I#868_1"])
                                                                    var"##T#869_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#847"[var"##I#868_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#847"[var"##I#868_3"]))
                                                                    var"##T#869_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#847"[var"##I#868_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#847"[var"##I#868_3"]))
                                                                    var"##T#869_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#847"[var"##I#868_4"])
                                                                    var"##st#847"[var"##I#868_1"] = var"##T#869_1"
                                                                    var"##st#847"[var"##I#868_2"] = var"##T#869_2"
                                                                    var"##st#847"[var"##I#868_3"] = var"##T#869_3"
                                                                    var"##st#847"[var"##I#868_4"] = var"##T#869_4"
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        #= threadingconstructs.jl:85 =#
                                        if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                            #= threadingconstructs.jl:86 =#
                                            (Base.Threads.Base).invokelatest(var"#713#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#713#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#847"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#663#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#847"
    end
    function BQCESubroutine.broutine!(var"##st#870"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#871"::Locations, var"##ctrl#787"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#871") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#870", Val{:PSWAP_test}(), var"##locs#871", var"##ctrl#787", θ)
                    return var"##st#870"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#871") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#870", Val{:PSWAP_test}(), var"##locs#871", var"##ctrl#787", θ)
                return var"##st#870"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#870"
    end
    function BQCESubroutine.basic_broutine!(var"##st#872"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#873"::Locations, var"##ctrl#787"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#874" = (YaoLocations.plain)(var"##locs#873")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#874"[1] > var"##plain_locs#874"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#873" = Locations((var"##plain_locs#874"[2], var"##plain_locs#874"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#876" = (YaoLocations.plain)(var"##locs#873")
                    var"##step_1_l#877" = 1 << (var"##plain_locs#876"[1] - 1)
                    var"##step_1_h#878" = 1 << var"##plain_locs#876"[1]
                    var"##step_2_l#879" = 1 << (var"##plain_locs#876"[2] - 1)
                    var"##step_2_h#880" = 1 << var"##plain_locs#876"[2]
                    var"##ctrl_mask#883" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#787"))
                    var"##flag_mask#884" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#787")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#727#val" = begin
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#877", 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#875_1" = 0:var"##step_2_h#880":Base.FastMath.sub_fast(size(var"##st#872", 1), var"##step_2_h#880"), var"##m#875_2" = var"##m#875_1":var"##step_1_h#878":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#875_1", var"##step_2_l#879"), var"##step_1_h#878")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 0), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#881_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), 1)
                                                    var"##I#881_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), 1)
                                                    var"##I#881_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_2_l#879"), 1)
                                                    var"##I#881_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#882_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#881_1"])
                                                    var"##T#882_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#881_3"]))
                                                    var"##T#882_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#881_3"]))
                                                    var"##T#882_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#881_4"])
                                                    var"##st#872"[var"##I#881_1"] = var"##T#882_1"
                                                    var"##st#872"[var"##I#881_2"] = var"##T#882_2"
                                                    var"##st#872"[var"##I#881_3"] = var"##T#882_3"
                                                    var"##st#872"[var"##I#881_4"] = var"##T#882_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#872"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#877", 2)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#875_1" = 0:var"##step_2_h#880":Base.FastMath.sub_fast(size(var"##st#872", 1), var"##step_2_h#880"), var"##m#875_2" = var"##m#875_1":var"##step_1_h#878":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#875_1", var"##step_2_l#879"), var"##step_1_h#878")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 0), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#885_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), 1)
                                                    var"##I#885_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), 1)
                                                    var"##I#885_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_2_l#879"), 1)
                                                    var"##I#885_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#886_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#885_1"])
                                                    var"##T#886_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#885_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#885_3"]))
                                                    var"##T#886_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#885_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#885_3"]))
                                                    var"##T#886_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#885_4"])
                                                    var"##st#872"[var"##I#885_1"] = var"##T#886_1"
                                                    var"##st#872"[var"##I#885_2"] = var"##T#886_2"
                                                    var"##st#872"[var"##I#885_3"] = var"##T#886_3"
                                                    var"##st#872"[var"##I#885_4"] = var"##T#886_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 1), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#887_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), 1)
                                                    var"##I#887_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_1_l#877"), 1)
                                                    var"##I#887_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_2_l#879"), 1)
                                                    var"##I#887_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#888_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#887_1"])
                                                    var"##T#888_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#887_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#887_3"]))
                                                    var"##T#888_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#887_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#887_3"]))
                                                    var"##T#888_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#887_4"])
                                                    var"##st#872"[var"##I#887_1"] = var"##T#888_1"
                                                    var"##st#872"[var"##I#887_2"] = var"##T#888_2"
                                                    var"##st#872"[var"##I#887_3"] = var"##T#888_3"
                                                    var"##st#872"[var"##I#887_4"] = var"##T#888_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#872"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#877", 4)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#875_1" = 0:var"##step_2_h#880":Base.FastMath.sub_fast(size(var"##st#872", 1), var"##step_2_h#880"), var"##m#875_2" = var"##m#875_1":var"##step_1_h#878":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#875_1", var"##step_2_l#879"), var"##step_1_h#878")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 0), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#889_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), 1)
                                                    var"##I#889_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), 1)
                                                    var"##I#889_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_2_l#879"), 1)
                                                    var"##I#889_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#890_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#889_1"])
                                                    var"##T#890_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#889_3"]))
                                                    var"##T#890_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#889_3"]))
                                                    var"##T#890_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#889_4"])
                                                    var"##st#872"[var"##I#889_1"] = var"##T#890_1"
                                                    var"##st#872"[var"##I#889_2"] = var"##T#890_2"
                                                    var"##st#872"[var"##I#889_3"] = var"##T#890_3"
                                                    var"##st#872"[var"##I#889_4"] = var"##T#890_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 1), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#891_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), 1)
                                                    var"##I#891_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_1_l#877"), 1)
                                                    var"##I#891_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_2_l#879"), 1)
                                                    var"##I#891_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#892_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#891_1"])
                                                    var"##T#892_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#891_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#891_3"]))
                                                    var"##T#892_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#891_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#891_3"]))
                                                    var"##T#892_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#891_4"])
                                                    var"##st#872"[var"##I#891_1"] = var"##T#892_1"
                                                    var"##st#872"[var"##I#891_2"] = var"##T#892_2"
                                                    var"##st#872"[var"##I#891_3"] = var"##T#892_3"
                                                    var"##st#872"[var"##I#891_4"] = var"##T#892_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 2), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#893_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), 1)
                                                    var"##I#893_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), var"##step_1_l#877"), 1)
                                                    var"##I#893_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), var"##step_2_l#879"), 1)
                                                    var"##I#893_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#894_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#893_1"])
                                                    var"##T#894_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#893_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#893_3"]))
                                                    var"##T#894_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#893_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#893_3"]))
                                                    var"##T#894_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#893_4"])
                                                    var"##st#872"[var"##I#893_1"] = var"##T#894_1"
                                                    var"##st#872"[var"##I#893_2"] = var"##T#894_2"
                                                    var"##st#872"[var"##I#893_3"] = var"##T#894_3"
                                                    var"##st#872"[var"##I#893_4"] = var"##T#894_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 3), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#895_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), 1)
                                                    var"##I#895_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), var"##step_1_l#877"), 1)
                                                    var"##I#895_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), var"##step_2_l#879"), 1)
                                                    var"##I#895_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#896_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#895_1"])
                                                    var"##T#896_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#895_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#895_3"]))
                                                    var"##T#896_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#895_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#895_3"]))
                                                    var"##T#896_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#895_4"])
                                                    var"##st#872"[var"##I#895_1"] = var"##T#896_1"
                                                    var"##st#872"[var"##I#895_2"] = var"##T#896_2"
                                                    var"##st#872"[var"##I#895_3"] = var"##T#896_3"
                                                    var"##st#872"[var"##I#895_4"] = var"##T#896_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#872"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#877", 8)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#875_1" = 0:var"##step_2_h#880":Base.FastMath.sub_fast(size(var"##st#872", 1), var"##step_2_h#880"), var"##m#875_2" = var"##m#875_1":var"##step_1_h#878":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#875_1", var"##step_2_l#879"), var"##step_1_h#878")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 0), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#897_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), 1)
                                                    var"##I#897_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), 1)
                                                    var"##I#897_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_2_l#879"), 1)
                                                    var"##I#897_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 0), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#898_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#897_1"])
                                                    var"##T#898_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#897_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#897_3"]))
                                                    var"##T#898_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#897_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#897_3"]))
                                                    var"##T#898_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#897_4"])
                                                    var"##st#872"[var"##I#897_1"] = var"##T#898_1"
                                                    var"##st#872"[var"##I#897_2"] = var"##T#898_2"
                                                    var"##st#872"[var"##I#897_3"] = var"##T#898_3"
                                                    var"##st#872"[var"##I#897_4"] = var"##T#898_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 1), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#899_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), 1)
                                                    var"##I#899_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_1_l#877"), 1)
                                                    var"##I#899_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_2_l#879"), 1)
                                                    var"##I#899_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 1), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#900_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#899_1"])
                                                    var"##T#900_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#899_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#899_3"]))
                                                    var"##T#900_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#899_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#899_3"]))
                                                    var"##T#900_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#899_4"])
                                                    var"##st#872"[var"##I#899_1"] = var"##T#900_1"
                                                    var"##st#872"[var"##I#899_2"] = var"##T#900_2"
                                                    var"##st#872"[var"##I#899_3"] = var"##T#900_3"
                                                    var"##st#872"[var"##I#899_4"] = var"##T#900_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 2), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#901_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), 1)
                                                    var"##I#901_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), var"##step_1_l#877"), 1)
                                                    var"##I#901_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), var"##step_2_l#879"), 1)
                                                    var"##I#901_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 2), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#902_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#901_1"])
                                                    var"##T#902_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#901_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#901_3"]))
                                                    var"##T#902_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#901_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#901_3"]))
                                                    var"##T#902_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#901_4"])
                                                    var"##st#872"[var"##I#901_1"] = var"##T#902_1"
                                                    var"##st#872"[var"##I#901_2"] = var"##T#902_2"
                                                    var"##st#872"[var"##I#901_3"] = var"##T#902_3"
                                                    var"##st#872"[var"##I#901_4"] = var"##T#902_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 3), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#903_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), 1)
                                                    var"##I#903_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), var"##step_1_l#877"), 1)
                                                    var"##I#903_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), var"##step_2_l#879"), 1)
                                                    var"##I#903_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 3), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#904_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#903_1"])
                                                    var"##T#904_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#903_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#903_3"]))
                                                    var"##T#904_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#903_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#903_3"]))
                                                    var"##T#904_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#903_4"])
                                                    var"##st#872"[var"##I#903_1"] = var"##T#904_1"
                                                    var"##st#872"[var"##I#903_2"] = var"##T#904_2"
                                                    var"##st#872"[var"##I#903_3"] = var"##T#904_3"
                                                    var"##st#872"[var"##I#903_4"] = var"##T#904_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 4), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#905_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 4), 1)
                                                    var"##I#905_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 4), var"##step_1_l#877"), 1)
                                                    var"##I#905_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 4), var"##step_2_l#879"), 1)
                                                    var"##I#905_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 4), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#906_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#905_1"])
                                                    var"##T#906_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#905_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#905_3"]))
                                                    var"##T#906_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#905_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#905_3"]))
                                                    var"##T#906_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#905_4"])
                                                    var"##st#872"[var"##I#905_1"] = var"##T#906_1"
                                                    var"##st#872"[var"##I#905_2"] = var"##T#906_2"
                                                    var"##st#872"[var"##I#905_3"] = var"##T#906_3"
                                                    var"##st#872"[var"##I#905_4"] = var"##T#906_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 5), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#907_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 5), 1)
                                                    var"##I#907_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 5), var"##step_1_l#877"), 1)
                                                    var"##I#907_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 5), var"##step_2_l#879"), 1)
                                                    var"##I#907_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 5), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#908_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#907_1"])
                                                    var"##T#908_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#907_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#907_3"]))
                                                    var"##T#908_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#907_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#907_3"]))
                                                    var"##T#908_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#907_4"])
                                                    var"##st#872"[var"##I#907_1"] = var"##T#908_1"
                                                    var"##st#872"[var"##I#907_2"] = var"##T#908_2"
                                                    var"##st#872"[var"##I#907_3"] = var"##T#908_3"
                                                    var"##st#872"[var"##I#907_4"] = var"##T#908_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 6), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#909_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 6), 1)
                                                    var"##I#909_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 6), var"##step_1_l#877"), 1)
                                                    var"##I#909_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 6), var"##step_2_l#879"), 1)
                                                    var"##I#909_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 6), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#910_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#909_1"])
                                                    var"##T#910_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#909_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#909_3"]))
                                                    var"##T#910_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#909_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#909_3"]))
                                                    var"##T#910_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#909_4"])
                                                    var"##st#872"[var"##I#909_1"] = var"##T#910_1"
                                                    var"##st#872"[var"##I#909_2"] = var"##T#910_2"
                                                    var"##st#872"[var"##I#909_3"] = var"##T#910_3"
                                                    var"##st#872"[var"##I#909_4"] = var"##T#910_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_2", 7), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#911_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 7), 1)
                                                    var"##I#911_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 7), var"##step_1_l#877"), 1)
                                                    var"##I#911_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 7), var"##step_2_l#879"), 1)
                                                    var"##I#911_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_2", 7), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#912_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#911_1"])
                                                    var"##T#912_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#911_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#911_3"]))
                                                    var"##T#912_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#911_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#911_3"]))
                                                    var"##T#912_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#911_4"])
                                                    var"##st#872"[var"##I#911_1"] = var"##T#912_1"
                                                    var"##st#872"[var"##I#911_2"] = var"##T#912_2"
                                                    var"##st#872"[var"##I#911_3"] = var"##T#912_3"
                                                    var"##st#872"[var"##I#911_4"] = var"##T#912_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#872"
                                    end
                                end
                                for var"##m#875_1" = 0:var"##step_2_h#880":Base.FastMath.sub_fast(size(var"##st#872", 1), var"##step_2_h#880"), var"##m#875_2" = var"##m#875_1":var"##step_1_h#878":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#875_1", var"##step_2_l#879"), var"##step_1_h#878")
                                    for var"##m#875_3" = var"##m#875_2":8:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#875_2", var"##step_1_l#877"), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                        begin
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 0), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#913_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 0), 1)
                                                    var"##I#913_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 0), var"##step_1_l#877"), 1)
                                                    var"##I#913_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 0), var"##step_2_l#879"), 1)
                                                    var"##I#913_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 0), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#914_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#913_1"])
                                                    var"##T#914_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#913_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#913_3"]))
                                                    var"##T#914_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#913_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#913_3"]))
                                                    var"##T#914_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#913_4"])
                                                    var"##st#872"[var"##I#913_1"] = var"##T#914_1"
                                                    var"##st#872"[var"##I#913_2"] = var"##T#914_2"
                                                    var"##st#872"[var"##I#913_3"] = var"##T#914_3"
                                                    var"##st#872"[var"##I#913_4"] = var"##T#914_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 1), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#915_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 1), 1)
                                                    var"##I#915_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 1), var"##step_1_l#877"), 1)
                                                    var"##I#915_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 1), var"##step_2_l#879"), 1)
                                                    var"##I#915_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 1), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#916_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#915_1"])
                                                    var"##T#916_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#915_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#915_3"]))
                                                    var"##T#916_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#915_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#915_3"]))
                                                    var"##T#916_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#915_4"])
                                                    var"##st#872"[var"##I#915_1"] = var"##T#916_1"
                                                    var"##st#872"[var"##I#915_2"] = var"##T#916_2"
                                                    var"##st#872"[var"##I#915_3"] = var"##T#916_3"
                                                    var"##st#872"[var"##I#915_4"] = var"##T#916_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 2), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#917_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 2), 1)
                                                    var"##I#917_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 2), var"##step_1_l#877"), 1)
                                                    var"##I#917_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 2), var"##step_2_l#879"), 1)
                                                    var"##I#917_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 2), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#918_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#917_1"])
                                                    var"##T#918_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#917_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#917_3"]))
                                                    var"##T#918_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#917_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#917_3"]))
                                                    var"##T#918_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#917_4"])
                                                    var"##st#872"[var"##I#917_1"] = var"##T#918_1"
                                                    var"##st#872"[var"##I#917_2"] = var"##T#918_2"
                                                    var"##st#872"[var"##I#917_3"] = var"##T#918_3"
                                                    var"##st#872"[var"##I#917_4"] = var"##T#918_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 3), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#919_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 3), 1)
                                                    var"##I#919_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 3), var"##step_1_l#877"), 1)
                                                    var"##I#919_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 3), var"##step_2_l#879"), 1)
                                                    var"##I#919_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 3), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#920_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#919_1"])
                                                    var"##T#920_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#919_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#919_3"]))
                                                    var"##T#920_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#919_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#919_3"]))
                                                    var"##T#920_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#919_4"])
                                                    var"##st#872"[var"##I#919_1"] = var"##T#920_1"
                                                    var"##st#872"[var"##I#919_2"] = var"##T#920_2"
                                                    var"##st#872"[var"##I#919_3"] = var"##T#920_3"
                                                    var"##st#872"[var"##I#919_4"] = var"##T#920_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 4), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#921_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 4), 1)
                                                    var"##I#921_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 4), var"##step_1_l#877"), 1)
                                                    var"##I#921_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 4), var"##step_2_l#879"), 1)
                                                    var"##I#921_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 4), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#922_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#921_1"])
                                                    var"##T#922_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#921_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#921_3"]))
                                                    var"##T#922_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#921_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#921_3"]))
                                                    var"##T#922_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#921_4"])
                                                    var"##st#872"[var"##I#921_1"] = var"##T#922_1"
                                                    var"##st#872"[var"##I#921_2"] = var"##T#922_2"
                                                    var"##st#872"[var"##I#921_3"] = var"##T#922_3"
                                                    var"##st#872"[var"##I#921_4"] = var"##T#922_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 5), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#923_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 5), 1)
                                                    var"##I#923_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 5), var"##step_1_l#877"), 1)
                                                    var"##I#923_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 5), var"##step_2_l#879"), 1)
                                                    var"##I#923_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 5), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#924_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#923_1"])
                                                    var"##T#924_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#923_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#923_3"]))
                                                    var"##T#924_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#923_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#923_3"]))
                                                    var"##T#924_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#923_4"])
                                                    var"##st#872"[var"##I#923_1"] = var"##T#924_1"
                                                    var"##st#872"[var"##I#923_2"] = var"##T#924_2"
                                                    var"##st#872"[var"##I#923_3"] = var"##T#924_3"
                                                    var"##st#872"[var"##I#923_4"] = var"##T#924_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 6), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#925_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 6), 1)
                                                    var"##I#925_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 6), var"##step_1_l#877"), 1)
                                                    var"##I#925_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 6), var"##step_2_l#879"), 1)
                                                    var"##I#925_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 6), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#926_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#925_1"])
                                                    var"##T#926_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#925_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#925_3"]))
                                                    var"##T#926_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#925_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#925_3"]))
                                                    var"##T#926_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#925_4"])
                                                    var"##st#872"[var"##I#925_1"] = var"##T#926_1"
                                                    var"##st#872"[var"##I#925_2"] = var"##T#926_2"
                                                    var"##st#872"[var"##I#925_3"] = var"##T#926_3"
                                                    var"##st#872"[var"##I#925_4"] = var"##T#926_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#875_3", 7), var"##ctrl_mask#883", var"##flag_mask#884")
                                                    var"##I#927_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 7), 1)
                                                    var"##I#927_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 7), var"##step_1_l#877"), 1)
                                                    var"##I#927_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 7), var"##step_2_l#879"), 1)
                                                    var"##I#927_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#875_3", 7), var"##step_1_l#877"), var"##step_2_l#879"), 1)
                                                    var"##T#928_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#872"[var"##I#927_1"])
                                                    var"##T#928_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#872"[var"##I#927_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#872"[var"##I#927_3"]))
                                                    var"##T#928_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#872"[var"##I#927_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#872"[var"##I#927_3"]))
                                                    var"##T#928_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#872"[var"##I#927_4"])
                                                    var"##st#872"[var"##I#927_1"] = var"##T#928_1"
                                                    var"##st#872"[var"##I#927_2"] = var"##T#928_2"
                                                    var"##st#872"[var"##I#927_3"] = var"##T#928_3"
                                                    var"##st#872"[var"##I#927_4"] = var"##T#928_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#727#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#872"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#931"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#932"::Locations, var"##ctrl#787"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#933" = (YaoLocations.plain)(var"##locs#932")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#933"[1] > var"##plain_locs#933"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#932" = Locations((var"##plain_locs#933"[2], var"##plain_locs#933"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#934" = (YaoLocations.plain)(var"##locs#932")
                    var"##nqubits#935" = (BQCESubroutine.log2i)(size(var"##st#931", 1))
                    var"##nlocs_needed#936" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#940" = 1 << (var"##plain_locs#934"[1] - 1)
                    var"##step_1_h#941" = 1 << var"##plain_locs#934"[1]
                    var"##step_2_l#942" = 1 << (var"##plain_locs#934"[2] - 1)
                    var"##step_2_h#943" = 1 << var"##plain_locs#934"[2]
                    var"##ctrl_mask#946" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#787"))
                    var"##flag_mask#947" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#787")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#728#val" = begin
                                if var"##nlocs_needed#936" ≤ Base.FastMath.sub_fast(var"##nqubits#935", var"##plain_locs#934"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#940", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#937_1" = 0:var"##step_2_h#943":Base.FastMath.sub_fast(size(var"##st#931", 1), var"##step_2_h#943")
                                                                for var"##idx#937_2" = var"##idx#937_1":var"##step_1_h#941":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#937_1", var"##step_2_l#942"), var"##step_1_h#941")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#937_2", 0), var"##ctrl_mask#946", var"##flag_mask#947")
                                                                            var"##I#944_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_2", 0), 1)
                                                                            var"##I#944_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_2", 0), var"##step_1_l#940"), 1)
                                                                            var"##I#944_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_2", 0), var"##step_2_l#942"), 1)
                                                                            var"##I#944_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_2", 0), var"##step_1_l#940"), var"##step_2_l#942"), 1)
                                                                            var"##T#945_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#931"[var"##I#944_1"])
                                                                            var"##T#945_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#931"[var"##I#944_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#931"[var"##I#944_3"]))
                                                                            var"##T#945_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#931"[var"##I#944_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#931"[var"##I#944_3"]))
                                                                            var"##T#945_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#931"[var"##I#944_4"])
                                                                            var"##st#931"[var"##I#944_1"] = var"##T#945_1"
                                                                            var"##st#931"[var"##I#944_2"] = var"##T#945_2"
                                                                            var"##st#931"[var"##I#944_3"] = var"##T#945_3"
                                                                            var"##st#931"[var"##I#944_4"] = var"##T#945_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                            begin
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                                (var"##inner##loop##", var"#729###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#943":Base.FastMath.sub_fast(size(var"##st#931", static(1)), var"##step_2_h#943"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#730###ITER_LENG##" = (ArrayInterface.static_length)(var"#729###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#731###LOOP_STEP##" = (ArrayInterface.static_step)(var"#729###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#732###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#729###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#941#1152", var"####step_2_l#942#1153", var"####ctrl_mask#946#1154", var"####flag_mask#947#1155", var"####step_1_l#940#1158", var"####hoisted#781#1162", var"####st#931#1163", var"####hoisted#782#1165", var"####hoisted#783#1166", var"####hoisted#784#1168", var"####hoisted#785#1169", var"####hoisted#786#1171"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#737#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#937_1#1150" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#937_2#1151" = var"####idx#937_1#1150":var"####step_1_h#941#1152":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#937_1#1150", var"####step_2_l#942#1153"), var"####step_1_h#941#1152")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#937_2#1151", 0), var"####ctrl_mask#946#1154", var"####flag_mask#947#1155")
                                                                                                                        var"####I#944_1#1156" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_2#1151", 0), 1)
                                                                                                                        var"####I#944_2#1157" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_2#1151", 0), var"####step_1_l#940#1158"), 1)
                                                                                                                        var"####I#944_3#1159" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_2#1151", 0), var"####step_2_l#942#1153"), 1)
                                                                                                                        var"####I#944_4#1160" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_2#1151", 0), var"####step_1_l#940#1158"), var"####step_2_l#942#1153"), 1)
                                                                                                                        var"####T#945_1#1161" = Base.FastMath.mul_fast(var"####hoisted#781#1162", var"####st#931#1163"[var"####I#944_1#1156"])
                                                                                                                        var"####T#945_2#1164" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1165", var"####st#931#1163"[var"####I#944_2#1157"]), Base.FastMath.mul_fast(var"####hoisted#783#1166", var"####st#931#1163"[var"####I#944_3#1159"]))
                                                                                                                        var"####T#945_3#1167" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1168", var"####st#931#1163"[var"####I#944_2#1157"]), Base.FastMath.mul_fast(var"####hoisted#785#1169", var"####st#931#1163"[var"####I#944_3#1159"]))
                                                                                                                        var"####T#945_4#1170" = Base.FastMath.mul_fast(var"####hoisted#786#1171", var"####st#931#1163"[var"####I#944_4#1160"])
                                                                                                                        var"####st#931#1163"[var"####I#944_1#1156"] = var"####T#945_1#1161"
                                                                                                                        var"####st#931#1163"[var"####I#944_2#1157"] = var"####T#945_2#1164"
                                                                                                                        var"####st#931#1163"[var"####I#944_3#1159"] = var"####T#945_3#1167"
                                                                                                                        var"####st#931#1163"[var"####I#944_4#1160"] = var"####T#945_4#1170"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#737#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#730###ITER_LENG##", Polyester.min(var"#730###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#732###LOOPOFFSET##", var"#731###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#941", var"##step_2_l#942", var"##ctrl_mask#946", var"##flag_mask#947", var"##step_1_l#940", var"##hoisted#781", var"##st#931", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#931"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#937_1" = 0:var"##step_2_h#943":Base.FastMath.sub_fast(size(var"##st#931", 1), var"##step_2_h#943")
                                                        for var"##idx#937_2" = var"##idx#937_1":var"##step_1_h#941":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#937_1", var"##step_2_l#942"), var"##step_1_h#941")
                                                            for var"##idx#937_3" = var"##idx#937_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#937_2", var"##step_1_l#940"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#937_3", 0), var"##ctrl_mask#946", var"##flag_mask#947")
                                                                            var"##I#948_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_3", 0), 1)
                                                                            var"##I#948_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_3", 0), var"##step_1_l#940"), 1)
                                                                            var"##I#948_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_3", 0), var"##step_2_l#942"), 1)
                                                                            var"##I#948_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#937_3", 0), var"##step_1_l#940"), var"##step_2_l#942"), 1)
                                                                            var"##T#949_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#931"[var"##I#948_1"])
                                                                            var"##T#949_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#931"[var"##I#948_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#931"[var"##I#948_3"]))
                                                                            var"##T#949_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#931"[var"##I#948_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#931"[var"##I#948_3"]))
                                                                            var"##T#949_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#931"[var"##I#948_4"])
                                                                            var"##st#931"[var"##I#948_1"] = var"##T#949_1"
                                                                            var"##st#931"[var"##I#948_2"] = var"##T#949_2"
                                                                            var"##st#931"[var"##I#948_3"] = var"##T#949_3"
                                                                            var"##st#931"[var"##I#948_4"] = var"##T#949_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                    begin
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                        (var"##inner##loop##", var"#738###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#943":Base.FastMath.sub_fast(size(var"##st#931", static(1)), var"##step_2_h#943"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#739###ITER_LENG##" = (ArrayInterface.static_length)(var"#738###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#740###LOOP_STEP##" = (ArrayInterface.static_step)(var"#738###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#741###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#738###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#941#1174", var"####step_2_l#942#1175", var"####step_1_l#940#1177", var"####ctrl_mask#946#1178", var"####flag_mask#947#1179", var"####hoisted#781#1185", var"####st#931#1186", var"####hoisted#782#1188", var"####hoisted#783#1189", var"####hoisted#784#1191", var"####hoisted#785#1192", var"####hoisted#786#1194"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#746#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#937_1#1172" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#937_2#1173" = var"####idx#937_1#1172":var"####step_1_h#941#1174":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#937_1#1172", var"####step_2_l#942#1175"), var"####step_1_h#941#1174")
                                                                                                        for var"####idx#937_3#1176" = var"####idx#937_2#1173":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#937_2#1173", var"####step_1_l#940#1177"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#937_3#1176", 0), var"####ctrl_mask#946#1178", var"####flag_mask#947#1179")
                                                                                                                        var"####I#948_1#1180" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_3#1176", 0), 1)
                                                                                                                        var"####I#948_2#1181" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_3#1176", 0), var"####step_1_l#940#1177"), 1)
                                                                                                                        var"####I#948_3#1182" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_3#1176", 0), var"####step_2_l#942#1175"), 1)
                                                                                                                        var"####I#948_4#1183" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#937_3#1176", 0), var"####step_1_l#940#1177"), var"####step_2_l#942#1175"), 1)
                                                                                                                        var"####T#949_1#1184" = Base.FastMath.mul_fast(var"####hoisted#781#1185", var"####st#931#1186"[var"####I#948_1#1180"])
                                                                                                                        var"####T#949_2#1187" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1188", var"####st#931#1186"[var"####I#948_2#1181"]), Base.FastMath.mul_fast(var"####hoisted#783#1189", var"####st#931#1186"[var"####I#948_3#1182"]))
                                                                                                                        var"####T#949_3#1190" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1191", var"####st#931#1186"[var"####I#948_2#1181"]), Base.FastMath.mul_fast(var"####hoisted#785#1192", var"####st#931#1186"[var"####I#948_3#1182"]))
                                                                                                                        var"####T#949_4#1193" = Base.FastMath.mul_fast(var"####hoisted#786#1194", var"####st#931#1186"[var"####I#948_4#1183"])
                                                                                                                        var"####st#931#1186"[var"####I#948_1#1180"] = var"####T#949_1#1184"
                                                                                                                        var"####st#931#1186"[var"####I#948_2#1181"] = var"####T#949_2#1187"
                                                                                                                        var"####st#931#1186"[var"####I#948_3#1182"] = var"####T#949_3#1190"
                                                                                                                        var"####st#931#1186"[var"####I#948_4#1183"] = var"####T#949_4#1193"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#746#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#739###ITER_LENG##", Polyester.min(var"#739###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#741###LOOPOFFSET##", var"#740###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#941", var"##step_2_l#942", var"##step_1_l#940", var"##ctrl_mask#946", var"##flag_mask#947", var"##hoisted#781", var"##st#931", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#931"
                                end
                                if var"##nlocs_needed#936" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#935", var"##plain_locs#934"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:502 =#
                                    var"##m#939" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#935", var"##nlocs_needed#936"), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#940", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#748#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#747#range" = (BQCESubroutine.bsubspace)(var"##nqubits#935", (1:var"##m#939"..., var"##plain_locs#934"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#748#threadsfor_fun"(var"#760#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#752#r" = var"#747#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#753#lenr" = Base.Threads.length(var"#752#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#760#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#754#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#755#len", var"#756#rem") = (var"#753#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#754#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#755#len", var"#756#rem") = Base.Threads.divrem(var"#753#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#755#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#754#tid" > var"#756#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#755#len", var"#756#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#757#f" = Base.Threads.firstindex(var"#752#r") + (var"#754#tid" - 1) * var"#755#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#758#l" = (var"#757#f" + var"#755#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#756#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#754#tid" <= var"#756#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#757#f" = var"#757#f" + (var"#754#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#758#l" = var"#758#l" + var"#754#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#757#f" = var"#757#f" + var"#756#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#758#l" = var"#758#l" + var"#756#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#759#i" = var"#757#f":var"#758#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#938" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#761#val" = var"#752#r"[var"#759#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#761#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                for var"##idx#937_2" = var"##idx#937_1":var"##step_1_h#941":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#937_1", var"##step_2_l#942"), var"##step_1_h#941")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_2", 0)), var"##ctrl_mask#946", var"##flag_mask#947")
                                                                            var"##I#950_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_2", 0)), 1)
                                                                            var"##I#950_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_2", 0)), var"##step_1_l#940"), 1)
                                                                            var"##I#950_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_2", 0)), var"##step_2_l#942"), 1)
                                                                            var"##I#950_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_2", 0)), var"##step_1_l#940"), var"##step_2_l#942"), 1)
                                                                            var"##T#951_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#931"[var"##I#950_1"])
                                                                            var"##T#951_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#931"[var"##I#950_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#931"[var"##I#950_3"]))
                                                                            var"##T#951_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#931"[var"##I#950_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#931"[var"##I#950_3"]))
                                                                            var"##T#951_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#931"[var"##I#950_4"])
                                                                            var"##st#931"[var"##I#950_1"] = var"##T#951_1"
                                                                            var"##st#931"[var"##I#950_2"] = var"##T#951_2"
                                                                            var"##st#931"[var"##I#950_3"] = var"##T#951_3"
                                                                            var"##st#931"[var"##I#950_4"] = var"##T#951_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#748#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#748#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#931"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#763#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#762#range" = (BQCESubroutine.bsubspace)(var"##nqubits#935", (1:var"##m#939"..., var"##plain_locs#934"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#763#threadsfor_fun"(var"#775#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#767#r" = var"#762#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#768#lenr" = Base.Threads.length(var"#767#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#775#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#769#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#770#len", var"#771#rem") = (var"#768#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#769#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#770#len", var"#771#rem") = Base.Threads.divrem(var"#768#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#770#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#769#tid" > var"#771#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#770#len", var"#771#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#772#f" = Base.Threads.firstindex(var"#767#r") + (var"#769#tid" - 1) * var"#770#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#773#l" = (var"#772#f" + var"#770#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#771#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#769#tid" <= var"#771#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#772#f" = var"#772#f" + (var"#769#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#773#l" = var"#773#l" + var"#769#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#772#f" = var"#772#f" + var"#771#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#773#l" = var"#773#l" + var"#771#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#774#i" = var"#772#f":var"#773#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#938" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#776#val" = var"#767#r"[var"#774#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#776#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#937_2" = var"##idx#937_1":var"##step_1_h#941":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#937_1", var"##step_2_l#942"), var"##step_1_h#941")
                                                            for var"##idx#937_3" = var"##idx#937_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#937_2", var"##step_1_l#940"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_3", 0)), var"##ctrl_mask#946", var"##flag_mask#947")
                                                                            var"##I#952_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_3", 0)), 1)
                                                                            var"##I#952_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_3", 0)), var"##step_1_l#940"), 1)
                                                                            var"##I#952_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_3", 0)), var"##step_2_l#942"), 1)
                                                                            var"##I#952_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", Base.FastMath.add_fast(var"##idx#937_3", 0)), var"##step_1_l#940"), var"##step_2_l#942"), 1)
                                                                            var"##T#953_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#931"[var"##I#952_1"])
                                                                            var"##T#953_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#931"[var"##I#952_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#931"[var"##I#952_3"]))
                                                                            var"##T#953_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#931"[var"##I#952_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#931"[var"##I#952_3"]))
                                                                            var"##T#953_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#931"[var"##I#952_4"])
                                                                            var"##st#931"[var"##I#952_1"] = var"##T#953_1"
                                                                            var"##st#931"[var"##I#952_2"] = var"##T#953_2"
                                                                            var"##st#931"[var"##I#952_3"] = var"##T#953_3"
                                                                            var"##st#931"[var"##I#952_4"] = var"##T#953_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            #= threadingconstructs.jl:85 =#
                                            if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                #= threadingconstructs.jl:86 =#
                                                (Base.Threads.Base).invokelatest(var"#763#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#763#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    return var"##st#931"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:510 =#
                                    var"##m#939" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#935", var"##nlocs_needed#936"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#778#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#777#range" = (BQCESubroutine.bsubspace)(var"##nqubits#935", (1:var"##m#939"..., var"##plain_locs#934"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#778#threadsfor_fun"(var"#790#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#782#r" = var"#777#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#783#lenr" = Base.Threads.length(var"#782#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#790#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#784#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#785#len", var"#786#rem") = (var"#783#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#784#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#785#len", var"#786#rem") = Base.Threads.divrem(var"#783#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#785#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#784#tid" > var"#786#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#785#len", var"#786#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#787#f" = Base.Threads.firstindex(var"#782#r") + (var"#784#tid" - 1) * var"#785#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#788#l" = (var"#787#f" + var"#785#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#786#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#784#tid" <= var"#786#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#787#f" = var"#787#f" + (var"#784#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#788#l" = var"#788#l" + var"#784#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#787#f" = var"#787#f" + var"#786#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#788#l" = var"#788#l" + var"#786#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#789#i" = var"#787#f":var"#788#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#938" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#791#val" = var"#782#r"[var"#789#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#791#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                                        for var"##idx#937_1" = 0:Base.FastMath.sub_fast(1 << var"##m#939", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#938", var"##idx#937_1"), var"##ctrl_mask#946", var"##flag_mask#947")
                                                                    var"##I#954_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", var"##idx#937_1"), 1)
                                                                    var"##I#954_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", var"##idx#937_1"), var"##step_1_l#940"), 1)
                                                                    var"##I#954_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", var"##idx#937_1"), var"##step_2_l#942"), 1)
                                                                    var"##I#954_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#938", var"##idx#937_1"), var"##step_1_l#940"), var"##step_2_l#942"), 1)
                                                                    var"##T#955_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#931"[var"##I#954_1"])
                                                                    var"##T#955_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#931"[var"##I#954_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#931"[var"##I#954_3"]))
                                                                    var"##T#955_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#931"[var"##I#954_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#931"[var"##I#954_3"]))
                                                                    var"##T#955_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#931"[var"##I#954_4"])
                                                                    var"##st#931"[var"##I#954_1"] = var"##T#955_1"
                                                                    var"##st#931"[var"##I#954_2"] = var"##T#955_2"
                                                                    var"##st#931"[var"##I#954_3"] = var"##T#955_3"
                                                                    var"##st#931"[var"##I#954_4"] = var"##T#955_4"
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        #= threadingconstructs.jl:85 =#
                                        if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                            #= threadingconstructs.jl:86 =#
                                            (Base.Threads.Base).invokelatest(var"#778#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#778#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#931"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#728#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#931"
    end
    function BQCESubroutine.broutine!(var"##st#957"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#958"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#958") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#957", Val{:PSWAP_test}(), var"##locs#958", θ)
                    return var"##st#957"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#958") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#957", Val{:PSWAP_test}(), var"##locs#958", θ)
                return var"##st#957"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#957"
    end
    function BQCESubroutine.basic_broutine!(var"##st#959"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#960"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#961" = (YaoLocations.plain)(var"##locs#960")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#961"[1] > var"##plain_locs#961"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#960" = Locations((var"##plain_locs#961"[2], var"##plain_locs#961"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#963" = (YaoLocations.plain)(var"##locs#960")
                    var"##step_1_l#964" = 1 << (var"##plain_locs#963"[1] - 1)
                    var"##step_1_h#965" = 1 << var"##plain_locs#963"[1]
                    var"##step_2_l#966" = 1 << (var"##plain_locs#963"[2] - 1)
                    var"##step_2_h#967" = 1 << var"##plain_locs#963"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#792#val" = for var"##m#962_1" = 0:var"##step_2_h#967":Base.FastMath.sub_fast(size(var"##st#959", 2), var"##step_2_h#967"), var"##m#962_2" = var"##m#962_1":var"##step_1_h#965":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#962_1", var"##step_2_l#966"), var"##step_1_h#965"), var"##m#962_3" = var"##m#962_2":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#962_2", var"##step_1_l#964"), 1)
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                nothing
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                    var"##upperbound#975" = size(var"##st#959", 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                    var"##Mmax#973" = Base.FastMath.sub_fast(size(var"##st#959", 1), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                    for var"##idx2#971" = 0:var"##Mmax#973" >>> 3
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                        var"##idx1#970" = Base.FastMath.add_fast(var"##idx2#971" << 3, 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                        var"##mmax#974" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#970", 7), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                        if var"##mmax#974" ≤ var"##Mmax#973"
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                            begin
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 0), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 1), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 2), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 3), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 4), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 5), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 6), var"##I#968_4"] = var"##T#969_4"
                                                end
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_4"])
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[Base.FastMath.add_fast(var"##idx1#970", 7), var"##I#968_4"] = var"##T#969_4"
                                                end
                                            end
                                        else
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                            for var"##idx3#972" = var"##idx1#970":var"##upperbound#975"
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                begin
                                                    var"##I#968_1" = Base.FastMath.add_fast(var"##m#962_3", 1)
                                                    var"##I#968_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), 1)
                                                    var"##I#968_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_2_l#966"), 1)
                                                    var"##I#968_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#962_3", var"##step_1_l#964"), var"##step_2_l#966"), 1)
                                                    var"##T#969_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#959"[var"##idx3#972", var"##I#968_1"])
                                                    var"##T#969_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#959"[var"##idx3#972", var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#959"[var"##idx3#972", var"##I#968_3"]))
                                                    var"##T#969_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#959"[var"##idx3#972", var"##I#968_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#959"[var"##idx3#972", var"##I#968_3"]))
                                                    var"##T#969_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#959"[var"##idx3#972", var"##I#968_4"])
                                                    var"##st#959"[var"##idx3#972", var"##I#968_1"] = var"##T#969_1"
                                                    var"##st#959"[var"##idx3#972", var"##I#968_2"] = var"##T#969_2"
                                                    var"##st#959"[var"##idx3#972", var"##I#968_3"] = var"##T#969_3"
                                                    var"##st#959"[var"##idx3#972", var"##I#968_4"] = var"##T#969_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#792#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#959"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#978"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#979"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#980" = (YaoLocations.plain)(var"##locs#979")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#980"[1] > var"##plain_locs#980"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#979" = Locations((var"##plain_locs#980"[2], var"##plain_locs#980"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#981" = (YaoLocations.plain)(var"##locs#979")
                    var"##nqubits#982" = (BQCESubroutine.log2i)(size(var"##st#978", 2))
                    var"##nlocs_needed#983" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#987" = 1 << (var"##plain_locs#981"[1] - 1)
                    var"##step_1_h#988" = 1 << var"##plain_locs#981"[1]
                    var"##step_2_l#989" = 1 << (var"##plain_locs#981"[2] - 1)
                    var"##step_2_h#990" = 1 << var"##plain_locs#981"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#793#val" = begin
                                if var"##nlocs_needed#983" ≤ Base.FastMath.sub_fast(var"##nqubits#982", var"##plain_locs#981"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#987", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#984_1" = 0:var"##step_2_h#990":Base.FastMath.sub_fast(size(var"##st#978", 2), var"##step_2_h#990")
                                                                for var"##idx#984_2" = var"##idx#984_1":var"##step_1_h#988":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#984_1", var"##step_2_l#989"), var"##step_1_h#988")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#998" = size(var"##st#978", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#996" = Base.FastMath.sub_fast(size(var"##st#978", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#994" = 0:var"##Mmax#996" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#993" = Base.FastMath.add_fast(var"##idx2#994" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#997" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#993", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#997" ≤ var"##Mmax#996"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#991_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), 1)
                                                                                            var"##I#991_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), var"##step_1_l#987"), 1)
                                                                                            var"##I#991_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), var"##step_2_l#989"), 1)
                                                                                            var"##I#991_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#992_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_1"])
                                                                                            var"##T#992_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_3"]))
                                                                                            var"##T#992_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_3"]))
                                                                                            var"##T#992_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_4"])
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_1"] = var"##T#992_1"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_2"] = var"##T#992_2"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_3"] = var"##T#992_3"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#993", 0), var"##I#991_4"] = var"##T#992_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#995" = var"##idx1#993":var"##upperbound#998"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#991_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), 1)
                                                                                            var"##I#991_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), var"##step_1_l#987"), 1)
                                                                                            var"##I#991_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), var"##step_2_l#989"), 1)
                                                                                            var"##I#991_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_2", 0), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#992_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[var"##idx3#995", var"##I#991_1"])
                                                                                            var"##T#992_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[var"##idx3#995", var"##I#991_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[var"##idx3#995", var"##I#991_3"]))
                                                                                            var"##T#992_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[var"##idx3#995", var"##I#991_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[var"##idx3#995", var"##I#991_3"]))
                                                                                            var"##T#992_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[var"##idx3#995", var"##I#991_4"])
                                                                                            var"##st#978"[var"##idx3#995", var"##I#991_1"] = var"##T#992_1"
                                                                                            var"##st#978"[var"##idx3#995", var"##I#991_2"] = var"##T#992_2"
                                                                                            var"##st#978"[var"##idx3#995", var"##I#991_3"] = var"##T#992_3"
                                                                                            var"##st#978"[var"##idx3#995", var"##I#991_4"] = var"##T#992_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                            begin
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                                (var"##inner##loop##", var"#794###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#990":Base.FastMath.sub_fast(size(var"##st#978", static(2)), var"##step_2_h#990"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#795###ITER_LENG##" = (ArrayInterface.static_length)(var"#794###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#796###LOOP_STEP##" = (ArrayInterface.static_step)(var"#794###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#797###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#794###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#988#1197", var"####step_2_l#989#1198", var"####st#978#1200", var"####step_1_l#987#1207", var"####hoisted#781#1211", var"####hoisted#782#1213", var"####hoisted#783#1214", var"####hoisted#784#1216", var"####hoisted#785#1217", var"####hoisted#786#1219"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#802#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#984_1#1195" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#984_2#1196" = var"####idx#984_1#1195":var"####step_1_h#988#1197":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#984_1#1195", var"####step_2_l#989#1198"), var"####step_1_h#988#1197")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                                                                        var"####upperbound#998#1199" = size(var"####st#978#1200", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####Mmax#996#1201" = Base.FastMath.sub_fast(size(var"####st#978#1200", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        for var"####idx2#994#1202" = 0:var"####Mmax#996#1201" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                            var"####idx1#993#1203" = Base.FastMath.add_fast(var"####idx2#994#1202" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####mmax#997#1204" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#993#1203", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            if var"####mmax#997#1204" ≤ var"####Mmax#996#1201"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#991_1#1205" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), 1)
                                                                                                                                        var"####I#991_2#1206" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), var"####step_1_l#987#1207"), 1)
                                                                                                                                        var"####I#991_3#1208" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), var"####step_2_l#989#1198"), 1)
                                                                                                                                        var"####I#991_4#1209" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), var"####step_1_l#987#1207"), var"####step_2_l#989#1198"), 1)
                                                                                                                                        var"####T#992_1#1210" = Base.FastMath.mul_fast(var"####hoisted#781#1211", var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_1#1205"])
                                                                                                                                        var"####T#992_2#1212" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1213", var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_2#1206"]), Base.FastMath.mul_fast(var"####hoisted#783#1214", var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_3#1208"]))
                                                                                                                                        var"####T#992_3#1215" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1216", var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_2#1206"]), Base.FastMath.mul_fast(var"####hoisted#785#1217", var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_3#1208"]))
                                                                                                                                        var"####T#992_4#1218" = Base.FastMath.mul_fast(var"####hoisted#786#1219", var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_4#1209"])
                                                                                                                                        var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_1#1205"] = var"####T#992_1#1210"
                                                                                                                                        var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_2#1206"] = var"####T#992_2#1212"
                                                                                                                                        var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_3#1208"] = var"####T#992_3#1215"
                                                                                                                                        var"####st#978#1200"[Base.FastMath.add_fast(var"####idx1#993#1203", 0), var"####I#991_4#1209"] = var"####T#992_4#1218"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                                                                for var"####idx3#995#1220" = var"####idx1#993#1203":var"####upperbound#998#1199"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#991_1#1205" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), 1)
                                                                                                                                        var"####I#991_2#1206" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), var"####step_1_l#987#1207"), 1)
                                                                                                                                        var"####I#991_3#1208" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), var"####step_2_l#989#1198"), 1)
                                                                                                                                        var"####I#991_4#1209" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_2#1196", 0), var"####step_1_l#987#1207"), var"####step_2_l#989#1198"), 1)
                                                                                                                                        var"####T#992_1#1210" = Base.FastMath.mul_fast(var"####hoisted#781#1211", var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_1#1205"])
                                                                                                                                        var"####T#992_2#1212" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1213", var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_2#1206"]), Base.FastMath.mul_fast(var"####hoisted#783#1214", var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_3#1208"]))
                                                                                                                                        var"####T#992_3#1215" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1216", var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_2#1206"]), Base.FastMath.mul_fast(var"####hoisted#785#1217", var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_3#1208"]))
                                                                                                                                        var"####T#992_4#1218" = Base.FastMath.mul_fast(var"####hoisted#786#1219", var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_4#1209"])
                                                                                                                                        var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_1#1205"] = var"####T#992_1#1210"
                                                                                                                                        var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_2#1206"] = var"####T#992_2#1212"
                                                                                                                                        var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_3#1208"] = var"####T#992_3#1215"
                                                                                                                                        var"####st#978#1200"[var"####idx3#995#1220", var"####I#991_4#1209"] = var"####T#992_4#1218"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#802#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#795###ITER_LENG##", Polyester.min(var"#795###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#797###LOOPOFFSET##", var"#796###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#988", var"##step_2_l#989", var"##st#978", var"##step_1_l#987", var"##hoisted#781", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#978"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#984_1" = 0:var"##step_2_h#990":Base.FastMath.sub_fast(size(var"##st#978", 2), var"##step_2_h#990")
                                                        for var"##idx#984_2" = var"##idx#984_1":var"##step_1_h#988":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#984_1", var"##step_2_l#989"), var"##step_1_h#988")
                                                            for var"##idx#984_3" = var"##idx#984_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#984_2", var"##step_1_l#987"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1006" = size(var"##st#978", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1004" = Base.FastMath.sub_fast(size(var"##st#978", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1002" = 0:var"##Mmax#1004" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1001" = Base.FastMath.add_fast(var"##idx2#1002" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1005" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1001", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1005" ≤ var"##Mmax#1004"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#999_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), 1)
                                                                                            var"##I#999_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), var"##step_1_l#987"), 1)
                                                                                            var"##I#999_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), var"##step_2_l#989"), 1)
                                                                                            var"##I#999_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#1000_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_1"])
                                                                                            var"##T#1000_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_3"]))
                                                                                            var"##T#1000_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_3"]))
                                                                                            var"##T#1000_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_4"])
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_1"] = var"##T#1000_1"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_2"] = var"##T#1000_2"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_3"] = var"##T#1000_3"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1001", 0), var"##I#999_4"] = var"##T#1000_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1003" = var"##idx1#1001":var"##upperbound#1006"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#999_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), 1)
                                                                                            var"##I#999_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), var"##step_1_l#987"), 1)
                                                                                            var"##I#999_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), var"##step_2_l#989"), 1)
                                                                                            var"##I#999_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#984_3", 0), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#1000_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[var"##idx3#1003", var"##I#999_1"])
                                                                                            var"##T#1000_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[var"##idx3#1003", var"##I#999_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[var"##idx3#1003", var"##I#999_3"]))
                                                                                            var"##T#1000_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[var"##idx3#1003", var"##I#999_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[var"##idx3#1003", var"##I#999_3"]))
                                                                                            var"##T#1000_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[var"##idx3#1003", var"##I#999_4"])
                                                                                            var"##st#978"[var"##idx3#1003", var"##I#999_1"] = var"##T#1000_1"
                                                                                            var"##st#978"[var"##idx3#1003", var"##I#999_2"] = var"##T#1000_2"
                                                                                            var"##st#978"[var"##idx3#1003", var"##I#999_3"] = var"##T#1000_3"
                                                                                            var"##st#978"[var"##idx3#1003", var"##I#999_4"] = var"##T#1000_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                    begin
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                        (var"##inner##loop##", var"#803###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#990":Base.FastMath.sub_fast(size(var"##st#978", static(2)), var"##step_2_h#990"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#804###ITER_LENG##" = (ArrayInterface.static_length)(var"#803###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#805###LOOP_STEP##" = (ArrayInterface.static_step)(var"#803###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#806###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#803###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#988#1223", var"####step_2_l#989#1224", var"####step_1_l#987#1226", var"####st#978#1228", var"####hoisted#781#1238", var"####hoisted#782#1240", var"####hoisted#783#1241", var"####hoisted#784#1243", var"####hoisted#785#1244", var"####hoisted#786#1246"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#811#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#984_1#1221" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#984_2#1222" = var"####idx#984_1#1221":var"####step_1_h#988#1223":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#984_1#1221", var"####step_2_l#989#1224"), var"####step_1_h#988#1223")
                                                                                                        for var"####idx#984_3#1225" = var"####idx#984_2#1222":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#984_2#1222", var"####step_1_l#987#1226"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                                                                        var"####upperbound#1006#1227" = size(var"####st#978#1228", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####Mmax#1004#1229" = Base.FastMath.sub_fast(size(var"####st#978#1228", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        for var"####idx2#1002#1230" = 0:var"####Mmax#1004#1229" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                            var"####idx1#1001#1231" = Base.FastMath.add_fast(var"####idx2#1002#1230" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####mmax#1005#1232" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1001#1231", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            if var"####mmax#1005#1232" ≤ var"####Mmax#1004#1229"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#999_1#1233" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), 1)
                                                                                                                                        var"####I#999_2#1234" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), var"####step_1_l#987#1226"), 1)
                                                                                                                                        var"####I#999_3#1235" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), var"####step_2_l#989#1224"), 1)
                                                                                                                                        var"####I#999_4#1236" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), var"####step_1_l#987#1226"), var"####step_2_l#989#1224"), 1)
                                                                                                                                        var"####T#1000_1#1237" = Base.FastMath.mul_fast(var"####hoisted#781#1238", var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_1#1233"])
                                                                                                                                        var"####T#1000_2#1239" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1240", var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_2#1234"]), Base.FastMath.mul_fast(var"####hoisted#783#1241", var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_3#1235"]))
                                                                                                                                        var"####T#1000_3#1242" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1243", var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_2#1234"]), Base.FastMath.mul_fast(var"####hoisted#785#1244", var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_3#1235"]))
                                                                                                                                        var"####T#1000_4#1245" = Base.FastMath.mul_fast(var"####hoisted#786#1246", var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_4#1236"])
                                                                                                                                        var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_1#1233"] = var"####T#1000_1#1237"
                                                                                                                                        var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_2#1234"] = var"####T#1000_2#1239"
                                                                                                                                        var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_3#1235"] = var"####T#1000_3#1242"
                                                                                                                                        var"####st#978#1228"[Base.FastMath.add_fast(var"####idx1#1001#1231", 0), var"####I#999_4#1236"] = var"####T#1000_4#1245"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                                                                for var"####idx3#1003#1247" = var"####idx1#1001#1231":var"####upperbound#1006#1227"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#999_1#1233" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), 1)
                                                                                                                                        var"####I#999_2#1234" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), var"####step_1_l#987#1226"), 1)
                                                                                                                                        var"####I#999_3#1235" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), var"####step_2_l#989#1224"), 1)
                                                                                                                                        var"####I#999_4#1236" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#984_3#1225", 0), var"####step_1_l#987#1226"), var"####step_2_l#989#1224"), 1)
                                                                                                                                        var"####T#1000_1#1237" = Base.FastMath.mul_fast(var"####hoisted#781#1238", var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_1#1233"])
                                                                                                                                        var"####T#1000_2#1239" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1240", var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_2#1234"]), Base.FastMath.mul_fast(var"####hoisted#783#1241", var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_3#1235"]))
                                                                                                                                        var"####T#1000_3#1242" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1243", var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_2#1234"]), Base.FastMath.mul_fast(var"####hoisted#785#1244", var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_3#1235"]))
                                                                                                                                        var"####T#1000_4#1245" = Base.FastMath.mul_fast(var"####hoisted#786#1246", var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_4#1236"])
                                                                                                                                        var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_1#1233"] = var"####T#1000_1#1237"
                                                                                                                                        var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_2#1234"] = var"####T#1000_2#1239"
                                                                                                                                        var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_3#1235"] = var"####T#1000_3#1242"
                                                                                                                                        var"####st#978#1228"[var"####idx3#1003#1247", var"####I#999_4#1236"] = var"####T#1000_4#1245"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#811#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#804###ITER_LENG##", Polyester.min(var"#804###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#806###LOOPOFFSET##", var"#805###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#988", var"##step_2_l#989", var"##step_1_l#987", var"##st#978", var"##hoisted#781", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#978"
                                end
                                if var"##nlocs_needed#983" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#982", var"##plain_locs#981"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:502 =#
                                    var"##m#986" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#982", var"##nlocs_needed#983"), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#987", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#813#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#812#range" = (BQCESubroutine.bsubspace)(var"##nqubits#982", (1:var"##m#986"..., var"##plain_locs#981"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#813#threadsfor_fun"(var"#825#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#817#r" = var"#812#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#818#lenr" = Base.Threads.length(var"#817#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#825#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#819#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#820#len", var"#821#rem") = (var"#818#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#819#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#820#len", var"#821#rem") = Base.Threads.divrem(var"#818#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#820#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#819#tid" > var"#821#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#820#len", var"#821#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#822#f" = Base.Threads.firstindex(var"#817#r") + (var"#819#tid" - 1) * var"#820#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#823#l" = (var"#822#f" + var"#820#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#821#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#819#tid" <= var"#821#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#822#f" = var"#822#f" + (var"#819#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#823#l" = var"#823#l" + var"#819#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#822#f" = var"#822#f" + var"#821#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#823#l" = var"#823#l" + var"#821#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#824#i" = var"#822#f":var"#823#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#985" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#826#val" = var"#817#r"[var"#824#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#826#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                for var"##idx#984_2" = var"##idx#984_1":var"##step_1_h#988":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#984_1", var"##step_2_l#989"), var"##step_1_h#988")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1014" = size(var"##st#978", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1012" = Base.FastMath.sub_fast(size(var"##st#978", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1010" = 0:var"##Mmax#1012" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1009" = Base.FastMath.add_fast(var"##idx2#1010" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1013" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1009", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1013" ≤ var"##Mmax#1012"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1007_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), 1)
                                                                                            var"##I#1007_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), var"##step_1_l#987"), 1)
                                                                                            var"##I#1007_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), var"##step_2_l#989"), 1)
                                                                                            var"##I#1007_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#1008_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_1"])
                                                                                            var"##T#1008_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_3"]))
                                                                                            var"##T#1008_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_3"]))
                                                                                            var"##T#1008_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_4"])
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_1"] = var"##T#1008_1"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_2"] = var"##T#1008_2"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_3"] = var"##T#1008_3"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1009", 0), var"##I#1007_4"] = var"##T#1008_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1011" = var"##idx1#1009":var"##upperbound#1014"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#1007_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), 1)
                                                                                            var"##I#1007_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), var"##step_1_l#987"), 1)
                                                                                            var"##I#1007_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), var"##step_2_l#989"), 1)
                                                                                            var"##I#1007_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_2", 0)), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#1008_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[var"##idx3#1011", var"##I#1007_1"])
                                                                                            var"##T#1008_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[var"##idx3#1011", var"##I#1007_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[var"##idx3#1011", var"##I#1007_3"]))
                                                                                            var"##T#1008_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[var"##idx3#1011", var"##I#1007_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[var"##idx3#1011", var"##I#1007_3"]))
                                                                                            var"##T#1008_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[var"##idx3#1011", var"##I#1007_4"])
                                                                                            var"##st#978"[var"##idx3#1011", var"##I#1007_1"] = var"##T#1008_1"
                                                                                            var"##st#978"[var"##idx3#1011", var"##I#1007_2"] = var"##T#1008_2"
                                                                                            var"##st#978"[var"##idx3#1011", var"##I#1007_3"] = var"##T#1008_3"
                                                                                            var"##st#978"[var"##idx3#1011", var"##I#1007_4"] = var"##T#1008_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#813#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#813#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#978"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#828#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#827#range" = (BQCESubroutine.bsubspace)(var"##nqubits#982", (1:var"##m#986"..., var"##plain_locs#981"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#828#threadsfor_fun"(var"#840#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#832#r" = var"#827#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#833#lenr" = Base.Threads.length(var"#832#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#840#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#834#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#835#len", var"#836#rem") = (var"#833#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#834#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#835#len", var"#836#rem") = Base.Threads.divrem(var"#833#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#835#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#834#tid" > var"#836#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#835#len", var"#836#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#837#f" = Base.Threads.firstindex(var"#832#r") + (var"#834#tid" - 1) * var"#835#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#838#l" = (var"#837#f" + var"#835#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#836#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#834#tid" <= var"#836#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#837#f" = var"#837#f" + (var"#834#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#838#l" = var"#838#l" + var"#834#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#837#f" = var"#837#f" + var"#836#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#838#l" = var"#838#l" + var"#836#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#839#i" = var"#837#f":var"#838#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#985" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#841#val" = var"#832#r"[var"#839#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#841#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#984_2" = var"##idx#984_1":var"##step_1_h#988":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#984_1", var"##step_2_l#989"), var"##step_1_h#988")
                                                            for var"##idx#984_3" = var"##idx#984_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#984_2", var"##step_1_l#987"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1022" = size(var"##st#978", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1020" = Base.FastMath.sub_fast(size(var"##st#978", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1018" = 0:var"##Mmax#1020" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1017" = Base.FastMath.add_fast(var"##idx2#1018" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1021" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1017", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1021" ≤ var"##Mmax#1020"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1015_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), 1)
                                                                                            var"##I#1015_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), var"##step_1_l#987"), 1)
                                                                                            var"##I#1015_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), var"##step_2_l#989"), 1)
                                                                                            var"##I#1015_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#1016_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_1"])
                                                                                            var"##T#1016_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_3"]))
                                                                                            var"##T#1016_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_3"]))
                                                                                            var"##T#1016_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_4"])
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_1"] = var"##T#1016_1"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_2"] = var"##T#1016_2"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_3"] = var"##T#1016_3"
                                                                                            var"##st#978"[Base.FastMath.add_fast(var"##idx1#1017", 0), var"##I#1015_4"] = var"##T#1016_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1019" = var"##idx1#1017":var"##upperbound#1022"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#1015_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), 1)
                                                                                            var"##I#1015_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), var"##step_1_l#987"), 1)
                                                                                            var"##I#1015_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), var"##step_2_l#989"), 1)
                                                                                            var"##I#1015_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", Base.FastMath.add_fast(var"##idx#984_3", 0)), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                            var"##T#1016_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[var"##idx3#1019", var"##I#1015_1"])
                                                                                            var"##T#1016_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[var"##idx3#1019", var"##I#1015_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[var"##idx3#1019", var"##I#1015_3"]))
                                                                                            var"##T#1016_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[var"##idx3#1019", var"##I#1015_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[var"##idx3#1019", var"##I#1015_3"]))
                                                                                            var"##T#1016_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[var"##idx3#1019", var"##I#1015_4"])
                                                                                            var"##st#978"[var"##idx3#1019", var"##I#1015_1"] = var"##T#1016_1"
                                                                                            var"##st#978"[var"##idx3#1019", var"##I#1015_2"] = var"##T#1016_2"
                                                                                            var"##st#978"[var"##idx3#1019", var"##I#1015_3"] = var"##T#1016_3"
                                                                                            var"##st#978"[var"##idx3#1019", var"##I#1015_4"] = var"##T#1016_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            #= threadingconstructs.jl:85 =#
                                            if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                #= threadingconstructs.jl:86 =#
                                                (Base.Threads.Base).invokelatest(var"#828#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#828#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    return var"##st#978"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:510 =#
                                    var"##m#986" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#982", var"##nlocs_needed#983"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#843#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#842#range" = (BQCESubroutine.bsubspace)(var"##nqubits#982", (1:var"##m#986"..., var"##plain_locs#981"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#843#threadsfor_fun"(var"#855#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#847#r" = var"#842#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#848#lenr" = Base.Threads.length(var"#847#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#855#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#849#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#850#len", var"#851#rem") = (var"#848#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#849#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#850#len", var"#851#rem") = Base.Threads.divrem(var"#848#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#850#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#849#tid" > var"#851#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#850#len", var"#851#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#852#f" = Base.Threads.firstindex(var"#847#r") + (var"#849#tid" - 1) * var"#850#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#853#l" = (var"#852#f" + var"#850#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#851#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#849#tid" <= var"#851#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#852#f" = var"#852#f" + (var"#849#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#853#l" = var"#853#l" + var"#849#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#852#f" = var"#852#f" + var"#851#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#853#l" = var"#853#l" + var"#851#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#854#i" = var"#852#f":var"#853#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#985" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#856#val" = var"#847#r"[var"#854#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#856#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                                        for var"##idx#984_1" = 0:Base.FastMath.sub_fast(1 << var"##m#986", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                    var"##upperbound#1030" = size(var"##st#978", 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                    var"##Mmax#1028" = Base.FastMath.sub_fast(size(var"##st#978", 1), 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                    for var"##idx2#1026" = 0:var"##Mmax#1028" >>> 0
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                        var"##idx1#1025" = Base.FastMath.add_fast(var"##idx2#1026" << 0, 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                        var"##mmax#1029" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1025", 0), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                        if var"##mmax#1029" ≤ var"##Mmax#1028"
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                            begin
                                                                                begin
                                                                                    var"##I#1023_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), 1)
                                                                                    var"##I#1023_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), var"##step_1_l#987"), 1)
                                                                                    var"##I#1023_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), var"##step_2_l#989"), 1)
                                                                                    var"##I#1023_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                    var"##T#1024_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_1"])
                                                                                    var"##T#1024_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_3"]))
                                                                                    var"##T#1024_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_3"]))
                                                                                    var"##T#1024_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_4"])
                                                                                    var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_1"] = var"##T#1024_1"
                                                                                    var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_2"] = var"##T#1024_2"
                                                                                    var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_3"] = var"##T#1024_3"
                                                                                    var"##st#978"[Base.FastMath.add_fast(var"##idx1#1025", 0), var"##I#1023_4"] = var"##T#1024_4"
                                                                                end
                                                                            end
                                                                        else
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                            for var"##idx3#1027" = var"##idx1#1025":var"##upperbound#1030"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                begin
                                                                                    var"##I#1023_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), 1)
                                                                                    var"##I#1023_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), var"##step_1_l#987"), 1)
                                                                                    var"##I#1023_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), var"##step_2_l#989"), 1)
                                                                                    var"##I#1023_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#985", var"##idx#984_1"), var"##step_1_l#987"), var"##step_2_l#989"), 1)
                                                                                    var"##T#1024_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#978"[var"##idx3#1027", var"##I#1023_1"])
                                                                                    var"##T#1024_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#978"[var"##idx3#1027", var"##I#1023_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#978"[var"##idx3#1027", var"##I#1023_3"]))
                                                                                    var"##T#1024_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#978"[var"##idx3#1027", var"##I#1023_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#978"[var"##idx3#1027", var"##I#1023_3"]))
                                                                                    var"##T#1024_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#978"[var"##idx3#1027", var"##I#1023_4"])
                                                                                    var"##st#978"[var"##idx3#1027", var"##I#1023_1"] = var"##T#1024_1"
                                                                                    var"##st#978"[var"##idx3#1027", var"##I#1023_2"] = var"##T#1024_2"
                                                                                    var"##st#978"[var"##idx3#1027", var"##I#1023_3"] = var"##T#1024_3"
                                                                                    var"##st#978"[var"##idx3#1027", var"##I#1023_4"] = var"##T#1024_4"
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        #= threadingconstructs.jl:85 =#
                                        if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                            #= threadingconstructs.jl:86 =#
                                            (Base.Threads.Base).invokelatest(var"#843#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#843#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#978"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#793#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#978"
    end
    function BQCESubroutine.broutine!(var"##st#1031"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1032"::Locations, var"##ctrl#956"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#1032") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#1031", Val{:PSWAP_test}(), var"##locs#1032", var"##ctrl#956", θ)
                    return var"##st#1031"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#1032") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#1031", Val{:PSWAP_test}(), var"##locs#1032", var"##ctrl#956", θ)
                return var"##st#1031"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1031"
    end
    function BQCESubroutine.basic_broutine!(var"##st#1033"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1034"::Locations, var"##ctrl#956"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#1035" = (YaoLocations.plain)(var"##locs#1034")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#1035"[1] > var"##plain_locs#1035"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#1034" = Locations((var"##plain_locs#1035"[2], var"##plain_locs#1035"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#1037" = (YaoLocations.plain)(var"##locs#1034")
                    var"##step_1_l#1038" = 1 << (var"##plain_locs#1037"[1] - 1)
                    var"##step_1_h#1039" = 1 << var"##plain_locs#1037"[1]
                    var"##step_2_l#1040" = 1 << (var"##plain_locs#1037"[2] - 1)
                    var"##step_2_h#1041" = 1 << var"##plain_locs#1037"[2]
                    var"##ctrl_mask#1044" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#956"))
                    var"##flag_mask#1045" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#956")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#857#val" = for var"##m#1036_1" = 0:var"##step_2_h#1041":Base.FastMath.sub_fast(size(var"##st#1033", 2), var"##step_2_h#1041"), var"##m#1036_2" = var"##m#1036_1":var"##step_1_h#1039":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#1036_1", var"##step_2_l#1040"), var"##step_1_h#1039"), var"##m#1036_3" = var"##m#1036_2":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#1036_2", var"##step_1_l#1038"), 1)
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                nothing
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                if (BQCESubroutine.ismatch)(var"##m#1036_3", var"##ctrl_mask#1044", var"##flag_mask#1045")
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                    var"##upperbound#1051" = size(var"##st#1033", 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                    var"##Mmax#1049" = Base.FastMath.sub_fast(size(var"##st#1033", 1), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                    for var"##idx2#1047" = 0:var"##Mmax#1049" >>> 3
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                        var"##idx1#1046" = Base.FastMath.add_fast(var"##idx2#1047" << 3, 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                        var"##mmax#1050" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1046", 7), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                        if var"##mmax#1050" ≤ var"##Mmax#1049"
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                            begin
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 0), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 1), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 2), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 3), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 4), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 5), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 6), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_4"])
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[Base.FastMath.add_fast(var"##idx1#1046", 7), var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                            end
                                        else
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                            for var"##idx3#1048" = var"##idx1#1046":var"##upperbound#1051"
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                begin
                                                    var"##I#1042_1" = Base.FastMath.add_fast(var"##m#1036_3", 1)
                                                    var"##I#1042_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), 1)
                                                    var"##I#1042_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_2_l#1040"), 1)
                                                    var"##I#1042_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1036_3", var"##step_1_l#1038"), var"##step_2_l#1040"), 1)
                                                    var"##T#1043_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1033"[var"##idx3#1048", var"##I#1042_1"])
                                                    var"##T#1043_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1033"[var"##idx3#1048", var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1033"[var"##idx3#1048", var"##I#1042_3"]))
                                                    var"##T#1043_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1033"[var"##idx3#1048", var"##I#1042_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1033"[var"##idx3#1048", var"##I#1042_3"]))
                                                    var"##T#1043_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1033"[var"##idx3#1048", var"##I#1042_4"])
                                                    var"##st#1033"[var"##idx3#1048", var"##I#1042_1"] = var"##T#1043_1"
                                                    var"##st#1033"[var"##idx3#1048", var"##I#1042_2"] = var"##T#1043_2"
                                                    var"##st#1033"[var"##idx3#1048", var"##I#1042_3"] = var"##T#1043_3"
                                                    var"##st#1033"[var"##idx3#1048", var"##I#1042_4"] = var"##T#1043_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#857#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1033"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#1054"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1055"::Locations, var"##ctrl#956"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:708 =#
                var"##plain_locs#1056" = (YaoLocations.plain)(var"##locs#1055")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                if var"##plain_locs#1056"[1] > var"##plain_locs#1056"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                    var"##locs#1055" = Locations((var"##plain_locs#1056"[2], var"##plain_locs#1056"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#1057" = (YaoLocations.plain)(var"##locs#1055")
                    var"##nqubits#1058" = (BQCESubroutine.log2i)(size(var"##st#1054", 2))
                    var"##nlocs_needed#1059" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#1063" = 1 << (var"##plain_locs#1057"[1] - 1)
                    var"##step_1_h#1064" = 1 << var"##plain_locs#1057"[1]
                    var"##step_2_l#1065" = 1 << (var"##plain_locs#1057"[2] - 1)
                    var"##step_2_h#1066" = 1 << var"##plain_locs#1057"[2]
                    var"##ctrl_mask#1069" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#956"))
                    var"##flag_mask#1070" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#956")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#781" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#782" = cos(θ / 2)
                    var"##hoisted#783" = -im * sin(θ / 2)
                    var"##hoisted#784" = -im * sin(θ / 2)
                    var"##hoisted#785" = cos(θ / 2)
                    var"##hoisted#786" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#858#val" = begin
                                if var"##nlocs_needed#1059" ≤ Base.FastMath.sub_fast(var"##nqubits#1058", var"##plain_locs#1057"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#1063", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#1060_1" = 0:var"##step_2_h#1066":Base.FastMath.sub_fast(size(var"##st#1054", 2), var"##step_2_h#1066")
                                                                for var"##idx#1060_2" = var"##idx#1060_1":var"##step_1_h#1064":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1060_1", var"##step_2_l#1065"), var"##step_1_h#1064")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##ctrl_mask#1069", var"##flag_mask#1070")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1076" = size(var"##st#1054", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1074" = Base.FastMath.sub_fast(size(var"##st#1054", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1072" = 0:var"##Mmax#1074" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1071" = Base.FastMath.add_fast(var"##idx2#1072" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1075" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1071", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1075" ≤ var"##Mmax#1074"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1067_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), 1)
                                                                                            var"##I#1067_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1067_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1067_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1068_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_1"])
                                                                                            var"##T#1068_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_3"]))
                                                                                            var"##T#1068_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_3"]))
                                                                                            var"##T#1068_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_4"])
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_1"] = var"##T#1068_1"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_2"] = var"##T#1068_2"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_3"] = var"##T#1068_3"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1067_4"] = var"##T#1068_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1073" = var"##idx1#1071":var"##upperbound#1076"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#1067_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), 1)
                                                                                            var"##I#1067_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1067_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1067_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_2", 0), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1068_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[var"##idx3#1073", var"##I#1067_1"])
                                                                                            var"##T#1068_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[var"##idx3#1073", var"##I#1067_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[var"##idx3#1073", var"##I#1067_3"]))
                                                                                            var"##T#1068_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[var"##idx3#1073", var"##I#1067_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[var"##idx3#1073", var"##I#1067_3"]))
                                                                                            var"##T#1068_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[var"##idx3#1073", var"##I#1067_4"])
                                                                                            var"##st#1054"[var"##idx3#1073", var"##I#1067_1"] = var"##T#1068_1"
                                                                                            var"##st#1054"[var"##idx3#1073", var"##I#1067_2"] = var"##T#1068_2"
                                                                                            var"##st#1054"[var"##idx3#1073", var"##I#1067_3"] = var"##T#1068_3"
                                                                                            var"##st#1054"[var"##idx3#1073", var"##I#1067_4"] = var"##T#1068_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    else
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                            begin
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                                (var"##inner##loop##", var"#859###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#1066":Base.FastMath.sub_fast(size(var"##st#1054", static(2)), var"##step_2_h#1066"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#860###ITER_LENG##" = (ArrayInterface.static_length)(var"#859###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#861###LOOP_STEP##" = (ArrayInterface.static_step)(var"#859###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#862###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#859###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#1064#1250", var"####step_2_l#1065#1251", var"####ctrl_mask#1069#1252", var"####flag_mask#1070#1253", var"####st#1054#1255", var"####step_1_l#1063#1262", var"####hoisted#781#1266", var"####hoisted#782#1268", var"####hoisted#783#1269", var"####hoisted#784#1271", var"####hoisted#785#1272", var"####hoisted#786#1274"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#867#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#1060_1#1248" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#1060_2#1249" = var"####idx#1060_1#1248":var"####step_1_h#1064#1250":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1060_1#1248", var"####step_2_l#1065#1251"), var"####step_1_h#1064#1250")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####ctrl_mask#1069#1252", var"####flag_mask#1070#1253")
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                                                                        var"####upperbound#1076#1254" = size(var"####st#1054#1255", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####Mmax#1074#1256" = Base.FastMath.sub_fast(size(var"####st#1054#1255", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        for var"####idx2#1072#1257" = 0:var"####Mmax#1074#1256" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                            var"####idx1#1071#1258" = Base.FastMath.add_fast(var"####idx2#1072#1257" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####mmax#1075#1259" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1071#1258", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            if var"####mmax#1075#1259" ≤ var"####Mmax#1074#1256"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#1067_1#1260" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), 1)
                                                                                                                                        var"####I#1067_2#1261" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####step_1_l#1063#1262"), 1)
                                                                                                                                        var"####I#1067_3#1263" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####step_2_l#1065#1251"), 1)
                                                                                                                                        var"####I#1067_4#1264" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####step_1_l#1063#1262"), var"####step_2_l#1065#1251"), 1)
                                                                                                                                        var"####T#1068_1#1265" = Base.FastMath.mul_fast(var"####hoisted#781#1266", var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_1#1260"])
                                                                                                                                        var"####T#1068_2#1267" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1268", var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_2#1261"]), Base.FastMath.mul_fast(var"####hoisted#783#1269", var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_3#1263"]))
                                                                                                                                        var"####T#1068_3#1270" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1271", var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_2#1261"]), Base.FastMath.mul_fast(var"####hoisted#785#1272", var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_3#1263"]))
                                                                                                                                        var"####T#1068_4#1273" = Base.FastMath.mul_fast(var"####hoisted#786#1274", var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_4#1264"])
                                                                                                                                        var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_1#1260"] = var"####T#1068_1#1265"
                                                                                                                                        var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_2#1261"] = var"####T#1068_2#1267"
                                                                                                                                        var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_3#1263"] = var"####T#1068_3#1270"
                                                                                                                                        var"####st#1054#1255"[Base.FastMath.add_fast(var"####idx1#1071#1258", 0), var"####I#1067_4#1264"] = var"####T#1068_4#1273"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                                                                for var"####idx3#1073#1275" = var"####idx1#1071#1258":var"####upperbound#1076#1254"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#1067_1#1260" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), 1)
                                                                                                                                        var"####I#1067_2#1261" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####step_1_l#1063#1262"), 1)
                                                                                                                                        var"####I#1067_3#1263" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####step_2_l#1065#1251"), 1)
                                                                                                                                        var"####I#1067_4#1264" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_2#1249", 0), var"####step_1_l#1063#1262"), var"####step_2_l#1065#1251"), 1)
                                                                                                                                        var"####T#1068_1#1265" = Base.FastMath.mul_fast(var"####hoisted#781#1266", var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_1#1260"])
                                                                                                                                        var"####T#1068_2#1267" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1268", var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_2#1261"]), Base.FastMath.mul_fast(var"####hoisted#783#1269", var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_3#1263"]))
                                                                                                                                        var"####T#1068_3#1270" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1271", var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_2#1261"]), Base.FastMath.mul_fast(var"####hoisted#785#1272", var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_3#1263"]))
                                                                                                                                        var"####T#1068_4#1273" = Base.FastMath.mul_fast(var"####hoisted#786#1274", var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_4#1264"])
                                                                                                                                        var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_1#1260"] = var"####T#1068_1#1265"
                                                                                                                                        var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_2#1261"] = var"####T#1068_2#1267"
                                                                                                                                        var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_3#1263"] = var"####T#1068_3#1270"
                                                                                                                                        var"####st#1054#1255"[var"####idx3#1073#1275", var"####I#1067_4#1264"] = var"####T#1068_4#1273"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#867#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#860###ITER_LENG##", Polyester.min(var"#860###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#862###LOOPOFFSET##", var"#861###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#1064", var"##step_2_l#1065", var"##ctrl_mask#1069", var"##flag_mask#1070", var"##st#1054", var"##step_1_l#1063", var"##hoisted#781", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#1054"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#1060_1" = 0:var"##step_2_h#1066":Base.FastMath.sub_fast(size(var"##st#1054", 2), var"##step_2_h#1066")
                                                        for var"##idx#1060_2" = var"##idx#1060_1":var"##step_1_h#1064":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1060_1", var"##step_2_l#1065"), var"##step_1_h#1064")
                                                            for var"##idx#1060_3" = var"##idx#1060_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1060_2", var"##step_1_l#1063"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##ctrl_mask#1069", var"##flag_mask#1070")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1084" = size(var"##st#1054", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1082" = Base.FastMath.sub_fast(size(var"##st#1054", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1080" = 0:var"##Mmax#1082" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1079" = Base.FastMath.add_fast(var"##idx2#1080" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1083" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1079", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1083" ≤ var"##Mmax#1082"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1077_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), 1)
                                                                                            var"##I#1077_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1077_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1077_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1078_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_1"])
                                                                                            var"##T#1078_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_3"]))
                                                                                            var"##T#1078_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_3"]))
                                                                                            var"##T#1078_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_4"])
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_1"] = var"##T#1078_1"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_2"] = var"##T#1078_2"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_3"] = var"##T#1078_3"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1079", 0), var"##I#1077_4"] = var"##T#1078_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1081" = var"##idx1#1079":var"##upperbound#1084"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#1077_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), 1)
                                                                                            var"##I#1077_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1077_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1077_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1060_3", 0), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1078_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[var"##idx3#1081", var"##I#1077_1"])
                                                                                            var"##T#1078_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[var"##idx3#1081", var"##I#1077_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[var"##idx3#1081", var"##I#1077_3"]))
                                                                                            var"##T#1078_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[var"##idx3#1081", var"##I#1077_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[var"##idx3#1081", var"##I#1077_3"]))
                                                                                            var"##T#1078_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[var"##idx3#1081", var"##I#1077_4"])
                                                                                            var"##st#1054"[var"##idx3#1081", var"##I#1077_1"] = var"##T#1078_1"
                                                                                            var"##st#1054"[var"##idx3#1081", var"##I#1077_2"] = var"##T#1078_2"
                                                                                            var"##st#1054"[var"##idx3#1081", var"##I#1077_3"] = var"##T#1078_3"
                                                                                            var"##st#1054"[var"##idx3#1081", var"##I#1077_4"] = var"##T#1078_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:311 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:312 =#
                                                    begin
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:259 =#
                                                        (var"##inner##loop##", var"#868###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#1066":Base.FastMath.sub_fast(size(var"##st#1054", static(2)), var"##step_2_h#1066"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#869###ITER_LENG##" = (ArrayInterface.static_length)(var"#868###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#870###LOOP_STEP##" = (ArrayInterface.static_step)(var"#868###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#871###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#868###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#1064#1278", var"####step_2_l#1065#1279", var"####step_1_l#1063#1281", var"####ctrl_mask#1069#1282", var"####flag_mask#1070#1283", var"####st#1054#1285", var"####hoisted#781#1295", var"####hoisted#782#1297", var"####hoisted#783#1298", var"####hoisted#784#1300", var"####hoisted#785#1301", var"####hoisted#786#1303"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#876#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#1060_1#1276" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#1060_2#1277" = var"####idx#1060_1#1276":var"####step_1_h#1064#1278":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1060_1#1276", var"####step_2_l#1065#1279"), var"####step_1_h#1064#1278")
                                                                                                        for var"####idx#1060_3#1280" = var"####idx#1060_2#1277":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1060_2#1277", var"####step_1_l#1063#1281"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####ctrl_mask#1069#1282", var"####flag_mask#1070#1283")
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                                                                        var"####upperbound#1084#1284" = size(var"####st#1054#1285", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####Mmax#1082#1286" = Base.FastMath.sub_fast(size(var"####st#1054#1285", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        for var"####idx2#1080#1287" = 0:var"####Mmax#1082#1286" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                            var"####idx1#1079#1288" = Base.FastMath.add_fast(var"####idx2#1080#1287" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####mmax#1083#1289" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1079#1288", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            if var"####mmax#1083#1289" ≤ var"####Mmax#1082#1286"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#1077_1#1290" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), 1)
                                                                                                                                        var"####I#1077_2#1291" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####step_1_l#1063#1281"), 1)
                                                                                                                                        var"####I#1077_3#1292" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####step_2_l#1065#1279"), 1)
                                                                                                                                        var"####I#1077_4#1293" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####step_1_l#1063#1281"), var"####step_2_l#1065#1279"), 1)
                                                                                                                                        var"####T#1078_1#1294" = Base.FastMath.mul_fast(var"####hoisted#781#1295", var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_1#1290"])
                                                                                                                                        var"####T#1078_2#1296" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1297", var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_2#1291"]), Base.FastMath.mul_fast(var"####hoisted#783#1298", var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_3#1292"]))
                                                                                                                                        var"####T#1078_3#1299" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1300", var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_2#1291"]), Base.FastMath.mul_fast(var"####hoisted#785#1301", var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_3#1292"]))
                                                                                                                                        var"####T#1078_4#1302" = Base.FastMath.mul_fast(var"####hoisted#786#1303", var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_4#1293"])
                                                                                                                                        var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_1#1290"] = var"####T#1078_1#1294"
                                                                                                                                        var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_2#1291"] = var"####T#1078_2#1296"
                                                                                                                                        var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_3#1292"] = var"####T#1078_3#1299"
                                                                                                                                        var"####st#1054#1285"[Base.FastMath.add_fast(var"####idx1#1079#1288", 0), var"####I#1077_4#1293"] = var"####T#1078_4#1302"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                                                                for var"####idx3#1081#1304" = var"####idx1#1079#1288":var"####upperbound#1084#1284"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#1077_1#1290" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), 1)
                                                                                                                                        var"####I#1077_2#1291" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####step_1_l#1063#1281"), 1)
                                                                                                                                        var"####I#1077_3#1292" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####step_2_l#1065#1279"), 1)
                                                                                                                                        var"####I#1077_4#1293" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1060_3#1280", 0), var"####step_1_l#1063#1281"), var"####step_2_l#1065#1279"), 1)
                                                                                                                                        var"####T#1078_1#1294" = Base.FastMath.mul_fast(var"####hoisted#781#1295", var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_1#1290"])
                                                                                                                                        var"####T#1078_2#1296" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#782#1297", var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_2#1291"]), Base.FastMath.mul_fast(var"####hoisted#783#1298", var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_3#1292"]))
                                                                                                                                        var"####T#1078_3#1299" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#784#1300", var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_2#1291"]), Base.FastMath.mul_fast(var"####hoisted#785#1301", var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_3#1292"]))
                                                                                                                                        var"####T#1078_4#1302" = Base.FastMath.mul_fast(var"####hoisted#786#1303", var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_4#1293"])
                                                                                                                                        var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_1#1290"] = var"####T#1078_1#1294"
                                                                                                                                        var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_2#1291"] = var"####T#1078_2#1296"
                                                                                                                                        var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_3#1292"] = var"####T#1078_3#1299"
                                                                                                                                        var"####st#1054#1285"[var"####idx3#1081#1304", var"####I#1077_4#1293"] = var"####T#1078_4#1302"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#876#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#869###ITER_LENG##", Polyester.min(var"#869###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#871###LOOPOFFSET##", var"#870###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#1064", var"##step_2_l#1065", var"##step_1_l#1063", var"##ctrl_mask#1069", var"##flag_mask#1070", var"##st#1054", var"##hoisted#781", var"##hoisted#782", var"##hoisted#783", var"##hoisted#784", var"##hoisted#785", var"##hoisted#786")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#1054"
                                end
                                if var"##nlocs_needed#1059" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1058", var"##plain_locs#1057"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:502 =#
                                    var"##m#1062" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1058", var"##nlocs_needed#1059"), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#1063", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#878#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#877#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1058", (1:var"##m#1062"..., var"##plain_locs#1057"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#878#threadsfor_fun"(var"#890#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#882#r" = var"#877#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#883#lenr" = Base.Threads.length(var"#882#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#890#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#884#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#885#len", var"#886#rem") = (var"#883#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#884#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#885#len", var"#886#rem") = Base.Threads.divrem(var"#883#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#885#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#884#tid" > var"#886#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#885#len", var"#886#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#887#f" = Base.Threads.firstindex(var"#882#r") + (var"#884#tid" - 1) * var"#885#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#888#l" = (var"#887#f" + var"#885#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#886#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#884#tid" <= var"#886#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#887#f" = var"#887#f" + (var"#884#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#888#l" = var"#888#l" + var"#884#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#887#f" = var"#887#f" + var"#886#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#888#l" = var"#888#l" + var"#886#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#889#i" = var"#887#f":var"#888#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#1061" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#891#val" = var"#882#r"[var"#889#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#891#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                for var"##idx#1060_2" = var"##idx#1060_1":var"##step_1_h#1064":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1060_1", var"##step_2_l#1065"), var"##step_1_h#1064")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##ctrl_mask#1069", var"##flag_mask#1070")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1092" = size(var"##st#1054", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1090" = Base.FastMath.sub_fast(size(var"##st#1054", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1088" = 0:var"##Mmax#1090" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1087" = Base.FastMath.add_fast(var"##idx2#1088" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1091" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1087", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1091" ≤ var"##Mmax#1090"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1085_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), 1)
                                                                                            var"##I#1085_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1085_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1085_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1086_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_1"])
                                                                                            var"##T#1086_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_3"]))
                                                                                            var"##T#1086_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_3"]))
                                                                                            var"##T#1086_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_4"])
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_1"] = var"##T#1086_1"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_2"] = var"##T#1086_2"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_3"] = var"##T#1086_3"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1087", 0), var"##I#1085_4"] = var"##T#1086_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1089" = var"##idx1#1087":var"##upperbound#1092"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#1085_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), 1)
                                                                                            var"##I#1085_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1085_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1085_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_2", 0)), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1086_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[var"##idx3#1089", var"##I#1085_1"])
                                                                                            var"##T#1086_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[var"##idx3#1089", var"##I#1085_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[var"##idx3#1089", var"##I#1085_3"]))
                                                                                            var"##T#1086_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[var"##idx3#1089", var"##I#1085_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[var"##idx3#1089", var"##I#1085_3"]))
                                                                                            var"##T#1086_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[var"##idx3#1089", var"##I#1085_4"])
                                                                                            var"##st#1054"[var"##idx3#1089", var"##I#1085_1"] = var"##T#1086_1"
                                                                                            var"##st#1054"[var"##idx3#1089", var"##I#1085_2"] = var"##T#1086_2"
                                                                                            var"##st#1054"[var"##idx3#1089", var"##I#1085_3"] = var"##T#1086_3"
                                                                                            var"##st#1054"[var"##idx3#1089", var"##I#1085_4"] = var"##T#1086_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#878#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#878#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#1054"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#893#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#892#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1058", (1:var"##m#1062"..., var"##plain_locs#1057"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#893#threadsfor_fun"(var"#905#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#897#r" = var"#892#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#898#lenr" = Base.Threads.length(var"#897#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#905#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#899#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#900#len", var"#901#rem") = (var"#898#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#899#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#900#len", var"#901#rem") = Base.Threads.divrem(var"#898#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#900#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#899#tid" > var"#901#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#900#len", var"#901#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#902#f" = Base.Threads.firstindex(var"#897#r") + (var"#899#tid" - 1) * var"#900#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#903#l" = (var"#902#f" + var"#900#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#901#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#899#tid" <= var"#901#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#902#f" = var"#902#f" + (var"#899#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#903#l" = var"#903#l" + var"#899#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#902#f" = var"#902#f" + var"#901#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#903#l" = var"#903#l" + var"#901#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#904#i" = var"#902#f":var"#903#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#1061" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#906#val" = var"#897#r"[var"#904#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#906#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#1060_2" = var"##idx#1060_1":var"##step_1_h#1064":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1060_1", var"##step_2_l#1065"), var"##step_1_h#1064")
                                                            for var"##idx#1060_3" = var"##idx#1060_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1060_2", var"##step_1_l#1063"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##ctrl_mask#1069", var"##flag_mask#1070")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                            var"##upperbound#1100" = size(var"##st#1054", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##Mmax#1098" = Base.FastMath.sub_fast(size(var"##st#1054", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            for var"##idx2#1096" = 0:var"##Mmax#1098" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                var"##idx1#1095" = Base.FastMath.add_fast(var"##idx2#1096" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##mmax#1099" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1095", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                if var"##mmax#1099" ≤ var"##Mmax#1098"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1093_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), 1)
                                                                                            var"##I#1093_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1093_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1093_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1094_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_1"])
                                                                                            var"##T#1094_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_3"]))
                                                                                            var"##T#1094_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_3"]))
                                                                                            var"##T#1094_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_4"])
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_1"] = var"##T#1094_1"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_2"] = var"##T#1094_2"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_3"] = var"##T#1094_3"
                                                                                            var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1095", 0), var"##I#1093_4"] = var"##T#1094_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                                    for var"##idx3#1097" = var"##idx1#1095":var"##upperbound#1100"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                        begin
                                                                                            var"##I#1093_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), 1)
                                                                                            var"##I#1093_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##step_1_l#1063"), 1)
                                                                                            var"##I#1093_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##step_2_l#1065"), 1)
                                                                                            var"##I#1093_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", Base.FastMath.add_fast(var"##idx#1060_3", 0)), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                            var"##T#1094_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[var"##idx3#1097", var"##I#1093_1"])
                                                                                            var"##T#1094_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[var"##idx3#1097", var"##I#1093_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[var"##idx3#1097", var"##I#1093_3"]))
                                                                                            var"##T#1094_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[var"##idx3#1097", var"##I#1093_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[var"##idx3#1097", var"##I#1093_3"]))
                                                                                            var"##T#1094_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[var"##idx3#1097", var"##I#1093_4"])
                                                                                            var"##st#1054"[var"##idx3#1097", var"##I#1093_1"] = var"##T#1094_1"
                                                                                            var"##st#1054"[var"##idx3#1097", var"##I#1093_2"] = var"##T#1094_2"
                                                                                            var"##st#1054"[var"##idx3#1097", var"##I#1093_3"] = var"##T#1094_3"
                                                                                            var"##st#1054"[var"##idx3#1097", var"##I#1093_4"] = var"##T#1094_4"
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            #= threadingconstructs.jl:85 =#
                                            if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                #= threadingconstructs.jl:86 =#
                                                (Base.Threads.Base).invokelatest(var"#893#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#893#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    return var"##st#1054"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:510 =#
                                    var"##m#1062" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1058", var"##nlocs_needed#1059"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#908#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#907#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1058", (1:var"##m#1062"..., var"##plain_locs#1057"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#908#threadsfor_fun"(var"#920#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#912#r" = var"#907#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#913#lenr" = Base.Threads.length(var"#912#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#920#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#914#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#915#len", var"#916#rem") = (var"#913#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#914#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#915#len", var"#916#rem") = Base.Threads.divrem(var"#913#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#915#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#914#tid" > var"#916#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#915#len", var"#916#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#917#f" = Base.Threads.firstindex(var"#912#r") + (var"#914#tid" - 1) * var"#915#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#918#l" = (var"#917#f" + var"#915#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#916#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#914#tid" <= var"#916#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#917#f" = var"#917#f" + (var"#914#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#918#l" = var"#918#l" + var"#914#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#917#f" = var"#917#f" + var"#916#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#918#l" = var"#918#l" + var"#916#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#919#i" = var"#917#f":var"#918#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#1061" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#921#val" = var"#912#r"[var"#919#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#921#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                                        for var"##idx#1060_1" = 0:Base.FastMath.sub_fast(1 << var"##m#1062", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##ctrl_mask#1069", var"##flag_mask#1070")
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:680 =#
                                                                    var"##upperbound#1108" = size(var"##st#1054", 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                    var"##Mmax#1106" = Base.FastMath.sub_fast(size(var"##st#1054", 1), 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                    for var"##idx2#1104" = 0:var"##Mmax#1106" >>> 0
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                        var"##idx1#1103" = Base.FastMath.add_fast(var"##idx2#1104" << 0, 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                        var"##mmax#1107" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1103", 0), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                        if var"##mmax#1107" ≤ var"##Mmax#1106"
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                            begin
                                                                                begin
                                                                                    var"##I#1101_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), 1)
                                                                                    var"##I#1101_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##step_1_l#1063"), 1)
                                                                                    var"##I#1101_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##step_2_l#1065"), 1)
                                                                                    var"##I#1101_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                    var"##T#1102_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_1"])
                                                                                    var"##T#1102_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_3"]))
                                                                                    var"##T#1102_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_3"]))
                                                                                    var"##T#1102_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_4"])
                                                                                    var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_1"] = var"##T#1102_1"
                                                                                    var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_2"] = var"##T#1102_2"
                                                                                    var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_3"] = var"##T#1102_3"
                                                                                    var"##st#1054"[Base.FastMath.add_fast(var"##idx1#1103", 0), var"##I#1101_4"] = var"##T#1102_4"
                                                                                end
                                                                            end
                                                                        else
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:667 =#
                                                                            for var"##idx3#1105" = var"##idx1#1103":var"##upperbound#1108"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                begin
                                                                                    var"##I#1101_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), 1)
                                                                                    var"##I#1101_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##step_1_l#1063"), 1)
                                                                                    var"##I#1101_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##step_2_l#1065"), 1)
                                                                                    var"##I#1101_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1061", var"##idx#1060_1"), var"##step_1_l#1063"), var"##step_2_l#1065"), 1)
                                                                                    var"##T#1102_1" = Base.FastMath.mul_fast(var"##hoisted#781", var"##st#1054"[var"##idx3#1105", var"##I#1101_1"])
                                                                                    var"##T#1102_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#782", var"##st#1054"[var"##idx3#1105", var"##I#1101_2"]), Base.FastMath.mul_fast(var"##hoisted#783", var"##st#1054"[var"##idx3#1105", var"##I#1101_3"]))
                                                                                    var"##T#1102_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#784", var"##st#1054"[var"##idx3#1105", var"##I#1101_2"]), Base.FastMath.mul_fast(var"##hoisted#785", var"##st#1054"[var"##idx3#1105", var"##I#1101_3"]))
                                                                                    var"##T#1102_4" = Base.FastMath.mul_fast(var"##hoisted#786", var"##st#1054"[var"##idx3#1105", var"##I#1101_4"])
                                                                                    var"##st#1054"[var"##idx3#1105", var"##I#1101_1"] = var"##T#1102_1"
                                                                                    var"##st#1054"[var"##idx3#1105", var"##I#1101_2"] = var"##T#1102_2"
                                                                                    var"##st#1054"[var"##idx3#1105", var"##I#1101_3"] = var"##T#1102_3"
                                                                                    var"##st#1054"[var"##idx3#1105", var"##I#1101_4"] = var"##T#1102_4"
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        #= threadingconstructs.jl:85 =#
                                        if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                            #= threadingconstructs.jl:86 =#
                                            (Base.Threads.Base).invokelatest(var"#908#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#908#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#1054"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#858#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1054"
    end
    # function $(Expr(:where, :(BPSWAP_test(θ))))
    #     [-im * sin(θ / 2) + cos(θ / 2) 0 0 0; 0 cos(θ / 2) -im * sin(θ / 2) 0; 0 -im * sin(θ / 2) cos(θ / 2) 0; 0 0 0 -im * sin(θ / 2) + cos(θ / 2)]
    # end
end

eval(prog)
