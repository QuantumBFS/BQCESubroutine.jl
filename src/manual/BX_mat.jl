function BQCESubroutine.broutine!(var"##st#699"::AbstractMatrix, ::Val{:X}, var"##locs#700"::Locations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(var"##locs#700") == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(var"##st#699", Val{:X}(), var"##locs#700")
                BQCESubroutine.threaded_basic_broutine!(var"##st#699", Val{:X}(), var"##locs#700")
                return var"##st#699"
            end
        end
        begin
            length(var"##locs#700") == 1 || return BQCESubroutine.multi_broutine2x2!(var"##st#699", Val{:X}(), var"##locs#700")
            BQCESubroutine.basic_broutine!(var"##st#699", Val{:X}(), var"##locs#700")
            return var"##st#699"
        end
    end
    return var"##st#699"
end
function BQCESubroutine.basic_broutine!(var"##st#701"::AbstractMatrix, ::Val{:X}, var"##locs#702"::Locations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#704" = (YaoLocations.plain)(var"##locs#702")
                var"##step_1_l#705" = 1 << (var"##plain_locs#704"[1] - 1)
                var"##step_1_h#706" = 1 << var"##plain_locs#704"[1]
            end
            begin
            end
            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(for var"##m#703_1" = 0:var"##step_1_h#706":size(var"##st#701", 2) - var"##step_1_h#706", var"##m#703_2" = var"##m#703_1":(var"##m#703_1" + var"##step_1_l#705") - 1
                        nothing
                        begin
                            var"##upperbound#714" = size(var"##st#701", 1)
                            var"##Mmax#712" = size(var"##st#701", 1) - 1
                            for var"##idx2#710" = 0:var"##Mmax#712" >>> 3
                                var"##idx1#709" = var"##idx2#710" << 3 + 1
                                var"##mmax#713" = (var"##idx1#709" + 7) - 1
                                if var"##mmax#713" ≤ var"##Mmax#712"
                                    begin
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 0, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 0, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 0, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 0, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 1, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 1, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 1, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 1, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 2, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 2, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 2, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 2, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 3, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 3, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 3, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 3, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 4, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 4, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 4, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 4, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 5, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 5, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 5, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 5, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 6, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 6, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 6, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 6, var"##I#707_2"] = var"##T#708_2"
                                        end
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx1#709" + 7, var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx1#709" + 7, var"##I#707_1"]
                                            var"##st#701"[var"##idx1#709" + 7, var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx1#709" + 7, var"##I#707_2"] = var"##T#708_2"
                                        end
                                    end
                                else
                                    for var"##idx3#711" = var"##idx1#709":var"##upperbound#714"
                                        begin
                                            var"##I#707_1" = var"##m#703_2" + 1
                                            var"##I#707_2" = (var"##m#703_2" + var"##step_1_l#705") + 1
                                            var"##T#708_1" = var"##st#701"[var"##idx3#711", var"##I#707_2"]
                                            var"##T#708_2" = var"##st#701"[var"##idx3#711", var"##I#707_1"]
                                            var"##st#701"[var"##idx3#711", var"##I#707_1"] = var"##T#708_1"
                                            var"##st#701"[var"##idx3#711", var"##I#707_2"] = var"##T#708_2"
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return var"##st#701"
end
function BQCESubroutine.multi_broutine2x2!(var"##st#715"::AbstractMatrix, ::Val{:X}, var"##locs#716"::Locations)
    begin
        begin
            var"##plain_locs#718" = (YaoLocations.plain)(var"##locs#716")
            var"##step_1_l#719" = 1 << (var"##plain_locs#718"[1] - 1)
            var"##step_1_h#720" = 1 << var"##plain_locs#718"[1]
            var"##mask#727" = (BQCESubroutine.bmask)(var"##plain_locs#718")
        end
        begin
        end
        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(for var"##m#717_1" = 0:var"##step_1_h#720":size(var"##st#715", 2) - var"##step_1_h#720", var"##m#717_2" = var"##m#717_1":(var"##m#717_1" + var"##step_1_l#719") - 1
                    begin
                        var"##i#752" = var"##m#717_2" + 1
                        var"##j#753" = (var"##m#717_2" ⊻ var"##mask#727") + 1
                    end
                    begin
                        var"##upperbound#726" = size(var"##st#715", 1)
                        var"##Mmax#724" = size(var"##st#715", 1) - 1
                        for var"##idx2#722" = 0:var"##Mmax#724" >>> 3
                            var"##idx1#721" = var"##idx2#722" << 3 + 1
                            var"##mmax#725" = (var"##idx1#721" + 7) - 1
                            if var"##mmax#725" ≤ var"##Mmax#724"
                                begin
                                    begin
                                        var"##tmp#730" = var"##st#715"[var"##idx1#721" + 0, var"##i#728"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 0, var"##i#728"] = var"##st#715"[var"##idx1#721" + 0, var"##j#729"]
                                            var"##st#715"[var"##idx1#721" + 0, var"##j#729"] = var"##tmp#730"
                                        end
                                    end
                                    begin
                                        var"##tmp#733" = var"##st#715"[var"##idx1#721" + 1, var"##i#731"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 1, var"##i#731"] = var"##st#715"[var"##idx1#721" + 1, var"##j#732"]
                                            var"##st#715"[var"##idx1#721" + 1, var"##j#732"] = var"##tmp#733"
                                        end
                                    end
                                    begin
                                        var"##tmp#736" = var"##st#715"[var"##idx1#721" + 2, var"##i#734"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 2, var"##i#734"] = var"##st#715"[var"##idx1#721" + 2, var"##j#735"]
                                            var"##st#715"[var"##idx1#721" + 2, var"##j#735"] = var"##tmp#736"
                                        end
                                    end
                                    begin
                                        var"##tmp#739" = var"##st#715"[var"##idx1#721" + 3, var"##i#737"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 3, var"##i#737"] = var"##st#715"[var"##idx1#721" + 3, var"##j#738"]
                                            var"##st#715"[var"##idx1#721" + 3, var"##j#738"] = var"##tmp#739"
                                        end
                                    end
                                    begin
                                        var"##tmp#742" = var"##st#715"[var"##idx1#721" + 4, var"##i#740"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 4, var"##i#740"] = var"##st#715"[var"##idx1#721" + 4, var"##j#741"]
                                            var"##st#715"[var"##idx1#721" + 4, var"##j#741"] = var"##tmp#742"
                                        end
                                    end
                                    begin
                                        var"##tmp#745" = var"##st#715"[var"##idx1#721" + 5, var"##i#743"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 5, var"##i#743"] = var"##st#715"[var"##idx1#721" + 5, var"##j#744"]
                                            var"##st#715"[var"##idx1#721" + 5, var"##j#744"] = var"##tmp#745"
                                        end
                                    end
                                    begin
                                        var"##tmp#748" = var"##st#715"[var"##idx1#721" + 6, var"##i#746"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 6, var"##i#746"] = var"##st#715"[var"##idx1#721" + 6, var"##j#747"]
                                            var"##st#715"[var"##idx1#721" + 6, var"##j#747"] = var"##tmp#748"
                                        end
                                    end
                                    begin
                                        var"##tmp#751" = var"##st#715"[var"##idx1#721" + 7, var"##i#749"]
                                        begin
                                            var"##st#715"[var"##idx1#721" + 7, var"##i#749"] = var"##st#715"[var"##idx1#721" + 7, var"##j#750"]
                                            var"##st#715"[var"##idx1#721" + 7, var"##j#750"] = var"##tmp#751"
                                        end
                                    end
                                end
                            else
                                for var"##idx3#723" = var"##idx1#721":var"##upperbound#726"
                                    begin
                                        var"##tmp#754" = var"##st#715"[var"##idx3#723", var"##i#752"]
                                        begin
                                            var"##st#715"[var"##idx3#723", var"##i#752"] = var"##st#715"[var"##idx3#723", var"##j#753"]
                                            var"##st#715"[var"##idx3#723", var"##j#753"] = var"##tmp#754"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
    end
    return var"##st#715"
end
function BQCESubroutine.threaded_basic_broutine!(var"##st#757"::AbstractMatrix, ::Val{:X}, var"##locs#758"::Locations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#759" = (YaoLocations.plain)(var"##locs#758")
                var"##nqubits#760" = (BQCESubroutine.log2i)(size(var"##st#757", 2))
                var"##nlocs_needed#761" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                var"##step_1_l#765" = 1 << (var"##plain_locs#759"[1] - 1)
                var"##step_1_h#766" = 1 << var"##plain_locs#759"[1]
            end
            begin
            end
            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                        if var"##nlocs_needed#761" ≤ var"##nqubits#760" - var"##plain_locs#759"[1]
                            begin
                                begin
                                    if var"##step_1_l#765" == 1
                                        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#762_1" = 0:var"##step_1_h#766":size(var"##st#757", 2) - var"##step_1_h#766"
                                                begin
                                                    nothing
                                                    begin
                                                        var"##upperbound#774" = size(var"##st#757", 1)
                                                        var"##Mmax#772" = size(var"##st#757", 1) - 1
                                                        for var"##idx2#770" = 0:var"##Mmax#772" >>> 0
                                                            var"##idx1#769" = var"##idx2#770" << 0 + 1
                                                            var"##mmax#773" = (var"##idx1#769" + 0) - 1
                                                            if var"##mmax#773" ≤ var"##Mmax#772"
                                                                begin
                                                                    begin
                                                                        var"##I#767_1" = (var"##idx#762_1" + 0) + 1
                                                                        var"##I#767_2" = ((var"##idx#762_1" + 0) + var"##step_1_l#765") + 1
                                                                        var"##T#768_1" = var"##st#757"[var"##idx1#769" + 0, var"##I#767_2"]
                                                                        var"##T#768_2" = var"##st#757"[var"##idx1#769" + 0, var"##I#767_1"]
                                                                        var"##st#757"[var"##idx1#769" + 0, var"##I#767_1"] = var"##T#768_1"
                                                                        var"##st#757"[var"##idx1#769" + 0, var"##I#767_2"] = var"##T#768_2"
                                                                    end
                                                                end
                                                            else
                                                                for var"##idx3#771" = var"##idx1#769":var"##upperbound#774"
                                                                    begin
                                                                        var"##I#767_1" = (var"##idx#762_1" + 0) + 1
                                                                        var"##I#767_2" = ((var"##idx#762_1" + 0) + var"##step_1_l#765") + 1
                                                                        var"##T#768_1" = var"##st#757"[var"##idx3#771", var"##I#767_2"]
                                                                        var"##T#768_2" = var"##st#757"[var"##idx3#771", var"##I#767_1"]
                                                                        var"##st#757"[var"##idx3#771", var"##I#767_1"] = var"##T#768_1"
                                                                        var"##st#757"[var"##idx3#771", var"##I#767_2"] = var"##T#768_2"
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        return var"##st#757"
                                    end
                                end
                                #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#762_1" = 0:var"##step_1_h#766":size(var"##st#757", 2) - var"##step_1_h#766"
                                        for var"##idx#762_2" = var"##idx#762_1":1:(var"##idx#762_1" + var"##step_1_l#765") - 1
                                            begin
                                                begin
                                                    nothing
                                                    begin
                                                        var"##upperbound#782" = size(var"##st#757", 1)
                                                        var"##Mmax#780" = size(var"##st#757", 1) - 1
                                                        for var"##idx2#778" = 0:var"##Mmax#780" >>> 0
                                                            var"##idx1#777" = var"##idx2#778" << 0 + 1
                                                            var"##mmax#781" = (var"##idx1#777" + 0) - 1
                                                            if var"##mmax#781" ≤ var"##Mmax#780"
                                                                begin
                                                                    begin
                                                                        var"##I#775_1" = (var"##idx#762_2" + 0) + 1
                                                                        var"##I#775_2" = ((var"##idx#762_2" + 0) + var"##step_1_l#765") + 1
                                                                        var"##T#776_1" = var"##st#757"[var"##idx1#777" + 0, var"##I#775_2"]
                                                                        var"##T#776_2" = var"##st#757"[var"##idx1#777" + 0, var"##I#775_1"]
                                                                        var"##st#757"[var"##idx1#777" + 0, var"##I#775_1"] = var"##T#776_1"
                                                                        var"##st#757"[var"##idx1#777" + 0, var"##I#775_2"] = var"##T#776_2"
                                                                    end
                                                                end
                                                            else
                                                                for var"##idx3#779" = var"##idx1#777":var"##upperbound#782"
                                                                    begin
                                                                        var"##I#775_1" = (var"##idx#762_2" + 0) + 1
                                                                        var"##I#775_2" = ((var"##idx#762_2" + 0) + var"##step_1_l#765") + 1
                                                                        var"##T#776_1" = var"##st#757"[var"##idx3#779", var"##I#775_2"]
                                                                        var"##T#776_2" = var"##st#757"[var"##idx3#779", var"##I#775_1"]
                                                                        var"##st#757"[var"##idx3#779", var"##I#775_1"] = var"##T#776_1"
                                                                        var"##st#757"[var"##idx3#779", var"##I#775_2"] = var"##T#776_2"
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
                            return var"##st#757"
                        end
                        begin
                            var"##m#764" = Base.max(0, (var"##nqubits#760" - var"##nlocs_needed#761") - 1)
                            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:512 =# Threads.@threads for var"##base#763" = (BQCESubroutine.bsubspace)(var"##nqubits#760", (1:var"##m#764"..., var"##plain_locs#759"...))
                                    for var"##idx#762_1" = 0:1 << var"##m#764" - 1
                                        begin
                                            nothing
                                            begin
                                                var"##upperbound#790" = size(var"##st#757", 1)
                                                var"##Mmax#788" = size(var"##st#757", 1) - 1
                                                for var"##idx2#786" = 0:var"##Mmax#788" >>> 0
                                                    var"##idx1#785" = var"##idx2#786" << 0 + 1
                                                    var"##mmax#789" = (var"##idx1#785" + 0) - 1
                                                    if var"##mmax#789" ≤ var"##Mmax#788"
                                                        begin
                                                            begin
                                                                var"##I#783_1" = (var"##base#763" + var"##idx#762_1") + 1
                                                                var"##I#783_2" = ((var"##base#763" + var"##idx#762_1") + var"##step_1_l#765") + 1
                                                                var"##T#784_1" = var"##st#757"[var"##idx1#785" + 0, var"##I#783_2"]
                                                                var"##T#784_2" = var"##st#757"[var"##idx1#785" + 0, var"##I#783_1"]
                                                                var"##st#757"[var"##idx1#785" + 0, var"##I#783_1"] = var"##T#784_1"
                                                                var"##st#757"[var"##idx1#785" + 0, var"##I#783_2"] = var"##T#784_2"
                                                            end
                                                        end
                                                    else
                                                        for var"##idx3#787" = var"##idx1#785":var"##upperbound#790"
                                                            begin
                                                                var"##I#783_1" = (var"##base#763" + var"##idx#762_1") + 1
                                                                var"##I#783_2" = ((var"##base#763" + var"##idx#762_1") + var"##step_1_l#765") + 1
                                                                var"##T#784_1" = var"##st#757"[var"##idx3#787", var"##I#783_2"]
                                                                var"##T#784_2" = var"##st#757"[var"##idx3#787", var"##I#783_1"]
                                                                var"##st#757"[var"##idx3#787", var"##I#783_1"] = var"##T#784_1"
                                                                var"##st#757"[var"##idx3#787", var"##I#783_2"] = var"##T#784_2"
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                        end
                        return var"##st#757"
                    end)
        end
    end
    return var"##st#757"
end
function BQCESubroutine.threaded_multi_broutine2x2!(st::AbstractMatrix, ::Val{:X}, locs::Locations)
    plain_locs = (YaoLocations.plain)(locs)
    nqubits = (BQCESubroutine.log2i)(size(st, 2))
    nlocs_needed = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
    step_1_l = 1 << (plain_locs[1] - 1)
    step_1_h = 1 << plain_locs[1]
    mask = (BQCESubroutine.bmask)(plain_locs)
    @fastmath @inbounds(begin
        if nlocs_needed ≤ nqubits - plain_locs[1]
            if step_1_l == 1
                @batch for idx_1 = 0:step_1_h:size(st, 2) - step_1_h
                    i = (idx_1 + 0) + 1
                    j = ((idx_1 + 0) ⊻ mask) + 1
                    upperbound = size(st, 1)
                    Mmax = size(st, 1) - 1
                    for idx2 = 0:Mmax >>> 0
                        idx1 = idx2 << 0 + 1
                        mmax = (idx1 + 0) - 1
                        if mmax ≤ Mmax
                            tmp = st[idx1 + 0, i]
                            st[idx1 + 0, i] = st[idx1 + 0, j]
                            st[idx1 + 0, j] = tmp
                        else
                            for idx3 = idx1:upperbound
                                tmp = st[idx3, i]
                                st[idx3, i] = st[idx3, j]
                                st[idx3, j] = tmp
                            end
                        end
                    end
                end
                return st
            end
            @batch for idx_1 = 0:step_1_h:size(st, 2) - step_1_h
                for idx_2 = idx_1:1:(idx_1 + step_1_l) - 1
                    i = (idx_2 + 0) + 1
                    j = ((idx_2 + 0) ⊻ mask) + 1
                    upperbound = size(st, 1)
                    Mmax = size(st, 1) - 1
                    for idx2 = 0:Mmax >>> 0
                        idx1 = idx2 << 0 + 1
                        mmax = (idx1 + 0) - 1
                        if mmax ≤ Mmax
                            tmp = st[idx1 + 0, i]
                            st[idx1 + 0, i] = st[idx1 + 0, j]
                            st[idx1 + 0, j] = tmp
                        else
                            for idx3 = idx1:upperbound
                                tmp = st[idx3, i]
                                st[idx3, i] = st[idx3, j]
                                st[idx3, j] = tmp
                            end
                        end
                    end
                end
            end
            return st
        end
        m = Base.max(0, (nqubits - nlocs_needed) - 1)
        @batch for base = (BQCESubroutine.bsubspace)(nqubits, (1:m..., plain_locs...))
            for idx_1 = 0:1 << m - 1
                i = (base + idx_1) + 1
                j = ((base + idx_1) ⊻ mask) + 1
                upperbound = size(st, 1)
                Mmax = size(st, 1) - 1
                for idx2 = 0:Mmax >>> 0
                    idx1 = idx2 << 0 + 1
                    mmax = (idx1 + 0) - 1
                    if mmax ≤ Mmax
                        tmp = st[idx1 + 0, i]
                        st[idx1 + 0, i] = st[idx1 + 0, j]
                        st[idx1 + 0, j] = tmp
                    else
                        for idx3 = idx1:upperbound
                            tmp = st[idx3, i]
                            st[idx3, i] = st[idx3, j]
                            st[idx3, j] = tmp
                        end
                    end
                end
            end
        end
        return st
    end)
    return st
end
