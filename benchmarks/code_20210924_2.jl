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

prog=
quote
    function BQCESubroutine.broutine!(var"##st#592"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#593"::YaoLocations.Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#593") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#592", Val{:PSWAP_test}(), var"##locs#593", θ)
                    return var"##st#592"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#593") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#592", Val{:PSWAP_test}(), var"##locs#593", θ)
                return var"##st#592"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#592"
    end
    function BQCESubroutine.basic_broutine!(var"##st#594"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#595"::YaoLocations.Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#596" = (YaoLocations.plain)(var"##locs#595")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#596"[1] > var"##plain_locs#596"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#595" = Locations((var"##plain_locs#596"[2], var"##plain_locs#596"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#598" = (YaoLocations.plain)(var"##locs#595")
                    var"##step_1_l#599" = 1 << (var"##plain_locs#598"[1] - 1)
                    var"##step_1_h#600" = 1 << var"##plain_locs#598"[1]
                    var"##step_2_l#601" = 1 << (var"##plain_locs#598"[2] - 1)
                    var"##step_2_h#602" = 1 << var"##plain_locs#598"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#2#val" = begin
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#599", 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#597_1" = 0:var"##step_2_h#602":Base.FastMath.sub_fast(size(var"##st#594", 1), var"##step_2_h#602"), var"##m#597_2" = var"##m#597_1":var"##step_1_h#600":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#597_1", var"##step_2_l#601"), var"##step_1_h#600")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#603_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), 1)
                                                    var"##I#603_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), 1)
                                                    var"##I#603_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_2_l#601"), 1)
                                                    var"##I#603_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#604_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#603_1"])
                                                    var"##T#604_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#603_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#603_3"]))
                                                    var"##T#604_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#603_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#603_3"]))
                                                    var"##T#604_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#603_4"])
                                                    var"##st#594"[var"##I#603_1"] = var"##T#604_1"
                                                    var"##st#594"[var"##I#603_2"] = var"##T#604_2"
                                                    var"##st#594"[var"##I#603_3"] = var"##T#604_3"
                                                    var"##st#594"[var"##I#603_4"] = var"##T#604_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#594"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#599", 2)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#597_1" = 0:var"##step_2_h#602":Base.FastMath.sub_fast(size(var"##st#594", 1), var"##step_2_h#602"), var"##m#597_2" = var"##m#597_1":var"##step_1_h#600":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#597_1", var"##step_2_l#601"), var"##step_1_h#600")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#605_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), 1)
                                                    var"##I#605_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), 1)
                                                    var"##I#605_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_2_l#601"), 1)
                                                    var"##I#605_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#606_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#605_1"])
                                                    var"##T#606_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#605_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#605_3"]))
                                                    var"##T#606_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#605_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#605_3"]))
                                                    var"##T#606_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#605_4"])
                                                    var"##st#594"[var"##I#605_1"] = var"##T#606_1"
                                                    var"##st#594"[var"##I#605_2"] = var"##T#606_2"
                                                    var"##st#594"[var"##I#605_3"] = var"##T#606_3"
                                                    var"##st#594"[var"##I#605_4"] = var"##T#606_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#607_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), 1)
                                                    var"##I#607_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_1_l#599"), 1)
                                                    var"##I#607_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_2_l#601"), 1)
                                                    var"##I#607_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#608_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#607_1"])
                                                    var"##T#608_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#607_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#607_3"]))
                                                    var"##T#608_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#607_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#607_3"]))
                                                    var"##T#608_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#607_4"])
                                                    var"##st#594"[var"##I#607_1"] = var"##T#608_1"
                                                    var"##st#594"[var"##I#607_2"] = var"##T#608_2"
                                                    var"##st#594"[var"##I#607_3"] = var"##T#608_3"
                                                    var"##st#594"[var"##I#607_4"] = var"##T#608_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#594"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#599", 4)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#597_1" = 0:var"##step_2_h#602":Base.FastMath.sub_fast(size(var"##st#594", 1), var"##step_2_h#602"), var"##m#597_2" = var"##m#597_1":var"##step_1_h#600":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#597_1", var"##step_2_l#601"), var"##step_1_h#600")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#609_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), 1)
                                                    var"##I#609_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), 1)
                                                    var"##I#609_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_2_l#601"), 1)
                                                    var"##I#609_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#610_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#609_1"])
                                                    var"##T#610_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#609_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#609_3"]))
                                                    var"##T#610_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#609_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#609_3"]))
                                                    var"##T#610_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#609_4"])
                                                    var"##st#594"[var"##I#609_1"] = var"##T#610_1"
                                                    var"##st#594"[var"##I#609_2"] = var"##T#610_2"
                                                    var"##st#594"[var"##I#609_3"] = var"##T#610_3"
                                                    var"##st#594"[var"##I#609_4"] = var"##T#610_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#611_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), 1)
                                                    var"##I#611_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_1_l#599"), 1)
                                                    var"##I#611_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_2_l#601"), 1)
                                                    var"##I#611_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#612_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#611_1"])
                                                    var"##T#612_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#611_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#611_3"]))
                                                    var"##T#612_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#611_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#611_3"]))
                                                    var"##T#612_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#611_4"])
                                                    var"##st#594"[var"##I#611_1"] = var"##T#612_1"
                                                    var"##st#594"[var"##I#611_2"] = var"##T#612_2"
                                                    var"##st#594"[var"##I#611_3"] = var"##T#612_3"
                                                    var"##st#594"[var"##I#611_4"] = var"##T#612_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#613_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), 1)
                                                    var"##I#613_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), var"##step_1_l#599"), 1)
                                                    var"##I#613_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), var"##step_2_l#601"), 1)
                                                    var"##I#613_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#614_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#613_1"])
                                                    var"##T#614_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#613_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#613_3"]))
                                                    var"##T#614_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#613_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#613_3"]))
                                                    var"##T#614_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#613_4"])
                                                    var"##st#594"[var"##I#613_1"] = var"##T#614_1"
                                                    var"##st#594"[var"##I#613_2"] = var"##T#614_2"
                                                    var"##st#594"[var"##I#613_3"] = var"##T#614_3"
                                                    var"##st#594"[var"##I#613_4"] = var"##T#614_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#615_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), 1)
                                                    var"##I#615_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), var"##step_1_l#599"), 1)
                                                    var"##I#615_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), var"##step_2_l#601"), 1)
                                                    var"##I#615_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#616_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#615_1"])
                                                    var"##T#616_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#615_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#615_3"]))
                                                    var"##T#616_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#615_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#615_3"]))
                                                    var"##T#616_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#615_4"])
                                                    var"##st#594"[var"##I#615_1"] = var"##T#616_1"
                                                    var"##st#594"[var"##I#615_2"] = var"##T#616_2"
                                                    var"##st#594"[var"##I#615_3"] = var"##T#616_3"
                                                    var"##st#594"[var"##I#615_4"] = var"##T#616_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#594"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#599", 8)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#597_1" = 0:var"##step_2_h#602":Base.FastMath.sub_fast(size(var"##st#594", 1), var"##step_2_h#602"), var"##m#597_2" = var"##m#597_1":var"##step_1_h#600":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#597_1", var"##step_2_l#601"), var"##step_1_h#600")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#617_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), 1)
                                                    var"##I#617_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), 1)
                                                    var"##I#617_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_2_l#601"), 1)
                                                    var"##I#617_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 0), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#618_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#617_1"])
                                                    var"##T#618_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#617_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#617_3"]))
                                                    var"##T#618_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#617_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#617_3"]))
                                                    var"##T#618_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#617_4"])
                                                    var"##st#594"[var"##I#617_1"] = var"##T#618_1"
                                                    var"##st#594"[var"##I#617_2"] = var"##T#618_2"
                                                    var"##st#594"[var"##I#617_3"] = var"##T#618_3"
                                                    var"##st#594"[var"##I#617_4"] = var"##T#618_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#619_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), 1)
                                                    var"##I#619_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_1_l#599"), 1)
                                                    var"##I#619_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_2_l#601"), 1)
                                                    var"##I#619_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 1), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#620_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#619_1"])
                                                    var"##T#620_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#619_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#619_3"]))
                                                    var"##T#620_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#619_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#619_3"]))
                                                    var"##T#620_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#619_4"])
                                                    var"##st#594"[var"##I#619_1"] = var"##T#620_1"
                                                    var"##st#594"[var"##I#619_2"] = var"##T#620_2"
                                                    var"##st#594"[var"##I#619_3"] = var"##T#620_3"
                                                    var"##st#594"[var"##I#619_4"] = var"##T#620_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#621_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), 1)
                                                    var"##I#621_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), var"##step_1_l#599"), 1)
                                                    var"##I#621_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), var"##step_2_l#601"), 1)
                                                    var"##I#621_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 2), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#622_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#621_1"])
                                                    var"##T#622_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#621_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#621_3"]))
                                                    var"##T#622_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#621_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#621_3"]))
                                                    var"##T#622_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#621_4"])
                                                    var"##st#594"[var"##I#621_1"] = var"##T#622_1"
                                                    var"##st#594"[var"##I#621_2"] = var"##T#622_2"
                                                    var"##st#594"[var"##I#621_3"] = var"##T#622_3"
                                                    var"##st#594"[var"##I#621_4"] = var"##T#622_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#623_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), 1)
                                                    var"##I#623_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), var"##step_1_l#599"), 1)
                                                    var"##I#623_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), var"##step_2_l#601"), 1)
                                                    var"##I#623_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 3), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#624_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#623_1"])
                                                    var"##T#624_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#623_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#623_3"]))
                                                    var"##T#624_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#623_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#623_3"]))
                                                    var"##T#624_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#623_4"])
                                                    var"##st#594"[var"##I#623_1"] = var"##T#624_1"
                                                    var"##st#594"[var"##I#623_2"] = var"##T#624_2"
                                                    var"##st#594"[var"##I#623_3"] = var"##T#624_3"
                                                    var"##st#594"[var"##I#623_4"] = var"##T#624_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#625_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 4), 1)
                                                    var"##I#625_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 4), var"##step_1_l#599"), 1)
                                                    var"##I#625_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 4), var"##step_2_l#601"), 1)
                                                    var"##I#625_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 4), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#626_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#625_1"])
                                                    var"##T#626_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#625_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#625_3"]))
                                                    var"##T#626_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#625_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#625_3"]))
                                                    var"##T#626_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#625_4"])
                                                    var"##st#594"[var"##I#625_1"] = var"##T#626_1"
                                                    var"##st#594"[var"##I#625_2"] = var"##T#626_2"
                                                    var"##st#594"[var"##I#625_3"] = var"##T#626_3"
                                                    var"##st#594"[var"##I#625_4"] = var"##T#626_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#627_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 5), 1)
                                                    var"##I#627_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 5), var"##step_1_l#599"), 1)
                                                    var"##I#627_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 5), var"##step_2_l#601"), 1)
                                                    var"##I#627_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 5), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#628_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#627_1"])
                                                    var"##T#628_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#627_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#627_3"]))
                                                    var"##T#628_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#627_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#627_3"]))
                                                    var"##T#628_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#627_4"])
                                                    var"##st#594"[var"##I#627_1"] = var"##T#628_1"
                                                    var"##st#594"[var"##I#627_2"] = var"##T#628_2"
                                                    var"##st#594"[var"##I#627_3"] = var"##T#628_3"
                                                    var"##st#594"[var"##I#627_4"] = var"##T#628_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#629_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 6), 1)
                                                    var"##I#629_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 6), var"##step_1_l#599"), 1)
                                                    var"##I#629_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 6), var"##step_2_l#601"), 1)
                                                    var"##I#629_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 6), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#630_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#629_1"])
                                                    var"##T#630_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#629_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#629_3"]))
                                                    var"##T#630_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#629_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#629_3"]))
                                                    var"##T#630_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#629_4"])
                                                    var"##st#594"[var"##I#629_1"] = var"##T#630_1"
                                                    var"##st#594"[var"##I#629_2"] = var"##T#630_2"
                                                    var"##st#594"[var"##I#629_3"] = var"##T#630_3"
                                                    var"##st#594"[var"##I#629_4"] = var"##T#630_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#631_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 7), 1)
                                                    var"##I#631_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 7), var"##step_1_l#599"), 1)
                                                    var"##I#631_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 7), var"##step_2_l#601"), 1)
                                                    var"##I#631_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_2", 7), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#632_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#631_1"])
                                                    var"##T#632_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#631_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#631_3"]))
                                                    var"##T#632_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#631_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#631_3"]))
                                                    var"##T#632_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#631_4"])
                                                    var"##st#594"[var"##I#631_1"] = var"##T#632_1"
                                                    var"##st#594"[var"##I#631_2"] = var"##T#632_2"
                                                    var"##st#594"[var"##I#631_3"] = var"##T#632_3"
                                                    var"##st#594"[var"##I#631_4"] = var"##T#632_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#594"
                                    end
                                end
                                for var"##m#597_1" = 0:var"##step_2_h#602":Base.FastMath.sub_fast(size(var"##st#594", 1), var"##step_2_h#602"), var"##m#597_2" = var"##m#597_1":var"##step_1_h#600":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#597_1", var"##step_2_l#601"), var"##step_1_h#600")
                                    for var"##m#597_3" = var"##m#597_2":8:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#597_2", var"##step_1_l#599"), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                        begin
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#633_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 0), 1)
                                                    var"##I#633_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 0), var"##step_1_l#599"), 1)
                                                    var"##I#633_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 0), var"##step_2_l#601"), 1)
                                                    var"##I#633_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 0), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#634_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#633_1"])
                                                    var"##T#634_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#633_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#633_3"]))
                                                    var"##T#634_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#633_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#633_3"]))
                                                    var"##T#634_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#633_4"])
                                                    var"##st#594"[var"##I#633_1"] = var"##T#634_1"
                                                    var"##st#594"[var"##I#633_2"] = var"##T#634_2"
                                                    var"##st#594"[var"##I#633_3"] = var"##T#634_3"
                                                    var"##st#594"[var"##I#633_4"] = var"##T#634_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#635_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 1), 1)
                                                    var"##I#635_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 1), var"##step_1_l#599"), 1)
                                                    var"##I#635_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 1), var"##step_2_l#601"), 1)
                                                    var"##I#635_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 1), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#636_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#635_1"])
                                                    var"##T#636_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#635_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#635_3"]))
                                                    var"##T#636_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#635_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#635_3"]))
                                                    var"##T#636_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#635_4"])
                                                    var"##st#594"[var"##I#635_1"] = var"##T#636_1"
                                                    var"##st#594"[var"##I#635_2"] = var"##T#636_2"
                                                    var"##st#594"[var"##I#635_3"] = var"##T#636_3"
                                                    var"##st#594"[var"##I#635_4"] = var"##T#636_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#637_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 2), 1)
                                                    var"##I#637_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 2), var"##step_1_l#599"), 1)
                                                    var"##I#637_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 2), var"##step_2_l#601"), 1)
                                                    var"##I#637_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 2), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#638_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#637_1"])
                                                    var"##T#638_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#637_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#637_3"]))
                                                    var"##T#638_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#637_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#637_3"]))
                                                    var"##T#638_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#637_4"])
                                                    var"##st#594"[var"##I#637_1"] = var"##T#638_1"
                                                    var"##st#594"[var"##I#637_2"] = var"##T#638_2"
                                                    var"##st#594"[var"##I#637_3"] = var"##T#638_3"
                                                    var"##st#594"[var"##I#637_4"] = var"##T#638_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#639_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 3), 1)
                                                    var"##I#639_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 3), var"##step_1_l#599"), 1)
                                                    var"##I#639_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 3), var"##step_2_l#601"), 1)
                                                    var"##I#639_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 3), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#640_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#639_1"])
                                                    var"##T#640_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#639_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#639_3"]))
                                                    var"##T#640_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#639_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#639_3"]))
                                                    var"##T#640_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#639_4"])
                                                    var"##st#594"[var"##I#639_1"] = var"##T#640_1"
                                                    var"##st#594"[var"##I#639_2"] = var"##T#640_2"
                                                    var"##st#594"[var"##I#639_3"] = var"##T#640_3"
                                                    var"##st#594"[var"##I#639_4"] = var"##T#640_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#641_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 4), 1)
                                                    var"##I#641_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 4), var"##step_1_l#599"), 1)
                                                    var"##I#641_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 4), var"##step_2_l#601"), 1)
                                                    var"##I#641_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 4), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#642_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#641_1"])
                                                    var"##T#642_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#641_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#641_3"]))
                                                    var"##T#642_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#641_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#641_3"]))
                                                    var"##T#642_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#641_4"])
                                                    var"##st#594"[var"##I#641_1"] = var"##T#642_1"
                                                    var"##st#594"[var"##I#641_2"] = var"##T#642_2"
                                                    var"##st#594"[var"##I#641_3"] = var"##T#642_3"
                                                    var"##st#594"[var"##I#641_4"] = var"##T#642_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#643_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 5), 1)
                                                    var"##I#643_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 5), var"##step_1_l#599"), 1)
                                                    var"##I#643_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 5), var"##step_2_l#601"), 1)
                                                    var"##I#643_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 5), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#644_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#643_1"])
                                                    var"##T#644_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#643_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#643_3"]))
                                                    var"##T#644_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#643_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#643_3"]))
                                                    var"##T#644_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#643_4"])
                                                    var"##st#594"[var"##I#643_1"] = var"##T#644_1"
                                                    var"##st#594"[var"##I#643_2"] = var"##T#644_2"
                                                    var"##st#594"[var"##I#643_3"] = var"##T#644_3"
                                                    var"##st#594"[var"##I#643_4"] = var"##T#644_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#645_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 6), 1)
                                                    var"##I#645_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 6), var"##step_1_l#599"), 1)
                                                    var"##I#645_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 6), var"##step_2_l#601"), 1)
                                                    var"##I#645_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 6), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#646_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#645_1"])
                                                    var"##T#646_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#645_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#645_3"]))
                                                    var"##T#646_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#645_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#645_3"]))
                                                    var"##T#646_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#645_4"])
                                                    var"##st#594"[var"##I#645_1"] = var"##T#646_1"
                                                    var"##st#594"[var"##I#645_2"] = var"##T#646_2"
                                                    var"##st#594"[var"##I#645_3"] = var"##T#646_3"
                                                    var"##st#594"[var"##I#645_4"] = var"##T#646_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                begin
                                                    var"##I#647_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 7), 1)
                                                    var"##I#647_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 7), var"##step_1_l#599"), 1)
                                                    var"##I#647_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 7), var"##step_2_l#601"), 1)
                                                    var"##I#647_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#597_3", 7), var"##step_1_l#599"), var"##step_2_l#601"), 1)
                                                    var"##T#648_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#594"[var"##I#647_1"])
                                                    var"##T#648_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#594"[var"##I#647_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#594"[var"##I#647_3"]))
                                                    var"##T#648_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#594"[var"##I#647_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#594"[var"##I#647_3"]))
                                                    var"##T#648_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#594"[var"##I#647_4"])
                                                    var"##st#594"[var"##I#647_1"] = var"##T#648_1"
                                                    var"##st#594"[var"##I#647_2"] = var"##T#648_2"
                                                    var"##st#594"[var"##I#647_3"] = var"##T#648_3"
                                                    var"##st#594"[var"##I#647_4"] = var"##T#648_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#2#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#594"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#651"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#652"::YaoLocations.Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#653" = (YaoLocations.plain)(var"##locs#652")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#653"[1] > var"##plain_locs#653"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#652" = Locations((var"##plain_locs#653"[2], var"##plain_locs#653"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#654" = (YaoLocations.plain)(var"##locs#652")
                    var"##nqubits#655" = (BQCESubroutine.log2i)(size(var"##st#651", 1))
                    var"##nlocs_needed#656" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#660" = 1 << (var"##plain_locs#654"[1] - 1)
                    var"##step_1_h#661" = 1 << var"##plain_locs#654"[1]
                    var"##step_2_l#662" = 1 << (var"##plain_locs#654"[2] - 1)
                    var"##step_2_h#663" = 1 << var"##plain_locs#654"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#3#val" = begin
                                if var"##nlocs_needed#656" ≤ Base.FastMath.sub_fast(var"##nqubits#655", var"##plain_locs#654"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#660", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#657_1" = 0:var"##step_2_h#663":Base.FastMath.sub_fast(size(var"##st#651", 1), var"##step_2_h#663")
                                                                for var"##idx#657_2" = var"##idx#657_1":var"##step_1_h#661":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#657_1", var"##step_2_l#662"), var"##step_1_h#661")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#664_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_2", 0), 1)
                                                                            var"##I#664_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_2", 0), var"##step_1_l#660"), 1)
                                                                            var"##I#664_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_2", 0), var"##step_2_l#662"), 1)
                                                                            var"##I#664_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_2", 0), var"##step_1_l#660"), var"##step_2_l#662"), 1)
                                                                            var"##T#665_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#651"[var"##I#664_1"])
                                                                            var"##T#665_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#651"[var"##I#664_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#651"[var"##I#664_3"]))
                                                                            var"##T#665_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#651"[var"##I#664_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#651"[var"##I#664_3"]))
                                                                            var"##T#665_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#651"[var"##I#664_4"])
                                                                            var"##st#651"[var"##I#664_1"] = var"##T#665_1"
                                                                            var"##st#651"[var"##I#664_2"] = var"##T#665_2"
                                                                            var"##st#651"[var"##I#664_3"] = var"##T#665_3"
                                                                            var"##st#651"[var"##I#664_4"] = var"##T#665_4"
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
                                                                (var"##inner##loop##", var"#4###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#663":Base.FastMath.sub_fast(size(var"##st#651", static(1)), var"##step_2_h#663"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#5###ITER_LENG##" = (ArrayInterface.static_length)(var"#4###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#6###LOOP_STEP##" = (ArrayInterface.static_step)(var"#4###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#7###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#4###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#661#915", var"####step_2_l#662#916", var"####step_1_l#660#919", var"####hoisted#585#923", var"####st#651#924", var"####hoisted#586#926", var"####hoisted#587#927", var"####hoisted#588#929", var"####hoisted#589#930", var"####hoisted#590#932"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#12#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#657_1#913" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#657_2#914" = var"####idx#657_1#913":var"####step_1_h#661#915":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#657_1#913", var"####step_2_l#662#916"), var"####step_1_h#661#915")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        var"####I#664_1#917" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_2#914", 0), 1)
                                                                                                                        var"####I#664_2#918" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_2#914", 0), var"####step_1_l#660#919"), 1)
                                                                                                                        var"####I#664_3#920" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_2#914", 0), var"####step_2_l#662#916"), 1)
                                                                                                                        var"####I#664_4#921" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_2#914", 0), var"####step_1_l#660#919"), var"####step_2_l#662#916"), 1)
                                                                                                                        var"####T#665_1#922" = Base.FastMath.mul_fast(var"####hoisted#585#923", var"####st#651#924"[var"####I#664_1#917"])
                                                                                                                        var"####T#665_2#925" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#926", var"####st#651#924"[var"####I#664_2#918"]), Base.FastMath.mul_fast(var"####hoisted#587#927", var"####st#651#924"[var"####I#664_3#920"]))
                                                                                                                        var"####T#665_3#928" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#929", var"####st#651#924"[var"####I#664_2#918"]), Base.FastMath.mul_fast(var"####hoisted#589#930", var"####st#651#924"[var"####I#664_3#920"]))
                                                                                                                        var"####T#665_4#931" = Base.FastMath.mul_fast(var"####hoisted#590#932", var"####st#651#924"[var"####I#664_4#921"])
                                                                                                                        var"####st#651#924"[var"####I#664_1#917"] = var"####T#665_1#922"
                                                                                                                        var"####st#651#924"[var"####I#664_2#918"] = var"####T#665_2#925"
                                                                                                                        var"####st#651#924"[var"####I#664_3#920"] = var"####T#665_3#928"
                                                                                                                        var"####st#651#924"[var"####I#664_4#921"] = var"####T#665_4#931"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#12#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#5###ITER_LENG##", Polyester.min(var"#5###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#7###LOOPOFFSET##", var"#6###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#661", var"##step_2_l#662", var"##step_1_l#660", var"##hoisted#585", var"##st#651", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#651"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#657_1" = 0:var"##step_2_h#663":Base.FastMath.sub_fast(size(var"##st#651", 1), var"##step_2_h#663")
                                                        for var"##idx#657_2" = var"##idx#657_1":var"##step_1_h#661":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#657_1", var"##step_2_l#662"), var"##step_1_h#661")
                                                            for var"##idx#657_3" = var"##idx#657_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#657_2", var"##step_1_l#660"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            var"##I#666_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), 1)
                                                                            var"##I#666_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), var"##step_1_l#660"), 1)
                                                                            var"##I#666_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), var"##step_2_l#662"), 1)
                                                                            var"##I#666_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), var"##step_1_l#660"), var"##step_2_l#662"), 1)
                                                                            var"##T#667_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#651"[var"##I#666_1"])
                                                                            var"##T#667_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#651"[var"##I#666_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#651"[var"##I#666_3"]))
                                                                            var"##T#667_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#651"[var"##I#666_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#651"[var"##I#666_3"]))
                                                                            var"##T#667_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#651"[var"##I#666_4"])
                                                                            var"##st#651"[var"##I#666_1"] = var"##T#667_1"
                                                                            var"##st#651"[var"##I#666_2"] = var"##T#667_2"
                                                                            var"##st#651"[var"##I#666_3"] = var"##T#667_3"
                                                                            var"##st#651"[var"##I#666_4"] = var"##T#667_4"
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
                                                        (var"##inner##loop##", var"#13###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#663":Base.FastMath.sub_fast(size(var"##st#651", static(1)), var"##step_2_h#663"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#14###ITER_LENG##" = (ArrayInterface.static_length)(var"#13###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#15###LOOP_STEP##" = (ArrayInterface.static_step)(var"#13###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#16###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#13###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#661#935", var"####step_2_l#662#936", var"####step_1_l#660#938", var"####hoisted#585#944", var"####st#651#945", var"####hoisted#586#947", var"####hoisted#587#948", var"####hoisted#588#950", var"####hoisted#589#951", var"####hoisted#590#953"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#21#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#657_1#933" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#657_2#934" = var"####idx#657_1#933":var"####step_1_h#661#935":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#657_1#933", var"####step_2_l#662#936"), var"####step_1_h#661#935")
                                                                                                        for var"####idx#657_3#937" = var"####idx#657_2#934":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#657_2#934", var"####step_1_l#660#938"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        var"####I#666_1#939" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_3#937", 0), 1)
                                                                                                                        var"####I#666_2#940" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_3#937", 0), var"####step_1_l#660#938"), 1)
                                                                                                                        var"####I#666_3#941" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_3#937", 0), var"####step_2_l#662#936"), 1)
                                                                                                                        var"####I#666_4#942" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#657_3#937", 0), var"####step_1_l#660#938"), var"####step_2_l#662#936"), 1)
                                                                                                                        var"####T#667_1#943" = Base.FastMath.mul_fast(var"####hoisted#585#944", var"####st#651#945"[var"####I#666_1#939"])
                                                                                                                        var"####T#667_2#946" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#947", var"####st#651#945"[var"####I#666_2#940"]), Base.FastMath.mul_fast(var"####hoisted#587#948", var"####st#651#945"[var"####I#666_3#941"]))
                                                                                                                        var"####T#667_3#949" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#950", var"####st#651#945"[var"####I#666_2#940"]), Base.FastMath.mul_fast(var"####hoisted#589#951", var"####st#651#945"[var"####I#666_3#941"]))
                                                                                                                        var"####T#667_4#952" = Base.FastMath.mul_fast(var"####hoisted#590#953", var"####st#651#945"[var"####I#666_4#942"])
                                                                                                                        var"####st#651#945"[var"####I#666_1#939"] = var"####T#667_1#943"
                                                                                                                        var"####st#651#945"[var"####I#666_2#940"] = var"####T#667_2#946"
                                                                                                                        var"####st#651#945"[var"####I#666_3#941"] = var"####T#667_3#949"
                                                                                                                        var"####st#651#945"[var"####I#666_4#942"] = var"####T#667_4#952"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#21#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#14###ITER_LENG##", Polyester.min(var"#14###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#16###LOOPOFFSET##", var"#15###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#661", var"##step_2_l#662", var"##step_1_l#660", var"##hoisted#585", var"##st#651", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#651"
                                end
                                if var"##nlocs_needed#656" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#655", var"##plain_locs#654"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    var"##m#659" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#655", var"##nlocs_needed#656"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:506 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#660", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#23#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#22#range" = (BQCESubroutine.bsubspace)(var"##nqubits#655", (1:var"##m#659"..., var"##plain_locs#654"[1], var"##plain_locs#654"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#23#threadsfor_fun"(var"#35#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#27#r" = var"#22#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#28#lenr" = Base.Threads.length(var"#27#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#35#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#29#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#30#len", var"#31#rem") = (var"#28#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#29#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#30#len", var"#31#rem") = Base.Threads.divrem(var"#28#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#30#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#29#tid" > var"#31#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#30#len", var"#31#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#32#f" = Base.Threads.firstindex(var"#27#r") + (var"#29#tid" - 1) * var"#30#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#33#l" = (var"#32#f" + var"#30#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#31#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#29#tid" <= var"#31#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#32#f" = var"#32#f" + (var"#29#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#33#l" = var"#33#l" + var"#29#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#32#f" = var"#32#f" + var"#31#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#33#l" = var"#33#l" + var"#31#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#34#i" = var"#32#f":var"#33#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#658" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#36#val" = var"#27#r"[var"#34#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#36#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            println(length(var"#22#range"))
                                                                            #println(var"##m#659")
                                                                            println(var"##base#658")
                                                                            var"##I#668_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", 0), 1)
                                                                            var"##I#668_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", 0), var"##step_1_l#660"), 1)
                                                                            var"##I#668_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", 0), var"##step_2_l#662"), 1)
                                                                            var"##I#668_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", 0), var"##step_1_l#660"), var"##step_2_l#662"), 1)
                                                                            var"##T#669_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#651"[var"##I#668_1"])
                                                                            var"##T#669_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#651"[var"##I#668_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#651"[var"##I#668_3"]))
                                                                            var"##T#669_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#651"[var"##I#668_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#651"[var"##I#668_3"]))
                                                                            var"##T#669_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#651"[var"##I#668_4"])
                                                                            var"##st#651"[var"##I#668_1"] = var"##T#669_1"
                                                                            var"##st#651"[var"##I#668_2"] = var"##T#669_2"
                                                                            var"##st#651"[var"##I#668_3"] = var"##T#669_3"
                                                                            var"##st#651"[var"##I#668_4"] = var"##T#669_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#23#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#23#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#651"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#38#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#37#range" = (BQCESubroutine.bsubspace)(var"##nqubits#655", (1:var"##m#659"..., var"##plain_locs#654"[1], var"##plain_locs#654"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#38#threadsfor_fun"(var"#50#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#42#r" = var"#37#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#43#lenr" = Base.Threads.length(var"#42#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#50#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#44#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#45#len", var"#46#rem") = (var"#43#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#44#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#45#len", var"#46#rem") = Base.Threads.divrem(var"#43#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#45#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#44#tid" > var"#46#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#45#len", var"#46#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#47#f" = Base.Threads.firstindex(var"#42#r") + (var"#44#tid" - 1) * var"#45#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#48#l" = (var"#47#f" + var"#45#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#46#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#44#tid" <= var"#46#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#47#f" = var"#47#f" + (var"#44#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#48#l" = var"#48#l" + var"#44#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#47#f" = var"#47#f" + var"#46#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#48#l" = var"#48#l" + var"#46#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#49#i" = var"#47#f":var"#48#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#658" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#51#val" = var"#42#r"[var"#49#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#51#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#657_3" = var"##base#658":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##base#658", var"##step_1_l#660"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    begin
                                                                        var"##I#670_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), 1)
                                                                        var"##I#670_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), var"##step_1_l#660"), 1)
                                                                        var"##I#670_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), var"##step_2_l#662"), 1)
                                                                        var"##I#670_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#657_3", 0), var"##step_1_l#660"), var"##step_2_l#662"), 1)
                                                                        var"##T#671_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#651"[var"##I#670_1"])
                                                                        var"##T#671_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#651"[var"##I#670_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#651"[var"##I#670_3"]))
                                                                        var"##T#671_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#651"[var"##I#670_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#651"[var"##I#670_3"]))
                                                                        var"##T#671_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#651"[var"##I#670_4"])
                                                                        var"##st#651"[var"##I#670_1"] = var"##T#671_1"
                                                                        var"##st#651"[var"##I#670_2"] = var"##T#671_2"
                                                                        var"##st#651"[var"##I#670_3"] = var"##T#671_3"
                                                                        var"##st#651"[var"##I#670_4"] = var"##T#671_4"
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
                                                (Base.Threads.Base).invokelatest(var"#38#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#38#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:507 =#
                                    return var"##st#651"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                    var"##m#659" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#655", var"##nlocs_needed#656"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#53#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#52#range" = (BQCESubroutine.bsubspace)(var"##nqubits#655", (1:var"##m#659"..., var"##plain_locs#654"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#53#threadsfor_fun"(var"#65#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#57#r" = var"#52#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#58#lenr" = Base.Threads.length(var"#57#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#65#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#59#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#60#len", var"#61#rem") = (var"#58#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#59#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#60#len", var"#61#rem") = Base.Threads.divrem(var"#58#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#60#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#59#tid" > var"#61#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#60#len", var"#61#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#62#f" = Base.Threads.firstindex(var"#57#r") + (var"#59#tid" - 1) * var"#60#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#63#l" = (var"#62#f" + var"#60#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#61#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#59#tid" <= var"#61#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#62#f" = var"#62#f" + (var"#59#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#63#l" = var"#63#l" + var"#59#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#62#f" = var"#62#f" + var"#61#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#63#l" = var"#63#l" + var"#61#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#64#i" = var"#62#f":var"#63#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#658" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#66#val" = var"#57#r"[var"#64#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#66#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:515 =#
                                                        for var"##idx#657_1" = 0:Base.FastMath.sub_fast(1 << var"##m#659", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:516 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                begin
                                                                    var"##I#672_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", var"##idx#657_1"), 1)
                                                                    var"##I#672_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", var"##idx#657_1"), var"##step_1_l#660"), 1)
                                                                    var"##I#672_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", var"##idx#657_1"), var"##step_2_l#662"), 1)
                                                                    var"##I#672_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#658", var"##idx#657_1"), var"##step_1_l#660"), var"##step_2_l#662"), 1)
                                                                    var"##T#673_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#651"[var"##I#672_1"])
                                                                    var"##T#673_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#651"[var"##I#672_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#651"[var"##I#672_3"]))
                                                                    var"##T#673_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#651"[var"##I#672_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#651"[var"##I#672_3"]))
                                                                    var"##T#673_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#651"[var"##I#672_4"])
                                                                    var"##st#651"[var"##I#672_1"] = var"##T#673_1"
                                                                    var"##st#651"[var"##I#672_2"] = var"##T#673_2"
                                                                    var"##st#651"[var"##I#672_3"] = var"##T#673_3"
                                                                    var"##st#651"[var"##I#672_4"] = var"##T#673_4"
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
                                            (Base.Threads.Base).invokelatest(var"#53#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#53#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#651"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#3#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#651"
    end
    function BQCESubroutine.broutine!(var"##st#674"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#675"::YaoLocations.Locations, var"##ctrl#591"::YaoLocations.CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#675") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#674", Val{:PSWAP_test}(), var"##locs#675", var"##ctrl#591", θ)
                    return var"##st#674"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#675") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#674", Val{:PSWAP_test}(), var"##locs#675", var"##ctrl#591", θ)
                return var"##st#674"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#674"
    end
    function BQCESubroutine.basic_broutine!(var"##st#676"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#677"::YaoLocations.Locations, var"##ctrl#591"::YaoLocations.CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#678" = (YaoLocations.plain)(var"##locs#677")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#678"[1] > var"##plain_locs#678"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#677" = Locations((var"##plain_locs#678"[2], var"##plain_locs#678"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#680" = (YaoLocations.plain)(var"##locs#677")
                    var"##step_1_l#681" = 1 << (var"##plain_locs#680"[1] - 1)
                    var"##step_1_h#682" = 1 << var"##plain_locs#680"[1]
                    var"##step_2_l#683" = 1 << (var"##plain_locs#680"[2] - 1)
                    var"##step_2_h#684" = 1 << var"##plain_locs#680"[2]
                    var"##ctrl_mask#687" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#591"))
                    var"##flag_mask#688" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#591")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#67#val" = begin
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#681", 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#679_1" = 0:var"##step_2_h#684":Base.FastMath.sub_fast(size(var"##st#676", 1), var"##step_2_h#684"), var"##m#679_2" = var"##m#679_1":var"##step_1_h#682":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#679_1", var"##step_2_l#683"), var"##step_1_h#682")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 0), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#685_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), 1)
                                                    var"##I#685_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), 1)
                                                    var"##I#685_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_2_l#683"), 1)
                                                    var"##I#685_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#686_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#685_1"])
                                                    var"##T#686_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#685_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#685_3"]))
                                                    var"##T#686_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#685_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#685_3"]))
                                                    var"##T#686_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#685_4"])
                                                    var"##st#676"[var"##I#685_1"] = var"##T#686_1"
                                                    var"##st#676"[var"##I#685_2"] = var"##T#686_2"
                                                    var"##st#676"[var"##I#685_3"] = var"##T#686_3"
                                                    var"##st#676"[var"##I#685_4"] = var"##T#686_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#676"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#681", 2)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#679_1" = 0:var"##step_2_h#684":Base.FastMath.sub_fast(size(var"##st#676", 1), var"##step_2_h#684"), var"##m#679_2" = var"##m#679_1":var"##step_1_h#682":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#679_1", var"##step_2_l#683"), var"##step_1_h#682")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 0), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#689_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), 1)
                                                    var"##I#689_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), 1)
                                                    var"##I#689_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_2_l#683"), 1)
                                                    var"##I#689_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#690_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#689_1"])
                                                    var"##T#690_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#689_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#689_3"]))
                                                    var"##T#690_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#689_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#689_3"]))
                                                    var"##T#690_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#689_4"])
                                                    var"##st#676"[var"##I#689_1"] = var"##T#690_1"
                                                    var"##st#676"[var"##I#689_2"] = var"##T#690_2"
                                                    var"##st#676"[var"##I#689_3"] = var"##T#690_3"
                                                    var"##st#676"[var"##I#689_4"] = var"##T#690_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 1), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#691_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), 1)
                                                    var"##I#691_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_1_l#681"), 1)
                                                    var"##I#691_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_2_l#683"), 1)
                                                    var"##I#691_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#692_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#691_1"])
                                                    var"##T#692_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#691_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#691_3"]))
                                                    var"##T#692_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#691_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#691_3"]))
                                                    var"##T#692_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#691_4"])
                                                    var"##st#676"[var"##I#691_1"] = var"##T#692_1"
                                                    var"##st#676"[var"##I#691_2"] = var"##T#692_2"
                                                    var"##st#676"[var"##I#691_3"] = var"##T#692_3"
                                                    var"##st#676"[var"##I#691_4"] = var"##T#692_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#676"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#681", 4)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#679_1" = 0:var"##step_2_h#684":Base.FastMath.sub_fast(size(var"##st#676", 1), var"##step_2_h#684"), var"##m#679_2" = var"##m#679_1":var"##step_1_h#682":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#679_1", var"##step_2_l#683"), var"##step_1_h#682")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 0), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#693_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), 1)
                                                    var"##I#693_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), 1)
                                                    var"##I#693_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_2_l#683"), 1)
                                                    var"##I#693_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#694_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#693_1"])
                                                    var"##T#694_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#693_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#693_3"]))
                                                    var"##T#694_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#693_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#693_3"]))
                                                    var"##T#694_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#693_4"])
                                                    var"##st#676"[var"##I#693_1"] = var"##T#694_1"
                                                    var"##st#676"[var"##I#693_2"] = var"##T#694_2"
                                                    var"##st#676"[var"##I#693_3"] = var"##T#694_3"
                                                    var"##st#676"[var"##I#693_4"] = var"##T#694_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 1), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#695_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), 1)
                                                    var"##I#695_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_1_l#681"), 1)
                                                    var"##I#695_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_2_l#683"), 1)
                                                    var"##I#695_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#696_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#695_1"])
                                                    var"##T#696_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#695_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#695_3"]))
                                                    var"##T#696_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#695_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#695_3"]))
                                                    var"##T#696_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#695_4"])
                                                    var"##st#676"[var"##I#695_1"] = var"##T#696_1"
                                                    var"##st#676"[var"##I#695_2"] = var"##T#696_2"
                                                    var"##st#676"[var"##I#695_3"] = var"##T#696_3"
                                                    var"##st#676"[var"##I#695_4"] = var"##T#696_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 2), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#697_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), 1)
                                                    var"##I#697_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), var"##step_1_l#681"), 1)
                                                    var"##I#697_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), var"##step_2_l#683"), 1)
                                                    var"##I#697_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#698_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#697_1"])
                                                    var"##T#698_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#697_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#697_3"]))
                                                    var"##T#698_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#697_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#697_3"]))
                                                    var"##T#698_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#697_4"])
                                                    var"##st#676"[var"##I#697_1"] = var"##T#698_1"
                                                    var"##st#676"[var"##I#697_2"] = var"##T#698_2"
                                                    var"##st#676"[var"##I#697_3"] = var"##T#698_3"
                                                    var"##st#676"[var"##I#697_4"] = var"##T#698_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 3), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#699_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), 1)
                                                    var"##I#699_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), var"##step_1_l#681"), 1)
                                                    var"##I#699_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), var"##step_2_l#683"), 1)
                                                    var"##I#699_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#700_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#699_1"])
                                                    var"##T#700_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#699_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#699_3"]))
                                                    var"##T#700_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#699_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#699_3"]))
                                                    var"##T#700_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#699_4"])
                                                    var"##st#676"[var"##I#699_1"] = var"##T#700_1"
                                                    var"##st#676"[var"##I#699_2"] = var"##T#700_2"
                                                    var"##st#676"[var"##I#699_3"] = var"##T#700_3"
                                                    var"##st#676"[var"##I#699_4"] = var"##T#700_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#676"
                                    end
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                    if Base.FastMath.eq_fast(var"##step_1_l#681", 8)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                        for var"##m#679_1" = 0:var"##step_2_h#684":Base.FastMath.sub_fast(size(var"##st#676", 1), var"##step_2_h#684"), var"##m#679_2" = var"##m#679_1":var"##step_1_h#682":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#679_1", var"##step_2_l#683"), var"##step_1_h#682")
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 0), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#701_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), 1)
                                                    var"##I#701_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), 1)
                                                    var"##I#701_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_2_l#683"), 1)
                                                    var"##I#701_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 0), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#702_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#701_1"])
                                                    var"##T#702_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#701_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#701_3"]))
                                                    var"##T#702_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#701_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#701_3"]))
                                                    var"##T#702_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#701_4"])
                                                    var"##st#676"[var"##I#701_1"] = var"##T#702_1"
                                                    var"##st#676"[var"##I#701_2"] = var"##T#702_2"
                                                    var"##st#676"[var"##I#701_3"] = var"##T#702_3"
                                                    var"##st#676"[var"##I#701_4"] = var"##T#702_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 1), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#703_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), 1)
                                                    var"##I#703_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_1_l#681"), 1)
                                                    var"##I#703_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_2_l#683"), 1)
                                                    var"##I#703_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 1), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#704_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#703_1"])
                                                    var"##T#704_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#703_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#703_3"]))
                                                    var"##T#704_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#703_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#703_3"]))
                                                    var"##T#704_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#703_4"])
                                                    var"##st#676"[var"##I#703_1"] = var"##T#704_1"
                                                    var"##st#676"[var"##I#703_2"] = var"##T#704_2"
                                                    var"##st#676"[var"##I#703_3"] = var"##T#704_3"
                                                    var"##st#676"[var"##I#703_4"] = var"##T#704_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 2), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#705_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), 1)
                                                    var"##I#705_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), var"##step_1_l#681"), 1)
                                                    var"##I#705_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), var"##step_2_l#683"), 1)
                                                    var"##I#705_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 2), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#706_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#705_1"])
                                                    var"##T#706_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#705_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#705_3"]))
                                                    var"##T#706_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#705_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#705_3"]))
                                                    var"##T#706_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#705_4"])
                                                    var"##st#676"[var"##I#705_1"] = var"##T#706_1"
                                                    var"##st#676"[var"##I#705_2"] = var"##T#706_2"
                                                    var"##st#676"[var"##I#705_3"] = var"##T#706_3"
                                                    var"##st#676"[var"##I#705_4"] = var"##T#706_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 3), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#707_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), 1)
                                                    var"##I#707_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), var"##step_1_l#681"), 1)
                                                    var"##I#707_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), var"##step_2_l#683"), 1)
                                                    var"##I#707_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 3), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#708_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#707_1"])
                                                    var"##T#708_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#707_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#707_3"]))
                                                    var"##T#708_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#707_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#707_3"]))
                                                    var"##T#708_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#707_4"])
                                                    var"##st#676"[var"##I#707_1"] = var"##T#708_1"
                                                    var"##st#676"[var"##I#707_2"] = var"##T#708_2"
                                                    var"##st#676"[var"##I#707_3"] = var"##T#708_3"
                                                    var"##st#676"[var"##I#707_4"] = var"##T#708_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 4), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#709_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 4), 1)
                                                    var"##I#709_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 4), var"##step_1_l#681"), 1)
                                                    var"##I#709_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 4), var"##step_2_l#683"), 1)
                                                    var"##I#709_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 4), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#710_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#709_1"])
                                                    var"##T#710_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#709_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#709_3"]))
                                                    var"##T#710_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#709_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#709_3"]))
                                                    var"##T#710_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#709_4"])
                                                    var"##st#676"[var"##I#709_1"] = var"##T#710_1"
                                                    var"##st#676"[var"##I#709_2"] = var"##T#710_2"
                                                    var"##st#676"[var"##I#709_3"] = var"##T#710_3"
                                                    var"##st#676"[var"##I#709_4"] = var"##T#710_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 5), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#711_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 5), 1)
                                                    var"##I#711_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 5), var"##step_1_l#681"), 1)
                                                    var"##I#711_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 5), var"##step_2_l#683"), 1)
                                                    var"##I#711_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 5), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#712_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#711_1"])
                                                    var"##T#712_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#711_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#711_3"]))
                                                    var"##T#712_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#711_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#711_3"]))
                                                    var"##T#712_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#711_4"])
                                                    var"##st#676"[var"##I#711_1"] = var"##T#712_1"
                                                    var"##st#676"[var"##I#711_2"] = var"##T#712_2"
                                                    var"##st#676"[var"##I#711_3"] = var"##T#712_3"
                                                    var"##st#676"[var"##I#711_4"] = var"##T#712_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 6), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#713_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 6), 1)
                                                    var"##I#713_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 6), var"##step_1_l#681"), 1)
                                                    var"##I#713_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 6), var"##step_2_l#683"), 1)
                                                    var"##I#713_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 6), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#714_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#713_1"])
                                                    var"##T#714_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#713_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#713_3"]))
                                                    var"##T#714_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#713_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#713_3"]))
                                                    var"##T#714_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#713_4"])
                                                    var"##st#676"[var"##I#713_1"] = var"##T#714_1"
                                                    var"##st#676"[var"##I#713_2"] = var"##T#714_2"
                                                    var"##st#676"[var"##I#713_3"] = var"##T#714_3"
                                                    var"##st#676"[var"##I#713_4"] = var"##T#714_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_2", 7), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#715_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 7), 1)
                                                    var"##I#715_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 7), var"##step_1_l#681"), 1)
                                                    var"##I#715_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 7), var"##step_2_l#683"), 1)
                                                    var"##I#715_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_2", 7), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#716_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#715_1"])
                                                    var"##T#716_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#715_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#715_3"]))
                                                    var"##T#716_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#715_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#715_3"]))
                                                    var"##T#716_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#715_4"])
                                                    var"##st#676"[var"##I#715_1"] = var"##T#716_1"
                                                    var"##st#676"[var"##I#715_2"] = var"##T#716_2"
                                                    var"##st#676"[var"##I#715_3"] = var"##T#716_3"
                                                    var"##st#676"[var"##I#715_4"] = var"##T#716_4"
                                                end
                                            end
                                        end
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                        return var"##st#676"
                                    end
                                end
                                for var"##m#679_1" = 0:var"##step_2_h#684":Base.FastMath.sub_fast(size(var"##st#676", 1), var"##step_2_h#684"), var"##m#679_2" = var"##m#679_1":var"##step_1_h#682":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#679_1", var"##step_2_l#683"), var"##step_1_h#682")
                                    for var"##m#679_3" = var"##m#679_2":8:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#679_2", var"##step_1_l#681"), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                        begin
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 0), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#717_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 0), 1)
                                                    var"##I#717_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 0), var"##step_1_l#681"), 1)
                                                    var"##I#717_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 0), var"##step_2_l#683"), 1)
                                                    var"##I#717_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 0), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#718_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#717_1"])
                                                    var"##T#718_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#717_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#717_3"]))
                                                    var"##T#718_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#717_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#717_3"]))
                                                    var"##T#718_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#717_4"])
                                                    var"##st#676"[var"##I#717_1"] = var"##T#718_1"
                                                    var"##st#676"[var"##I#717_2"] = var"##T#718_2"
                                                    var"##st#676"[var"##I#717_3"] = var"##T#718_3"
                                                    var"##st#676"[var"##I#717_4"] = var"##T#718_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 1), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#719_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 1), 1)
                                                    var"##I#719_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 1), var"##step_1_l#681"), 1)
                                                    var"##I#719_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 1), var"##step_2_l#683"), 1)
                                                    var"##I#719_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 1), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#720_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#719_1"])
                                                    var"##T#720_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#719_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#719_3"]))
                                                    var"##T#720_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#719_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#719_3"]))
                                                    var"##T#720_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#719_4"])
                                                    var"##st#676"[var"##I#719_1"] = var"##T#720_1"
                                                    var"##st#676"[var"##I#719_2"] = var"##T#720_2"
                                                    var"##st#676"[var"##I#719_3"] = var"##T#720_3"
                                                    var"##st#676"[var"##I#719_4"] = var"##T#720_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 2), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#721_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 2), 1)
                                                    var"##I#721_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 2), var"##step_1_l#681"), 1)
                                                    var"##I#721_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 2), var"##step_2_l#683"), 1)
                                                    var"##I#721_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 2), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#722_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#721_1"])
                                                    var"##T#722_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#721_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#721_3"]))
                                                    var"##T#722_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#721_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#721_3"]))
                                                    var"##T#722_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#721_4"])
                                                    var"##st#676"[var"##I#721_1"] = var"##T#722_1"
                                                    var"##st#676"[var"##I#721_2"] = var"##T#722_2"
                                                    var"##st#676"[var"##I#721_3"] = var"##T#722_3"
                                                    var"##st#676"[var"##I#721_4"] = var"##T#722_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 3), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#723_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 3), 1)
                                                    var"##I#723_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 3), var"##step_1_l#681"), 1)
                                                    var"##I#723_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 3), var"##step_2_l#683"), 1)
                                                    var"##I#723_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 3), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#724_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#723_1"])
                                                    var"##T#724_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#723_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#723_3"]))
                                                    var"##T#724_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#723_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#723_3"]))
                                                    var"##T#724_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#723_4"])
                                                    var"##st#676"[var"##I#723_1"] = var"##T#724_1"
                                                    var"##st#676"[var"##I#723_2"] = var"##T#724_2"
                                                    var"##st#676"[var"##I#723_3"] = var"##T#724_3"
                                                    var"##st#676"[var"##I#723_4"] = var"##T#724_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 4), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#725_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 4), 1)
                                                    var"##I#725_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 4), var"##step_1_l#681"), 1)
                                                    var"##I#725_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 4), var"##step_2_l#683"), 1)
                                                    var"##I#725_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 4), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#726_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#725_1"])
                                                    var"##T#726_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#725_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#725_3"]))
                                                    var"##T#726_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#725_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#725_3"]))
                                                    var"##T#726_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#725_4"])
                                                    var"##st#676"[var"##I#725_1"] = var"##T#726_1"
                                                    var"##st#676"[var"##I#725_2"] = var"##T#726_2"
                                                    var"##st#676"[var"##I#725_3"] = var"##T#726_3"
                                                    var"##st#676"[var"##I#725_4"] = var"##T#726_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 5), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#727_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 5), 1)
                                                    var"##I#727_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 5), var"##step_1_l#681"), 1)
                                                    var"##I#727_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 5), var"##step_2_l#683"), 1)
                                                    var"##I#727_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 5), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#728_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#727_1"])
                                                    var"##T#728_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#727_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#727_3"]))
                                                    var"##T#728_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#727_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#727_3"]))
                                                    var"##T#728_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#727_4"])
                                                    var"##st#676"[var"##I#727_1"] = var"##T#728_1"
                                                    var"##st#676"[var"##I#727_2"] = var"##T#728_2"
                                                    var"##st#676"[var"##I#727_3"] = var"##T#728_3"
                                                    var"##st#676"[var"##I#727_4"] = var"##T#728_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 6), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#729_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 6), 1)
                                                    var"##I#729_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 6), var"##step_1_l#681"), 1)
                                                    var"##I#729_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 6), var"##step_2_l#683"), 1)
                                                    var"##I#729_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 6), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#730_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#729_1"])
                                                    var"##T#730_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#729_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#729_3"]))
                                                    var"##T#730_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#729_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#729_3"]))
                                                    var"##T#730_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#729_4"])
                                                    var"##st#676"[var"##I#729_1"] = var"##T#730_1"
                                                    var"##st#676"[var"##I#729_2"] = var"##T#730_2"
                                                    var"##st#676"[var"##I#729_3"] = var"##T#730_3"
                                                    var"##st#676"[var"##I#729_4"] = var"##T#730_4"
                                                end
                                            end
                                            begin
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                nothing
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##m#679_3", 7), var"##ctrl_mask#687", var"##flag_mask#688")
                                                    var"##I#731_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 7), 1)
                                                    var"##I#731_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 7), var"##step_1_l#681"), 1)
                                                    var"##I#731_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 7), var"##step_2_l#683"), 1)
                                                    var"##I#731_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#679_3", 7), var"##step_1_l#681"), var"##step_2_l#683"), 1)
                                                    var"##T#732_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#676"[var"##I#731_1"])
                                                    var"##T#732_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#676"[var"##I#731_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#676"[var"##I#731_3"]))
                                                    var"##T#732_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#676"[var"##I#731_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#676"[var"##I#731_3"]))
                                                    var"##T#732_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#676"[var"##I#731_4"])
                                                    var"##st#676"[var"##I#731_1"] = var"##T#732_1"
                                                    var"##st#676"[var"##I#731_2"] = var"##T#732_2"
                                                    var"##st#676"[var"##I#731_3"] = var"##T#732_3"
                                                    var"##st#676"[var"##I#731_4"] = var"##T#732_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#67#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#676"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#735"::AbstractVector{T} where T, ::Val{:PSWAP_test}, var"##locs#736"::YaoLocations.Locations, var"##ctrl#591"::YaoLocations.CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#737" = (YaoLocations.plain)(var"##locs#736")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#737"[1] > var"##plain_locs#737"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#736" = Locations((var"##plain_locs#737"[2], var"##plain_locs#737"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#738" = (YaoLocations.plain)(var"##locs#736")
                    var"##nqubits#739" = (BQCESubroutine.log2i)(size(var"##st#735", 1))
                    var"##nlocs_needed#740" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#744" = 1 << (var"##plain_locs#738"[1] - 1)
                    var"##step_1_h#745" = 1 << var"##plain_locs#738"[1]
                    var"##step_2_l#746" = 1 << (var"##plain_locs#738"[2] - 1)
                    var"##step_2_h#747" = 1 << var"##plain_locs#738"[2]
                    var"##ctrl_mask#750" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#591"))
                    var"##flag_mask#751" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#591")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#68#val" = begin
                                if var"##nlocs_needed#740" ≤ Base.FastMath.sub_fast(var"##nqubits#739", var"##plain_locs#738"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#744", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#741_1" = 0:var"##step_2_h#747":Base.FastMath.sub_fast(size(var"##st#735", 1), var"##step_2_h#747")
                                                                for var"##idx#741_2" = var"##idx#741_1":var"##step_1_h#745":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#741_1", var"##step_2_l#746"), var"##step_1_h#745")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#741_2", 0), var"##ctrl_mask#750", var"##flag_mask#751")
                                                                            var"##I#748_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_2", 0), 1)
                                                                            var"##I#748_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_2", 0), var"##step_1_l#744"), 1)
                                                                            var"##I#748_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_2", 0), var"##step_2_l#746"), 1)
                                                                            var"##I#748_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_2", 0), var"##step_1_l#744"), var"##step_2_l#746"), 1)
                                                                            var"##T#749_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#735"[var"##I#748_1"])
                                                                            var"##T#749_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#735"[var"##I#748_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#735"[var"##I#748_3"]))
                                                                            var"##T#749_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#735"[var"##I#748_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#735"[var"##I#748_3"]))
                                                                            var"##T#749_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#735"[var"##I#748_4"])
                                                                            var"##st#735"[var"##I#748_1"] = var"##T#749_1"
                                                                            var"##st#735"[var"##I#748_2"] = var"##T#749_2"
                                                                            var"##st#735"[var"##I#748_3"] = var"##T#749_3"
                                                                            var"##st#735"[var"##I#748_4"] = var"##T#749_4"
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
                                                                (var"##inner##loop##", var"#69###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#747":Base.FastMath.sub_fast(size(var"##st#735", static(1)), var"##step_2_h#747"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#70###ITER_LENG##" = (ArrayInterface.static_length)(var"#69###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#71###LOOP_STEP##" = (ArrayInterface.static_step)(var"#69###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#72###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#69###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#745#956", var"####step_2_l#746#957", var"####ctrl_mask#750#958", var"####flag_mask#751#959", var"####step_1_l#744#962", var"####hoisted#585#966", var"####st#735#967", var"####hoisted#586#969", var"####hoisted#587#970", var"####hoisted#588#972", var"####hoisted#589#973", var"####hoisted#590#975"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#77#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#741_1#954" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#741_2#955" = var"####idx#741_1#954":var"####step_1_h#745#956":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#741_1#954", var"####step_2_l#746#957"), var"####step_1_h#745#956")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#741_2#955", 0), var"####ctrl_mask#750#958", var"####flag_mask#751#959")
                                                                                                                        var"####I#748_1#960" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_2#955", 0), 1)
                                                                                                                        var"####I#748_2#961" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_2#955", 0), var"####step_1_l#744#962"), 1)
                                                                                                                        var"####I#748_3#963" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_2#955", 0), var"####step_2_l#746#957"), 1)
                                                                                                                        var"####I#748_4#964" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_2#955", 0), var"####step_1_l#744#962"), var"####step_2_l#746#957"), 1)
                                                                                                                        var"####T#749_1#965" = Base.FastMath.mul_fast(var"####hoisted#585#966", var"####st#735#967"[var"####I#748_1#960"])
                                                                                                                        var"####T#749_2#968" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#969", var"####st#735#967"[var"####I#748_2#961"]), Base.FastMath.mul_fast(var"####hoisted#587#970", var"####st#735#967"[var"####I#748_3#963"]))
                                                                                                                        var"####T#749_3#971" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#972", var"####st#735#967"[var"####I#748_2#961"]), Base.FastMath.mul_fast(var"####hoisted#589#973", var"####st#735#967"[var"####I#748_3#963"]))
                                                                                                                        var"####T#749_4#974" = Base.FastMath.mul_fast(var"####hoisted#590#975", var"####st#735#967"[var"####I#748_4#964"])
                                                                                                                        var"####st#735#967"[var"####I#748_1#960"] = var"####T#749_1#965"
                                                                                                                        var"####st#735#967"[var"####I#748_2#961"] = var"####T#749_2#968"
                                                                                                                        var"####st#735#967"[var"####I#748_3#963"] = var"####T#749_3#971"
                                                                                                                        var"####st#735#967"[var"####I#748_4#964"] = var"####T#749_4#974"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                        $(Expr(:inbounds, :pop))
                                                                                        var"#77#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#70###ITER_LENG##", Polyester.min(var"#70###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#72###LOOPOFFSET##", var"#71###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#745", var"##step_2_l#746", var"##ctrl_mask#750", var"##flag_mask#751", var"##step_1_l#744", var"##hoisted#585", var"##st#735", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#735"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#741_1" = 0:var"##step_2_h#747":Base.FastMath.sub_fast(size(var"##st#735", 1), var"##step_2_h#747")
                                                        for var"##idx#741_2" = var"##idx#741_1":var"##step_1_h#745":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#741_1", var"##step_2_l#746"), var"##step_1_h#745")
                                                            for var"##idx#741_3" = var"##idx#741_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#741_2", var"##step_1_l#744"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##ctrl_mask#750", var"##flag_mask#751")
                                                                            var"##I#752_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), 1)
                                                                            var"##I#752_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##step_1_l#744"), 1)
                                                                            var"##I#752_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##step_2_l#746"), 1)
                                                                            var"##I#752_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##step_1_l#744"), var"##step_2_l#746"), 1)
                                                                            var"##T#753_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#735"[var"##I#752_1"])
                                                                            var"##T#753_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#735"[var"##I#752_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#735"[var"##I#752_3"]))
                                                                            var"##T#753_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#735"[var"##I#752_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#735"[var"##I#752_3"]))
                                                                            var"##T#753_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#735"[var"##I#752_4"])
                                                                            var"##st#735"[var"##I#752_1"] = var"##T#753_1"
                                                                            var"##st#735"[var"##I#752_2"] = var"##T#753_2"
                                                                            var"##st#735"[var"##I#752_3"] = var"##T#753_3"
                                                                            var"##st#735"[var"##I#752_4"] = var"##T#753_4"
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
                                                        (var"##inner##loop##", var"#78###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#747":Base.FastMath.sub_fast(size(var"##st#735", static(1)), var"##step_2_h#747"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#79###ITER_LENG##" = (ArrayInterface.static_length)(var"#78###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#80###LOOP_STEP##" = (ArrayInterface.static_step)(var"#78###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#81###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#78###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#745#978", var"####step_2_l#746#979", var"####step_1_l#744#981", var"####ctrl_mask#750#982", var"####flag_mask#751#983", var"####hoisted#585#989", var"####st#735#990", var"####hoisted#586#992", var"####hoisted#587#993", var"####hoisted#588#995", var"####hoisted#589#996", var"####hoisted#590#998"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#86#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#741_1#976" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#741_2#977" = var"####idx#741_1#976":var"####step_1_h#745#978":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#741_1#976", var"####step_2_l#746#979"), var"####step_1_h#745#978")
                                                                                                        for var"####idx#741_3#980" = var"####idx#741_2#977":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#741_2#977", var"####step_1_l#744#981"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#741_3#980", 0), var"####ctrl_mask#750#982", var"####flag_mask#751#983")
                                                                                                                        var"####I#752_1#984" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_3#980", 0), 1)
                                                                                                                        var"####I#752_2#985" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_3#980", 0), var"####step_1_l#744#981"), 1)
                                                                                                                        var"####I#752_3#986" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_3#980", 0), var"####step_2_l#746#979"), 1)
                                                                                                                        var"####I#752_4#987" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#741_3#980", 0), var"####step_1_l#744#981"), var"####step_2_l#746#979"), 1)
                                                                                                                        var"####T#753_1#988" = Base.FastMath.mul_fast(var"####hoisted#585#989", var"####st#735#990"[var"####I#752_1#984"])
                                                                                                                        var"####T#753_2#991" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#992", var"####st#735#990"[var"####I#752_2#985"]), Base.FastMath.mul_fast(var"####hoisted#587#993", var"####st#735#990"[var"####I#752_3#986"]))
                                                                                                                        var"####T#753_3#994" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#995", var"####st#735#990"[var"####I#752_2#985"]), Base.FastMath.mul_fast(var"####hoisted#589#996", var"####st#735#990"[var"####I#752_3#986"]))
                                                                                                                        var"####T#753_4#997" = Base.FastMath.mul_fast(var"####hoisted#590#998", var"####st#735#990"[var"####I#752_4#987"])
                                                                                                                        var"####st#735#990"[var"####I#752_1#984"] = var"####T#753_1#988"
                                                                                                                        var"####st#735#990"[var"####I#752_2#985"] = var"####T#753_2#991"
                                                                                                                        var"####st#735#990"[var"####I#752_3#986"] = var"####T#753_3#994"
                                                                                                                        var"####st#735#990"[var"####I#752_4#987"] = var"####T#753_4#997"
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                $(Expr(:inbounds, :pop))
                                                                                var"#86#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#79###ITER_LENG##", Polyester.min(var"#79###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#81###LOOPOFFSET##", var"#80###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#745", var"##step_2_l#746", var"##step_1_l#744", var"##ctrl_mask#750", var"##flag_mask#751", var"##hoisted#585", var"##st#735", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#735"
                                end
                                if var"##nlocs_needed#740" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#739", var"##plain_locs#738"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    var"##m#743" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#739", var"##nlocs_needed#740"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:506 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#744", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#88#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#87#range" = (BQCESubroutine.bsubspace)(var"##nqubits#739", (1:var"##m#743"..., var"##plain_locs#738"[1], var"##plain_locs#738"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#88#threadsfor_fun"(var"#100#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#92#r" = var"#87#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#93#lenr" = Base.Threads.length(var"#92#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#100#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#94#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#95#len", var"#96#rem") = (var"#93#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#94#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#95#len", var"#96#rem") = Base.Threads.divrem(var"#93#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#95#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#94#tid" > var"#96#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#95#len", var"#96#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#97#f" = Base.Threads.firstindex(var"#92#r") + (var"#94#tid" - 1) * var"#95#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#98#l" = (var"#97#f" + var"#95#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#96#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#94#tid" <= var"#96#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#97#f" = var"#97#f" + (var"#94#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#98#l" = var"#98#l" + var"#94#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#97#f" = var"#97#f" + var"#96#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#98#l" = var"#98#l" + var"#96#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#99#i" = var"#97#f":var"#98#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#742" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#101#val" = var"#92#r"[var"#99#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#101#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#742", 0), var"##ctrl_mask#750", var"##flag_mask#751")
                                                                            var"##I#754_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", 0), 1)
                                                                            var"##I#754_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", 0), var"##step_1_l#744"), 1)
                                                                            var"##I#754_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", 0), var"##step_2_l#746"), 1)
                                                                            var"##I#754_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", 0), var"##step_1_l#744"), var"##step_2_l#746"), 1)
                                                                            var"##T#755_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#735"[var"##I#754_1"])
                                                                            var"##T#755_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#735"[var"##I#754_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#735"[var"##I#754_3"]))
                                                                            var"##T#755_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#735"[var"##I#754_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#735"[var"##I#754_3"]))
                                                                            var"##T#755_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#735"[var"##I#754_4"])
                                                                            var"##st#735"[var"##I#754_1"] = var"##T#755_1"
                                                                            var"##st#735"[var"##I#754_2"] = var"##T#755_2"
                                                                            var"##st#735"[var"##I#754_3"] = var"##T#755_3"
                                                                            var"##st#735"[var"##I#754_4"] = var"##T#755_4"
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:85 =#
                                                    if Base.Threads.threadid() != 1 || ccall(:jl_in_threaded_region, Base.Threads.Cint, ()) != 0
                                                        #= threadingconstructs.jl:86 =#
                                                        (Base.Threads.Base).invokelatest(var"#88#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#88#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#735"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#103#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#102#range" = (BQCESubroutine.bsubspace)(var"##nqubits#739", (1:var"##m#743"..., var"##plain_locs#738"[1], var"##plain_locs#738"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#103#threadsfor_fun"(var"#115#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#107#r" = var"#102#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#108#lenr" = Base.Threads.length(var"#107#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#115#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#109#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#110#len", var"#111#rem") = (var"#108#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#109#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#110#len", var"#111#rem") = Base.Threads.divrem(var"#108#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#110#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#109#tid" > var"#111#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#110#len", var"#111#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#112#f" = Base.Threads.firstindex(var"#107#r") + (var"#109#tid" - 1) * var"#110#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#113#l" = (var"#112#f" + var"#110#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#111#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#109#tid" <= var"#111#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#112#f" = var"#112#f" + (var"#109#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#113#l" = var"#113#l" + var"#109#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#112#f" = var"#112#f" + var"#111#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#113#l" = var"#113#l" + var"#111#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#114#i" = var"#112#f":var"#113#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#742" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#116#val" = var"#107#r"[var"#114#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#116#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#741_3" = var"##base#742":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##base#742", var"##step_1_l#744"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##ctrl_mask#750", var"##flag_mask#751")
                                                                        var"##I#756_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), 1)
                                                                        var"##I#756_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##step_1_l#744"), 1)
                                                                        var"##I#756_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##step_2_l#746"), 1)
                                                                        var"##I#756_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#741_3", 0), var"##step_1_l#744"), var"##step_2_l#746"), 1)
                                                                        var"##T#757_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#735"[var"##I#756_1"])
                                                                        var"##T#757_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#735"[var"##I#756_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#735"[var"##I#756_3"]))
                                                                        var"##T#757_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#735"[var"##I#756_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#735"[var"##I#756_3"]))
                                                                        var"##T#757_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#735"[var"##I#756_4"])
                                                                        var"##st#735"[var"##I#756_1"] = var"##T#757_1"
                                                                        var"##st#735"[var"##I#756_2"] = var"##T#757_2"
                                                                        var"##st#735"[var"##I#756_3"] = var"##T#757_3"
                                                                        var"##st#735"[var"##I#756_4"] = var"##T#757_4"
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
                                                (Base.Threads.Base).invokelatest(var"#103#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#103#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:507 =#
                                    return var"##st#735"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                    var"##m#743" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#739", var"##nlocs_needed#740"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#118#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#117#range" = (BQCESubroutine.bsubspace)(var"##nqubits#739", (1:var"##m#743"..., var"##plain_locs#738"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#118#threadsfor_fun"(var"#130#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#122#r" = var"#117#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#123#lenr" = Base.Threads.length(var"#122#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#130#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#124#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#125#len", var"#126#rem") = (var"#123#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#124#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#125#len", var"#126#rem") = Base.Threads.divrem(var"#123#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#125#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#124#tid" > var"#126#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#125#len", var"#126#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#127#f" = Base.Threads.firstindex(var"#122#r") + (var"#124#tid" - 1) * var"#125#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#128#l" = (var"#127#f" + var"#125#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#126#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#124#tid" <= var"#126#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#127#f" = var"#127#f" + (var"#124#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#128#l" = var"#128#l" + var"#124#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#127#f" = var"#127#f" + var"#126#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#128#l" = var"#128#l" + var"#126#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#129#i" = var"#127#f":var"#128#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#742" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#131#val" = var"#122#r"[var"#129#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#131#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:515 =#
                                                        for var"##idx#741_1" = 0:Base.FastMath.sub_fast(1 << var"##m#743", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:516 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#742", var"##idx#741_1"), var"##ctrl_mask#750", var"##flag_mask#751")
                                                                    var"##I#758_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", var"##idx#741_1"), 1)
                                                                    var"##I#758_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", var"##idx#741_1"), var"##step_1_l#744"), 1)
                                                                    var"##I#758_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", var"##idx#741_1"), var"##step_2_l#746"), 1)
                                                                    var"##I#758_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#742", var"##idx#741_1"), var"##step_1_l#744"), var"##step_2_l#746"), 1)
                                                                    var"##T#759_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#735"[var"##I#758_1"])
                                                                    var"##T#759_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#735"[var"##I#758_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#735"[var"##I#758_3"]))
                                                                    var"##T#759_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#735"[var"##I#758_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#735"[var"##I#758_3"]))
                                                                    var"##T#759_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#735"[var"##I#758_4"])
                                                                    var"##st#735"[var"##I#758_1"] = var"##T#759_1"
                                                                    var"##st#735"[var"##I#758_2"] = var"##T#759_2"
                                                                    var"##st#735"[var"##I#758_3"] = var"##T#759_3"
                                                                    var"##st#735"[var"##I#758_4"] = var"##T#759_4"
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
                                            (Base.Threads.Base).invokelatest(var"#118#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#118#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#735"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#68#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#735"
    end
    function BQCESubroutine.broutine!(var"##st#761"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#762"::YaoLocations.Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#762") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#761", Val{:PSWAP_test}(), var"##locs#762", θ)
                    return var"##st#761"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#762") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#761", Val{:PSWAP_test}(), var"##locs#762", θ)
                return var"##st#761"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#761"
    end
    function BQCESubroutine.basic_broutine!(var"##st#763"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#764"::YaoLocations.Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#765" = (YaoLocations.plain)(var"##locs#764")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#765"[1] > var"##plain_locs#765"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#764" = Locations((var"##plain_locs#765"[2], var"##plain_locs#765"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#767" = (YaoLocations.plain)(var"##locs#764")
                    var"##step_1_l#768" = 1 << (var"##plain_locs#767"[1] - 1)
                    var"##step_1_h#769" = 1 << var"##plain_locs#767"[1]
                    var"##step_2_l#770" = 1 << (var"##plain_locs#767"[2] - 1)
                    var"##step_2_h#771" = 1 << var"##plain_locs#767"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#132#val" = for var"##m#766_1" = 0:var"##step_2_h#771":Base.FastMath.sub_fast(size(var"##st#763", 2), var"##step_2_h#771"), var"##m#766_2" = var"##m#766_1":var"##step_1_h#769":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#766_1", var"##step_2_l#770"), var"##step_1_h#769"), var"##m#766_3" = var"##m#766_2":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#766_2", var"##step_1_l#768"), 1)
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                nothing
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                    var"##upperbound#779" = size(var"##st#763", 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                    var"##Mmax#777" = Base.FastMath.sub_fast(size(var"##st#763", 1), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                    for var"##idx2#775" = 0:var"##Mmax#777" >>> 3
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                        var"##idx1#774" = Base.FastMath.add_fast(var"##idx2#775" << 3, 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                        var"##mmax#778" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#774", 7), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                        if var"##mmax#778" ≤ var"##Mmax#777"
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                            begin
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 0), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 1), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 2), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 3), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 4), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 5), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 6), var"##I#772_4"] = var"##T#773_4"
                                                end
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_4"])
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[Base.FastMath.add_fast(var"##idx1#774", 7), var"##I#772_4"] = var"##T#773_4"
                                                end
                                            end
                                        else
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                            for var"##idx3#776" = var"##idx1#774":var"##upperbound#779"
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                begin
                                                    var"##I#772_1" = Base.FastMath.add_fast(var"##m#766_3", 1)
                                                    var"##I#772_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), 1)
                                                    var"##I#772_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_2_l#770"), 1)
                                                    var"##I#772_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#766_3", var"##step_1_l#768"), var"##step_2_l#770"), 1)
                                                    var"##T#773_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#763"[var"##idx3#776", var"##I#772_1"])
                                                    var"##T#773_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#763"[var"##idx3#776", var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#763"[var"##idx3#776", var"##I#772_3"]))
                                                    var"##T#773_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#763"[var"##idx3#776", var"##I#772_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#763"[var"##idx3#776", var"##I#772_3"]))
                                                    var"##T#773_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#763"[var"##idx3#776", var"##I#772_4"])
                                                    var"##st#763"[var"##idx3#776", var"##I#772_1"] = var"##T#773_1"
                                                    var"##st#763"[var"##idx3#776", var"##I#772_2"] = var"##T#773_2"
                                                    var"##st#763"[var"##idx3#776", var"##I#772_3"] = var"##T#773_3"
                                                    var"##st#763"[var"##idx3#776", var"##I#772_4"] = var"##T#773_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#132#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#763"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#782"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#783"::YaoLocations.Locations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#784" = (YaoLocations.plain)(var"##locs#783")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#784"[1] > var"##plain_locs#784"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#783" = Locations((var"##plain_locs#784"[2], var"##plain_locs#784"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#785" = (YaoLocations.plain)(var"##locs#783")
                    var"##nqubits#786" = (BQCESubroutine.log2i)(size(var"##st#782", 2))
                    var"##nlocs_needed#787" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#791" = 1 << (var"##plain_locs#785"[1] - 1)
                    var"##step_1_h#792" = 1 << var"##plain_locs#785"[1]
                    var"##step_2_l#793" = 1 << (var"##plain_locs#785"[2] - 1)
                    var"##step_2_h#794" = 1 << var"##plain_locs#785"[2]
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#133#val" = begin
                                if var"##nlocs_needed#787" ≤ Base.FastMath.sub_fast(var"##nqubits#786", var"##plain_locs#785"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#791", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#788_1" = 0:var"##step_2_h#794":Base.FastMath.sub_fast(size(var"##st#782", 2), var"##step_2_h#794")
                                                                for var"##idx#788_2" = var"##idx#788_1":var"##step_1_h#792":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#788_1", var"##step_2_l#793"), var"##step_1_h#792")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                            var"##upperbound#802" = size(var"##st#782", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                            var"##Mmax#800" = Base.FastMath.sub_fast(size(var"##st#782", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                            for var"##idx2#798" = 0:var"##Mmax#800" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                var"##idx1#797" = Base.FastMath.add_fast(var"##idx2#798" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                var"##mmax#801" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#797", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                if var"##mmax#801" ≤ var"##Mmax#800"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#795_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), 1)
                                                                                            var"##I#795_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), var"##step_1_l#791"), 1)
                                                                                            var"##I#795_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), var"##step_2_l#793"), 1)
                                                                                            var"##I#795_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                            var"##T#796_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_1"])
                                                                                            var"##T#796_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_3"]))
                                                                                            var"##T#796_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_3"]))
                                                                                            var"##T#796_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_4"])
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_1"] = var"##T#796_1"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_2"] = var"##T#796_2"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_3"] = var"##T#796_3"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#797", 0), var"##I#795_4"] = var"##T#796_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                    for var"##idx3#799" = var"##idx1#797":var"##upperbound#802"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                        begin
                                                                                            var"##I#795_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), 1)
                                                                                            var"##I#795_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), var"##step_1_l#791"), 1)
                                                                                            var"##I#795_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), var"##step_2_l#793"), 1)
                                                                                            var"##I#795_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_2", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                            var"##T#796_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[var"##idx3#799", var"##I#795_1"])
                                                                                            var"##T#796_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[var"##idx3#799", var"##I#795_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[var"##idx3#799", var"##I#795_3"]))
                                                                                            var"##T#796_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[var"##idx3#799", var"##I#795_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[var"##idx3#799", var"##I#795_3"]))
                                                                                            var"##T#796_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[var"##idx3#799", var"##I#795_4"])
                                                                                            var"##st#782"[var"##idx3#799", var"##I#795_1"] = var"##T#796_1"
                                                                                            var"##st#782"[var"##idx3#799", var"##I#795_2"] = var"##T#796_2"
                                                                                            var"##st#782"[var"##idx3#799", var"##I#795_3"] = var"##T#796_3"
                                                                                            var"##st#782"[var"##idx3#799", var"##I#795_4"] = var"##T#796_4"
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
                                                                (var"##inner##loop##", var"#134###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#794":Base.FastMath.sub_fast(size(var"##st#782", static(2)), var"##step_2_h#794"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#135###ITER_LENG##" = (ArrayInterface.static_length)(var"#134###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#136###LOOP_STEP##" = (ArrayInterface.static_step)(var"#134###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#137###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#134###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#792#1001", var"####step_2_l#793#1002", var"####st#782#1004", var"####step_1_l#791#1011", var"####hoisted#585#1015", var"####hoisted#586#1017", var"####hoisted#587#1018", var"####hoisted#588#1020", var"####hoisted#589#1021", var"####hoisted#590#1023"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#142#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#788_1#999" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#788_2#1000" = var"####idx#788_1#999":var"####step_1_h#792#1001":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#788_1#999", var"####step_2_l#793#1002"), var"####step_1_h#792#1001")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                                                                        var"####upperbound#802#1003" = size(var"####st#782#1004", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                                                                        var"####Mmax#800#1005" = Base.FastMath.sub_fast(size(var"####st#782#1004", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                                                                        for var"####idx2#798#1006" = 0:var"####Mmax#800#1005" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                                                            var"####idx1#797#1007" = Base.FastMath.add_fast(var"####idx2#798#1006" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                                                            var"####mmax#801#1008" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#797#1007", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                                                            if var"####mmax#801#1008" ≤ var"####Mmax#800#1005"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#795_1#1009" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), 1)
                                                                                                                                        var"####I#795_2#1010" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), var"####step_1_l#791#1011"), 1)
                                                                                                                                        var"####I#795_3#1012" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), var"####step_2_l#793#1002"), 1)
                                                                                                                                        var"####I#795_4#1013" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), var"####step_1_l#791#1011"), var"####step_2_l#793#1002"), 1)
                                                                                                                                        var"####T#796_1#1014" = Base.FastMath.mul_fast(var"####hoisted#585#1015", var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_1#1009"])
                                                                                                                                        var"####T#796_2#1016" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1017", var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_2#1010"]), Base.FastMath.mul_fast(var"####hoisted#587#1018", var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_3#1012"]))
                                                                                                                                        var"####T#796_3#1019" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1020", var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_2#1010"]), Base.FastMath.mul_fast(var"####hoisted#589#1021", var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_3#1012"]))
                                                                                                                                        var"####T#796_4#1022" = Base.FastMath.mul_fast(var"####hoisted#590#1023", var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_4#1013"])
                                                                                                                                        var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_1#1009"] = var"####T#796_1#1014"
                                                                                                                                        var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_2#1010"] = var"####T#796_2#1016"
                                                                                                                                        var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_3#1012"] = var"####T#796_3#1019"
                                                                                                                                        var"####st#782#1004"[Base.FastMath.add_fast(var"####idx1#797#1007", 0), var"####I#795_4#1013"] = var"####T#796_4#1022"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                                for var"####idx3#799#1024" = var"####idx1#797#1007":var"####upperbound#802#1003"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#795_1#1009" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), 1)
                                                                                                                                        var"####I#795_2#1010" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), var"####step_1_l#791#1011"), 1)
                                                                                                                                        var"####I#795_3#1012" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), var"####step_2_l#793#1002"), 1)
                                                                                                                                        var"####I#795_4#1013" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_2#1000", 0), var"####step_1_l#791#1011"), var"####step_2_l#793#1002"), 1)
                                                                                                                                        var"####T#796_1#1014" = Base.FastMath.mul_fast(var"####hoisted#585#1015", var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_1#1009"])
                                                                                                                                        var"####T#796_2#1016" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1017", var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_2#1010"]), Base.FastMath.mul_fast(var"####hoisted#587#1018", var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_3#1012"]))
                                                                                                                                        var"####T#796_3#1019" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1020", var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_2#1010"]), Base.FastMath.mul_fast(var"####hoisted#589#1021", var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_3#1012"]))
                                                                                                                                        var"####T#796_4#1022" = Base.FastMath.mul_fast(var"####hoisted#590#1023", var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_4#1013"])
                                                                                                                                        var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_1#1009"] = var"####T#796_1#1014"
                                                                                                                                        var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_2#1010"] = var"####T#796_2#1016"
                                                                                                                                        var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_3#1012"] = var"####T#796_3#1019"
                                                                                                                                        var"####st#782#1004"[var"####idx3#799#1024", var"####I#795_4#1013"] = var"####T#796_4#1022"
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
                                                                                        var"#142#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#135###ITER_LENG##", Polyester.min(var"#135###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#137###LOOPOFFSET##", var"#136###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#792", var"##step_2_l#793", var"##st#782", var"##step_1_l#791", var"##hoisted#585", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#782"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#788_1" = 0:var"##step_2_h#794":Base.FastMath.sub_fast(size(var"##st#782", 2), var"##step_2_h#794")
                                                        for var"##idx#788_2" = var"##idx#788_1":var"##step_1_h#792":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#788_1", var"##step_2_l#793"), var"##step_1_h#792")
                                                            for var"##idx#788_3" = var"##idx#788_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#788_2", var"##step_1_l#791"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                            var"##upperbound#810" = size(var"##st#782", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                            var"##Mmax#808" = Base.FastMath.sub_fast(size(var"##st#782", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                            for var"##idx2#806" = 0:var"##Mmax#808" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                var"##idx1#805" = Base.FastMath.add_fast(var"##idx2#806" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                var"##mmax#809" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#805", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                if var"##mmax#809" ≤ var"##Mmax#808"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#803_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), 1)
                                                                                            var"##I#803_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), 1)
                                                                                            var"##I#803_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_2_l#793"), 1)
                                                                                            var"##I#803_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                            var"##T#804_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_1"])
                                                                                            var"##T#804_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_3"]))
                                                                                            var"##T#804_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_3"]))
                                                                                            var"##T#804_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_4"])
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_1"] = var"##T#804_1"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_2"] = var"##T#804_2"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_3"] = var"##T#804_3"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#805", 0), var"##I#803_4"] = var"##T#804_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                    for var"##idx3#807" = var"##idx1#805":var"##upperbound#810"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                        begin
                                                                                            var"##I#803_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), 1)
                                                                                            var"##I#803_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), 1)
                                                                                            var"##I#803_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_2_l#793"), 1)
                                                                                            var"##I#803_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                            var"##T#804_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[var"##idx3#807", var"##I#803_1"])
                                                                                            var"##T#804_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[var"##idx3#807", var"##I#803_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[var"##idx3#807", var"##I#803_3"]))
                                                                                            var"##T#804_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[var"##idx3#807", var"##I#803_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[var"##idx3#807", var"##I#803_3"]))
                                                                                            var"##T#804_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[var"##idx3#807", var"##I#803_4"])
                                                                                            var"##st#782"[var"##idx3#807", var"##I#803_1"] = var"##T#804_1"
                                                                                            var"##st#782"[var"##idx3#807", var"##I#803_2"] = var"##T#804_2"
                                                                                            var"##st#782"[var"##idx3#807", var"##I#803_3"] = var"##T#804_3"
                                                                                            var"##st#782"[var"##idx3#807", var"##I#803_4"] = var"##T#804_4"
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
                                                        (var"##inner##loop##", var"#143###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#794":Base.FastMath.sub_fast(size(var"##st#782", static(2)), var"##step_2_h#794"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#144###ITER_LENG##" = (ArrayInterface.static_length)(var"#143###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#145###LOOP_STEP##" = (ArrayInterface.static_step)(var"#143###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#146###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#143###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#792#1027", var"####step_2_l#793#1028", var"####step_1_l#791#1030", var"####st#782#1032", var"####hoisted#585#1042", var"####hoisted#586#1044", var"####hoisted#587#1045", var"####hoisted#588#1047", var"####hoisted#589#1048", var"####hoisted#590#1050"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#151#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#788_1#1025" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#788_2#1026" = var"####idx#788_1#1025":var"####step_1_h#792#1027":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#788_1#1025", var"####step_2_l#793#1028"), var"####step_1_h#792#1027")
                                                                                                        for var"####idx#788_3#1029" = var"####idx#788_2#1026":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#788_2#1026", var"####step_1_l#791#1030"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    begin
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                                                                        var"####upperbound#810#1031" = size(var"####st#782#1032", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                                                                        var"####Mmax#808#1033" = Base.FastMath.sub_fast(size(var"####st#782#1032", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                                                                        for var"####idx2#806#1034" = 0:var"####Mmax#808#1033" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                                                            var"####idx1#805#1035" = Base.FastMath.add_fast(var"####idx2#806#1034" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                                                            var"####mmax#809#1036" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#805#1035", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                                                            if var"####mmax#809#1036" ≤ var"####Mmax#808#1033"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#803_1#1037" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), 1)
                                                                                                                                        var"####I#803_2#1038" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), var"####step_1_l#791#1030"), 1)
                                                                                                                                        var"####I#803_3#1039" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), var"####step_2_l#793#1028"), 1)
                                                                                                                                        var"####I#803_4#1040" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), var"####step_1_l#791#1030"), var"####step_2_l#793#1028"), 1)
                                                                                                                                        var"####T#804_1#1041" = Base.FastMath.mul_fast(var"####hoisted#585#1042", var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_1#1037"])
                                                                                                                                        var"####T#804_2#1043" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1044", var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_2#1038"]), Base.FastMath.mul_fast(var"####hoisted#587#1045", var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_3#1039"]))
                                                                                                                                        var"####T#804_3#1046" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1047", var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_2#1038"]), Base.FastMath.mul_fast(var"####hoisted#589#1048", var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_3#1039"]))
                                                                                                                                        var"####T#804_4#1049" = Base.FastMath.mul_fast(var"####hoisted#590#1050", var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_4#1040"])
                                                                                                                                        var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_1#1037"] = var"####T#804_1#1041"
                                                                                                                                        var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_2#1038"] = var"####T#804_2#1043"
                                                                                                                                        var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_3#1039"] = var"####T#804_3#1046"
                                                                                                                                        var"####st#782#1032"[Base.FastMath.add_fast(var"####idx1#805#1035", 0), var"####I#803_4#1040"] = var"####T#804_4#1049"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                                for var"####idx3#807#1051" = var"####idx1#805#1035":var"####upperbound#810#1031"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#803_1#1037" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), 1)
                                                                                                                                        var"####I#803_2#1038" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), var"####step_1_l#791#1030"), 1)
                                                                                                                                        var"####I#803_3#1039" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), var"####step_2_l#793#1028"), 1)
                                                                                                                                        var"####I#803_4#1040" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#788_3#1029", 0), var"####step_1_l#791#1030"), var"####step_2_l#793#1028"), 1)
                                                                                                                                        var"####T#804_1#1041" = Base.FastMath.mul_fast(var"####hoisted#585#1042", var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_1#1037"])
                                                                                                                                        var"####T#804_2#1043" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1044", var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_2#1038"]), Base.FastMath.mul_fast(var"####hoisted#587#1045", var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_3#1039"]))
                                                                                                                                        var"####T#804_3#1046" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1047", var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_2#1038"]), Base.FastMath.mul_fast(var"####hoisted#589#1048", var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_3#1039"]))
                                                                                                                                        var"####T#804_4#1049" = Base.FastMath.mul_fast(var"####hoisted#590#1050", var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_4#1040"])
                                                                                                                                        var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_1#1037"] = var"####T#804_1#1041"
                                                                                                                                        var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_2#1038"] = var"####T#804_2#1043"
                                                                                                                                        var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_3#1039"] = var"####T#804_3#1046"
                                                                                                                                        var"####st#782#1032"[var"####idx3#807#1051", var"####I#803_4#1040"] = var"####T#804_4#1049"
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
                                                                                var"#151#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#144###ITER_LENG##", Polyester.min(var"#144###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#146###LOOPOFFSET##", var"#145###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#792", var"##step_2_l#793", var"##step_1_l#791", var"##st#782", var"##hoisted#585", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#782"
                                end
                                if var"##nlocs_needed#787" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#786", var"##plain_locs#785"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    var"##m#790" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#786", var"##nlocs_needed#787"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:506 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#791", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#153#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#152#range" = (BQCESubroutine.bsubspace)(var"##nqubits#786", (1:var"##m#790"..., var"##plain_locs#785"[1], var"##plain_locs#785"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#153#threadsfor_fun"(var"#165#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#157#r" = var"#152#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#158#lenr" = Base.Threads.length(var"#157#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#165#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#159#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#160#len", var"#161#rem") = (var"#158#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#159#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#160#len", var"#161#rem") = Base.Threads.divrem(var"#158#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#160#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#159#tid" > var"#161#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#160#len", var"#161#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#162#f" = Base.Threads.firstindex(var"#157#r") + (var"#159#tid" - 1) * var"#160#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#163#l" = (var"#162#f" + var"#160#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#161#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#159#tid" <= var"#161#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#162#f" = var"#162#f" + (var"#159#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#163#l" = var"#163#l" + var"#159#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#162#f" = var"#162#f" + var"#161#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#163#l" = var"#163#l" + var"#161#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#164#i" = var"#162#f":var"#163#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#789" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#166#val" = var"#157#r"[var"#164#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#166#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        begin
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                            var"##upperbound#818" = size(var"##st#782", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                            var"##Mmax#816" = Base.FastMath.sub_fast(size(var"##st#782", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                            for var"##idx2#814" = 0:var"##Mmax#816" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                var"##idx1#813" = Base.FastMath.add_fast(var"##idx2#814" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                var"##mmax#817" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#813", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                if var"##mmax#817" ≤ var"##Mmax#816"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#811_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), 1)
                                                                                            var"##I#811_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), var"##step_1_l#791"), 1)
                                                                                            var"##I#811_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), var"##step_2_l#793"), 1)
                                                                                            var"##I#811_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                            var"##T#812_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_1"])
                                                                                            var"##T#812_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_3"]))
                                                                                            var"##T#812_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_3"]))
                                                                                            var"##T#812_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_4"])
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_1"] = var"##T#812_1"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_2"] = var"##T#812_2"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_3"] = var"##T#812_3"
                                                                                            var"##st#782"[Base.FastMath.add_fast(var"##idx1#813", 0), var"##I#811_4"] = var"##T#812_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                    for var"##idx3#815" = var"##idx1#813":var"##upperbound#818"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                        begin
                                                                                            var"##I#811_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), 1)
                                                                                            var"##I#811_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), var"##step_1_l#791"), 1)
                                                                                            var"##I#811_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), var"##step_2_l#793"), 1)
                                                                                            var"##I#811_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                            var"##T#812_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[var"##idx3#815", var"##I#811_1"])
                                                                                            var"##T#812_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[var"##idx3#815", var"##I#811_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[var"##idx3#815", var"##I#811_3"]))
                                                                                            var"##T#812_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[var"##idx3#815", var"##I#811_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[var"##idx3#815", var"##I#811_3"]))
                                                                                            var"##T#812_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[var"##idx3#815", var"##I#811_4"])
                                                                                            var"##st#782"[var"##idx3#815", var"##I#811_1"] = var"##T#812_1"
                                                                                            var"##st#782"[var"##idx3#815", var"##I#811_2"] = var"##T#812_2"
                                                                                            var"##st#782"[var"##idx3#815", var"##I#811_3"] = var"##T#812_3"
                                                                                            var"##st#782"[var"##idx3#815", var"##I#811_4"] = var"##T#812_4"
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
                                                        (Base.Threads.Base).invokelatest(var"#153#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#153#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#782"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#168#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#167#range" = (BQCESubroutine.bsubspace)(var"##nqubits#786", (1:var"##m#790"..., var"##plain_locs#785"[1], var"##plain_locs#785"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#168#threadsfor_fun"(var"#180#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#172#r" = var"#167#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#173#lenr" = Base.Threads.length(var"#172#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#180#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#174#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#175#len", var"#176#rem") = (var"#173#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#174#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#175#len", var"#176#rem") = Base.Threads.divrem(var"#173#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#175#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#174#tid" > var"#176#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#175#len", var"#176#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#177#f" = Base.Threads.firstindex(var"#172#r") + (var"#174#tid" - 1) * var"#175#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#178#l" = (var"#177#f" + var"#175#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#176#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#174#tid" <= var"#176#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#177#f" = var"#177#f" + (var"#174#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#178#l" = var"#178#l" + var"#174#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#177#f" = var"#177#f" + var"#176#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#178#l" = var"#178#l" + var"#176#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#179#i" = var"#177#f":var"#178#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#789" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#181#val" = var"#172#r"[var"#179#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#181#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#788_3" = var"##base#789":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##base#789", var"##step_1_l#791"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                        var"##upperbound#826" = size(var"##st#782", 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                        var"##Mmax#824" = Base.FastMath.sub_fast(size(var"##st#782", 1), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                        for var"##idx2#822" = 0:var"##Mmax#824" >>> 0
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                            var"##idx1#821" = Base.FastMath.add_fast(var"##idx2#822" << 0, 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                            var"##mmax#825" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#821", 0), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                            if var"##mmax#825" ≤ var"##Mmax#824"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                begin
                                                                                    begin
                                                                                        var"##I#819_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), 1)
                                                                                        var"##I#819_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), 1)
                                                                                        var"##I#819_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_2_l#793"), 1)
                                                                                        var"##I#819_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                        var"##T#820_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_1"])
                                                                                        var"##T#820_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_3"]))
                                                                                        var"##T#820_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_3"]))
                                                                                        var"##T#820_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_4"])
                                                                                        var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_1"] = var"##T#820_1"
                                                                                        var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_2"] = var"##T#820_2"
                                                                                        var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_3"] = var"##T#820_3"
                                                                                        var"##st#782"[Base.FastMath.add_fast(var"##idx1#821", 0), var"##I#819_4"] = var"##T#820_4"
                                                                                    end
                                                                                end
                                                                            else
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                for var"##idx3#823" = var"##idx1#821":var"##upperbound#826"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                    begin
                                                                                        var"##I#819_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), 1)
                                                                                        var"##I#819_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), 1)
                                                                                        var"##I#819_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_2_l#793"), 1)
                                                                                        var"##I#819_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#788_3", 0), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                        var"##T#820_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[var"##idx3#823", var"##I#819_1"])
                                                                                        var"##T#820_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[var"##idx3#823", var"##I#819_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[var"##idx3#823", var"##I#819_3"]))
                                                                                        var"##T#820_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[var"##idx3#823", var"##I#819_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[var"##idx3#823", var"##I#819_3"]))
                                                                                        var"##T#820_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[var"##idx3#823", var"##I#819_4"])
                                                                                        var"##st#782"[var"##idx3#823", var"##I#819_1"] = var"##T#820_1"
                                                                                        var"##st#782"[var"##idx3#823", var"##I#819_2"] = var"##T#820_2"
                                                                                        var"##st#782"[var"##idx3#823", var"##I#819_3"] = var"##T#820_3"
                                                                                        var"##st#782"[var"##idx3#823", var"##I#819_4"] = var"##T#820_4"
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
                                                (Base.Threads.Base).invokelatest(var"#168#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#168#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:507 =#
                                    return var"##st#782"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                    var"##m#790" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#786", var"##nlocs_needed#787"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#183#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#182#range" = (BQCESubroutine.bsubspace)(var"##nqubits#786", (1:var"##m#790"..., var"##plain_locs#785"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#183#threadsfor_fun"(var"#195#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#187#r" = var"#182#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#188#lenr" = Base.Threads.length(var"#187#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#195#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#189#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#190#len", var"#191#rem") = (var"#188#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#189#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#190#len", var"#191#rem") = Base.Threads.divrem(var"#188#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#190#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#189#tid" > var"#191#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#190#len", var"#191#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#192#f" = Base.Threads.firstindex(var"#187#r") + (var"#189#tid" - 1) * var"#190#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#193#l" = (var"#192#f" + var"#190#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#191#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#189#tid" <= var"#191#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#192#f" = var"#192#f" + (var"#189#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#193#l" = var"#193#l" + var"#189#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#192#f" = var"#192#f" + var"#191#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#193#l" = var"#193#l" + var"#191#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#194#i" = var"#192#f":var"#193#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#789" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#196#val" = var"#187#r"[var"#194#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#196#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:515 =#
                                                        for var"##idx#788_1" = 0:Base.FastMath.sub_fast(1 << var"##m#790", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:516 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                    var"##upperbound#834" = size(var"##st#782", 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                    var"##Mmax#832" = Base.FastMath.sub_fast(size(var"##st#782", 1), 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                    for var"##idx2#830" = 0:var"##Mmax#832" >>> 0
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                        var"##idx1#829" = Base.FastMath.add_fast(var"##idx2#830" << 0, 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                        var"##mmax#833" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#829", 0), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                        if var"##mmax#833" ≤ var"##Mmax#832"
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                            begin
                                                                                begin
                                                                                    var"##I#827_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), 1)
                                                                                    var"##I#827_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), var"##step_1_l#791"), 1)
                                                                                    var"##I#827_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), var"##step_2_l#793"), 1)
                                                                                    var"##I#827_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                    var"##T#828_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_1"])
                                                                                    var"##T#828_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_3"]))
                                                                                    var"##T#828_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_3"]))
                                                                                    var"##T#828_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_4"])
                                                                                    var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_1"] = var"##T#828_1"
                                                                                    var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_2"] = var"##T#828_2"
                                                                                    var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_3"] = var"##T#828_3"
                                                                                    var"##st#782"[Base.FastMath.add_fast(var"##idx1#829", 0), var"##I#827_4"] = var"##T#828_4"
                                                                                end
                                                                            end
                                                                        else
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                            for var"##idx3#831" = var"##idx1#829":var"##upperbound#834"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                begin
                                                                                    var"##I#827_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), 1)
                                                                                    var"##I#827_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), var"##step_1_l#791"), 1)
                                                                                    var"##I#827_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), var"##step_2_l#793"), 1)
                                                                                    var"##I#827_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#789", var"##idx#788_1"), var"##step_1_l#791"), var"##step_2_l#793"), 1)
                                                                                    var"##T#828_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#782"[var"##idx3#831", var"##I#827_1"])
                                                                                    var"##T#828_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#782"[var"##idx3#831", var"##I#827_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#782"[var"##idx3#831", var"##I#827_3"]))
                                                                                    var"##T#828_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#782"[var"##idx3#831", var"##I#827_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#782"[var"##idx3#831", var"##I#827_3"]))
                                                                                    var"##T#828_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#782"[var"##idx3#831", var"##I#827_4"])
                                                                                    var"##st#782"[var"##idx3#831", var"##I#827_1"] = var"##T#828_1"
                                                                                    var"##st#782"[var"##idx3#831", var"##I#827_2"] = var"##T#828_2"
                                                                                    var"##st#782"[var"##idx3#831", var"##I#827_3"] = var"##T#828_3"
                                                                                    var"##st#782"[var"##idx3#831", var"##I#827_4"] = var"##T#828_4"
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
                                            (Base.Threads.Base).invokelatest(var"#183#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#183#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#782"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#133#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#782"
    end
    function BQCESubroutine.broutine!(var"##st#835"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#836"::YaoLocations.Locations, var"##ctrl#760"::YaoLocations.CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:249 =#
            if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:250 =#
                begin
                    if length(var"##locs#836") == 2
                        nothing
                    else
                        Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                    end
                    BQCESubroutine.threaded_basic_broutine!(var"##st#835", Val{:PSWAP_test}(), var"##locs#836", var"##ctrl#760", θ)
                    return var"##st#835"
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:252 =#
            begin
                if length(var"##locs#836") == 2
                    nothing
                else
                    Base.throw(Base.AssertionError("number of locations mismatch operator size"))
                end
                BQCESubroutine.basic_broutine!(var"##st#835", Val{:PSWAP_test}(), var"##locs#836", var"##ctrl#760", θ)
                return var"##st#835"
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#835"
    end
    function BQCESubroutine.basic_broutine!(var"##st#837"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#838"::YaoLocations.Locations, var"##ctrl#760"::YaoLocations.CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#839" = (YaoLocations.plain)(var"##locs#838")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#839"[1] > var"##plain_locs#839"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#838" = Locations((var"##plain_locs#839"[2], var"##plain_locs#839"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#841" = (YaoLocations.plain)(var"##locs#838")
                    var"##step_1_l#842" = 1 << (var"##plain_locs#841"[1] - 1)
                    var"##step_1_h#843" = 1 << var"##plain_locs#841"[1]
                    var"##step_2_l#844" = 1 << (var"##plain_locs#841"[2] - 1)
                    var"##step_2_h#845" = 1 << var"##plain_locs#841"[2]
                    var"##ctrl_mask#848" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#760"))
                    var"##flag_mask#849" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#760")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#197#val" = for var"##m#840_1" = 0:var"##step_2_h#845":Base.FastMath.sub_fast(size(var"##st#837", 2), var"##step_2_h#845"), var"##m#840_2" = var"##m#840_1":var"##step_1_h#843":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#840_1", var"##step_2_l#844"), var"##step_1_h#843"), var"##m#840_3" = var"##m#840_2":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##m#840_2", var"##step_1_l#842"), 1)
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                nothing
                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                if (BQCESubroutine.ismatch)(var"##m#840_3", var"##ctrl_mask#848", var"##flag_mask#849")
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                    var"##upperbound#855" = size(var"##st#837", 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                    var"##Mmax#853" = Base.FastMath.sub_fast(size(var"##st#837", 1), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                    for var"##idx2#851" = 0:var"##Mmax#853" >>> 3
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                        var"##idx1#850" = Base.FastMath.add_fast(var"##idx2#851" << 3, 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                        var"##mmax#854" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#850", 7), 1)
                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                        if var"##mmax#854" ≤ var"##Mmax#853"
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                            begin
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 0), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 1), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 2), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 3), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 4), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 5), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 6), var"##I#846_4"] = var"##T#847_4"
                                                end
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_4"])
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[Base.FastMath.add_fast(var"##idx1#850", 7), var"##I#846_4"] = var"##T#847_4"
                                                end
                                            end
                                        else
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                            for var"##idx3#852" = var"##idx1#850":var"##upperbound#855"
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                begin
                                                    var"##I#846_1" = Base.FastMath.add_fast(var"##m#840_3", 1)
                                                    var"##I#846_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), 1)
                                                    var"##I#846_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_2_l#844"), 1)
                                                    var"##I#846_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##m#840_3", var"##step_1_l#842"), var"##step_2_l#844"), 1)
                                                    var"##T#847_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#837"[var"##idx3#852", var"##I#846_1"])
                                                    var"##T#847_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#837"[var"##idx3#852", var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#837"[var"##idx3#852", var"##I#846_3"]))
                                                    var"##T#847_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#837"[var"##idx3#852", var"##I#846_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#837"[var"##idx3#852", var"##I#846_3"]))
                                                    var"##T#847_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#837"[var"##idx3#852", var"##I#846_4"])
                                                    var"##st#837"[var"##idx3#852", var"##I#846_1"] = var"##T#847_1"
                                                    var"##st#837"[var"##idx3#852", var"##I#846_2"] = var"##T#847_2"
                                                    var"##st#837"[var"##idx3#852", var"##I#846_3"] = var"##T#847_3"
                                                    var"##st#837"[var"##idx3#852", var"##I#846_4"] = var"##T#847_4"
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                    $(Expr(:inbounds, :pop))
                    var"#197#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#837"
    end
    nothing
    function BQCESubroutine.threaded_basic_broutine!(var"##st#858"::AbstractMatrix{T} where T, ::Val{:PSWAP_test}, var"##locs#859"::YaoLocations.Locations, var"##ctrl#760"::YaoLocations.CtrlLocations, θ)
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:162 =#
        begin
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:260 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:703 =#
                var"##plain_locs#860" = (YaoLocations.plain)(var"##locs#859")
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:704 =#
                if var"##plain_locs#860"[1] > var"##plain_locs#860"[2]
                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:705 =#
                    var"##locs#859" = Locations((var"##plain_locs#860"[2], var"##plain_locs#860"[1]))
                end
            end
            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:261 =#
            begin
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:298 =#
                begin
                    var"##plain_locs#861" = (YaoLocations.plain)(var"##locs#859")
                    var"##nqubits#862" = (BQCESubroutine.log2i)(size(var"##st#858", 2))
                    var"##nlocs_needed#863" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                    var"##step_1_l#867" = 1 << (var"##plain_locs#861"[1] - 1)
                    var"##step_1_h#868" = 1 << var"##plain_locs#861"[1]
                    var"##step_2_l#869" = 1 << (var"##plain_locs#861"[2] - 1)
                    var"##step_2_h#870" = 1 << var"##plain_locs#861"[2]
                    var"##ctrl_mask#873" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#760"))
                    var"##flag_mask#874" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#760")
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:299 =#
                begin
                    var"##hoisted#585" = -im * sin(θ / 2) + cos(θ / 2)
                    var"##hoisted#586" = cos(θ / 2)
                    var"##hoisted#587" = -im * sin(θ / 2)
                    var"##hoisted#588" = -im * sin(θ / 2)
                    var"##hoisted#589" = cos(θ / 2)
                    var"##hoisted#590" = -im * sin(θ / 2) + cos(θ / 2)
                end
                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:300 =#
                begin
                    $(Expr(:inbounds, true))
                    local var"#198#val" = begin
                                if var"##nlocs_needed#863" ≤ Base.FastMath.sub_fast(var"##nqubits#862", var"##plain_locs#861"[2])
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:479 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#867", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                                    if (CPUSummary.num_threads)() == 1
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                        let
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                            for var"##idx#864_1" = 0:var"##step_2_h#870":Base.FastMath.sub_fast(size(var"##st#858", 2), var"##step_2_h#870")
                                                                for var"##idx#864_2" = var"##idx#864_1":var"##step_1_h#868":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#864_1", var"##step_2_l#869"), var"##step_1_h#868")
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##ctrl_mask#873", var"##flag_mask#874")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                            var"##upperbound#880" = size(var"##st#858", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                            var"##Mmax#878" = Base.FastMath.sub_fast(size(var"##st#858", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                            for var"##idx2#876" = 0:var"##Mmax#878" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                var"##idx1#875" = Base.FastMath.add_fast(var"##idx2#876" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                var"##mmax#879" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#875", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                if var"##mmax#879" ≤ var"##Mmax#878"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#871_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), 1)
                                                                                            var"##I#871_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##step_1_l#867"), 1)
                                                                                            var"##I#871_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##step_2_l#869"), 1)
                                                                                            var"##I#871_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                            var"##T#872_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_1"])
                                                                                            var"##T#872_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_3"]))
                                                                                            var"##T#872_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_3"]))
                                                                                            var"##T#872_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_4"])
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_1"] = var"##T#872_1"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_2"] = var"##T#872_2"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_3"] = var"##T#872_3"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#875", 0), var"##I#871_4"] = var"##T#872_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                    for var"##idx3#877" = var"##idx1#875":var"##upperbound#880"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                        begin
                                                                                            var"##I#871_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), 1)
                                                                                            var"##I#871_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##step_1_l#867"), 1)
                                                                                            var"##I#871_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##step_2_l#869"), 1)
                                                                                            var"##I#871_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_2", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                            var"##T#872_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[var"##idx3#877", var"##I#871_1"])
                                                                                            var"##T#872_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[var"##idx3#877", var"##I#871_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[var"##idx3#877", var"##I#871_3"]))
                                                                                            var"##T#872_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[var"##idx3#877", var"##I#871_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[var"##idx3#877", var"##I#871_3"]))
                                                                                            var"##T#872_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[var"##idx3#877", var"##I#871_4"])
                                                                                            var"##st#858"[var"##idx3#877", var"##I#871_1"] = var"##T#872_1"
                                                                                            var"##st#858"[var"##idx3#877", var"##I#871_2"] = var"##T#872_2"
                                                                                            var"##st#858"[var"##idx3#877", var"##I#871_3"] = var"##T#872_3"
                                                                                            var"##st#858"[var"##idx3#877", var"##I#871_4"] = var"##T#872_4"
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
                                                                (var"##inner##loop##", var"#199###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#870":Base.FastMath.sub_fast(size(var"##st#858", static(2)), var"##step_2_h#870"))
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                                var"#200###ITER_LENG##" = (ArrayInterface.static_length)(var"#199###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                                var"#201###LOOP_STEP##" = (ArrayInterface.static_step)(var"#199###LOOP##")
                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                                var"#202###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#199###LOOP##")
                                                                begin
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                                    var"##closure##" = let
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#868#1054", var"####step_2_l#869#1055", var"####ctrl_mask#873#1056", var"####flag_mask#874#1057", var"####st#858#1059", var"####step_1_l#867#1066", var"####hoisted#585#1070", var"####hoisted#586#1072", var"####hoisted#587#1073", var"####hoisted#588#1075", var"####hoisted#589#1076", var"####hoisted#590#1078"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                                    $(Expr(:meta, :inline))
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                                    var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                                    var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                                    begin
                                                                                        $(Expr(:inbounds, true))
                                                                                        local var"#207#val" = begin
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                                    begin
                                                                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                        for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                            var"####idx#864_1#1052" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                            for var"####idx#864_2#1053" = var"####idx#864_1#1052":var"####step_1_h#868#1054":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#864_1#1052", var"####step_2_l#869#1055"), var"####step_1_h#868#1054")
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####ctrl_mask#873#1056", var"####flag_mask#874#1057")
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                                                                        var"####upperbound#880#1058" = size(var"####st#858#1059", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                                                                        var"####Mmax#878#1060" = Base.FastMath.sub_fast(size(var"####st#858#1059", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                                                                        for var"####idx2#876#1061" = 0:var"####Mmax#878#1060" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                                                            var"####idx1#875#1062" = Base.FastMath.add_fast(var"####idx2#876#1061" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                                                            var"####mmax#879#1063" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#875#1062", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                                                            if var"####mmax#879#1063" ≤ var"####Mmax#878#1060"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#871_1#1064" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), 1)
                                                                                                                                        var"####I#871_2#1065" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####step_1_l#867#1066"), 1)
                                                                                                                                        var"####I#871_3#1067" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####step_2_l#869#1055"), 1)
                                                                                                                                        var"####I#871_4#1068" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####step_1_l#867#1066"), var"####step_2_l#869#1055"), 1)
                                                                                                                                        var"####T#872_1#1069" = Base.FastMath.mul_fast(var"####hoisted#585#1070", var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_1#1064"])
                                                                                                                                        var"####T#872_2#1071" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1072", var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_2#1065"]), Base.FastMath.mul_fast(var"####hoisted#587#1073", var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_3#1067"]))
                                                                                                                                        var"####T#872_3#1074" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1075", var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_2#1065"]), Base.FastMath.mul_fast(var"####hoisted#589#1076", var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_3#1067"]))
                                                                                                                                        var"####T#872_4#1077" = Base.FastMath.mul_fast(var"####hoisted#590#1078", var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_4#1068"])
                                                                                                                                        var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_1#1064"] = var"####T#872_1#1069"
                                                                                                                                        var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_2#1065"] = var"####T#872_2#1071"
                                                                                                                                        var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_3#1067"] = var"####T#872_3#1074"
                                                                                                                                        var"####st#858#1059"[Base.FastMath.add_fast(var"####idx1#875#1062", 0), var"####I#871_4#1068"] = var"####T#872_4#1077"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                                for var"####idx3#877#1079" = var"####idx1#875#1062":var"####upperbound#880#1058"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#871_1#1064" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), 1)
                                                                                                                                        var"####I#871_2#1065" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####step_1_l#867#1066"), 1)
                                                                                                                                        var"####I#871_3#1067" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####step_2_l#869#1055"), 1)
                                                                                                                                        var"####I#871_4#1068" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_2#1053", 0), var"####step_1_l#867#1066"), var"####step_2_l#869#1055"), 1)
                                                                                                                                        var"####T#872_1#1069" = Base.FastMath.mul_fast(var"####hoisted#585#1070", var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_1#1064"])
                                                                                                                                        var"####T#872_2#1071" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1072", var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_2#1065"]), Base.FastMath.mul_fast(var"####hoisted#587#1073", var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_3#1067"]))
                                                                                                                                        var"####T#872_3#1074" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1075", var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_2#1065"]), Base.FastMath.mul_fast(var"####hoisted#589#1076", var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_3#1067"]))
                                                                                                                                        var"####T#872_4#1077" = Base.FastMath.mul_fast(var"####hoisted#590#1078", var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_4#1068"])
                                                                                                                                        var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_1#1064"] = var"####T#872_1#1069"
                                                                                                                                        var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_2#1065"] = var"####T#872_2#1071"
                                                                                                                                        var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_3#1067"] = var"####T#872_3#1074"
                                                                                                                                        var"####st#858#1059"[var"####idx3#877#1079", var"####I#871_4#1068"] = var"####T#872_4#1077"
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
                                                                                        var"#207#val"
                                                                                    end
                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                                    nothing
                                                                                end
                                                                        end
                                                                end
                                                                (Polyester.batch)(var"##closure##", (var"#200###ITER_LENG##", Polyester.min(var"#200###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#202###LOOPOFFSET##", var"#201###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#868", var"##step_2_l#869", var"##ctrl_mask#873", var"##flag_mask#874", var"##st#858", var"##step_1_l#867", var"##hoisted#585", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                            end
                                                        end
                                                    end
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#858"
                                            end
                                        end
                                        begin
                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:306 =#
                                            if (CPUSummary.num_threads)() == 1
                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:307 =#
                                                let
                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:308 =#
                                                    for var"##idx#864_1" = 0:var"##step_2_h#870":Base.FastMath.sub_fast(size(var"##st#858", 2), var"##step_2_h#870")
                                                        for var"##idx#864_2" = var"##idx#864_1":var"##step_1_h#868":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#864_1", var"##step_2_l#869"), var"##step_1_h#868")
                                                            for var"##idx#864_3" = var"##idx#864_2":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx#864_2", var"##step_1_l#867"), 1)
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##ctrl_mask#873", var"##flag_mask#874")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                            var"##upperbound#888" = size(var"##st#858", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                            var"##Mmax#886" = Base.FastMath.sub_fast(size(var"##st#858", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                            for var"##idx2#884" = 0:var"##Mmax#886" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                var"##idx1#883" = Base.FastMath.add_fast(var"##idx2#884" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                var"##mmax#887" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#883", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                if var"##mmax#887" ≤ var"##Mmax#886"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#881_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), 1)
                                                                                            var"##I#881_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), 1)
                                                                                            var"##I#881_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_2_l#869"), 1)
                                                                                            var"##I#881_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                            var"##T#882_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_1"])
                                                                                            var"##T#882_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_3"]))
                                                                                            var"##T#882_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_3"]))
                                                                                            var"##T#882_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_4"])
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_1"] = var"##T#882_1"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_2"] = var"##T#882_2"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_3"] = var"##T#882_3"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#883", 0), var"##I#881_4"] = var"##T#882_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                    for var"##idx3#885" = var"##idx1#883":var"##upperbound#888"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                        begin
                                                                                            var"##I#881_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), 1)
                                                                                            var"##I#881_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), 1)
                                                                                            var"##I#881_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_2_l#869"), 1)
                                                                                            var"##I#881_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                            var"##T#882_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[var"##idx3#885", var"##I#881_1"])
                                                                                            var"##T#882_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[var"##idx3#885", var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[var"##idx3#885", var"##I#881_3"]))
                                                                                            var"##T#882_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[var"##idx3#885", var"##I#881_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[var"##idx3#885", var"##I#881_3"]))
                                                                                            var"##T#882_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[var"##idx3#885", var"##I#881_4"])
                                                                                            var"##st#858"[var"##idx3#885", var"##I#881_1"] = var"##T#882_1"
                                                                                            var"##st#858"[var"##idx3#885", var"##I#881_2"] = var"##T#882_2"
                                                                                            var"##st#858"[var"##idx3#885", var"##I#881_3"] = var"##T#882_3"
                                                                                            var"##st#858"[var"##idx3#885", var"##I#881_4"] = var"##T#882_4"
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
                                                        (var"##inner##loop##", var"#208###LOOP##", var"##split##recombined##") = (Polyester.splitloop)(static(0):var"##step_2_h#870":Base.FastMath.sub_fast(size(var"##st#858", static(2)), var"##step_2_h#870"))
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:261 =#
                                                        var"#209###ITER_LENG##" = (ArrayInterface.static_length)(var"#208###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:262 =#
                                                        var"#210###LOOP_STEP##" = (ArrayInterface.static_step)(var"#208###LOOP##")
                                                        #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:263 =#
                                                        var"#211###LOOPOFFSET##" = (ArrayInterface.static_first)(var"#208###LOOP##")
                                                        begin
                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:287 =#
                                                            var"##closure##" = let
                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                    ((var"##LOOPOFFSET##", var"##LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"####step_1_h#868#1082", var"####step_2_l#869#1083", var"####step_1_l#867#1085", var"####ctrl_mask#873#1086", var"####flag_mask#874#1087", var"####st#858#1089", var"####hoisted#585#1099", var"####hoisted#586#1101", var"####hoisted#587#1102", var"####hoisted#588#1104", var"####hoisted#589#1105", var"####hoisted#590#1107"), var"##SUBSTART##"::Int, var"##SUBSTOP##"::Int)->begin
                                                                            $(Expr(:meta, :inline))
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:288 =#
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:289 =#
                                                                            var"##LOOPSTART##" = (var"##SUBSTART##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:290 =#
                                                                            var"##LOOP_STOP##" = (var"##SUBSTOP##" * var"##LOOP_STEP##" + var"##LOOPOFFSET##") - var"##LOOP_STEP##"
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:291 =#
                                                                            begin
                                                                                $(Expr(:inbounds, true))
                                                                                local var"#216#val" = begin
                                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:292 =#
                                                                                            begin
                                                                                                #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:221 =#
                                                                                                for var"##outer##" = var"##LOOPSTART##":var"##LOOP_STEP##":var"##LOOP_STOP##", var"##inner##" = var"##inner##loop##"
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:222 =#
                                                                                                    var"####idx#864_1#1080" = (Polyester.combine)(var"##split##recombined##", var"##inner##", var"##outer##")
                                                                                                    #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:223 =#
                                                                                                    for var"####idx#864_2#1081" = var"####idx#864_1#1080":var"####step_1_h#868#1082":Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#864_1#1080", var"####step_2_l#869#1083"), var"####step_1_h#868#1082")
                                                                                                        for var"####idx#864_3#1084" = var"####idx#864_2#1081":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx#864_2#1081", var"####step_1_l#867#1085"), 1)
                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                                                                            begin
                                                                                                                begin
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                                                                    nothing
                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####ctrl_mask#873#1086", var"####flag_mask#874#1087")
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                                                                        var"####upperbound#888#1088" = size(var"####st#858#1089", 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                                                                        var"####Mmax#886#1090" = Base.FastMath.sub_fast(size(var"####st#858#1089", 1), 1)
                                                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                                                                        for var"####idx2#884#1091" = 0:var"####Mmax#886#1090" >>> 0
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                                                            var"####idx1#883#1092" = Base.FastMath.add_fast(var"####idx2#884#1091" << 0, 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                                                            var"####mmax#887#1093" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"####idx1#883#1092", 0), 1)
                                                                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                                                            if var"####mmax#887#1093" ≤ var"####Mmax#886#1090"
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                                                                begin
                                                                                                                                    begin
                                                                                                                                        var"####I#881_1#1094" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), 1)
                                                                                                                                        var"####I#881_2#1095" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####step_1_l#867#1085"), 1)
                                                                                                                                        var"####I#881_3#1096" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####step_2_l#869#1083"), 1)
                                                                                                                                        var"####I#881_4#1097" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####step_1_l#867#1085"), var"####step_2_l#869#1083"), 1)
                                                                                                                                        var"####T#882_1#1098" = Base.FastMath.mul_fast(var"####hoisted#585#1099", var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_1#1094"])
                                                                                                                                        var"####T#882_2#1100" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1101", var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_2#1095"]), Base.FastMath.mul_fast(var"####hoisted#587#1102", var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_3#1096"]))
                                                                                                                                        var"####T#882_3#1103" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1104", var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_2#1095"]), Base.FastMath.mul_fast(var"####hoisted#589#1105", var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_3#1096"]))
                                                                                                                                        var"####T#882_4#1106" = Base.FastMath.mul_fast(var"####hoisted#590#1107", var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_4#1097"])
                                                                                                                                        var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_1#1094"] = var"####T#882_1#1098"
                                                                                                                                        var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_2#1095"] = var"####T#882_2#1100"
                                                                                                                                        var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_3#1096"] = var"####T#882_3#1103"
                                                                                                                                        var"####st#858#1089"[Base.FastMath.add_fast(var"####idx1#883#1092", 0), var"####I#881_4#1097"] = var"####T#882_4#1106"
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            else
                                                                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                                                                for var"####idx3#885#1108" = var"####idx1#883#1092":var"####upperbound#888#1088"
                                                                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                                                                    begin
                                                                                                                                        var"####I#881_1#1094" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), 1)
                                                                                                                                        var"####I#881_2#1095" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####step_1_l#867#1085"), 1)
                                                                                                                                        var"####I#881_3#1096" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####step_2_l#869#1083"), 1)
                                                                                                                                        var"####I#881_4#1097" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"####idx#864_3#1084", 0), var"####step_1_l#867#1085"), var"####step_2_l#869#1083"), 1)
                                                                                                                                        var"####T#882_1#1098" = Base.FastMath.mul_fast(var"####hoisted#585#1099", var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_1#1094"])
                                                                                                                                        var"####T#882_2#1100" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#586#1101", var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_2#1095"]), Base.FastMath.mul_fast(var"####hoisted#587#1102", var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_3#1096"]))
                                                                                                                                        var"####T#882_3#1103" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"####hoisted#588#1104", var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_2#1095"]), Base.FastMath.mul_fast(var"####hoisted#589#1105", var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_3#1096"]))
                                                                                                                                        var"####T#882_4#1106" = Base.FastMath.mul_fast(var"####hoisted#590#1107", var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_4#1097"])
                                                                                                                                        var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_1#1094"] = var"####T#882_1#1098"
                                                                                                                                        var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_2#1095"] = var"####T#882_2#1100"
                                                                                                                                        var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_3#1096"] = var"####T#882_3#1103"
                                                                                                                                        var"####st#858#1089"[var"####idx3#885#1108", var"####I#881_4#1097"] = var"####T#882_4#1106"
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
                                                                                var"#216#val"
                                                                            end
                                                                            #= C:\Users\XX\.julia\packages\Polyester\7cr0U\src\closure.jl:294 =#
                                                                            nothing
                                                                        end
                                                                end
                                                        end
                                                        (Polyester.batch)(var"##closure##", (var"#209###ITER_LENG##", Polyester.min(var"#209###ITER_LENG##", (min)((CPUSummary.num_threads)(), (CPUSummary.num_cores)()))), var"#211###LOOPOFFSET##", var"#210###LOOP_STEP##", var"##inner##loop##", var"##split##recombined##", var"##step_1_h#868", var"##step_2_l#869", var"##step_1_l#867", var"##ctrl_mask#873", var"##flag_mask#874", var"##st#858", var"##hoisted#585", var"##hoisted#586", var"##hoisted#587", var"##hoisted#588", var"##hoisted#589", var"##hoisted#590")
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:480 =#
                                    return var"##st#858"
                                end
                                if var"##nlocs_needed#863" ≤ Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#862", var"##plain_locs#861"[1]), 1)
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:505 =#
                                    var"##m#866" = Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#862", var"##nlocs_needed#863"), Base.FastMath.add_fast(1, 1))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:506 =#
                                    begin
                                        begin
                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:434 =#
                                            if Base.FastMath.eq_fast(var"##step_1_l#867", 1)
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:435 =#
                                                begin
                                                    #= threadingconstructs.jl:45 =#
                                                    local var"#218#threadsfor_fun"
                                                    #= threadingconstructs.jl:46 =#
                                                    let var"#217#range" = (BQCESubroutine.bsubspace)(var"##nqubits#862", (1:var"##m#866"..., var"##plain_locs#861"[1], var"##plain_locs#861"[2]))
                                                        #= threadingconstructs.jl:47 =#
                                                        function var"#218#threadsfor_fun"(var"#230#onethread" = false)
                                                            #= threadingconstructs.jl:47 =#
                                                            #= threadingconstructs.jl:48 =#
                                                            var"#222#r" = var"#217#range"
                                                            #= threadingconstructs.jl:49 =#
                                                            var"#223#lenr" = Base.Threads.length(var"#222#r")
                                                            #= threadingconstructs.jl:51 =#
                                                            if var"#230#onethread"
                                                                #= threadingconstructs.jl:52 =#
                                                                var"#224#tid" = 1
                                                                #= threadingconstructs.jl:53 =#
                                                                (var"#225#len", var"#226#rem") = (var"#223#lenr", 0)
                                                            else
                                                                #= threadingconstructs.jl:55 =#
                                                                var"#224#tid" = Base.Threads.threadid()
                                                                #= threadingconstructs.jl:56 =#
                                                                (var"#225#len", var"#226#rem") = Base.Threads.divrem(var"#223#lenr", Base.Threads.nthreads())
                                                            end
                                                            #= threadingconstructs.jl:59 =#
                                                            if var"#225#len" == 0
                                                                #= threadingconstructs.jl:60 =#
                                                                if var"#224#tid" > var"#226#rem"
                                                                    #= threadingconstructs.jl:61 =#
                                                                    return
                                                                end
                                                                #= threadingconstructs.jl:63 =#
                                                                (var"#225#len", var"#226#rem") = (1, 0)
                                                            end
                                                            #= threadingconstructs.jl:66 =#
                                                            var"#227#f" = Base.Threads.firstindex(var"#222#r") + (var"#224#tid" - 1) * var"#225#len"
                                                            #= threadingconstructs.jl:67 =#
                                                            var"#228#l" = (var"#227#f" + var"#225#len") - 1
                                                            #= threadingconstructs.jl:69 =#
                                                            if var"#226#rem" > 0
                                                                #= threadingconstructs.jl:70 =#
                                                                if var"#224#tid" <= var"#226#rem"
                                                                    #= threadingconstructs.jl:71 =#
                                                                    var"#227#f" = var"#227#f" + (var"#224#tid" - 1)
                                                                    #= threadingconstructs.jl:72 =#
                                                                    var"#228#l" = var"#228#l" + var"#224#tid"
                                                                else
                                                                    #= threadingconstructs.jl:74 =#
                                                                    var"#227#f" = var"#227#f" + var"#226#rem"
                                                                    #= threadingconstructs.jl:75 =#
                                                                    var"#228#l" = var"#228#l" + var"#226#rem"
                                                                end
                                                            end
                                                            #= threadingconstructs.jl:79 =#
                                                            for var"#229#i" = var"#227#f":var"#228#l"
                                                                #= threadingconstructs.jl:80 =#
                                                                local var"##base#865" = begin
                                                                            $(Expr(:inbounds, true))
                                                                            local var"#231#val" = var"#222#r"[var"#229#i"]
                                                                            $(Expr(:inbounds, :pop))
                                                                            var"#231#val"
                                                                        end
                                                                #= threadingconstructs.jl:81 =#
                                                                begin
                                                                    begin
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                        nothing
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                        if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#865", 0), var"##ctrl_mask#873", var"##flag_mask#874")
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                            var"##upperbound#896" = size(var"##st#858", 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                            var"##Mmax#894" = Base.FastMath.sub_fast(size(var"##st#858", 1), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                            for var"##idx2#892" = 0:var"##Mmax#894" >>> 0
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                                var"##idx1#891" = Base.FastMath.add_fast(var"##idx2#892" << 0, 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                                var"##mmax#895" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#891", 0), 1)
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                                if var"##mmax#895" ≤ var"##Mmax#894"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                    begin
                                                                                        begin
                                                                                            var"##I#889_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), 1)
                                                                                            var"##I#889_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), var"##step_1_l#867"), 1)
                                                                                            var"##I#889_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), var"##step_2_l#869"), 1)
                                                                                            var"##I#889_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                            var"##T#890_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_1"])
                                                                                            var"##T#890_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_3"]))
                                                                                            var"##T#890_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_3"]))
                                                                                            var"##T#890_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_4"])
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_1"] = var"##T#890_1"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_2"] = var"##T#890_2"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_3"] = var"##T#890_3"
                                                                                            var"##st#858"[Base.FastMath.add_fast(var"##idx1#891", 0), var"##I#889_4"] = var"##T#890_4"
                                                                                        end
                                                                                    end
                                                                                else
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                    for var"##idx3#893" = var"##idx1#891":var"##upperbound#896"
                                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                        begin
                                                                                            var"##I#889_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), 1)
                                                                                            var"##I#889_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), var"##step_1_l#867"), 1)
                                                                                            var"##I#889_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), var"##step_2_l#869"), 1)
                                                                                            var"##I#889_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                            var"##T#890_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[var"##idx3#893", var"##I#889_1"])
                                                                                            var"##T#890_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[var"##idx3#893", var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[var"##idx3#893", var"##I#889_3"]))
                                                                                            var"##T#890_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[var"##idx3#893", var"##I#889_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[var"##idx3#893", var"##I#889_3"]))
                                                                                            var"##T#890_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[var"##idx3#893", var"##I#889_4"])
                                                                                            var"##st#858"[var"##idx3#893", var"##I#889_1"] = var"##T#890_1"
                                                                                            var"##st#858"[var"##idx3#893", var"##I#889_2"] = var"##T#890_2"
                                                                                            var"##st#858"[var"##idx3#893", var"##I#889_3"] = var"##T#890_3"
                                                                                            var"##st#858"[var"##idx3#893", var"##I#889_4"] = var"##T#890_4"
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
                                                        (Base.Threads.Base).invokelatest(var"#218#threadsfor_fun", true)
                                                    else
                                                        #= threadingconstructs.jl:93 =#
                                                        Base.Threads.threading_run(var"#218#threadsfor_fun")
                                                    end
                                                    #= threadingconstructs.jl:95 =#
                                                    Base.Threads.nothing
                                                end
                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:436 =#
                                                return var"##st#858"
                                            end
                                        end
                                        begin
                                            #= threadingconstructs.jl:45 =#
                                            local var"#233#threadsfor_fun"
                                            #= threadingconstructs.jl:46 =#
                                            let var"#232#range" = (BQCESubroutine.bsubspace)(var"##nqubits#862", (1:var"##m#866"..., var"##plain_locs#861"[1], var"##plain_locs#861"[2]))
                                                #= threadingconstructs.jl:47 =#
                                                function var"#233#threadsfor_fun"(var"#245#onethread" = false)
                                                    #= threadingconstructs.jl:47 =#
                                                    #= threadingconstructs.jl:48 =#
                                                    var"#237#r" = var"#232#range"
                                                    #= threadingconstructs.jl:49 =#
                                                    var"#238#lenr" = Base.Threads.length(var"#237#r")
                                                    #= threadingconstructs.jl:51 =#
                                                    if var"#245#onethread"
                                                        #= threadingconstructs.jl:52 =#
                                                        var"#239#tid" = 1
                                                        #= threadingconstructs.jl:53 =#
                                                        (var"#240#len", var"#241#rem") = (var"#238#lenr", 0)
                                                    else
                                                        #= threadingconstructs.jl:55 =#
                                                        var"#239#tid" = Base.Threads.threadid()
                                                        #= threadingconstructs.jl:56 =#
                                                        (var"#240#len", var"#241#rem") = Base.Threads.divrem(var"#238#lenr", Base.Threads.nthreads())
                                                    end
                                                    #= threadingconstructs.jl:59 =#
                                                    if var"#240#len" == 0
                                                        #= threadingconstructs.jl:60 =#
                                                        if var"#239#tid" > var"#241#rem"
                                                            #= threadingconstructs.jl:61 =#
                                                            return
                                                        end
                                                        #= threadingconstructs.jl:63 =#
                                                        (var"#240#len", var"#241#rem") = (1, 0)
                                                    end
                                                    #= threadingconstructs.jl:66 =#
                                                    var"#242#f" = Base.Threads.firstindex(var"#237#r") + (var"#239#tid" - 1) * var"#240#len"
                                                    #= threadingconstructs.jl:67 =#
                                                    var"#243#l" = (var"#242#f" + var"#240#len") - 1
                                                    #= threadingconstructs.jl:69 =#
                                                    if var"#241#rem" > 0
                                                        #= threadingconstructs.jl:70 =#
                                                        if var"#239#tid" <= var"#241#rem"
                                                            #= threadingconstructs.jl:71 =#
                                                            var"#242#f" = var"#242#f" + (var"#239#tid" - 1)
                                                            #= threadingconstructs.jl:72 =#
                                                            var"#243#l" = var"#243#l" + var"#239#tid"
                                                        else
                                                            #= threadingconstructs.jl:74 =#
                                                            var"#242#f" = var"#242#f" + var"#241#rem"
                                                            #= threadingconstructs.jl:75 =#
                                                            var"#243#l" = var"#243#l" + var"#241#rem"
                                                        end
                                                    end
                                                    #= threadingconstructs.jl:79 =#
                                                    for var"#244#i" = var"#242#f":var"#243#l"
                                                        #= threadingconstructs.jl:80 =#
                                                        local var"##base#865" = begin
                                                                    $(Expr(:inbounds, true))
                                                                    local var"#246#val" = var"#237#r"[var"#244#i"]
                                                                    $(Expr(:inbounds, :pop))
                                                                    var"#246#val"
                                                                end
                                                        #= threadingconstructs.jl:81 =#
                                                        for var"##idx#864_3" = var"##base#865":1:Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##base#865", var"##step_1_l#867"), 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:446 =#
                                                            begin
                                                                begin
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                    nothing
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                    if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##ctrl_mask#873", var"##flag_mask#874")
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                        var"##upperbound#904" = size(var"##st#858", 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                        var"##Mmax#902" = Base.FastMath.sub_fast(size(var"##st#858", 1), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                        for var"##idx2#900" = 0:var"##Mmax#902" >>> 0
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                            var"##idx1#899" = Base.FastMath.add_fast(var"##idx2#900" << 0, 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                            var"##mmax#903" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#899", 0), 1)
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                            if var"##mmax#903" ≤ var"##Mmax#902"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                                begin
                                                                                    begin
                                                                                        var"##I#897_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), 1)
                                                                                        var"##I#897_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), 1)
                                                                                        var"##I#897_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_2_l#869"), 1)
                                                                                        var"##I#897_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                        var"##T#898_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_1"])
                                                                                        var"##T#898_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_3"]))
                                                                                        var"##T#898_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_3"]))
                                                                                        var"##T#898_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_4"])
                                                                                        var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_1"] = var"##T#898_1"
                                                                                        var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_2"] = var"##T#898_2"
                                                                                        var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_3"] = var"##T#898_3"
                                                                                        var"##st#858"[Base.FastMath.add_fast(var"##idx1#899", 0), var"##I#897_4"] = var"##T#898_4"
                                                                                    end
                                                                                end
                                                                            else
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                                for var"##idx3#901" = var"##idx1#899":var"##upperbound#904"
                                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                    begin
                                                                                        var"##I#897_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), 1)
                                                                                        var"##I#897_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), 1)
                                                                                        var"##I#897_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_2_l#869"), 1)
                                                                                        var"##I#897_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##idx#864_3", 0), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                        var"##T#898_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[var"##idx3#901", var"##I#897_1"])
                                                                                        var"##T#898_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[var"##idx3#901", var"##I#897_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[var"##idx3#901", var"##I#897_3"]))
                                                                                        var"##T#898_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[var"##idx3#901", var"##I#897_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[var"##idx3#901", var"##I#897_3"]))
                                                                                        var"##T#898_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[var"##idx3#901", var"##I#897_4"])
                                                                                        var"##st#858"[var"##idx3#901", var"##I#897_1"] = var"##T#898_1"
                                                                                        var"##st#858"[var"##idx3#901", var"##I#897_2"] = var"##T#898_2"
                                                                                        var"##st#858"[var"##idx3#901", var"##I#897_3"] = var"##T#898_3"
                                                                                        var"##st#858"[var"##idx3#901", var"##I#897_4"] = var"##T#898_4"
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
                                                (Base.Threads.Base).invokelatest(var"#233#threadsfor_fun", true)
                                            else
                                                #= threadingconstructs.jl:93 =#
                                                Base.Threads.threading_run(var"#233#threadsfor_fun")
                                            end
                                            #= threadingconstructs.jl:95 =#
                                            Base.Threads.nothing
                                        end
                                    end
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:507 =#
                                    return var"##st#858"
                                end
                                begin
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:513 =#
                                    var"##m#866" = Base.max(0, Base.FastMath.sub_fast(Base.FastMath.sub_fast(var"##nqubits#862", var"##nlocs_needed#863"), 2))
                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:514 =#
                                    begin
                                        #= threadingconstructs.jl:45 =#
                                        local var"#248#threadsfor_fun"
                                        #= threadingconstructs.jl:46 =#
                                        let var"#247#range" = (BQCESubroutine.bsubspace)(var"##nqubits#862", (1:var"##m#866"..., var"##plain_locs#861"...))
                                            #= threadingconstructs.jl:47 =#
                                            function var"#248#threadsfor_fun"(var"#260#onethread" = false)
                                                #= threadingconstructs.jl:47 =#
                                                #= threadingconstructs.jl:48 =#
                                                var"#252#r" = var"#247#range"
                                                #= threadingconstructs.jl:49 =#
                                                var"#253#lenr" = Base.Threads.length(var"#252#r")
                                                #= threadingconstructs.jl:51 =#
                                                if var"#260#onethread"
                                                    #= threadingconstructs.jl:52 =#
                                                    var"#254#tid" = 1
                                                    #= threadingconstructs.jl:53 =#
                                                    (var"#255#len", var"#256#rem") = (var"#253#lenr", 0)
                                                else
                                                    #= threadingconstructs.jl:55 =#
                                                    var"#254#tid" = Base.Threads.threadid()
                                                    #= threadingconstructs.jl:56 =#
                                                    (var"#255#len", var"#256#rem") = Base.Threads.divrem(var"#253#lenr", Base.Threads.nthreads())
                                                end
                                                #= threadingconstructs.jl:59 =#
                                                if var"#255#len" == 0
                                                    #= threadingconstructs.jl:60 =#
                                                    if var"#254#tid" > var"#256#rem"
                                                        #= threadingconstructs.jl:61 =#
                                                        return
                                                    end
                                                    #= threadingconstructs.jl:63 =#
                                                    (var"#255#len", var"#256#rem") = (1, 0)
                                                end
                                                #= threadingconstructs.jl:66 =#
                                                var"#257#f" = Base.Threads.firstindex(var"#252#r") + (var"#254#tid" - 1) * var"#255#len"
                                                #= threadingconstructs.jl:67 =#
                                                var"#258#l" = (var"#257#f" + var"#255#len") - 1
                                                #= threadingconstructs.jl:69 =#
                                                if var"#256#rem" > 0
                                                    #= threadingconstructs.jl:70 =#
                                                    if var"#254#tid" <= var"#256#rem"
                                                        #= threadingconstructs.jl:71 =#
                                                        var"#257#f" = var"#257#f" + (var"#254#tid" - 1)
                                                        #= threadingconstructs.jl:72 =#
                                                        var"#258#l" = var"#258#l" + var"#254#tid"
                                                    else
                                                        #= threadingconstructs.jl:74 =#
                                                        var"#257#f" = var"#257#f" + var"#256#rem"
                                                        #= threadingconstructs.jl:75 =#
                                                        var"#258#l" = var"#258#l" + var"#256#rem"
                                                    end
                                                end
                                                #= threadingconstructs.jl:79 =#
                                                for var"#259#i" = var"#257#f":var"#258#l"
                                                    #= threadingconstructs.jl:80 =#
                                                    local var"##base#865" = begin
                                                                $(Expr(:inbounds, true))
                                                                local var"#261#val" = var"#252#r"[var"#259#i"]
                                                                $(Expr(:inbounds, :pop))
                                                                var"#261#val"
                                                            end
                                                    #= threadingconstructs.jl:81 =#
                                                    begin
                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:515 =#
                                                        for var"##idx#864_1" = 0:Base.FastMath.sub_fast(1 << var"##m#866", 1)
                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:516 =#
                                                            begin
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:314 =#
                                                                nothing
                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:315 =#
                                                                if (BQCESubroutine.ismatch)(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##ctrl_mask#873", var"##flag_mask#874")
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:675 =#
                                                                    var"##upperbound#912" = size(var"##st#858", 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:676 =#
                                                                    var"##Mmax#910" = Base.FastMath.sub_fast(size(var"##st#858", 1), 1)
                                                                    #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:677 =#
                                                                    for var"##idx2#908" = 0:var"##Mmax#910" >>> 0
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:657 =#
                                                                        var"##idx1#907" = Base.FastMath.add_fast(var"##idx2#908" << 0, 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:658 =#
                                                                        var"##mmax#911" = Base.FastMath.sub_fast(Base.FastMath.add_fast(var"##idx1#907", 0), 1)
                                                                        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:659 =#
                                                                        if var"##mmax#911" ≤ var"##Mmax#910"
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:660 =#
                                                                            begin
                                                                                begin
                                                                                    var"##I#905_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), 1)
                                                                                    var"##I#905_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##step_1_l#867"), 1)
                                                                                    var"##I#905_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##step_2_l#869"), 1)
                                                                                    var"##I#905_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                    var"##T#906_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_1"])
                                                                                    var"##T#906_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_3"]))
                                                                                    var"##T#906_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_3"]))
                                                                                    var"##T#906_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_4"])
                                                                                    var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_1"] = var"##T#906_1"
                                                                                    var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_2"] = var"##T#906_2"
                                                                                    var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_3"] = var"##T#906_3"
                                                                                    var"##st#858"[Base.FastMath.add_fast(var"##idx1#907", 0), var"##I#905_4"] = var"##T#906_4"
                                                                                end
                                                                            end
                                                                        else
                                                                            #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:662 =#
                                                                            for var"##idx3#909" = var"##idx1#907":var"##upperbound#912"
                                                                                #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:663 =#
                                                                                begin
                                                                                    var"##I#905_1" = Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), 1)
                                                                                    var"##I#905_2" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##step_1_l#867"), 1)
                                                                                    var"##I#905_3" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##step_2_l#869"), 1)
                                                                                    var"##I#905_4" = Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(Base.FastMath.add_fast(var"##base#865", var"##idx#864_1"), var"##step_1_l#867"), var"##step_2_l#869"), 1)
                                                                                    var"##T#906_1" = Base.FastMath.mul_fast(var"##hoisted#585", var"##st#858"[var"##idx3#909", var"##I#905_1"])
                                                                                    var"##T#906_2" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#586", var"##st#858"[var"##idx3#909", var"##I#905_2"]), Base.FastMath.mul_fast(var"##hoisted#587", var"##st#858"[var"##idx3#909", var"##I#905_3"]))
                                                                                    var"##T#906_3" = Base.FastMath.add_fast(Base.FastMath.mul_fast(var"##hoisted#588", var"##st#858"[var"##idx3#909", var"##I#905_2"]), Base.FastMath.mul_fast(var"##hoisted#589", var"##st#858"[var"##idx3#909", var"##I#905_3"]))
                                                                                    var"##T#906_4" = Base.FastMath.mul_fast(var"##hoisted#590", var"##st#858"[var"##idx3#909", var"##I#905_4"])
                                                                                    var"##st#858"[var"##idx3#909", var"##I#905_1"] = var"##T#906_1"
                                                                                    var"##st#858"[var"##idx3#909", var"##I#905_2"] = var"##T#906_2"
                                                                                    var"##st#858"[var"##idx3#909", var"##I#905_3"] = var"##T#906_3"
                                                                                    var"##st#858"[var"##idx3#909", var"##I#905_4"] = var"##T#906_4"
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
                                            (Base.Threads.Base).invokelatest(var"#248#threadsfor_fun", true)
                                        else
                                            #= threadingconstructs.jl:93 =#
                                            Base.Threads.threading_run(var"#248#threadsfor_fun")
                                        end
                                        #= threadingconstructs.jl:95 =#
                                        Base.Threads.nothing
                                    end
                                end
                                return var"##st#858"
                            end
                    $(Expr(:inbounds, :pop))
                    var"#198#val"
                end
            end
        end
        #= d:\school\q\q_iscas\BQCESubroutine\BQCESubroutine.jl\src\codegen\broutine.jl:163 =#
        return var"##st#858"
    end
    # function $(Expr(:where, :(BPSWAP_test(θ))))
    #     [-im * sin(θ / 2) + cos(θ / 2) 0 0 0; 0 cos(θ / 2) -im * sin(θ / 2) 0; 0 -im * sin(θ / 2) cos(θ / 2) 0; 0 0 0 -im * sin(θ / 2) + cos(θ / 2)]
    # end
end

eval(prog)