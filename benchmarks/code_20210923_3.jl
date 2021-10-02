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
    function BQCESubroutine.broutine!(var"##st#834"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#835"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#835") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#834", Val{:PSWAP_test}(), var"##locs#835", θ)
                    return var"##st#834"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#835") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#834", Val{:PSWAP_test}(), var"##locs#835", θ)
                return var"##st#834"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#834"
    end
    function BQCESubroutine.basic_broutine!(var"##st#836"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#837"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#838" = (YaoLocations.plain)(var"##locs#837")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#838"[1] > var"##plain_locs#838"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#837" = Locations((var"##plain_locs#838"[2], var"##plain_locs#838"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#840" = (YaoLocations.plain)(var"##locs#837")
                    var"##step_1_l#841" = 1 << (var"##plain_locs#840"[1] - 1)
                    var"##step_1_h#842" = 1 << var"##plain_locs#840"[1]
                    var"##step_2_l#843" = 1 << (var"##plain_locs#840"[2] - 1)
                    var"##step_2_h#844" = 1 << var"##plain_locs#840"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#339#val" = begin
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#841", 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#839_1" = 0:var"##step_2_h#844":Base.FastMath.sub_fast(size(var"##st#836", 1), var"##step_2_h#844"), var"##m#839_2" = var"##m#839_1":var"##step_1_h#842":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#839_1", var"##step_2_l#843"), var"##step_1_h#842")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#845_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), 1)
                                                    var"##I#845_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), 1)
                                                    var"##I#845_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_2_l#843"), 1)
                                                    var"##I#845_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#846_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#845_1"])
                                                    var"##T#846_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#845_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#845_3"]))
                                                    var"##T#846_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#845_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#845_3"]))
                                                    var"##T#846_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#845_4"])
                                                    var"##st#836"[var"##I#845_1"] = var"##T#846_1"
                                                    var"##st#836"[var"##I#845_2"] = var"##T#846_2"
                                                    var"##st#836"[var"##I#845_3"] = var"##T#846_3"
                                                    var"##st#836"[var"##I#845_4"] = var"##T#846_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#836"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#841", 2)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#839_1" = 0:var"##step_2_h#844":Base.FastMath.sub_fast(size(var"##st#836", 1), var"##step_2_h#844"), var"##m#839_2" = var"##m#839_1":var"##step_1_h#842":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#839_1", var"##step_2_l#843"), var"##step_1_h#842")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#847_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), 1)
                                                    var"##I#847_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), 1)
                                                    var"##I#847_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_2_l#843"), 1)
                                                    var"##I#847_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#848_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#847_1"])
                                                    var"##T#848_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#847_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#847_3"]))
                                                    var"##T#848_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#847_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#847_3"]))
                                                    var"##T#848_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#847_4"])
                                                    var"##st#836"[var"##I#847_1"] = var"##T#848_1"
                                                    var"##st#836"[var"##I#847_2"] = var"##T#848_2"
                                                    var"##st#836"[var"##I#847_3"] = var"##T#848_3"
                                                    var"##st#836"[var"##I#847_4"] = var"##T#848_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#849_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), 1)
                                                    var"##I#849_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_1_l#841"), 1)
                                                    var"##I#849_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_2_l#843"), 1)
                                                    var"##I#849_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#850_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#849_1"])
                                                    var"##T#850_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#849_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#849_3"]))
                                                    var"##T#850_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#849_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#849_3"]))
                                                    var"##T#850_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#849_4"])
                                                    var"##st#836"[var"##I#849_1"] = var"##T#850_1"
                                                    var"##st#836"[var"##I#849_2"] = var"##T#850_2"
                                                    var"##st#836"[var"##I#849_3"] = var"##T#850_3"
                                                    var"##st#836"[var"##I#849_4"] = var"##T#850_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#836"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#841", 4)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#839_1" = 0:var"##step_2_h#844":Base.FastMath.sub_fast(size(var"##st#836", 1), var"##step_2_h#844"), var"##m#839_2" = var"##m#839_1":var"##step_1_h#842":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#839_1", var"##step_2_l#843"), var"##step_1_h#842")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#851_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), 1)
                                                    var"##I#851_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), 1)
                                                    var"##I#851_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_2_l#843"), 1)
                                                    var"##I#851_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#852_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#851_1"])
                                                    var"##T#852_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#851_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#851_3"]))
                                                    var"##T#852_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#851_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#851_3"]))
                                                    var"##T#852_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#851_4"])
                                                    var"##st#836"[var"##I#851_1"] = var"##T#852_1"
                                                    var"##st#836"[var"##I#851_2"] = var"##T#852_2"
                                                    var"##st#836"[var"##I#851_3"] = var"##T#852_3"
                                                    var"##st#836"[var"##I#851_4"] = var"##T#852_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#853_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), 1)
                                                    var"##I#853_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_1_l#841"), 1)
                                                    var"##I#853_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_2_l#843"), 1)
                                                    var"##I#853_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#854_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#853_1"])
                                                    var"##T#854_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#853_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#853_3"]))
                                                    var"##T#854_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#853_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#853_3"]))
                                                    var"##T#854_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#853_4"])
                                                    var"##st#836"[var"##I#853_1"] = var"##T#854_1"
                                                    var"##st#836"[var"##I#853_2"] = var"##T#854_2"
                                                    var"##st#836"[var"##I#853_3"] = var"##T#854_3"
                                                    var"##st#836"[var"##I#853_4"] = var"##T#854_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#855_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), 1)
                                                    var"##I#855_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), var"##step_1_l#841"), 1)
                                                    var"##I#855_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), var"##step_2_l#843"), 1)
                                                    var"##I#855_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#856_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#855_1"])
                                                    var"##T#856_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#855_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#855_3"]))
                                                    var"##T#856_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#855_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#855_3"]))
                                                    var"##T#856_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#855_4"])
                                                    var"##st#836"[var"##I#855_1"] = var"##T#856_1"
                                                    var"##st#836"[var"##I#855_2"] = var"##T#856_2"
                                                    var"##st#836"[var"##I#855_3"] = var"##T#856_3"
                                                    var"##st#836"[var"##I#855_4"] = var"##T#856_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#857_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), 1)
                                                    var"##I#857_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), var"##step_1_l#841"), 1)
                                                    var"##I#857_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), var"##step_2_l#843"), 1)
                                                    var"##I#857_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#858_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#857_1"])
                                                    var"##T#858_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#857_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#857_3"]))
                                                    var"##T#858_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#857_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#857_3"]))
                                                    var"##T#858_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#857_4"])
                                                    var"##st#836"[var"##I#857_1"] = var"##T#858_1"
                                                    var"##st#836"[var"##I#857_2"] = var"##T#858_2"
                                                    var"##st#836"[var"##I#857_3"] = var"##T#858_3"
                                                    var"##st#836"[var"##I#857_4"] = var"##T#858_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#836"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#841", 8)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#839_1" = 0:var"##step_2_h#844":Base.FastMath.sub_fast(size(var"##st#836", 1), var"##step_2_h#844"), var"##m#839_2" = var"##m#839_1":var"##step_1_h#842":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#839_1", var"##step_2_l#843"), var"##step_1_h#842")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#859_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), 1)
                                                    var"##I#859_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), 1)
                                                    var"##I#859_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_2_l#843"), 1)
                                                    var"##I#859_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 0), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#860_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#859_1"])
                                                    var"##T#860_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#859_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#859_3"]))
                                                    var"##T#860_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#859_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#859_3"]))
                                                    var"##T#860_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#859_4"])
                                                    var"##st#836"[var"##I#859_1"] = var"##T#860_1"
                                                    var"##st#836"[var"##I#859_2"] = var"##T#860_2"
                                                    var"##st#836"[var"##I#859_3"] = var"##T#860_3"
                                                    var"##st#836"[var"##I#859_4"] = var"##T#860_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#861_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), 1)
                                                    var"##I#861_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_1_l#841"), 1)
                                                    var"##I#861_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_2_l#843"), 1)
                                                    var"##I#861_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 1), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#862_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#861_1"])
                                                    var"##T#862_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#861_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#861_3"]))
                                                    var"##T#862_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#861_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#861_3"]))
                                                    var"##T#862_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#861_4"])
                                                    var"##st#836"[var"##I#861_1"] = var"##T#862_1"
                                                    var"##st#836"[var"##I#861_2"] = var"##T#862_2"
                                                    var"##st#836"[var"##I#861_3"] = var"##T#862_3"
                                                    var"##st#836"[var"##I#861_4"] = var"##T#862_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#863_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), 1)
                                                    var"##I#863_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), var"##step_1_l#841"), 1)
                                                    var"##I#863_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), var"##step_2_l#843"), 1)
                                                    var"##I#863_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 2), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#864_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#863_1"])
                                                    var"##T#864_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#863_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#863_3"]))
                                                    var"##T#864_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#863_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#863_3"]))
                                                    var"##T#864_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#863_4"])
                                                    var"##st#836"[var"##I#863_1"] = var"##T#864_1"
                                                    var"##st#836"[var"##I#863_2"] = var"##T#864_2"
                                                    var"##st#836"[var"##I#863_3"] = var"##T#864_3"
                                                    var"##st#836"[var"##I#863_4"] = var"##T#864_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#865_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), 1)
                                                    var"##I#865_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), var"##step_1_l#841"), 1)
                                                    var"##I#865_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), var"##step_2_l#843"), 1)
                                                    var"##I#865_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 3), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#866_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#865_1"])
                                                    var"##T#866_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#865_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#865_3"]))
                                                    var"##T#866_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#865_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#865_3"]))
                                                    var"##T#866_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#865_4"])
                                                    var"##st#836"[var"##I#865_1"] = var"##T#866_1"
                                                    var"##st#836"[var"##I#865_2"] = var"##T#866_2"
                                                    var"##st#836"[var"##I#865_3"] = var"##T#866_3"
                                                    var"##st#836"[var"##I#865_4"] = var"##T#866_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#867_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 4), 1)
                                                    var"##I#867_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 4), var"##step_1_l#841"), 1)
                                                    var"##I#867_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 4), var"##step_2_l#843"), 1)
                                                    var"##I#867_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 4), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#868_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#867_1"])
                                                    var"##T#868_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#867_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#867_3"]))
                                                    var"##T#868_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#867_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#867_3"]))
                                                    var"##T#868_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#867_4"])
                                                    var"##st#836"[var"##I#867_1"] = var"##T#868_1"
                                                    var"##st#836"[var"##I#867_2"] = var"##T#868_2"
                                                    var"##st#836"[var"##I#867_3"] = var"##T#868_3"
                                                    var"##st#836"[var"##I#867_4"] = var"##T#868_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#869_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 5), 1)
                                                    var"##I#869_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 5), var"##step_1_l#841"), 1)
                                                    var"##I#869_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 5), var"##step_2_l#843"), 1)
                                                    var"##I#869_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 5), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#870_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#869_1"])
                                                    var"##T#870_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#869_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#869_3"]))
                                                    var"##T#870_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#869_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#869_3"]))
                                                    var"##T#870_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#869_4"])
                                                    var"##st#836"[var"##I#869_1"] = var"##T#870_1"
                                                    var"##st#836"[var"##I#869_2"] = var"##T#870_2"
                                                    var"##st#836"[var"##I#869_3"] = var"##T#870_3"
                                                    var"##st#836"[var"##I#869_4"] = var"##T#870_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#871_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 6), 1)
                                                    var"##I#871_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 6), var"##step_1_l#841"), 1)
                                                    var"##I#871_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 6), var"##step_2_l#843"), 1)
                                                    var"##I#871_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 6), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#872_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#871_1"])
                                                    var"##T#872_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#871_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#871_3"]))
                                                    var"##T#872_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#871_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#871_3"]))
                                                    var"##T#872_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#871_4"])
                                                    var"##st#836"[var"##I#871_1"] = var"##T#872_1"
                                                    var"##st#836"[var"##I#871_2"] = var"##T#872_2"
                                                    var"##st#836"[var"##I#871_3"] = var"##T#872_3"
                                                    var"##st#836"[var"##I#871_4"] = var"##T#872_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#873_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 7), 1)
                                                    var"##I#873_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 7), var"##step_1_l#841"), 1)
                                                    var"##I#873_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 7), var"##step_2_l#843"), 1)
                                                    var"##I#873_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_2", 7), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#874_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#873_1"])
                                                    var"##T#874_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#873_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#873_3"]))
                                                    var"##T#874_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#873_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#873_3"]))
                                                    var"##T#874_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#873_4"])
                                                    var"##st#836"[var"##I#873_1"] = var"##T#874_1"
                                                    var"##st#836"[var"##I#873_2"] = var"##T#874_2"
                                                    var"##st#836"[var"##I#873_3"] = var"##T#874_3"
                                                    var"##st#836"[var"##I#873_4"] = var"##T#874_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#836"
                                    end
                                end
                                for var"##m#839_1" = 0:var"##step_2_h#844":Base.FastMath.sub_fast(size(var"##st#836", 1), var"##step_2_h#844"), var"##m#839_2" = var"##m#839_1":var"##step_1_h#842":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#839_1", var"##step_2_l#843"), var"##step_1_h#842")
                                    for var"##m#839_3" = var"##m#839_2":8:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#839_2", var"##step_1_l#841"), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                        begin
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#875_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 0), 1)
                                                    var"##I#875_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 0), var"##step_1_l#841"), 1)
                                                    var"##I#875_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 0), var"##step_2_l#843"), 1)
                                                    var"##I#875_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 0), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#876_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#875_1"])
                                                    var"##T#876_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#875_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#875_3"]))
                                                    var"##T#876_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#875_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#875_3"]))
                                                    var"##T#876_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#875_4"])
                                                    var"##st#836"[var"##I#875_1"] = var"##T#876_1"
                                                    var"##st#836"[var"##I#875_2"] = var"##T#876_2"
                                                    var"##st#836"[var"##I#875_3"] = var"##T#876_3"
                                                    var"##st#836"[var"##I#875_4"] = var"##T#876_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#877_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 1), 1)
                                                    var"##I#877_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 1), var"##step_1_l#841"), 1)
                                                    var"##I#877_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 1), var"##step_2_l#843"), 1)
                                                    var"##I#877_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 1), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#878_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#877_1"])
                                                    var"##T#878_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#877_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#877_3"]))
                                                    var"##T#878_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#877_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#877_3"]))
                                                    var"##T#878_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#877_4"])
                                                    var"##st#836"[var"##I#877_1"] = var"##T#878_1"
                                                    var"##st#836"[var"##I#877_2"] = var"##T#878_2"
                                                    var"##st#836"[var"##I#877_3"] = var"##T#878_3"
                                                    var"##st#836"[var"##I#877_4"] = var"##T#878_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#879_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 2), 1)
                                                    var"##I#879_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 2), var"##step_1_l#841"), 1)
                                                    var"##I#879_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 2), var"##step_2_l#843"), 1)
                                                    var"##I#879_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 2), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#880_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#879_1"])
                                                    var"##T#880_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#879_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#879_3"]))
                                                    var"##T#880_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#879_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#879_3"]))
                                                    var"##T#880_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#879_4"])
                                                    var"##st#836"[var"##I#879_1"] = var"##T#880_1"
                                                    var"##st#836"[var"##I#879_2"] = var"##T#880_2"
                                                    var"##st#836"[var"##I#879_3"] = var"##T#880_3"
                                                    var"##st#836"[var"##I#879_4"] = var"##T#880_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#881_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 3), 1)
                                                    var"##I#881_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 3), var"##step_1_l#841"), 1)
                                                    var"##I#881_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 3), var"##step_2_l#843"), 1)
                                                    var"##I#881_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 3), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#882_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#881_1"])
                                                    var"##T#882_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#881_3"]))
                                                    var"##T#882_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#881_3"]))
                                                    var"##T#882_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#881_4"])
                                                    var"##st#836"[var"##I#881_1"] = var"##T#882_1"
                                                    var"##st#836"[var"##I#881_2"] = var"##T#882_2"
                                                    var"##st#836"[var"##I#881_3"] = var"##T#882_3"
                                                    var"##st#836"[var"##I#881_4"] = var"##T#882_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#883_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 4), 1)
                                                    var"##I#883_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 4), var"##step_1_l#841"), 1)
                                                    var"##I#883_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 4), var"##step_2_l#843"), 1)
                                                    var"##I#883_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 4), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#884_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#883_1"])
                                                    var"##T#884_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#883_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#883_3"]))
                                                    var"##T#884_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#883_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#883_3"]))
                                                    var"##T#884_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#883_4"])
                                                    var"##st#836"[var"##I#883_1"] = var"##T#884_1"
                                                    var"##st#836"[var"##I#883_2"] = var"##T#884_2"
                                                    var"##st#836"[var"##I#883_3"] = var"##T#884_3"
                                                    var"##st#836"[var"##I#883_4"] = var"##T#884_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#885_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 5), 1)
                                                    var"##I#885_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 5), var"##step_1_l#841"), 1)
                                                    var"##I#885_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 5), var"##step_2_l#843"), 1)
                                                    var"##I#885_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 5), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#886_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#885_1"])
                                                    var"##T#886_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#885_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#885_3"]))
                                                    var"##T#886_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#885_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#885_3"]))
                                                    var"##T#886_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#885_4"])
                                                    var"##st#836"[var"##I#885_1"] = var"##T#886_1"
                                                    var"##st#836"[var"##I#885_2"] = var"##T#886_2"
                                                    var"##st#836"[var"##I#885_3"] = var"##T#886_3"
                                                    var"##st#836"[var"##I#885_4"] = var"##T#886_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#887_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 6), 1)
                                                    var"##I#887_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 6), var"##step_1_l#841"), 1)
                                                    var"##I#887_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 6), var"##step_2_l#843"), 1)
                                                    var"##I#887_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 6), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#888_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#887_1"])
                                                    var"##T#888_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#887_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#887_3"]))
                                                    var"##T#888_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#887_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#887_3"]))
                                                    var"##T#888_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#887_4"])
                                                    var"##st#836"[var"##I#887_1"] = var"##T#888_1"
                                                    var"##st#836"[var"##I#887_2"] = var"##T#888_2"
                                                    var"##st#836"[var"##I#887_3"] = var"##T#888_3"
                                                    var"##st#836"[var"##I#887_4"] = var"##T#888_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#889_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 7), 1)
                                                    var"##I#889_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 7), var"##step_1_l#841"), 1)
                                                    var"##I#889_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 7), var"##step_2_l#843"), 1)
                                                    var"##I#889_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#839_3", 7), var"##step_1_l#841"), var"##step_2_l#843"), 1)
                                                    var"##T#890_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#836"[var"##I#889_1"])
                                                    var"##T#890_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#836"[var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#836"[var"##I#889_3"]))
                                                    var"##T#890_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#836"[var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#836"[var"##I#889_3"]))
                                                    var"##T#890_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#836"[var"##I#889_4"])
                                                    var"##st#836"[var"##I#889_1"] = var"##T#890_1"
                                                    var"##st#836"[var"##I#889_2"] = var"##T#890_2"
                                                    var"##st#836"[var"##I#889_3"] = var"##T#890_3"
                                                    var"##st#836"[var"##I#889_4"] = var"##T#890_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#339#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#836"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#893"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#894"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#895" = (YaoLocations.plain)(var"##locs#894")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#895"[1] > var"##plain_locs#895"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#894" = Locations((var"##plain_locs#895"[2], var"##plain_locs#895"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#896" = (YaoLocations.plain)(var"##locs#894")
                    var"##nqubits#897" = (BQCESubroutine.log2i)(size(var"##st#893", 1))
                    var"##nlocs_needed#898" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#902" = 1 << (var"##plain_locs#896"[1] - 1)
                    var"##step_1_h#903" = 1 << var"##plain_locs#896"[1]
                    var"##step_2_l#904" = 1 << (var"##plain_locs#896"[2] - 1)
                    var"##step_2_h#905" = 1 << var"##plain_locs#896"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#340#val" = begin
                                if var"##nlocs_needed#898" ≤ Base.FastMath.sub_fast(var"##nqubits#897", var"##plain_locs#896"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#902", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#899_1" = 0:var"##step_2_h#905":Base.FastMath.sub_fast(size(var"##st#893", 1), var"##step_2_h#905")
                                                                for var"##idx#899_2" = var"##idx#899_1":var"##step_1_h#903":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#899_1", var"##step_2_l#904"), var"##step_1_h#903")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#906_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), 1)
                                                                            var"##I#906_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), var"##step_1_l#902"), 1)
                                                                            var"##I#906_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), var"##step_2_l#904"), 1)
                                                                            var"##I#906_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), var"##step_1_l#902"), var"##step_2_l#904"), 1)
                                                                            var"##T#907_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#893"[var"##I#906_1"])
                                                                            var"##T#907_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#893"[var"##I#906_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#893"[var"##I#906_3"]))
                                                                            var"##T#907_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#893"[var"##I#906_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#893"[var"##I#906_3"]))
                                                                            var"##T#907_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#893"[var"##I#906_4"])
                                                                            var"##st#893"[var"##I#906_1"] = var"##T#907_1"
                                                                            var"##st#893"[var"##I#906_2"] = var"##T#907_2"
                                                                            var"##st#893"[var"##I#906_3"] = var"##T#907_3"
                                                                            var"##st#893"[var"##I#906_4"] = var"##T#907_4"
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
                                                                (var"##inner##loop##", var"#341###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#905":Base.FastMath.sub_fast(size(var"##st#893", static(1)), var"##step_2_h#905"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#342###ITER_LENG##" = (ArrayInterface.static_length)(var"#341###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#343###LOOP_STEP##" = (ArrayInterface.static_step)(var"#341###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#344###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#341###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#903#1157", var"####step_2_l#904#1158", var"####step_1_l#902#1161", var"####hoisted#827#1165", var"####st#893#1166", var"####hoisted#828#1168", var"####hoisted#829#1169", var"####hoisted#830#1171", var"####hoisted#831#1172", var"####hoisted#832#1174"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#349#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#899_1#1155" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#899_2#1156" = var"####idx#899_1#1155":var"####step_1_h#903#1157":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#899_1#1155", var"####step_2_l#904#1158"), var"####step_1_h#903#1157")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        var"####I#906_1#1159" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_2#1156", 0), 1)
                                                                                                                        var"####I#906_2#1160" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_2#1156", 0), var"####step_1_l#902#1161"), 1)
                                                                                                                        var"####I#906_3#1162" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_2#1156", 0), var"####step_2_l#904#1158"), 1)
                                                                                                                        var"####I#906_4#1163" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_2#1156", 0), var"####step_1_l#902#1161"), var"####step_2_l#904#1158"), 1)
                                                                                                                        var"####T#907_1#1164" = Base.FastMath.mul_fast(var"####hoisted#827#1165", var"####st#893#1166"[var"####I#906_1#1159"])
                                                                                                                        var"####T#907_2#1167" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1168", var"####st#893#1166"[var"####I#906_2#1160"]), Base.FastMath.mul_fast(var"####hoisted#829#1169", var"####st#893#1166"[var"####I#906_3#1162"]))
                                                                                                                        var"####T#907_3#1170" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1171", var"####st#893#1166"[var"####I#906_2#1160"]), Base.FastMath.mul_fast(var"####hoisted#831#1172", var"####st#893#1166"[var"####I#906_3#1162"]))
                                                                                                                        var"####T#907_4#1173" = Base.FastMath.mul_fast(var"####hoisted#832#1174", var"####st#893#1166"[var"####I#906_4#1163"])
                                                                                                                        var"####st#893#1166"[var"####I#906_1#1159"] = var"####T#907_1#1164"
                                                                                                                        var"####st#893#1166"[var"####I#906_2#1160"] = var"####T#907_2#1167"
                                                                                                                        var"####st#893#1166"[var"####I#906_3#1162"] = var"####T#907_3#1170"
                                                                                                                        var"####st#893#1166"[var"####I#906_4#1163"] = var"####T#907_4#1173"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#349#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#342###ITER_LENG##", Polyester.min(var"#342###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#344###LOOPOFFSET##", var"#343###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#903", var"##step_2_l#904", var"##step_1_l#902", var"##hoisted#827", var"##st#893", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#893"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#899_1" = 0:var"##step_2_h#905":Base.FastMath.sub_fast(size(var"##st#893", 1), var"##step_2_h#905")
                                                        for var"##idx#899_2" = var"##idx#899_1":var"##step_1_h#903":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#899_1", var"##step_2_l#904"), var"##step_1_h#903")
                                                            for var"##idx#899_3" = var"##idx#899_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#899_2", var"##step_1_l#902"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#908_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), 1)
                                                                            var"##I#908_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), var"##step_1_l#902"), 1)
                                                                            var"##I#908_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), var"##step_2_l#904"), 1)
                                                                            var"##I#908_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), var"##step_1_l#902"), var"##step_2_l#904"), 1)
                                                                            var"##T#909_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#893"[var"##I#908_1"])
                                                                            var"##T#909_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#893"[var"##I#908_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#893"[var"##I#908_3"]))
                                                                            var"##T#909_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#893"[var"##I#908_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#893"[var"##I#908_3"]))
                                                                            var"##T#909_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#893"[var"##I#908_4"])
                                                                            var"##st#893"[var"##I#908_1"] = var"##T#909_1"
                                                                            var"##st#893"[var"##I#908_2"] = var"##T#909_2"
                                                                            var"##st#893"[var"##I#908_3"] = var"##T#909_3"
                                                                            var"##st#893"[var"##I#908_4"] = var"##T#909_4"
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
                                                        (var"##inner##loop##", var"#350###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#905":Base.FastMath.sub_fast(size(var"##st#893", static(1)), var"##step_2_h#905"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#351###ITER_LENG##" = (ArrayInterface.static_length)(var"#350###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#352###LOOP_STEP##" = (ArrayInterface.static_step)(var"#350###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#353###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#350###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#903#1177", var"####step_2_l#904#1178", var"####step_1_l#902#1180", var"####hoisted#827#1186", var"####st#893#1187", var"####hoisted#828#1189", var"####hoisted#829#1190", var"####hoisted#830#1192", var"####hoisted#831#1193", var"####hoisted#832#1195"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#358#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#899_1#1175" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#899_2#1176" = var"####idx#899_1#1175":var"####step_1_h#903#1177":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#899_1#1175", var"####step_2_l#904#1178"), var"####step_1_h#903#1177")
                                                                                                        for var"####idx#899_3#1179" = var"####idx#899_2#1176":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#899_2#1176", var"####step_1_l#902#1180"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        var"####I#908_1#1181" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_3#1179", 0), 1)
                                                                                                                        var"####I#908_2#1182" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_3#1179", 0), var"####step_1_l#902#1180"), 1)
                                                                                                                        var"####I#908_3#1183" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_3#1179", 0), var"####step_2_l#904#1178"), 1)
                                                                                                                        var"####I#908_4#1184" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#899_3#1179", 0), var"####step_1_l#902#1180"), var"####step_2_l#904#1178"), 1)
                                                                                                                        var"####T#909_1#1185" = Base.FastMath.mul_fast(var"####hoisted#827#1186", var"####st#893#1187"[var"####I#908_1#1181"])
                                                                                                                        var"####T#909_2#1188" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1189", var"####st#893#1187"[var"####I#908_2#1182"]), Base.FastMath.mul_fast(var"####hoisted#829#1190", var"####st#893#1187"[var"####I#908_3#1183"]))
                                                                                                                        var"####T#909_3#1191" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1192", var"####st#893#1187"[var"####I#908_2#1182"]), Base.FastMath.mul_fast(var"####hoisted#831#1193", var"####st#893#1187"[var"####I#908_3#1183"]))
                                                                                                                        var"####T#909_4#1194" = Base.FastMath.mul_fast(var"####hoisted#832#1195", var"####st#893#1187"[var"####I#908_4#1184"])
                                                                                                                        var"####st#893#1187"[var"####I#908_1#1181"] = var"####T#909_1#1185"
                                                                                                                        var"####st#893#1187"[var"####I#908_2#1182"] = var"####T#909_2#1188"
                                                                                                                        var"####st#893#1187"[var"####I#908_3#1183"] = var"####T#909_3#1191"
                                                                                                                        var"####st#893#1187"[var"####I#908_4#1184"] = var"####T#909_4#1194"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#358#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#351###ITER_LENG##", Polyester.min(var"#351###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#353###LOOPOFFSET##", var"#352###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#903", var"##step_2_l#904", var"##step_1_l#902", var"##hoisted#827", var"##st#893", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#893"
                                end
                                if var"##nlocs_needed#898" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#897", var"##plain_locs#896"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    var"##m#901" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#897", var"##nlocs_needed#898"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#902", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#360#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#359#range" = (BQCESubroutine.bsubspace)(var"##nqubits#897", (1:var"##m#901"..., var"##plain_locs#896"[1], var"##plain_locs#896"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#360#threadsfor_fun"(var"#372#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#364#r" = var"#359#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#365#lenr" = Base.Threads.length(var"#364#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#372#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#366#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#367#len", var"#368#rem") = (var"#365#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#366#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#367#len", var"#368#rem") = Base.Threads.divrem(var"#365#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#367#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#366#tid" > var"#368#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#367#len", var"#368#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#369#f" = Base.Threads.firstindex(var"#364#r") + (var"#366#tid" - 1) * var"#367#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#370#l" = (var"#369#f" + var"#367#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#368#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#366#tid" <= var"#368#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#369#f" = var"#369#f" + (var"#366#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#370#l" = var"#370#l" + var"#366#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#369#f" = var"#369#f" + var"#368#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#370#l" = var"#370#l" + var"#368#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#371#i" = var"#369#f":var"#370#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#900" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#373#val" = var"#364#r"[var"#371#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#373#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#910_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), 1)
                                                                            var"##I#910_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), var"##step_1_l#902"), 1)
                                                                            var"##I#910_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), var"##step_2_l#904"), 1)
                                                                            var"##I#910_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_2", 0), var"##step_1_l#902"), var"##step_2_l#904"), 1)
                                                                            var"##T#911_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#893"[var"##I#910_1"])
                                                                            var"##T#911_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#893"[var"##I#910_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#893"[var"##I#910_3"]))
                                                                            var"##T#911_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#893"[var"##I#910_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#893"[var"##I#910_3"]))
                                                                            var"##T#911_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#893"[var"##I#910_4"])
                                                                            var"##st#893"[var"##I#910_1"] = var"##T#911_1"
                                                                            var"##st#893"[var"##I#910_2"] = var"##T#911_2"
                                                                            var"##st#893"[var"##I#910_3"] = var"##T#911_3"
                                                                            var"##st#893"[var"##I#910_4"] = var"##T#911_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#360#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#360#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#893"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#375#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#374#range" = (BQCESubroutine.bsubspace)(var"##nqubits#897", (1:var"##m#901"..., var"##plain_locs#896"[1], var"##plain_locs#896"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#375#threadsfor_fun"(var"#387#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#379#r" = var"#374#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#380#lenr" = Base.Threads.length(var"#379#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#387#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#381#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#382#len", var"#383#rem") = (var"#380#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#381#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#382#len", var"#383#rem") = Base.Threads.divrem(var"#380#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#382#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#381#tid" > var"#383#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#382#len", var"#383#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#384#f" = Base.Threads.firstindex(var"#379#r") + (var"#381#tid" - 1) * var"#382#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#385#l" = (var"#384#f" + var"#382#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#383#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#381#tid" <= var"#383#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#384#f" = var"#384#f" + (var"#381#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#385#l" = var"#385#l" + var"#381#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#384#f" = var"#384#f" + var"#383#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#385#l" = var"#385#l" + var"#383#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#386#i" = var"#384#f":var"#385#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#900" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#388#val" = var"#379#r"[var"#386#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#388#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#899_3" = var"##idx#899_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#899_2", var"##step_1_l#902"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    begin
                                                                        var"##I#912_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), 1)
                                                                        var"##I#912_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), var"##step_1_l#902"), 1)
                                                                        var"##I#912_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), var"##step_2_l#904"), 1)
                                                                        var"##I#912_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#899_3", 0), var"##step_1_l#902"), var"##step_2_l#904"), 1)
                                                                        var"##T#913_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#893"[var"##I#912_1"])
                                                                        var"##T#913_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#893"[var"##I#912_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#893"[var"##I#912_3"]))
                                                                        var"##T#913_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#893"[var"##I#912_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#893"[var"##I#912_3"]))
                                                                        var"##T#913_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#893"[var"##I#912_4"])
                                                                        var"##st#893"[var"##I#912_1"] = var"##T#913_1"
                                                                        var"##st#893"[var"##I#912_2"] = var"##T#913_2"
                                                                        var"##st#893"[var"##I#912_3"] = var"##T#913_3"
                                                                        var"##st#893"[var"##I#912_4"] = var"##T#913_4"
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
                                                (Base.Threads.Base).invokelatest(var"#375#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#375#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    return var"##st#893"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    var"##m#901" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#897", var"##nlocs_needed#898"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#390#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#389#range" = (BQCESubroutine.bsubspace)(var"##nqubits#897", (1:var"##m#901"..., var"##plain_locs#896"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#390#threadsfor_fun"(var"#402#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#394#r" = var"#389#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#395#lenr" = Base.Threads.length(var"#394#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#402#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#396#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#397#len", var"#398#rem") = (var"#395#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#396#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#397#len", var"#398#rem") = Base.Threads.divrem(var"#395#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#397#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#396#tid" > var"#398#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#397#len", var"#398#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#399#f" = Base.Threads.firstindex(var"#394#r") + (var"#396#tid" - 1) * var"#397#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#400#l" = (var"#399#f" + var"#397#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#398#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#396#tid" <= var"#398#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#399#f" = var"#399#f" + (var"#396#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#400#l" = var"#400#l" + var"#396#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#399#f" = var"#399#f" + var"#398#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#400#l" = var"#400#l" + var"#398#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#401#i" = var"#399#f":var"#400#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#900" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#403#val" = var"#394#r"[var"#401#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#403#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                        for var"##idx#899_1" = 0:Base.FastMath.sub_fast(1 << var"##m#901", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                begin
                                                                    var"##I#914_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#900", var"##idx#899_1"), 1)
                                                                    var"##I#914_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#900", var"##idx#899_1"), var"##step_1_l#902"), 1)
                                                                    var"##I#914_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#900", var"##idx#899_1"), var"##step_2_l#904"), 1)
                                                                    var"##I#914_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#900", var"##idx#899_1"), var"##step_1_l#902"), var"##step_2_l#904"), 1)
                                                                    var"##T#915_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#893"[var"##I#914_1"])
                                                                    var"##T#915_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#893"[var"##I#914_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#893"[var"##I#914_3"]))
                                                                    var"##T#915_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#893"[var"##I#914_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#893"[var"##I#914_3"]))
                                                                    var"##T#915_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#893"[var"##I#914_4"])
                                                                    var"##st#893"[var"##I#914_1"] = var"##T#915_1"
                                                                    var"##st#893"[var"##I#914_2"] = var"##T#915_2"
                                                                    var"##st#893"[var"##I#914_3"] = var"##T#915_3"
                                                                    var"##st#893"[var"##I#914_4"] = var"##T#915_4"
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
                                            (Base.Threads.Base).invokelatest(var"#390#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#390#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#893"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#340#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#893"
    end
    function BQCESubroutine.broutine!(var"##st#916"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#917"::Locations, var"##ctrl#833"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#917") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#916", Val{:PSWAP_test}(), var"##locs#917", var"##ctrl#833", θ)
                    return var"##st#916"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#917") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#916", Val{:PSWAP_test}(), var"##locs#917", var"##ctrl#833", θ)
                return var"##st#916"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#916"
    end
    function BQCESubroutine.basic_broutine!(var"##st#918"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#919"::Locations, var"##ctrl#833"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#920" = (YaoLocations.plain)(var"##locs#919")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#920"[1] > var"##plain_locs#920"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#919" = Locations((var"##plain_locs#920"[2], var"##plain_locs#920"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#922" = (YaoLocations.plain)(var"##locs#919")
                    var"##step_1_l#923" = 1 << (var"##plain_locs#922"[1] - 1)
                    var"##step_1_h#924" = 1 << var"##plain_locs#922"[1]
                    var"##step_2_l#925" = 1 << (var"##plain_locs#922"[2] - 1)
                    var"##step_2_h#926" = 1 << var"##plain_locs#922"[2]
                    var"##ctrl_mask#929" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#833"))
                    var"##flag_mask#930" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#833")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#404#val" = begin
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#923", 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#921_1" = 0:var"##step_2_h#926":Base.FastMath.sub_fast(size(var"##st#918", 1), var"##step_2_h#926"), var"##m#921_2" = var"##m#921_1":var"##step_1_h#924":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#921_1", var"##step_2_l#925"), var"##step_1_h#924")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 0), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#927_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), 1)
                                                    var"##I#927_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), 1)
                                                    var"##I#927_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_2_l#925"), 1)
                                                    var"##I#927_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#928_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#927_1"])
                                                    var"##T#928_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#927_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#927_3"]))
                                                    var"##T#928_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#927_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#927_3"]))
                                                    var"##T#928_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#927_4"])
                                                    var"##st#918"[var"##I#927_1"] = var"##T#928_1"
                                                    var"##st#918"[var"##I#927_2"] = var"##T#928_2"
                                                    var"##st#918"[var"##I#927_3"] = var"##T#928_3"
                                                    var"##st#918"[var"##I#927_4"] = var"##T#928_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#918"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#923", 2)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#921_1" = 0:var"##step_2_h#926":Base.FastMath.sub_fast(size(var"##st#918", 1), var"##step_2_h#926"), var"##m#921_2" = var"##m#921_1":var"##step_1_h#924":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#921_1", var"##step_2_l#925"), var"##step_1_h#924")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 0), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#931_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), 1)
                                                    var"##I#931_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), 1)
                                                    var"##I#931_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_2_l#925"), 1)
                                                    var"##I#931_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#932_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#931_1"])
                                                    var"##T#932_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#931_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#931_3"]))
                                                    var"##T#932_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#931_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#931_3"]))
                                                    var"##T#932_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#931_4"])
                                                    var"##st#918"[var"##I#931_1"] = var"##T#932_1"
                                                    var"##st#918"[var"##I#931_2"] = var"##T#932_2"
                                                    var"##st#918"[var"##I#931_3"] = var"##T#932_3"
                                                    var"##st#918"[var"##I#931_4"] = var"##T#932_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 1), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#933_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), 1)
                                                    var"##I#933_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_1_l#923"), 1)
                                                    var"##I#933_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_2_l#925"), 1)
                                                    var"##I#933_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#934_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#933_1"])
                                                    var"##T#934_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#933_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#933_3"]))
                                                    var"##T#934_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#933_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#933_3"]))
                                                    var"##T#934_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#933_4"])
                                                    var"##st#918"[var"##I#933_1"] = var"##T#934_1"
                                                    var"##st#918"[var"##I#933_2"] = var"##T#934_2"
                                                    var"##st#918"[var"##I#933_3"] = var"##T#934_3"
                                                    var"##st#918"[var"##I#933_4"] = var"##T#934_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#918"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#923", 4)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#921_1" = 0:var"##step_2_h#926":Base.FastMath.sub_fast(size(var"##st#918", 1), var"##step_2_h#926"), var"##m#921_2" = var"##m#921_1":var"##step_1_h#924":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#921_1", var"##step_2_l#925"), var"##step_1_h#924")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 0), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#935_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), 1)
                                                    var"##I#935_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), 1)
                                                    var"##I#935_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_2_l#925"), 1)
                                                    var"##I#935_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#936_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#935_1"])
                                                    var"##T#936_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#935_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#935_3"]))
                                                    var"##T#936_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#935_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#935_3"]))
                                                    var"##T#936_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#935_4"])
                                                    var"##st#918"[var"##I#935_1"] = var"##T#936_1"
                                                    var"##st#918"[var"##I#935_2"] = var"##T#936_2"
                                                    var"##st#918"[var"##I#935_3"] = var"##T#936_3"
                                                    var"##st#918"[var"##I#935_4"] = var"##T#936_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 1), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#937_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), 1)
                                                    var"##I#937_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_1_l#923"), 1)
                                                    var"##I#937_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_2_l#925"), 1)
                                                    var"##I#937_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#938_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#937_1"])
                                                    var"##T#938_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#937_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#937_3"]))
                                                    var"##T#938_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#937_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#937_3"]))
                                                    var"##T#938_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#937_4"])
                                                    var"##st#918"[var"##I#937_1"] = var"##T#938_1"
                                                    var"##st#918"[var"##I#937_2"] = var"##T#938_2"
                                                    var"##st#918"[var"##I#937_3"] = var"##T#938_3"
                                                    var"##st#918"[var"##I#937_4"] = var"##T#938_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 2), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#939_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), 1)
                                                    var"##I#939_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), var"##step_1_l#923"), 1)
                                                    var"##I#939_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), var"##step_2_l#925"), 1)
                                                    var"##I#939_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#940_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#939_1"])
                                                    var"##T#940_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#939_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#939_3"]))
                                                    var"##T#940_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#939_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#939_3"]))
                                                    var"##T#940_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#939_4"])
                                                    var"##st#918"[var"##I#939_1"] = var"##T#940_1"
                                                    var"##st#918"[var"##I#939_2"] = var"##T#940_2"
                                                    var"##st#918"[var"##I#939_3"] = var"##T#940_3"
                                                    var"##st#918"[var"##I#939_4"] = var"##T#940_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 3), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#941_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), 1)
                                                    var"##I#941_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), var"##step_1_l#923"), 1)
                                                    var"##I#941_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), var"##step_2_l#925"), 1)
                                                    var"##I#941_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#942_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#941_1"])
                                                    var"##T#942_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#941_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#941_3"]))
                                                    var"##T#942_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#941_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#941_3"]))
                                                    var"##T#942_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#941_4"])
                                                    var"##st#918"[var"##I#941_1"] = var"##T#942_1"
                                                    var"##st#918"[var"##I#941_2"] = var"##T#942_2"
                                                    var"##st#918"[var"##I#941_3"] = var"##T#942_3"
                                                    var"##st#918"[var"##I#941_4"] = var"##T#942_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#918"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#923", 8)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#921_1" = 0:var"##step_2_h#926":Base.FastMath.sub_fast(size(var"##st#918", 1), var"##step_2_h#926"), var"##m#921_2" = var"##m#921_1":var"##step_1_h#924":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#921_1", var"##step_2_l#925"), var"##step_1_h#924")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 0), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#943_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), 1)
                                                    var"##I#943_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), 1)
                                                    var"##I#943_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_2_l#925"), 1)
                                                    var"##I#943_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 0), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#944_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#943_1"])
                                                    var"##T#944_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#943_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#943_3"]))
                                                    var"##T#944_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#943_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#943_3"]))
                                                    var"##T#944_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#943_4"])
                                                    var"##st#918"[var"##I#943_1"] = var"##T#944_1"
                                                    var"##st#918"[var"##I#943_2"] = var"##T#944_2"
                                                    var"##st#918"[var"##I#943_3"] = var"##T#944_3"
                                                    var"##st#918"[var"##I#943_4"] = var"##T#944_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 1), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#945_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), 1)
                                                    var"##I#945_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_1_l#923"), 1)
                                                    var"##I#945_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_2_l#925"), 1)
                                                    var"##I#945_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 1), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#946_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#945_1"])
                                                    var"##T#946_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#945_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#945_3"]))
                                                    var"##T#946_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#945_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#945_3"]))
                                                    var"##T#946_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#945_4"])
                                                    var"##st#918"[var"##I#945_1"] = var"##T#946_1"
                                                    var"##st#918"[var"##I#945_2"] = var"##T#946_2"
                                                    var"##st#918"[var"##I#945_3"] = var"##T#946_3"
                                                    var"##st#918"[var"##I#945_4"] = var"##T#946_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 2), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#947_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), 1)
                                                    var"##I#947_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), var"##step_1_l#923"), 1)
                                                    var"##I#947_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), var"##step_2_l#925"), 1)
                                                    var"##I#947_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 2), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#948_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#947_1"])
                                                    var"##T#948_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#947_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#947_3"]))
                                                    var"##T#948_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#947_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#947_3"]))
                                                    var"##T#948_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#947_4"])
                                                    var"##st#918"[var"##I#947_1"] = var"##T#948_1"
                                                    var"##st#918"[var"##I#947_2"] = var"##T#948_2"
                                                    var"##st#918"[var"##I#947_3"] = var"##T#948_3"
                                                    var"##st#918"[var"##I#947_4"] = var"##T#948_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 3), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#949_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), 1)
                                                    var"##I#949_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), var"##step_1_l#923"), 1)
                                                    var"##I#949_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), var"##step_2_l#925"), 1)
                                                    var"##I#949_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 3), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#950_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#949_1"])
                                                    var"##T#950_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#949_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#949_3"]))
                                                    var"##T#950_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#949_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#949_3"]))
                                                    var"##T#950_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#949_4"])
                                                    var"##st#918"[var"##I#949_1"] = var"##T#950_1"
                                                    var"##st#918"[var"##I#949_2"] = var"##T#950_2"
                                                    var"##st#918"[var"##I#949_3"] = var"##T#950_3"
                                                    var"##st#918"[var"##I#949_4"] = var"##T#950_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 4), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#951_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 4), 1)
                                                    var"##I#951_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 4), var"##step_1_l#923"), 1)
                                                    var"##I#951_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 4), var"##step_2_l#925"), 1)
                                                    var"##I#951_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 4), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#952_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#951_1"])
                                                    var"##T#952_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#951_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#951_3"]))
                                                    var"##T#952_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#951_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#951_3"]))
                                                    var"##T#952_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#951_4"])
                                                    var"##st#918"[var"##I#951_1"] = var"##T#952_1"
                                                    var"##st#918"[var"##I#951_2"] = var"##T#952_2"
                                                    var"##st#918"[var"##I#951_3"] = var"##T#952_3"
                                                    var"##st#918"[var"##I#951_4"] = var"##T#952_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 5), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#953_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 5), 1)
                                                    var"##I#953_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 5), var"##step_1_l#923"), 1)
                                                    var"##I#953_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 5), var"##step_2_l#925"), 1)
                                                    var"##I#953_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 5), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#954_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#953_1"])
                                                    var"##T#954_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#953_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#953_3"]))
                                                    var"##T#954_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#953_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#953_3"]))
                                                    var"##T#954_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#953_4"])
                                                    var"##st#918"[var"##I#953_1"] = var"##T#954_1"
                                                    var"##st#918"[var"##I#953_2"] = var"##T#954_2"
                                                    var"##st#918"[var"##I#953_3"] = var"##T#954_3"
                                                    var"##st#918"[var"##I#953_4"] = var"##T#954_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 6), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#955_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 6), 1)
                                                    var"##I#955_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 6), var"##step_1_l#923"), 1)
                                                    var"##I#955_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 6), var"##step_2_l#925"), 1)
                                                    var"##I#955_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 6), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#956_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#955_1"])
                                                    var"##T#956_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#955_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#955_3"]))
                                                    var"##T#956_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#955_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#955_3"]))
                                                    var"##T#956_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#955_4"])
                                                    var"##st#918"[var"##I#955_1"] = var"##T#956_1"
                                                    var"##st#918"[var"##I#955_2"] = var"##T#956_2"
                                                    var"##st#918"[var"##I#955_3"] = var"##T#956_3"
                                                    var"##st#918"[var"##I#955_4"] = var"##T#956_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_2", 7), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#957_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 7), 1)
                                                    var"##I#957_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 7), var"##step_1_l#923"), 1)
                                                    var"##I#957_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 7), var"##step_2_l#925"), 1)
                                                    var"##I#957_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_2", 7), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#958_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#957_1"])
                                                    var"##T#958_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#957_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#957_3"]))
                                                    var"##T#958_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#957_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#957_3"]))
                                                    var"##T#958_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#957_4"])
                                                    var"##st#918"[var"##I#957_1"] = var"##T#958_1"
                                                    var"##st#918"[var"##I#957_2"] = var"##T#958_2"
                                                    var"##st#918"[var"##I#957_3"] = var"##T#958_3"
                                                    var"##st#918"[var"##I#957_4"] = var"##T#958_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#918"
                                    end
                                end
                                for var"##m#921_1" = 0:var"##step_2_h#926":Base.FastMath.sub_fast(size(var"##st#918", 1), var"##step_2_h#926"), var"##m#921_2" = var"##m#921_1":var"##step_1_h#924":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#921_1", var"##step_2_l#925"), var"##step_1_h#924")
                                    for var"##m#921_3" = var"##m#921_2":8:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#921_2", var"##step_1_l#923"), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                        begin
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 0), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#959_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 0), 1)
                                                    var"##I#959_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 0), var"##step_1_l#923"), 1)
                                                    var"##I#959_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 0), var"##step_2_l#925"), 1)
                                                    var"##I#959_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 0), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#960_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#959_1"])
                                                    var"##T#960_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#959_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#959_3"]))
                                                    var"##T#960_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#959_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#959_3"]))
                                                    var"##T#960_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#959_4"])
                                                    var"##st#918"[var"##I#959_1"] = var"##T#960_1"
                                                    var"##st#918"[var"##I#959_2"] = var"##T#960_2"
                                                    var"##st#918"[var"##I#959_3"] = var"##T#960_3"
                                                    var"##st#918"[var"##I#959_4"] = var"##T#960_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 1), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#961_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 1), 1)
                                                    var"##I#961_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 1), var"##step_1_l#923"), 1)
                                                    var"##I#961_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 1), var"##step_2_l#925"), 1)
                                                    var"##I#961_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 1), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#962_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#961_1"])
                                                    var"##T#962_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#961_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#961_3"]))
                                                    var"##T#962_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#961_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#961_3"]))
                                                    var"##T#962_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#961_4"])
                                                    var"##st#918"[var"##I#961_1"] = var"##T#962_1"
                                                    var"##st#918"[var"##I#961_2"] = var"##T#962_2"
                                                    var"##st#918"[var"##I#961_3"] = var"##T#962_3"
                                                    var"##st#918"[var"##I#961_4"] = var"##T#962_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 2), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#963_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 2), 1)
                                                    var"##I#963_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 2), var"##step_1_l#923"), 1)
                                                    var"##I#963_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 2), var"##step_2_l#925"), 1)
                                                    var"##I#963_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 2), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#964_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#963_1"])
                                                    var"##T#964_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#963_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#963_3"]))
                                                    var"##T#964_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#963_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#963_3"]))
                                                    var"##T#964_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#963_4"])
                                                    var"##st#918"[var"##I#963_1"] = var"##T#964_1"
                                                    var"##st#918"[var"##I#963_2"] = var"##T#964_2"
                                                    var"##st#918"[var"##I#963_3"] = var"##T#964_3"
                                                    var"##st#918"[var"##I#963_4"] = var"##T#964_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 3), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#965_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 3), 1)
                                                    var"##I#965_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 3), var"##step_1_l#923"), 1)
                                                    var"##I#965_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 3), var"##step_2_l#925"), 1)
                                                    var"##I#965_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 3), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#966_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#965_1"])
                                                    var"##T#966_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#965_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#965_3"]))
                                                    var"##T#966_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#965_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#965_3"]))
                                                    var"##T#966_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#965_4"])
                                                    var"##st#918"[var"##I#965_1"] = var"##T#966_1"
                                                    var"##st#918"[var"##I#965_2"] = var"##T#966_2"
                                                    var"##st#918"[var"##I#965_3"] = var"##T#966_3"
                                                    var"##st#918"[var"##I#965_4"] = var"##T#966_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 4), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#967_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 4), 1)
                                                    var"##I#967_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 4), var"##step_1_l#923"), 1)
                                                    var"##I#967_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 4), var"##step_2_l#925"), 1)
                                                    var"##I#967_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 4), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#968_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#967_1"])
                                                    var"##T#968_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#967_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#967_3"]))
                                                    var"##T#968_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#967_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#967_3"]))
                                                    var"##T#968_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#967_4"])
                                                    var"##st#918"[var"##I#967_1"] = var"##T#968_1"
                                                    var"##st#918"[var"##I#967_2"] = var"##T#968_2"
                                                    var"##st#918"[var"##I#967_3"] = var"##T#968_3"
                                                    var"##st#918"[var"##I#967_4"] = var"##T#968_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 5), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#969_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 5), 1)
                                                    var"##I#969_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 5), var"##step_1_l#923"), 1)
                                                    var"##I#969_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 5), var"##step_2_l#925"), 1)
                                                    var"##I#969_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 5), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#970_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#969_1"])
                                                    var"##T#970_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#969_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#969_3"]))
                                                    var"##T#970_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#969_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#969_3"]))
                                                    var"##T#970_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#969_4"])
                                                    var"##st#918"[var"##I#969_1"] = var"##T#970_1"
                                                    var"##st#918"[var"##I#969_2"] = var"##T#970_2"
                                                    var"##st#918"[var"##I#969_3"] = var"##T#970_3"
                                                    var"##st#918"[var"##I#969_4"] = var"##T#970_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 6), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#971_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 6), 1)
                                                    var"##I#971_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 6), var"##step_1_l#923"), 1)
                                                    var"##I#971_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 6), var"##step_2_l#925"), 1)
                                                    var"##I#971_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 6), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#972_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#971_1"])
                                                    var"##T#972_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#971_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#971_3"]))
                                                    var"##T#972_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#971_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#971_3"]))
                                                    var"##T#972_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#971_4"])
                                                    var"##st#918"[var"##I#971_1"] = var"##T#972_1"
                                                    var"##st#918"[var"##I#971_2"] = var"##T#972_2"
                                                    var"##st#918"[var"##I#971_3"] = var"##T#972_3"
                                                    var"##st#918"[var"##I#971_4"] = var"##T#972_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#921_3", 7), var"##ctrl_mask#929", var"##flag_mask#930")
                                                    var"##I#973_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 7), 1)
                                                    var"##I#973_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 7), var"##step_1_l#923"), 1)
                                                    var"##I#973_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 7), var"##step_2_l#925"), 1)
                                                    var"##I#973_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#921_3", 7), var"##step_1_l#923"), var"##step_2_l#925"), 1)
                                                    var"##T#974_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#918"[var"##I#973_1"])
                                                    var"##T#974_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#918"[var"##I#973_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#918"[var"##I#973_3"]))
                                                    var"##T#974_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#918"[var"##I#973_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#918"[var"##I#973_3"]))
                                                    var"##T#974_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#918"[var"##I#973_4"])
                                                    var"##st#918"[var"##I#973_1"] = var"##T#974_1"
                                                    var"##st#918"[var"##I#973_2"] = var"##T#974_2"
                                                    var"##st#918"[var"##I#973_3"] = var"##T#974_3"
                                                    var"##st#918"[var"##I#973_4"] = var"##T#974_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#404#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#918"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#977"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#978"::Locations, var"##ctrl#833"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#979" = (YaoLocations.plain)(var"##locs#978")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#979"[1] > var"##plain_locs#979"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#978" = Locations((var"##plain_locs#979"[2], var"##plain_locs#979"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#980" = (YaoLocations.plain)(var"##locs#978")
                    var"##nqubits#981" = (BQCESubroutine.log2i)(size(var"##st#977", 1))
                    var"##nlocs_needed#982" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#986" = 1 << (var"##plain_locs#980"[1] - 1)
                    var"##step_1_h#987" = 1 << var"##plain_locs#980"[1]
                    var"##step_2_l#988" = 1 << (var"##plain_locs#980"[2] - 1)
                    var"##step_2_h#989" = 1 << var"##plain_locs#980"[2]
                    var"##ctrl_mask#992" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#833"))
                    var"##flag_mask#993" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#833")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#405#val" = begin
                                if var"##nlocs_needed#982" ≤ Base.FastMath.sub_fast(var"##nqubits#981", var"##plain_locs#980"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#986", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#983_1" = 0:var"##step_2_h#989":Base.FastMath.sub_fast(size(var"##st#977", 1), var"##step_2_h#989")
                                                                for var"##idx#983_2" = var"##idx#983_1":var"##step_1_h#987":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#983_1", var"##step_2_l#988"), var"##step_1_h#987")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##ctrl_mask#992", var"##flag_mask#993")
                                                                            var"##I#990_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), 1)
                                                                            var"##I#990_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##step_1_l#986"), 1)
                                                                            var"##I#990_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##step_2_l#988"), 1)
                                                                            var"##I#990_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##step_1_l#986"), var"##step_2_l#988"), 1)
                                                                            var"##T#991_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#977"[var"##I#990_1"])
                                                                            var"##T#991_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#977"[var"##I#990_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#977"[var"##I#990_3"]))
                                                                            var"##T#991_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#977"[var"##I#990_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#977"[var"##I#990_3"]))
                                                                            var"##T#991_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#977"[var"##I#990_4"])
                                                                            var"##st#977"[var"##I#990_1"] = var"##T#991_1"
                                                                            var"##st#977"[var"##I#990_2"] = var"##T#991_2"
                                                                            var"##st#977"[var"##I#990_3"] = var"##T#991_3"
                                                                            var"##st#977"[var"##I#990_4"] = var"##T#991_4"
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
                                                                (var"##inner##loop##", var"#406###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#989":Base.FastMath.sub_fast(size(var"##st#977", static(1)), var"##step_2_h#989"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#407###ITER_LENG##" = (ArrayInterface.static_length)(var"#406###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#408###LOOP_STEP##" = (ArrayInterface.static_step)(var"#406###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#409###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#406###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#987#1198", var"####step_2_l#988#1199", var"####ctrl_mask#992#1200", var"####flag_mask#993#1201", var"####step_1_l#986#1204", var"####hoisted#827#1208", var"####st#977#1209", var"####hoisted#828#1211", var"####hoisted#829#1212", var"####hoisted#830#1214", var"####hoisted#831#1215", var"####hoisted#832#1217"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#414#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#983_1#1196" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#983_2#1197" = var"####idx#983_1#1196":var"####step_1_h#987#1198":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#983_1#1196", var"####step_2_l#988#1199"), var"####step_1_h#987#1198")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#983_2#1197", 0), var"####ctrl_mask#992#1200", var"####flag_mask#993#1201")
                                                                                                                        var"####I#990_1#1202" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_2#1197", 0), 1)
                                                                                                                        var"####I#990_2#1203" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_2#1197", 0), var"####step_1_l#986#1204"), 1)
                                                                                                                        var"####I#990_3#1205" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_2#1197", 0), var"####step_2_l#988#1199"), 1)
                                                                                                                        var"####I#990_4#1206" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_2#1197", 0), var"####step_1_l#986#1204"), var"####step_2_l#988#1199"), 1)
                                                                                                                        var"####T#991_1#1207" = Base.FastMath.mul_fast(var"####hoisted#827#1208", var"####st#977#1209"[var"####I#990_1#1202"])
                                                                                                                        var"####T#991_2#1210" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1211", var"####st#977#1209"[var"####I#990_2#1203"]), Base.FastMath.mul_fast(var"####hoisted#829#1212", var"####st#977#1209"[var"####I#990_3#1205"]))
                                                                                                                        var"####T#991_3#1213" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1214", var"####st#977#1209"[var"####I#990_2#1203"]), Base.FastMath.mul_fast(var"####hoisted#831#1215", var"####st#977#1209"[var"####I#990_3#1205"]))
                                                                                                                        var"####T#991_4#1216" = Base.FastMath.mul_fast(var"####hoisted#832#1217", var"####st#977#1209"[var"####I#990_4#1206"])
                                                                                                                        var"####st#977#1209"[var"####I#990_1#1202"] = var"####T#991_1#1207"
                                                                                                                        var"####st#977#1209"[var"####I#990_2#1203"] = var"####T#991_2#1210"
                                                                                                                        var"####st#977#1209"[var"####I#990_3#1205"] = var"####T#991_3#1213"
                                                                                                                        var"####st#977#1209"[var"####I#990_4#1206"] = var"####T#991_4#1216"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#414#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#407###ITER_LENG##", Polyester.min(var"#407###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#409###LOOPOFFSET##", var"#408###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#987", var"##step_2_l#988", var"##ctrl_mask#992", var"##flag_mask#993", var"##step_1_l#986", var"##hoisted#827", var"##st#977", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#977"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#983_1" = 0:var"##step_2_h#989":Base.FastMath.sub_fast(size(var"##st#977", 1), var"##step_2_h#989")
                                                        for var"##idx#983_2" = var"##idx#983_1":var"##step_1_h#987":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#983_1", var"##step_2_l#988"), var"##step_1_h#987")
                                                            for var"##idx#983_3" = var"##idx#983_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#983_2", var"##step_1_l#986"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##ctrl_mask#992", var"##flag_mask#993")
                                                                            var"##I#994_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), 1)
                                                                            var"##I#994_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##step_1_l#986"), 1)
                                                                            var"##I#994_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##step_2_l#988"), 1)
                                                                            var"##I#994_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##step_1_l#986"), var"##step_2_l#988"), 1)
                                                                            var"##T#995_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#977"[var"##I#994_1"])
                                                                            var"##T#995_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#977"[var"##I#994_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#977"[var"##I#994_3"]))
                                                                            var"##T#995_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#977"[var"##I#994_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#977"[var"##I#994_3"]))
                                                                            var"##T#995_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#977"[var"##I#994_4"])
                                                                            var"##st#977"[var"##I#994_1"] = var"##T#995_1"
                                                                            var"##st#977"[var"##I#994_2"] = var"##T#995_2"
                                                                            var"##st#977"[var"##I#994_3"] = var"##T#995_3"
                                                                            var"##st#977"[var"##I#994_4"] = var"##T#995_4"
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
                                                        (var"##inner##loop##", var"#415###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#989":Base.FastMath.sub_fast(size(var"##st#977", static(1)), var"##step_2_h#989"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#416###ITER_LENG##" = (ArrayInterface.static_length)(var"#415###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#417###LOOP_STEP##" = (ArrayInterface.static_step)(var"#415###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#418###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#415###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#987#1220", var"####step_2_l#988#1221", var"####step_1_l#986#1223", var"####ctrl_mask#992#1224", var"####flag_mask#993#1225", var"####hoisted#827#1231", var"####st#977#1232", var"####hoisted#828#1234", var"####hoisted#829#1235", var"####hoisted#830#1237", var"####hoisted#831#1238", var"####hoisted#832#1240"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#423#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#983_1#1218" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#983_2#1219" = var"####idx#983_1#1218":var"####step_1_h#987#1220":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#983_1#1218", var"####step_2_l#988#1221"), var"####step_1_h#987#1220")
                                                                                                        for var"####idx#983_3#1222" = var"####idx#983_2#1219":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#983_2#1219", var"####step_1_l#986#1223"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#983_3#1222", 0), var"####ctrl_mask#992#1224", var"####flag_mask#993#1225")
                                                                                                                        var"####I#994_1#1226" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_3#1222", 0), 1)
                                                                                                                        var"####I#994_2#1227" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_3#1222", 0), var"####step_1_l#986#1223"), 1)
                                                                                                                        var"####I#994_3#1228" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_3#1222", 0), var"####step_2_l#988#1221"), 1)
                                                                                                                        var"####I#994_4#1229" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#983_3#1222", 0), var"####step_1_l#986#1223"), var"####step_2_l#988#1221"), 1)
                                                                                                                        var"####T#995_1#1230" = Base.FastMath.mul_fast(var"####hoisted#827#1231", var"####st#977#1232"[var"####I#994_1#1226"])
                                                                                                                        var"####T#995_2#1233" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1234", var"####st#977#1232"[var"####I#994_2#1227"]), Base.FastMath.mul_fast(var"####hoisted#829#1235", var"####st#977#1232"[var"####I#994_3#1228"]))
                                                                                                                        var"####T#995_3#1236" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1237", var"####st#977#1232"[var"####I#994_2#1227"]), Base.FastMath.mul_fast(var"####hoisted#831#1238", var"####st#977#1232"[var"####I#994_3#1228"]))
                                                                                                                        var"####T#995_4#1239" = Base.FastMath.mul_fast(var"####hoisted#832#1240", var"####st#977#1232"[var"####I#994_4#1229"])
                                                                                                                        var"####st#977#1232"[var"####I#994_1#1226"] = var"####T#995_1#1230"
                                                                                                                        var"####st#977#1232"[var"####I#994_2#1227"] = var"####T#995_2#1233"
                                                                                                                        var"####st#977#1232"[var"####I#994_3#1228"] = var"####T#995_3#1236"
                                                                                                                        var"####st#977#1232"[var"####I#994_4#1229"] = var"####T#995_4#1239"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#423#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#416###ITER_LENG##", Polyester.min(var"#416###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#418###LOOPOFFSET##", var"#417###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#987", var"##step_2_l#988", var"##step_1_l#986", var"##ctrl_mask#992", var"##flag_mask#993", var"##hoisted#827", var"##st#977", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#977"
                                end
                                if var"##nlocs_needed#982" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#981", var"##plain_locs#980"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    var"##m#985" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#981", var"##nlocs_needed#982"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#986", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#425#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#424#range" = (BQCESubroutine.bsubspace)(var"##nqubits#981", (1:var"##m#985"..., var"##plain_locs#980"[1], var"##plain_locs#980"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#425#threadsfor_fun"(var"#437#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#429#r" = var"#424#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#430#lenr" = Base.Threads.length(var"#429#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#437#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#431#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#432#len", var"#433#rem") = (var"#430#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#431#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#432#len", var"#433#rem") = Base.Threads.divrem(var"#430#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#432#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#431#tid" > var"#433#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#432#len", var"#433#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#434#f" = Base.Threads.firstindex(var"#429#r") + (var"#431#tid" - 1) * var"#432#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#435#l" = (var"#434#f" + var"#432#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#433#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#431#tid" <= var"#433#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#434#f" = var"#434#f" + (var"#431#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#435#l" = var"#435#l" + var"#431#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#434#f" = var"#434#f" + var"#433#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#435#l" = var"#435#l" + var"#433#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#436#i" = var"#434#f":var"#435#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#984" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#438#val" = var"#429#r"[var"#436#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#438#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##ctrl_mask#992", var"##flag_mask#993")
                                                                            var"##I#996_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), 1)
                                                                            var"##I#996_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##step_1_l#986"), 1)
                                                                            var"##I#996_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##step_2_l#988"), 1)
                                                                            var"##I#996_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_2", 0), var"##step_1_l#986"), var"##step_2_l#988"), 1)
                                                                            var"##T#997_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#977"[var"##I#996_1"])
                                                                            var"##T#997_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#977"[var"##I#996_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#977"[var"##I#996_3"]))
                                                                            var"##T#997_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#977"[var"##I#996_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#977"[var"##I#996_3"]))
                                                                            var"##T#997_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#977"[var"##I#996_4"])
                                                                            var"##st#977"[var"##I#996_1"] = var"##T#997_1"
                                                                            var"##st#977"[var"##I#996_2"] = var"##T#997_2"
                                                                            var"##st#977"[var"##I#996_3"] = var"##T#997_3"
                                                                            var"##st#977"[var"##I#996_4"] = var"##T#997_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#425#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#425#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#977"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#440#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#439#range" = (BQCESubroutine.bsubspace)(var"##nqubits#981", (1:var"##m#985"..., var"##plain_locs#980"[1], var"##plain_locs#980"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#440#threadsfor_fun"(var"#452#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#444#r" = var"#439#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#445#lenr" = Base.Threads.length(var"#444#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#452#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#446#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#447#len", var"#448#rem") = (var"#445#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#446#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#447#len", var"#448#rem") = Base.Threads.divrem(var"#445#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#447#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#446#tid" > var"#448#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#447#len", var"#448#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#449#f" = Base.Threads.firstindex(var"#444#r") + (var"#446#tid" - 1) * var"#447#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#450#l" = (var"#449#f" + var"#447#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#448#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#446#tid" <= var"#448#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#449#f" = var"#449#f" + (var"#446#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#450#l" = var"#450#l" + var"#446#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#449#f" = var"#449#f" + var"#448#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#450#l" = var"#450#l" + var"#448#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#451#i" = var"#449#f":var"#450#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#984" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#453#val" = var"#444#r"[var"#451#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#453#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#983_3" = var"##idx#983_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#983_2", var"##step_1_l#986"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##ctrl_mask#992", var"##flag_mask#993")
                                                                        var"##I#998_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), 1)
                                                                        var"##I#998_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##step_1_l#986"), 1)
                                                                        var"##I#998_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##step_2_l#988"), 1)
                                                                        var"##I#998_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#983_3", 0), var"##step_1_l#986"), var"##step_2_l#988"), 1)
                                                                        var"##T#999_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#977"[var"##I#998_1"])
                                                                        var"##T#999_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#977"[var"##I#998_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#977"[var"##I#998_3"]))
                                                                        var"##T#999_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#977"[var"##I#998_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#977"[var"##I#998_3"]))
                                                                        var"##T#999_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#977"[var"##I#998_4"])
                                                                        var"##st#977"[var"##I#998_1"] = var"##T#999_1"
                                                                        var"##st#977"[var"##I#998_2"] = var"##T#999_2"
                                                                        var"##st#977"[var"##I#998_3"] = var"##T#999_3"
                                                                        var"##st#977"[var"##I#998_4"] = var"##T#999_4"
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
                                                (Base.Threads.Base).invokelatest(var"#440#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#440#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    return var"##st#977"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    var"##m#985" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#981", var"##nlocs_needed#982"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#455#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#454#range" = (BQCESubroutine.bsubspace)(var"##nqubits#981", (1:var"##m#985"..., var"##plain_locs#980"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#455#threadsfor_fun"(var"#467#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#459#r" = var"#454#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#460#lenr" = Base.Threads.length(var"#459#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#467#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#461#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#462#len", var"#463#rem") = (var"#460#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#461#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#462#len", var"#463#rem") = Base.Threads.divrem(var"#460#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#462#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#461#tid" > var"#463#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#462#len", var"#463#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#464#f" = Base.Threads.firstindex(var"#459#r") + (var"#461#tid" - 1) * var"#462#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#465#l" = (var"#464#f" + var"#462#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#463#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#461#tid" <= var"#463#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#464#f" = var"#464#f" + (var"#461#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#465#l" = var"#465#l" + var"#461#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#464#f" = var"#464#f" + var"#463#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#465#l" = var"#465#l" + var"#463#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#466#i" = var"#464#f":var"#465#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#984" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#468#val" = var"#459#r"[var"#466#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#468#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                        for var"##idx#983_1" = 0:Base.FastMath.sub_fast(1 << var"##m#985", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#984", var"##idx#983_1"), var"##ctrl_mask#992", var"##flag_mask#993")
                                                                    var"##I#1000_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#984", var"##idx#983_1"), 1)
                                                                    var"##I#1000_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#984", var"##idx#983_1"), var"##step_1_l#986"), 1)
                                                                    var"##I#1000_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#984", var"##idx#983_1"), var"##step_2_l#988"), 1)
                                                                    var"##I#1000_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#984", var"##idx#983_1"), var"##step_1_l#986"), var"##step_2_l#988"), 1)
                                                                    var"##T#1001_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#977"[var"##I#1000_1"])
                                                                    var"##T#1001_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#977"[var"##I#1000_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#977"[var"##I#1000_3"]))
                                                                    var"##T#1001_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#977"[var"##I#1000_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#977"[var"##I#1000_3"]))
                                                                    var"##T#1001_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#977"[var"##I#1000_4"])
                                                                    var"##st#977"[var"##I#1000_1"] = var"##T#1001_1"
                                                                    var"##st#977"[var"##I#1000_2"] = var"##T#1001_2"
                                                                    var"##st#977"[var"##I#1000_3"] = var"##T#1001_3"
                                                                    var"##st#977"[var"##I#1000_4"] = var"##T#1001_4"
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
                                            (Base.Threads.Base).invokelatest(var"#455#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#455#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#977"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#405#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#977"
    end
    function BQCESubroutine.broutine!(var"##st#1003"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1004"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#1004") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#1003", Val{:PSWAP_test}(), var"##locs#1004", θ)
                    return var"##st#1003"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#1004") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#1003", Val{:PSWAP_test}(), var"##locs#1004", θ)
                return var"##st#1003"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1003"
    end
    function BQCESubroutine.basic_broutine!(var"##st#1005"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1006"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#1007" = (YaoLocations.plain)(var"##locs#1006")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#1007"[1] > var"##plain_locs#1007"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#1006" = Locations((var"##plain_locs#1007"[2], var"##plain_locs#1007"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#1009" = (YaoLocations.plain)(var"##locs#1006")
                    var"##step_1_l#1010" = 1 << (var"##plain_locs#1009"[1] - 1)
                    var"##step_1_h#1011" = 1 << var"##plain_locs#1009"[1]
                    var"##step_2_l#1012" = 1 << (var"##plain_locs#1009"[2] - 1)
                    var"##step_2_h#1013" = 1 << var"##plain_locs#1009"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#469#val" = for var"##m#1008_1" = 0:var"##step_2_h#1013":Base.FastMath.sub_fast(size(var"##st#1005", 2), var"##step_2_h#1013"), var"##m#1008_2" = var"##m#1008_1":var"##step_1_h#1011":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#1008_1", var"##step_2_l#1012"), var"##step_1_h#1011"), var"##m#1008_3" = var"##m#1008_2":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#1008_2", var"##step_1_l#1010"), 1)
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                nothing
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                    var"##upperbound#1021" = size(var"##st#1005", 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                    var"##Mmax#1019" = Base.FastMath.sub_fast(size(var"##st#1005", 1), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                    for var"##idx2#1017" = 0:var"##Mmax#1019" >>> 3
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                        var"##idx1#1016" = Base.FastMath.add_fast(var"##idx2#1017" << 3, 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                        var"##mmax#1020" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1016", 7), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                        if var"##mmax#1020" ≤ var"##Mmax#1019"
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                            begin
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 0), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 1), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 2), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 3), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 4), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 5), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 6), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_4"])
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[Base.FastMath.add_fast(var"##idx1#1016", 7), var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                            end
                                        else
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                            for var"##idx3#1018" = var"##idx1#1016":var"##upperbound#1021"
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                begin
                                                    var"##I#1014_1" = Base.FastMath.add_fast(var"##m#1008_3", 1)
                                                    var"##I#1014_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), 1)
                                                    var"##I#1014_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_2_l#1012"), 1)
                                                    var"##I#1014_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1008_3", var"##step_1_l#1010"), var"##step_2_l#1012"), 1)
                                                    var"##T#1015_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1005"[var"##idx3#1018", var"##I#1014_1"])
                                                    var"##T#1015_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1005"[var"##idx3#1018", var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1005"[var"##idx3#1018", var"##I#1014_3"]))
                                                    var"##T#1015_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1005"[var"##idx3#1018", var"##I#1014_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1005"[var"##idx3#1018", var"##I#1014_3"]))
                                                    var"##T#1015_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1005"[var"##idx3#1018", var"##I#1014_4"])
                                                    var"##st#1005"[var"##idx3#1018", var"##I#1014_1"] = var"##T#1015_1"
                                                    var"##st#1005"[var"##idx3#1018", var"##I#1014_2"] = var"##T#1015_2"
                                                    var"##st#1005"[var"##idx3#1018", var"##I#1014_3"] = var"##T#1015_3"
                                                    var"##st#1005"[var"##idx3#1018", var"##I#1014_4"] = var"##T#1015_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#469#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1005"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#1024"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1025"::Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#1026" = (YaoLocations.plain)(var"##locs#1025")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#1026"[1] > var"##plain_locs#1026"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#1025" = Locations((var"##plain_locs#1026"[2], var"##plain_locs#1026"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#1027" = (YaoLocations.plain)(var"##locs#1025")
                    var"##nqubits#1028" = (BQCESubroutine.log2i)(size(var"##st#1024", 2))
                    var"##nlocs_needed#1029" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#1033" = 1 << (var"##plain_locs#1027"[1] - 1)
                    var"##step_1_h#1034" = 1 << var"##plain_locs#1027"[1]
                    var"##step_2_l#1035" = 1 << (var"##plain_locs#1027"[2] - 1)
                    var"##step_2_h#1036" = 1 << var"##plain_locs#1027"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#470#val" = begin
                                if var"##nlocs_needed#1029" ≤ Base.FastMath.sub_fast(var"##nqubits#1028", var"##plain_locs#1027"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#1033", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#1030_1" = 0:var"##step_2_h#1036":Base.FastMath.sub_fast(size(var"##st#1024", 2), var"##step_2_h#1036")
                                                                for var"##idx#1030_2" = var"##idx#1030_1":var"##step_1_h#1034":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1030_1", var"##step_2_l#1035"), var"##step_1_h#1034")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##upperbound#1044" = size(var"##st#1024", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            var"##Mmax#1042" = Base.FastMath.sub_fast(size(var"##st#1024", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                            for var"##idx2#1040" = 0:var"##Mmax#1042" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##idx1#1039" = Base.FastMath.add_fast(var"##idx2#1040" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                var"##mmax#1043" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1039", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                if var"##mmax#1043" ≤ var"##Mmax#1042"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1037_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), 1)
                                                                                            var"##I#1037_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), 1)
                                                                                            var"##I#1037_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_2_l#1035"), 1)
                                                                                            var"##I#1037_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                            var"##T#1038_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_1"])
                                                                                            var"##T#1038_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_3"]))
                                                                                            var"##T#1038_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_3"]))
                                                                                            var"##T#1038_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_4"])
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_1"] = var"##T#1038_1"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_2"] = var"##T#1038_2"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_3"] = var"##T#1038_3"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1039", 0), var"##I#1037_4"] = var"##T#1038_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                    for var"##idx3#1041" = var"##idx1#1039":var"##upperbound#1044"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                        begin
                                                                                            var"##I#1037_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), 1)
                                                                                            var"##I#1037_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), 1)
                                                                                            var"##I#1037_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_2_l#1035"), 1)
                                                                                            var"##I#1037_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                            var"##T#1038_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[var"##idx3#1041", var"##I#1037_1"])
                                                                                            var"##T#1038_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[var"##idx3#1041", var"##I#1037_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[var"##idx3#1041", var"##I#1037_3"]))
                                                                                            var"##T#1038_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[var"##idx3#1041", var"##I#1037_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[var"##idx3#1041", var"##I#1037_3"]))
                                                                                            var"##T#1038_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[var"##idx3#1041", var"##I#1037_4"])
                                                                                            var"##st#1024"[var"##idx3#1041", var"##I#1037_1"] = var"##T#1038_1"
                                                                                            var"##st#1024"[var"##idx3#1041", var"##I#1037_2"] = var"##T#1038_2"
                                                                                            var"##st#1024"[var"##idx3#1041", var"##I#1037_3"] = var"##T#1038_3"
                                                                                            var"##st#1024"[var"##idx3#1041", var"##I#1037_4"] = var"##T#1038_4"
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
                                                                (var"##inner##loop##", var"#471###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#1036":Base.FastMath.sub_fast(size(var"##st#1024", static(2)), var"##step_2_h#1036"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#472###ITER_LENG##" = (ArrayInterface.static_length)(var"#471###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#473###LOOP_STEP##" = (ArrayInterface.static_step)(var"#471###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#474###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#471###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#1034#1243", var"####step_2_l#1035#1244", var"####st#1024#1246", var"####step_1_l#1033#1253", var"####hoisted#827#1257", var"####hoisted#828#1259", var"####hoisted#829#1260", var"####hoisted#830#1262", var"####hoisted#831#1263", var"####hoisted#832#1265"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#479#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#1030_1#1241" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#1030_2#1242" = var"####idx#1030_1#1241":var"####step_1_h#1034#1243":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1030_1#1241", var"####step_2_l#1035#1244"), var"####step_1_h#1034#1243")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####upperbound#1044#1245" = size(var"####st#1024#1246", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        var"####Mmax#1042#1247" = Base.FastMath.sub_fast(size(var"####st#1024#1246", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                                                                        for var"####idx2#1040#1248" = 0:var"####Mmax#1042#1247" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####idx1#1039#1249" = Base.FastMath.add_fast(var"####idx2#1040#1248" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            var"####mmax#1043#1250" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1039#1249", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                            if var"####mmax#1043#1250" ≤ var"####Mmax#1042#1247"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#1037_1#1251" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), 1)
                                                                                                                                        var"####I#1037_2#1252" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), var"####step_1_l#1033#1253"), 1)
                                                                                                                                        var"####I#1037_3#1254" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), var"####step_2_l#1035#1244"), 1)
                                                                                                                                        var"####I#1037_4#1255" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), var"####step_1_l#1033#1253"), var"####step_2_l#1035#1244"), 1)
                                                                                                                                        var"####T#1038_1#1256" = Base.FastMath.mul_fast(var"####hoisted#827#1257", var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_1#1251"])
                                                                                                                                        var"####T#1038_2#1258" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1259", var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_2#1252"]), Base.FastMath.mul_fast(var"####hoisted#829#1260", var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_3#1254"]))
                                                                                                                                        var"####T#1038_3#1261" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1262", var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_2#1252"]), Base.FastMath.mul_fast(var"####hoisted#831#1263", var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_3#1254"]))
                                                                                                                                        var"####T#1038_4#1264" = Base.FastMath.mul_fast(var"####hoisted#832#1265", var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_4#1255"])
                                                                                                                                        var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_1#1251"] = var"####T#1038_1#1256"
                                                                                                                                        var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_2#1252"] = var"####T#1038_2#1258"
                                                                                                                                        var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_3#1254"] = var"####T#1038_3#1261"
                                                                                                                                        var"####st#1024#1246"[Base.FastMath.add_fast(var"####idx1#1039#1249", 0), var"####I#1037_4#1255"] = var"####T#1038_4#1264"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                for var"####idx3#1041#1266" = var"####idx1#1039#1249":var"####upperbound#1044#1245"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#1037_1#1251" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), 1)
                                                                                                                                        var"####I#1037_2#1252" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), var"####step_1_l#1033#1253"), 1)
                                                                                                                                        var"####I#1037_3#1254" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), var"####step_2_l#1035#1244"), 1)
                                                                                                                                        var"####I#1037_4#1255" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_2#1242", 0), var"####step_1_l#1033#1253"), var"####step_2_l#1035#1244"), 1)
                                                                                                                                        var"####T#1038_1#1256" = Base.FastMath.mul_fast(var"####hoisted#827#1257", var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_1#1251"])
                                                                                                                                        var"####T#1038_2#1258" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1259", var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_2#1252"]), Base.FastMath.mul_fast(var"####hoisted#829#1260", var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_3#1254"]))
                                                                                                                                        var"####T#1038_3#1261" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1262", var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_2#1252"]), Base.FastMath.mul_fast(var"####hoisted#831#1263", var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_3#1254"]))
                                                                                                                                        var"####T#1038_4#1264" = Base.FastMath.mul_fast(var"####hoisted#832#1265", var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_4#1255"])
                                                                                                                                        var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_1#1251"] = var"####T#1038_1#1256"
                                                                                                                                        var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_2#1252"] = var"####T#1038_2#1258"
                                                                                                                                        var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_3#1254"] = var"####T#1038_3#1261"
                                                                                                                                        var"####st#1024#1246"[var"####idx3#1041#1266", var"####I#1037_4#1255"] = var"####T#1038_4#1264"
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
                                                                                        var"#479#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#472###ITER_LENG##", Polyester.min(var"#472###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#474###LOOPOFFSET##", var"#473###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#1034", var"##step_2_l#1035", var"##st#1024", var"##step_1_l#1033", var"##hoisted#827", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#1024"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#1030_1" = 0:var"##step_2_h#1036":Base.FastMath.sub_fast(size(var"##st#1024", 2), var"##step_2_h#1036")
                                                        for var"##idx#1030_2" = var"##idx#1030_1":var"##step_1_h#1034":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1030_1", var"##step_2_l#1035"), var"##step_1_h#1034")
                                                            for var"##idx#1030_3" = var"##idx#1030_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1030_2", var"##step_1_l#1033"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##upperbound#1052" = size(var"##st#1024", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            var"##Mmax#1050" = Base.FastMath.sub_fast(size(var"##st#1024", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                            for var"##idx2#1048" = 0:var"##Mmax#1050" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##idx1#1047" = Base.FastMath.add_fast(var"##idx2#1048" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                var"##mmax#1051" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1047", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                if var"##mmax#1051" ≤ var"##Mmax#1050"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1045_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), 1)
                                                                                            var"##I#1045_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), 1)
                                                                                            var"##I#1045_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_2_l#1035"), 1)
                                                                                            var"##I#1045_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                            var"##T#1046_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_1"])
                                                                                            var"##T#1046_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_3"]))
                                                                                            var"##T#1046_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_3"]))
                                                                                            var"##T#1046_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_4"])
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_1"] = var"##T#1046_1"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_2"] = var"##T#1046_2"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_3"] = var"##T#1046_3"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1047", 0), var"##I#1045_4"] = var"##T#1046_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                    for var"##idx3#1049" = var"##idx1#1047":var"##upperbound#1052"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                        begin
                                                                                            var"##I#1045_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), 1)
                                                                                            var"##I#1045_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), 1)
                                                                                            var"##I#1045_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_2_l#1035"), 1)
                                                                                            var"##I#1045_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                            var"##T#1046_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[var"##idx3#1049", var"##I#1045_1"])
                                                                                            var"##T#1046_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[var"##idx3#1049", var"##I#1045_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[var"##idx3#1049", var"##I#1045_3"]))
                                                                                            var"##T#1046_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[var"##idx3#1049", var"##I#1045_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[var"##idx3#1049", var"##I#1045_3"]))
                                                                                            var"##T#1046_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[var"##idx3#1049", var"##I#1045_4"])
                                                                                            var"##st#1024"[var"##idx3#1049", var"##I#1045_1"] = var"##T#1046_1"
                                                                                            var"##st#1024"[var"##idx3#1049", var"##I#1045_2"] = var"##T#1046_2"
                                                                                            var"##st#1024"[var"##idx3#1049", var"##I#1045_3"] = var"##T#1046_3"
                                                                                            var"##st#1024"[var"##idx3#1049", var"##I#1045_4"] = var"##T#1046_4"
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
                                                        (var"##inner##loop##", var"#480###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#1036":Base.FastMath.sub_fast(size(var"##st#1024", static(2)), var"##step_2_h#1036"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#481###ITER_LENG##" = (ArrayInterface.static_length)(var"#480###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#482###LOOP_STEP##" = (ArrayInterface.static_step)(var"#480###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#483###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#480###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#1034#1269", var"####step_2_l#1035#1270", var"####step_1_l#1033#1272", var"####st#1024#1274", var"####hoisted#827#1284", var"####hoisted#828#1286", var"####hoisted#829#1287", var"####hoisted#830#1289", var"####hoisted#831#1290", var"####hoisted#832#1292"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#488#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#1030_1#1267" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#1030_2#1268" = var"####idx#1030_1#1267":var"####step_1_h#1034#1269":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1030_1#1267", var"####step_2_l#1035#1270"), var"####step_1_h#1034#1269")
                                                                                                        for var"####idx#1030_3#1271" = var"####idx#1030_2#1268":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1030_2#1268", var"####step_1_l#1033#1272"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####upperbound#1052#1273" = size(var"####st#1024#1274", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        var"####Mmax#1050#1275" = Base.FastMath.sub_fast(size(var"####st#1024#1274", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                                                                        for var"####idx2#1048#1276" = 0:var"####Mmax#1050#1275" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####idx1#1047#1277" = Base.FastMath.add_fast(var"####idx2#1048#1276" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            var"####mmax#1051#1278" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1047#1277", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                            if var"####mmax#1051#1278" ≤ var"####Mmax#1050#1275"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#1045_1#1279" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), 1)
                                                                                                                                        var"####I#1045_2#1280" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), var"####step_1_l#1033#1272"), 1)
                                                                                                                                        var"####I#1045_3#1281" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), var"####step_2_l#1035#1270"), 1)
                                                                                                                                        var"####I#1045_4#1282" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), var"####step_1_l#1033#1272"), var"####step_2_l#1035#1270"), 1)
                                                                                                                                        var"####T#1046_1#1283" = Base.FastMath.mul_fast(var"####hoisted#827#1284", var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_1#1279"])
                                                                                                                                        var"####T#1046_2#1285" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1286", var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_2#1280"]), Base.FastMath.mul_fast(var"####hoisted#829#1287", var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_3#1281"]))
                                                                                                                                        var"####T#1046_3#1288" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1289", var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_2#1280"]), Base.FastMath.mul_fast(var"####hoisted#831#1290", var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_3#1281"]))
                                                                                                                                        var"####T#1046_4#1291" = Base.FastMath.mul_fast(var"####hoisted#832#1292", var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_4#1282"])
                                                                                                                                        var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_1#1279"] = var"####T#1046_1#1283"
                                                                                                                                        var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_2#1280"] = var"####T#1046_2#1285"
                                                                                                                                        var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_3#1281"] = var"####T#1046_3#1288"
                                                                                                                                        var"####st#1024#1274"[Base.FastMath.add_fast(var"####idx1#1047#1277", 0), var"####I#1045_4#1282"] = var"####T#1046_4#1291"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                for var"####idx3#1049#1293" = var"####idx1#1047#1277":var"####upperbound#1052#1273"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#1045_1#1279" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), 1)
                                                                                                                                        var"####I#1045_2#1280" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), var"####step_1_l#1033#1272"), 1)
                                                                                                                                        var"####I#1045_3#1281" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), var"####step_2_l#1035#1270"), 1)
                                                                                                                                        var"####I#1045_4#1282" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1030_3#1271", 0), var"####step_1_l#1033#1272"), var"####step_2_l#1035#1270"), 1)
                                                                                                                                        var"####T#1046_1#1283" = Base.FastMath.mul_fast(var"####hoisted#827#1284", var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_1#1279"])
                                                                                                                                        var"####T#1046_2#1285" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1286", var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_2#1280"]), Base.FastMath.mul_fast(var"####hoisted#829#1287", var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_3#1281"]))
                                                                                                                                        var"####T#1046_3#1288" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1289", var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_2#1280"]), Base.FastMath.mul_fast(var"####hoisted#831#1290", var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_3#1281"]))
                                                                                                                                        var"####T#1046_4#1291" = Base.FastMath.mul_fast(var"####hoisted#832#1292", var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_4#1282"])
                                                                                                                                        var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_1#1279"] = var"####T#1046_1#1283"
                                                                                                                                        var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_2#1280"] = var"####T#1046_2#1285"
                                                                                                                                        var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_3#1281"] = var"####T#1046_3#1288"
                                                                                                                                        var"####st#1024#1274"[var"####idx3#1049#1293", var"####I#1045_4#1282"] = var"####T#1046_4#1291"
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
                                                                                var"#488#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#481###ITER_LENG##", Polyester.min(var"#481###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#483###LOOPOFFSET##", var"#482###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#1034", var"##step_2_l#1035", var"##step_1_l#1033", var"##st#1024", var"##hoisted#827", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#1024"
                                end
                                if var"##nlocs_needed#1029" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1028", var"##plain_locs#1027"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    var"##m#1032" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1028", var"##nlocs_needed#1029"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#1033", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#490#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#489#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1028", (1:var"##m#1032"..., var"##plain_locs#1027"[1], var"##plain_locs#1027"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#490#threadsfor_fun"(var"#502#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#494#r" = var"#489#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#495#lenr" = Base.Threads.length(var"#494#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#502#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#496#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#497#len", var"#498#rem") = (var"#495#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#496#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#497#len", var"#498#rem") = Base.Threads.divrem(var"#495#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#497#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#496#tid" > var"#498#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#497#len", var"#498#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#499#f" = Base.Threads.firstindex(var"#494#r") + (var"#496#tid" - 1) * var"#497#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#500#l" = (var"#499#f" + var"#497#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#498#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#496#tid" <= var"#498#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#499#f" = var"#499#f" + (var"#496#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#500#l" = var"#500#l" + var"#496#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#499#f" = var"#499#f" + var"#498#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#500#l" = var"#500#l" + var"#498#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#501#i" = var"#499#f":var"#500#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#1031" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#503#val" = var"#494#r"[var"#501#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#503#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##upperbound#1060" = size(var"##st#1024", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            var"##Mmax#1058" = Base.FastMath.sub_fast(size(var"##st#1024", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                            for var"##idx2#1056" = 0:var"##Mmax#1058" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##idx1#1055" = Base.FastMath.add_fast(var"##idx2#1056" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                var"##mmax#1059" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1055", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                if var"##mmax#1059" ≤ var"##Mmax#1058"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1053_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), 1)
                                                                                            var"##I#1053_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), 1)
                                                                                            var"##I#1053_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_2_l#1035"), 1)
                                                                                            var"##I#1053_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                            var"##T#1054_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_1"])
                                                                                            var"##T#1054_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_3"]))
                                                                                            var"##T#1054_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_3"]))
                                                                                            var"##T#1054_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_4"])
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_1"] = var"##T#1054_1"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_2"] = var"##T#1054_2"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_3"] = var"##T#1054_3"
                                                                                            var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1055", 0), var"##I#1053_4"] = var"##T#1054_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                    for var"##idx3#1057" = var"##idx1#1055":var"##upperbound#1060"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                        begin
                                                                                            var"##I#1053_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), 1)
                                                                                            var"##I#1053_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), 1)
                                                                                            var"##I#1053_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_2_l#1035"), 1)
                                                                                            var"##I#1053_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_2", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                            var"##T#1054_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[var"##idx3#1057", var"##I#1053_1"])
                                                                                            var"##T#1054_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[var"##idx3#1057", var"##I#1053_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[var"##idx3#1057", var"##I#1053_3"]))
                                                                                            var"##T#1054_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[var"##idx3#1057", var"##I#1053_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[var"##idx3#1057", var"##I#1053_3"]))
                                                                                            var"##T#1054_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[var"##idx3#1057", var"##I#1053_4"])
                                                                                            var"##st#1024"[var"##idx3#1057", var"##I#1053_1"] = var"##T#1054_1"
                                                                                            var"##st#1024"[var"##idx3#1057", var"##I#1053_2"] = var"##T#1054_2"
                                                                                            var"##st#1024"[var"##idx3#1057", var"##I#1053_3"] = var"##T#1054_3"
                                                                                            var"##st#1024"[var"##idx3#1057", var"##I#1053_4"] = var"##T#1054_4"
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
                                                        (Base.Threads.Base).invokelatest(var"#490#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#490#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#1024"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#505#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#504#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1028", (1:var"##m#1032"..., var"##plain_locs#1027"[1], var"##plain_locs#1027"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#505#threadsfor_fun"(var"#517#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#509#r" = var"#504#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#510#lenr" = Base.Threads.length(var"#509#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#517#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#511#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#512#len", var"#513#rem") = (var"#510#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#511#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#512#len", var"#513#rem") = Base.Threads.divrem(var"#510#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#512#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#511#tid" > var"#513#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#512#len", var"#513#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#514#f" = Base.Threads.firstindex(var"#509#r") + (var"#511#tid" - 1) * var"#512#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#515#l" = (var"#514#f" + var"#512#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#513#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#511#tid" <= var"#513#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#514#f" = var"#514#f" + (var"#511#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#515#l" = var"#515#l" + var"#511#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#514#f" = var"#514#f" + var"#513#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#515#l" = var"#515#l" + var"#513#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#516#i" = var"#514#f":var"#515#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#1031" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#518#val" = var"#509#r"[var"#516#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#518#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#1030_3" = var"##idx#1030_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1030_2", var"##step_1_l#1033"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                        var"##upperbound#1068" = size(var"##st#1024", 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                        var"##Mmax#1066" = Base.FastMath.sub_fast(size(var"##st#1024", 1), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                        for var"##idx2#1064" = 0:var"##Mmax#1066" >>> 0
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                            var"##idx1#1063" = Base.FastMath.add_fast(var"##idx2#1064" << 0, 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                            var"##mmax#1067" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1063", 0), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                            if var"##mmax#1067" ≤ var"##Mmax#1066"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                begin
                                                                                    begin
                                                                                        var"##I#1061_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), 1)
                                                                                        var"##I#1061_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), 1)
                                                                                        var"##I#1061_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_2_l#1035"), 1)
                                                                                        var"##I#1061_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                        var"##T#1062_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_1"])
                                                                                        var"##T#1062_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_3"]))
                                                                                        var"##T#1062_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_3"]))
                                                                                        var"##T#1062_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_4"])
                                                                                        var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_1"] = var"##T#1062_1"
                                                                                        var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_2"] = var"##T#1062_2"
                                                                                        var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_3"] = var"##T#1062_3"
                                                                                        var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1063", 0), var"##I#1061_4"] = var"##T#1062_4"
                                                                                    end
                                                                                end
                                                                            else
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                for var"##idx3#1065" = var"##idx1#1063":var"##upperbound#1068"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                    begin
                                                                                        var"##I#1061_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), 1)
                                                                                        var"##I#1061_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), 1)
                                                                                        var"##I#1061_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_2_l#1035"), 1)
                                                                                        var"##I#1061_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1030_3", 0), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                        var"##T#1062_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[var"##idx3#1065", var"##I#1061_1"])
                                                                                        var"##T#1062_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[var"##idx3#1065", var"##I#1061_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[var"##idx3#1065", var"##I#1061_3"]))
                                                                                        var"##T#1062_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[var"##idx3#1065", var"##I#1061_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[var"##idx3#1065", var"##I#1061_3"]))
                                                                                        var"##T#1062_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[var"##idx3#1065", var"##I#1061_4"])
                                                                                        var"##st#1024"[var"##idx3#1065", var"##I#1061_1"] = var"##T#1062_1"
                                                                                        var"##st#1024"[var"##idx3#1065", var"##I#1061_2"] = var"##T#1062_2"
                                                                                        var"##st#1024"[var"##idx3#1065", var"##I#1061_3"] = var"##T#1062_3"
                                                                                        var"##st#1024"[var"##idx3#1065", var"##I#1061_4"] = var"##T#1062_4"
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
                                                (Base.Threads.Base).invokelatest(var"#505#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#505#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    return var"##st#1024"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    var"##m#1032" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1028", var"##nlocs_needed#1029"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#520#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#519#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1028", (1:var"##m#1032"..., var"##plain_locs#1027"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#520#threadsfor_fun"(var"#532#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#524#r" = var"#519#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#525#lenr" = Base.Threads.length(var"#524#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#532#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#526#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#527#len", var"#528#rem") = (var"#525#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#526#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#527#len", var"#528#rem") = Base.Threads.divrem(var"#525#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#527#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#526#tid" > var"#528#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#527#len", var"#528#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#529#f" = Base.Threads.firstindex(var"#524#r") + (var"#526#tid" - 1) * var"#527#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#530#l" = (var"#529#f" + var"#527#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#528#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#526#tid" <= var"#528#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#529#f" = var"#529#f" + (var"#526#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#530#l" = var"#530#l" + var"#526#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#529#f" = var"#529#f" + var"#528#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#530#l" = var"#530#l" + var"#528#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#531#i" = var"#529#f":var"#530#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#1031" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#533#val" = var"#524#r"[var"#531#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#533#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                        for var"##idx#1030_1" = 0:Base.FastMath.sub_fast(1 << var"##m#1032", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                    var"##upperbound#1076" = size(var"##st#1024", 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                    var"##Mmax#1074" = Base.FastMath.sub_fast(size(var"##st#1024", 1), 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                    for var"##idx2#1072" = 0:var"##Mmax#1074" >>> 0
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                        var"##idx1#1071" = Base.FastMath.add_fast(var"##idx2#1072" << 0, 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                        var"##mmax#1075" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1071", 0), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                        if var"##mmax#1075" ≤ var"##Mmax#1074"
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                            begin
                                                                                begin
                                                                                    var"##I#1069_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), 1)
                                                                                    var"##I#1069_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), var"##step_1_l#1033"), 1)
                                                                                    var"##I#1069_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), var"##step_2_l#1035"), 1)
                                                                                    var"##I#1069_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                    var"##T#1070_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_1"])
                                                                                    var"##T#1070_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_3"]))
                                                                                    var"##T#1070_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_3"]))
                                                                                    var"##T#1070_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_4"])
                                                                                    var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_1"] = var"##T#1070_1"
                                                                                    var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_2"] = var"##T#1070_2"
                                                                                    var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_3"] = var"##T#1070_3"
                                                                                    var"##st#1024"[Base.FastMath.add_fast(var"##idx1#1071", 0), var"##I#1069_4"] = var"##T#1070_4"
                                                                                end
                                                                            end
                                                                        else
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                            for var"##idx3#1073" = var"##idx1#1071":var"##upperbound#1076"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                begin
                                                                                    var"##I#1069_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), 1)
                                                                                    var"##I#1069_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), var"##step_1_l#1033"), 1)
                                                                                    var"##I#1069_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), var"##step_2_l#1035"), 1)
                                                                                    var"##I#1069_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1031", var"##idx#1030_1"), var"##step_1_l#1033"), var"##step_2_l#1035"), 1)
                                                                                    var"##T#1070_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1024"[var"##idx3#1073", var"##I#1069_1"])
                                                                                    var"##T#1070_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1024"[var"##idx3#1073", var"##I#1069_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1024"[var"##idx3#1073", var"##I#1069_3"]))
                                                                                    var"##T#1070_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1024"[var"##idx3#1073", var"##I#1069_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1024"[var"##idx3#1073", var"##I#1069_3"]))
                                                                                    var"##T#1070_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1024"[var"##idx3#1073", var"##I#1069_4"])
                                                                                    var"##st#1024"[var"##idx3#1073", var"##I#1069_1"] = var"##T#1070_1"
                                                                                    var"##st#1024"[var"##idx3#1073", var"##I#1069_2"] = var"##T#1070_2"
                                                                                    var"##st#1024"[var"##idx3#1073", var"##I#1069_3"] = var"##T#1070_3"
                                                                                    var"##st#1024"[var"##idx3#1073", var"##I#1069_4"] = var"##T#1070_4"
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
                                            (Base.Threads.Base).invokelatest(var"#520#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#520#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#1024"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#470#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1024"
    end
    function BQCESubroutine.broutine!(var"##st#1077"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1078"::Locations, var"##ctrl#1002"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#1078") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#1077", Val{:PSWAP_test}(), var"##locs#1078", var"##ctrl#1002", θ)
                    return var"##st#1077"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#1078") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#1077", Val{:PSWAP_test}(), var"##locs#1078", var"##ctrl#1002", θ)
                return var"##st#1077"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1077"
    end
    function BQCESubroutine.basic_broutine!(var"##st#1079"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1080"::Locations, var"##ctrl#1002"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#1081" = (YaoLocations.plain)(var"##locs#1080")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#1081"[1] > var"##plain_locs#1081"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#1080" = Locations((var"##plain_locs#1081"[2], var"##plain_locs#1081"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#1083" = (YaoLocations.plain)(var"##locs#1080")
                    var"##step_1_l#1084" = 1 << (var"##plain_locs#1083"[1] - 1)
                    var"##step_1_h#1085" = 1 << var"##plain_locs#1083"[1]
                    var"##step_2_l#1086" = 1 << (var"##plain_locs#1083"[2] - 1)
                    var"##step_2_h#1087" = 1 << var"##plain_locs#1083"[2]
                    var"##ctrl_mask#1090" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#1002"))
                    var"##flag_mask#1091" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#1002")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#534#val" = for var"##m#1082_1" = 0:var"##step_2_h#1087":Base.FastMath.sub_fast(size(var"##st#1079", 2), var"##step_2_h#1087"), var"##m#1082_2" = var"##m#1082_1":var"##step_1_h#1085":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#1082_1", var"##step_2_l#1086"), var"##step_1_h#1085"), var"##m#1082_3" = var"##m#1082_2":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#1082_2", var"##step_1_l#1084"), 1)
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                nothing
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                if (BQCESubroutine.ismatch)(var"##m#1082_3", var"##ctrl_mask#1090", var"##flag_mask#1091")
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                    var"##upperbound#1097" = size(var"##st#1079", 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                    var"##Mmax#1095" = Base.FastMath.sub_fast(size(var"##st#1079", 1), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                    for var"##idx2#1093" = 0:var"##Mmax#1095" >>> 3
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                        var"##idx1#1092" = Base.FastMath.add_fast(var"##idx2#1093" << 3, 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                        var"##mmax#1096" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1092", 7), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                        if var"##mmax#1096" ≤ var"##Mmax#1095"
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                            begin
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 0), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 1), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 2), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 3), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 4), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 5), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 6), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_4"])
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[Base.FastMath.add_fast(var"##idx1#1092", 7), var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                            end
                                        else
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                            for var"##idx3#1094" = var"##idx1#1092":var"##upperbound#1097"
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                begin
                                                    var"##I#1088_1" = Base.FastMath.add_fast(var"##m#1082_3", 1)
                                                    var"##I#1088_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), 1)
                                                    var"##I#1088_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_2_l#1086"), 1)
                                                    var"##I#1088_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#1082_3", var"##step_1_l#1084"), var"##step_2_l#1086"), 1)
                                                    var"##T#1089_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1079"[var"##idx3#1094", var"##I#1088_1"])
                                                    var"##T#1089_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1079"[var"##idx3#1094", var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1079"[var"##idx3#1094", var"##I#1088_3"]))
                                                    var"##T#1089_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1079"[var"##idx3#1094", var"##I#1088_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1079"[var"##idx3#1094", var"##I#1088_3"]))
                                                    var"##T#1089_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1079"[var"##idx3#1094", var"##I#1088_4"])
                                                    var"##st#1079"[var"##idx3#1094", var"##I#1088_1"] = var"##T#1089_1"
                                                    var"##st#1079"[var"##idx3#1094", var"##I#1088_2"] = var"##T#1089_2"
                                                    var"##st#1079"[var"##idx3#1094", var"##I#1088_3"] = var"##T#1089_3"
                                                    var"##st#1079"[var"##idx3#1094", var"##I#1088_4"] = var"##T#1089_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#534#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1079"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#1100"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#1101"::Locations, var"##ctrl#1002"::CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:709 =#
                var"##plain_locs#1102" = (YaoLocations.plain)(var"##locs#1101")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:710 =#
                if var"##plain_locs#1102"[1] > var"##plain_locs#1102"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:711 =#
                    var"##locs#1101" = Locations((var"##plain_locs#1102"[2], var"##plain_locs#1102"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#1103" = (YaoLocations.plain)(var"##locs#1101")
                    var"##nqubits#1104" = (BQCESubroutine.log2i)(size(var"##st#1100", 2))
                    var"##nlocs_needed#1105" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#1109" = 1 << (var"##plain_locs#1103"[1] - 1)
                    var"##step_1_h#1110" = 1 << var"##plain_locs#1103"[1]
                    var"##step_2_l#1111" = 1 << (var"##plain_locs#1103"[2] - 1)
                    var"##step_2_h#1112" = 1 << var"##plain_locs#1103"[2]
                    var"##ctrl_mask#1115" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#1002"))
                    var"##flag_mask#1116" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#1002")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#827" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#828" = cos(θ / 2)
                    var"##hoisted#829" = -im * sin(θ / 2)
                    var"##hoisted#830" = -im * sin(θ / 2)
                    var"##hoisted#831" = cos(θ / 2)
                    var"##hoisted#832" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#535#val" = begin
                                if var"##nlocs_needed#1105" ≤ Base.FastMath.sub_fast(var"##nqubits#1104", var"##plain_locs#1103"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#1109", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#1106_1" = 0:var"##step_2_h#1112":Base.FastMath.sub_fast(size(var"##st#1100", 2), var"##step_2_h#1112")
                                                                for var"##idx#1106_2" = var"##idx#1106_1":var"##step_1_h#1110":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1106_1", var"##step_2_l#1111"), var"##step_1_h#1110")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##ctrl_mask#1115", var"##flag_mask#1116")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##upperbound#1122" = size(var"##st#1100", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            var"##Mmax#1120" = Base.FastMath.sub_fast(size(var"##st#1100", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                            for var"##idx2#1118" = 0:var"##Mmax#1120" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##idx1#1117" = Base.FastMath.add_fast(var"##idx2#1118" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                var"##mmax#1121" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1117", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                if var"##mmax#1121" ≤ var"##Mmax#1120"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1113_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), 1)
                                                                                            var"##I#1113_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), 1)
                                                                                            var"##I#1113_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_2_l#1111"), 1)
                                                                                            var"##I#1113_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                            var"##T#1114_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_1"])
                                                                                            var"##T#1114_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_3"]))
                                                                                            var"##T#1114_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_3"]))
                                                                                            var"##T#1114_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_4"])
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_1"] = var"##T#1114_1"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_2"] = var"##T#1114_2"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_3"] = var"##T#1114_3"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1117", 0), var"##I#1113_4"] = var"##T#1114_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                    for var"##idx3#1119" = var"##idx1#1117":var"##upperbound#1122"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                        begin
                                                                                            var"##I#1113_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), 1)
                                                                                            var"##I#1113_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), 1)
                                                                                            var"##I#1113_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_2_l#1111"), 1)
                                                                                            var"##I#1113_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                            var"##T#1114_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[var"##idx3#1119", var"##I#1113_1"])
                                                                                            var"##T#1114_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[var"##idx3#1119", var"##I#1113_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[var"##idx3#1119", var"##I#1113_3"]))
                                                                                            var"##T#1114_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[var"##idx3#1119", var"##I#1113_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[var"##idx3#1119", var"##I#1113_3"]))
                                                                                            var"##T#1114_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[var"##idx3#1119", var"##I#1113_4"])
                                                                                            var"##st#1100"[var"##idx3#1119", var"##I#1113_1"] = var"##T#1114_1"
                                                                                            var"##st#1100"[var"##idx3#1119", var"##I#1113_2"] = var"##T#1114_2"
                                                                                            var"##st#1100"[var"##idx3#1119", var"##I#1113_3"] = var"##T#1114_3"
                                                                                            var"##st#1100"[var"##idx3#1119", var"##I#1113_4"] = var"##T#1114_4"
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
                                                                (var"##inner##loop##", var"#536###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#1112":Base.FastMath.sub_fast(size(var"##st#1100", static(2)), var"##step_2_h#1112"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#537###ITER_LENG##" = (ArrayInterface.static_length)(var"#536###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#538###LOOP_STEP##" = (ArrayInterface.static_step)(var"#536###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#539###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#536###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#1110#1296", var"####step_2_l#1111#1297", var"####ctrl_mask#1115#1298", var"####flag_mask#1116#1299", var"####st#1100#1301", var"####step_1_l#1109#1308", var"####hoisted#827#1312", var"####hoisted#828#1314", var"####hoisted#829#1315", var"####hoisted#830#1317", var"####hoisted#831#1318", var"####hoisted#832#1320"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#544#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#1106_1#1294" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#1106_2#1295" = var"####idx#1106_1#1294":var"####step_1_h#1110#1296":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1106_1#1294", var"####step_2_l#1111#1297"), var"####step_1_h#1110#1296")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####ctrl_mask#1115#1298", var"####flag_mask#1116#1299")
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####upperbound#1122#1300" = size(var"####st#1100#1301", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        var"####Mmax#1120#1302" = Base.FastMath.sub_fast(size(var"####st#1100#1301", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                                                                        for var"####idx2#1118#1303" = 0:var"####Mmax#1120#1302" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####idx1#1117#1304" = Base.FastMath.add_fast(var"####idx2#1118#1303" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            var"####mmax#1121#1305" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1117#1304", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                            if var"####mmax#1121#1305" ≤ var"####Mmax#1120#1302"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#1113_1#1306" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), 1)
                                                                                                                                        var"####I#1113_2#1307" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####step_1_l#1109#1308"), 1)
                                                                                                                                        var"####I#1113_3#1309" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####step_2_l#1111#1297"), 1)
                                                                                                                                        var"####I#1113_4#1310" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####step_1_l#1109#1308"), var"####step_2_l#1111#1297"), 1)
                                                                                                                                        var"####T#1114_1#1311" = Base.FastMath.mul_fast(var"####hoisted#827#1312", var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_1#1306"])
                                                                                                                                        var"####T#1114_2#1313" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1314", var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_2#1307"]), Base.FastMath.mul_fast(var"####hoisted#829#1315", var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_3#1309"]))
                                                                                                                                        var"####T#1114_3#1316" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1317", var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_2#1307"]), Base.FastMath.mul_fast(var"####hoisted#831#1318", var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_3#1309"]))
                                                                                                                                        var"####T#1114_4#1319" = Base.FastMath.mul_fast(var"####hoisted#832#1320", var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_4#1310"])
                                                                                                                                        var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_1#1306"] = var"####T#1114_1#1311"
                                                                                                                                        var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_2#1307"] = var"####T#1114_2#1313"
                                                                                                                                        var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_3#1309"] = var"####T#1114_3#1316"
                                                                                                                                        var"####st#1100#1301"[Base.FastMath.add_fast(var"####idx1#1117#1304", 0), var"####I#1113_4#1310"] = var"####T#1114_4#1319"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                for var"####idx3#1119#1321" = var"####idx1#1117#1304":var"####upperbound#1122#1300"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#1113_1#1306" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), 1)
                                                                                                                                        var"####I#1113_2#1307" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####step_1_l#1109#1308"), 1)
                                                                                                                                        var"####I#1113_3#1309" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####step_2_l#1111#1297"), 1)
                                                                                                                                        var"####I#1113_4#1310" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_2#1295", 0), var"####step_1_l#1109#1308"), var"####step_2_l#1111#1297"), 1)
                                                                                                                                        var"####T#1114_1#1311" = Base.FastMath.mul_fast(var"####hoisted#827#1312", var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_1#1306"])
                                                                                                                                        var"####T#1114_2#1313" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1314", var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_2#1307"]), Base.FastMath.mul_fast(var"####hoisted#829#1315", var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_3#1309"]))
                                                                                                                                        var"####T#1114_3#1316" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1317", var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_2#1307"]), Base.FastMath.mul_fast(var"####hoisted#831#1318", var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_3#1309"]))
                                                                                                                                        var"####T#1114_4#1319" = Base.FastMath.mul_fast(var"####hoisted#832#1320", var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_4#1310"])
                                                                                                                                        var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_1#1306"] = var"####T#1114_1#1311"
                                                                                                                                        var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_2#1307"] = var"####T#1114_2#1313"
                                                                                                                                        var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_3#1309"] = var"####T#1114_3#1316"
                                                                                                                                        var"####st#1100#1301"[var"####idx3#1119#1321", var"####I#1113_4#1310"] = var"####T#1114_4#1319"
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
                                                                                        var"#544#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#537###ITER_LENG##", Polyester.min(var"#537###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#539###LOOPOFFSET##", var"#538###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#1110", var"##step_2_l#1111", var"##ctrl_mask#1115", var"##flag_mask#1116", var"##st#1100", var"##step_1_l#1109", var"##hoisted#827", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#1100"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#1106_1" = 0:var"##step_2_h#1112":Base.FastMath.sub_fast(size(var"##st#1100", 2), var"##step_2_h#1112")
                                                        for var"##idx#1106_2" = var"##idx#1106_1":var"##step_1_h#1110":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1106_1", var"##step_2_l#1111"), var"##step_1_h#1110")
                                                            for var"##idx#1106_3" = var"##idx#1106_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1106_2", var"##step_1_l#1109"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##ctrl_mask#1115", var"##flag_mask#1116")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##upperbound#1130" = size(var"##st#1100", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            var"##Mmax#1128" = Base.FastMath.sub_fast(size(var"##st#1100", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                            for var"##idx2#1126" = 0:var"##Mmax#1128" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##idx1#1125" = Base.FastMath.add_fast(var"##idx2#1126" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                var"##mmax#1129" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1125", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                if var"##mmax#1129" ≤ var"##Mmax#1128"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1123_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), 1)
                                                                                            var"##I#1123_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), 1)
                                                                                            var"##I#1123_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_2_l#1111"), 1)
                                                                                            var"##I#1123_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                            var"##T#1124_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_1"])
                                                                                            var"##T#1124_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_3"]))
                                                                                            var"##T#1124_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_3"]))
                                                                                            var"##T#1124_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_4"])
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_1"] = var"##T#1124_1"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_2"] = var"##T#1124_2"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_3"] = var"##T#1124_3"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1125", 0), var"##I#1123_4"] = var"##T#1124_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                    for var"##idx3#1127" = var"##idx1#1125":var"##upperbound#1130"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                        begin
                                                                                            var"##I#1123_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), 1)
                                                                                            var"##I#1123_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), 1)
                                                                                            var"##I#1123_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_2_l#1111"), 1)
                                                                                            var"##I#1123_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                            var"##T#1124_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[var"##idx3#1127", var"##I#1123_1"])
                                                                                            var"##T#1124_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[var"##idx3#1127", var"##I#1123_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[var"##idx3#1127", var"##I#1123_3"]))
                                                                                            var"##T#1124_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[var"##idx3#1127", var"##I#1123_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[var"##idx3#1127", var"##I#1123_3"]))
                                                                                            var"##T#1124_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[var"##idx3#1127", var"##I#1123_4"])
                                                                                            var"##st#1100"[var"##idx3#1127", var"##I#1123_1"] = var"##T#1124_1"
                                                                                            var"##st#1100"[var"##idx3#1127", var"##I#1123_2"] = var"##T#1124_2"
                                                                                            var"##st#1100"[var"##idx3#1127", var"##I#1123_3"] = var"##T#1124_3"
                                                                                            var"##st#1100"[var"##idx3#1127", var"##I#1123_4"] = var"##T#1124_4"
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
                                                        (var"##inner##loop##", var"#545###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#1112":Base.FastMath.sub_fast(size(var"##st#1100", static(2)), var"##step_2_h#1112"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#546###ITER_LENG##" = (ArrayInterface.static_length)(var"#545###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#547###LOOP_STEP##" = (ArrayInterface.static_step)(var"#545###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#548###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#545###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#1110#1324", var"####step_2_l#1111#1325", var"####step_1_l#1109#1327", var"####ctrl_mask#1115#1328", var"####flag_mask#1116#1329", var"####st#1100#1331", var"####hoisted#827#1341", var"####hoisted#828#1343", var"####hoisted#829#1344", var"####hoisted#830#1346", var"####hoisted#831#1347", var"####hoisted#832#1349"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#553#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#1106_1#1322" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#1106_2#1323" = var"####idx#1106_1#1322":var"####step_1_h#1110#1324":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1106_1#1322", var"####step_2_l#1111#1325"), var"####step_1_h#1110#1324")
                                                                                                        for var"####idx#1106_3#1326" = var"####idx#1106_2#1323":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#1106_2#1323", var"####step_1_l#1109#1327"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####ctrl_mask#1115#1328", var"####flag_mask#1116#1329")
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                                                                        var"####upperbound#1130#1330" = size(var"####st#1100#1331", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                                                                        var"####Mmax#1128#1332" = Base.FastMath.sub_fast(size(var"####st#1100#1331", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                                                                        for var"####idx2#1126#1333" = 0:var"####Mmax#1128#1332" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                            var"####idx1#1125#1334" = Base.FastMath.add_fast(var"####idx2#1126#1333" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                                                            var"####mmax#1129#1335" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#1125#1334", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                                                            if var"####mmax#1129#1335" ≤ var"####Mmax#1128#1332"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#1123_1#1336" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), 1)
                                                                                                                                        var"####I#1123_2#1337" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####step_1_l#1109#1327"), 1)
                                                                                                                                        var"####I#1123_3#1338" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####step_2_l#1111#1325"), 1)
                                                                                                                                        var"####I#1123_4#1339" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####step_1_l#1109#1327"), var"####step_2_l#1111#1325"), 1)
                                                                                                                                        var"####T#1124_1#1340" = Base.FastMath.mul_fast(var"####hoisted#827#1341", var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_1#1336"])
                                                                                                                                        var"####T#1124_2#1342" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1343", var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_2#1337"]), Base.FastMath.mul_fast(var"####hoisted#829#1344", var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_3#1338"]))
                                                                                                                                        var"####T#1124_3#1345" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1346", var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_2#1337"]), Base.FastMath.mul_fast(var"####hoisted#831#1347", var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_3#1338"]))
                                                                                                                                        var"####T#1124_4#1348" = Base.FastMath.mul_fast(var"####hoisted#832#1349", var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_4#1339"])
                                                                                                                                        var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_1#1336"] = var"####T#1124_1#1340"
                                                                                                                                        var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_2#1337"] = var"####T#1124_2#1342"
                                                                                                                                        var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_3#1338"] = var"####T#1124_3#1345"
                                                                                                                                        var"####st#1100#1331"[Base.FastMath.add_fast(var"####idx1#1125#1334", 0), var"####I#1123_4#1339"] = var"####T#1124_4#1348"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                                                                for var"####idx3#1127#1350" = var"####idx1#1125#1334":var"####upperbound#1130#1330"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#1123_1#1336" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), 1)
                                                                                                                                        var"####I#1123_2#1337" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####step_1_l#1109#1327"), 1)
                                                                                                                                        var"####I#1123_3#1338" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####step_2_l#1111#1325"), 1)
                                                                                                                                        var"####I#1123_4#1339" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#1106_3#1326", 0), var"####step_1_l#1109#1327"), var"####step_2_l#1111#1325"), 1)
                                                                                                                                        var"####T#1124_1#1340" = Base.FastMath.mul_fast(var"####hoisted#827#1341", var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_1#1336"])
                                                                                                                                        var"####T#1124_2#1342" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#828#1343", var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_2#1337"]), Base.FastMath.mul_fast(var"####hoisted#829#1344", var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_3#1338"]))
                                                                                                                                        var"####T#1124_3#1345" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#830#1346", var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_2#1337"]), Base.FastMath.mul_fast(var"####hoisted#831#1347", var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_3#1338"]))
                                                                                                                                        var"####T#1124_4#1348" = Base.FastMath.mul_fast(var"####hoisted#832#1349", var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_4#1339"])
                                                                                                                                        var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_1#1336"] = var"####T#1124_1#1340"
                                                                                                                                        var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_2#1337"] = var"####T#1124_2#1342"
                                                                                                                                        var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_3#1338"] = var"####T#1124_3#1345"
                                                                                                                                        var"####st#1100#1331"[var"####idx3#1127#1350", var"####I#1123_4#1339"] = var"####T#1124_4#1348"
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
                                                                                var"#553#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#546###ITER_LENG##", Polyester.min(var"#546###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#548###LOOPOFFSET##", var"#547###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#1110", var"##step_2_l#1111", var"##step_1_l#1109", var"##ctrl_mask#1115", var"##flag_mask#1116", var"##st#1100", var"##hoisted#827", var"##hoisted#828", var"##hoisted#829", var"##hoisted#830", var"##hoisted#831", var"##hoisted#832")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#1100"
                                end
                                if var"##nlocs_needed#1105" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1104", var"##plain_locs#1103"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:503 =#
                                    var"##m#1108" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1104", var"##nlocs_needed#1105"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:504 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#1109", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#555#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#554#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1104", (1:var"##m#1108"..., var"##plain_locs#1103"[1], var"##plain_locs#1103"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#555#threadsfor_fun"(var"#567#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#559#r" = var"#554#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#560#lenr" = Base.Threads.length(var"#559#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#567#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#561#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#562#len", var"#563#rem") = (var"#560#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#561#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#562#len", var"#563#rem") = Base.Threads.divrem(var"#560#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#562#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#561#tid" > var"#563#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#562#len", var"#563#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#564#f" = Base.Threads.firstindex(var"#559#r") + (var"#561#tid" - 1) * var"#562#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#565#l" = (var"#564#f" + var"#562#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#563#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#561#tid" <= var"#563#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#564#f" = var"#564#f" + (var"#561#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#565#l" = var"#565#l" + var"#561#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#564#f" = var"#564#f" + var"#563#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#565#l" = var"#565#l" + var"#563#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#566#i" = var"#564#f":var"#565#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#1107" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#568#val" = var"#559#r"[var"#566#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#568#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##ctrl_mask#1115", var"##flag_mask#1116")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                            var"##upperbound#1138" = size(var"##st#1100", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                            var"##Mmax#1136" = Base.FastMath.sub_fast(size(var"##st#1100", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                            for var"##idx2#1134" = 0:var"##Mmax#1136" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                var"##idx1#1133" = Base.FastMath.add_fast(var"##idx2#1134" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                                var"##mmax#1137" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1133", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                                if var"##mmax#1137" ≤ var"##Mmax#1136"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#1131_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), 1)
                                                                                            var"##I#1131_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), 1)
                                                                                            var"##I#1131_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_2_l#1111"), 1)
                                                                                            var"##I#1131_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                            var"##T#1132_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_1"])
                                                                                            var"##T#1132_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_3"]))
                                                                                            var"##T#1132_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_3"]))
                                                                                            var"##T#1132_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_4"])
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_1"] = var"##T#1132_1"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_2"] = var"##T#1132_2"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_3"] = var"##T#1132_3"
                                                                                            var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1133", 0), var"##I#1131_4"] = var"##T#1132_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                    for var"##idx3#1135" = var"##idx1#1133":var"##upperbound#1138"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                        begin
                                                                                            var"##I#1131_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), 1)
                                                                                            var"##I#1131_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), 1)
                                                                                            var"##I#1131_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_2_l#1111"), 1)
                                                                                            var"##I#1131_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_2", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                            var"##T#1132_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[var"##idx3#1135", var"##I#1131_1"])
                                                                                            var"##T#1132_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[var"##idx3#1135", var"##I#1131_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[var"##idx3#1135", var"##I#1131_3"]))
                                                                                            var"##T#1132_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[var"##idx3#1135", var"##I#1131_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[var"##idx3#1135", var"##I#1131_3"]))
                                                                                            var"##T#1132_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[var"##idx3#1135", var"##I#1131_4"])
                                                                                            var"##st#1100"[var"##idx3#1135", var"##I#1131_1"] = var"##T#1132_1"
                                                                                            var"##st#1100"[var"##idx3#1135", var"##I#1131_2"] = var"##T#1132_2"
                                                                                            var"##st#1100"[var"##idx3#1135", var"##I#1131_3"] = var"##T#1132_3"
                                                                                            var"##st#1100"[var"##idx3#1135", var"##I#1131_4"] = var"##T#1132_4"
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
                                                        (Base.Threads.Base).invokelatest(var"#555#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#555#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#1100"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#570#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#569#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1104", (1:var"##m#1108"..., var"##plain_locs#1103"[1], var"##plain_locs#1103"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#570#threadsfor_fun"(var"#582#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#574#r" = var"#569#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#575#lenr" = Base.Threads.length(var"#574#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#582#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#576#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#577#len", var"#578#rem") = (var"#575#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#576#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#577#len", var"#578#rem") = Base.Threads.divrem(var"#575#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#577#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#576#tid" > var"#578#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#577#len", var"#578#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#579#f" = Base.Threads.firstindex(var"#574#r") + (var"#576#tid" - 1) * var"#577#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#580#l" = (var"#579#f" + var"#577#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#578#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#576#tid" <= var"#578#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#579#f" = var"#579#f" + (var"#576#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#580#l" = var"#580#l" + var"#576#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#579#f" = var"#579#f" + var"#578#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#580#l" = var"#580#l" + var"#578#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#581#i" = var"#579#f":var"#580#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#1107" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#583#val" = var"#574#r"[var"#581#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#583#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#1106_3" = var"##idx#1106_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#1106_2", var"##step_1_l#1109"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##ctrl_mask#1115", var"##flag_mask#1116")
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                        var"##upperbound#1146" = size(var"##st#1100", 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                        var"##Mmax#1144" = Base.FastMath.sub_fast(size(var"##st#1100", 1), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                        for var"##idx2#1142" = 0:var"##Mmax#1144" >>> 0
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                            var"##idx1#1141" = Base.FastMath.add_fast(var"##idx2#1142" << 0, 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                            var"##mmax#1145" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1141", 0), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                            if var"##mmax#1145" ≤ var"##Mmax#1144"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                                begin
                                                                                    begin
                                                                                        var"##I#1139_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), 1)
                                                                                        var"##I#1139_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), 1)
                                                                                        var"##I#1139_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_2_l#1111"), 1)
                                                                                        var"##I#1139_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                        var"##T#1140_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_1"])
                                                                                        var"##T#1140_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_3"]))
                                                                                        var"##T#1140_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_3"]))
                                                                                        var"##T#1140_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_4"])
                                                                                        var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_1"] = var"##T#1140_1"
                                                                                        var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_2"] = var"##T#1140_2"
                                                                                        var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_3"] = var"##T#1140_3"
                                                                                        var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1141", 0), var"##I#1139_4"] = var"##T#1140_4"
                                                                                    end
                                                                                end
                                                                            else
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                                for var"##idx3#1143" = var"##idx1#1141":var"##upperbound#1146"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                    begin
                                                                                        var"##I#1139_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), 1)
                                                                                        var"##I#1139_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), 1)
                                                                                        var"##I#1139_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_2_l#1111"), 1)
                                                                                        var"##I#1139_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#1106_3", 0), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                        var"##T#1140_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[var"##idx3#1143", var"##I#1139_1"])
                                                                                        var"##T#1140_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[var"##idx3#1143", var"##I#1139_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[var"##idx3#1143", var"##I#1139_3"]))
                                                                                        var"##T#1140_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[var"##idx3#1143", var"##I#1139_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[var"##idx3#1143", var"##I#1139_3"]))
                                                                                        var"##T#1140_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[var"##idx3#1143", var"##I#1139_4"])
                                                                                        var"##st#1100"[var"##idx3#1143", var"##I#1139_1"] = var"##T#1140_1"
                                                                                        var"##st#1100"[var"##idx3#1143", var"##I#1139_2"] = var"##T#1140_2"
                                                                                        var"##st#1100"[var"##idx3#1143", var"##I#1139_3"] = var"##T#1140_3"
                                                                                        var"##st#1100"[var"##idx3#1143", var"##I#1139_4"] = var"##T#1140_4"
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
                                                (Base.Threads.Base).invokelatest(var"#570#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#570#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    return var"##st#1100"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:511 =#
                                    var"##m#1108" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#1104", var"##nlocs_needed#1105"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:512 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#585#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#584#range" = (BQCESubroutine.bsubspace)(var"##nqubits#1104", (1:var"##m#1108"..., var"##plain_locs#1103"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#585#threadsfor_fun"(var"#597#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#589#r" = var"#584#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#590#lenr" = Base.Threads.length(var"#589#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#597#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#591#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#592#len", var"#593#rem") = (var"#590#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#591#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#592#len", var"#593#rem") = Base.Threads.divrem(var"#590#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#592#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#591#tid" > var"#593#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#592#len", var"#593#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#594#f" = Base.Threads.firstindex(var"#589#r") + (var"#591#tid" - 1) * var"#592#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#595#l" = (var"#594#f" + var"#592#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#593#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#591#tid" <= var"#593#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#594#f" = var"#594#f" + (var"#591#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#595#l" = var"#595#l" + var"#591#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#594#f" = var"#594#f" + var"#593#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#595#l" = var"#595#l" + var"#593#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#596#i" = var"#594#f":var"#595#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#1107" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#598#val" = var"#589#r"[var"#596#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#598#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                                        for var"##idx#1106_1" = 0:Base.FastMath.sub_fast(1 << var"##m#1108", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##ctrl_mask#1115", var"##flag_mask#1116")
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:681 =#
                                                                    var"##upperbound#1154" = size(var"##st#1100", 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:682 =#
                                                                    var"##Mmax#1152" = Base.FastMath.sub_fast(size(var"##st#1100", 1), 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:683 =#
                                                                    for var"##idx2#1150" = 0:var"##Mmax#1152" >>> 0
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                        var"##idx1#1149" = Base.FastMath.add_fast(var"##idx2#1150" << 0, 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:664 =#
                                                                        var"##mmax#1153" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#1149", 0), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:665 =#
                                                                        if var"##mmax#1153" ≤ var"##Mmax#1152"
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:666 =#
                                                                            begin
                                                                                begin
                                                                                    var"##I#1147_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), 1)
                                                                                    var"##I#1147_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##step_1_l#1109"), 1)
                                                                                    var"##I#1147_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##step_2_l#1111"), 1)
                                                                                    var"##I#1147_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                    var"##T#1148_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_1"])
                                                                                    var"##T#1148_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_3"]))
                                                                                    var"##T#1148_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_3"]))
                                                                                    var"##T#1148_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_4"])
                                                                                    var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_1"] = var"##T#1148_1"
                                                                                    var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_2"] = var"##T#1148_2"
                                                                                    var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_3"] = var"##T#1148_3"
                                                                                    var"##st#1100"[Base.FastMath.add_fast(var"##idx1#1149", 0), var"##I#1147_4"] = var"##T#1148_4"
                                                                                end
                                                                            end
                                                                        else
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:668 =#
                                                                            for var"##idx3#1151" = var"##idx1#1149":var"##upperbound#1154"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:669 =#
                                                                                begin
                                                                                    var"##I#1147_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), 1)
                                                                                    var"##I#1147_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##step_1_l#1109"), 1)
                                                                                    var"##I#1147_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##step_2_l#1111"), 1)
                                                                                    var"##I#1147_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#1107", var"##idx#1106_1"), var"##step_1_l#1109"), var"##step_2_l#1111"), 1)
                                                                                    var"##T#1148_1" = Base.FastMath.mul_fast(var"##hoisted#827", var"##st#1100"[var"##idx3#1151", var"##I#1147_1"])
                                                                                    var"##T#1148_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#828", var"##st#1100"[var"##idx3#1151", var"##I#1147_2"]), Base.FastMath.mul_fast(var"##hoisted#829", var"##st#1100"[var"##idx3#1151", var"##I#1147_3"]))
                                                                                    var"##T#1148_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#830", var"##st#1100"[var"##idx3#1151", var"##I#1147_2"]), Base.FastMath.mul_fast(var"##hoisted#831", var"##st#1100"[var"##idx3#1151", var"##I#1147_3"]))
                                                                                    var"##T#1148_4" = Base.FastMath.mul_fast(var"##hoisted#832", var"##st#1100"[var"##idx3#1151", var"##I#1147_4"])
                                                                                    var"##st#1100"[var"##idx3#1151", var"##I#1147_1"] = var"##T#1148_1"
                                                                                    var"##st#1100"[var"##idx3#1151", var"##I#1147_2"] = var"##T#1148_2"
                                                                                    var"##st#1100"[var"##idx3#1151", var"##I#1147_3"] = var"##T#1148_3"
                                                                                    var"##st#1100"[var"##idx3#1151", var"##I#1147_4"] = var"##T#1148_4"
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
                                            (Base.Threads.Base).invokelatest(var"#585#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#585#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#1100"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#535#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#1100"
    end
    # function $(Expr(:where, :(BPSWAP_test(θ))))
    #     [-im * sin(θ / 2) + cos(θ / 2) 0 0 0; 0 cos(θ / 2) -im * sin(θ / 2) 0; 0 -im * sin(θ / 2) cos(θ / 2) 0; 0 0 0 -im * sin(θ / 2) + cos(θ / 2)]
    # end
end

eval(prog)
