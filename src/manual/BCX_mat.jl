function BQCESubroutine.broutine!(var"##st#838"::AbstractMatrix, ::Val{:X}, var"##locs#839"::Locations, var"##ctrl#698"::CtrlLocations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(var"##locs#839") == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(var"##st#838", Val{:X}(), var"##locs#839", var"##ctrl#698")
                BQCESubroutine.threaded_basic_broutine!(var"##st#838", Val{:X}(), var"##locs#839", var"##ctrl#698")
                return var"##st#838"
            end
        end
        begin
            length(var"##locs#839") == 1 || return BQCESubroutine.multi_broutine2x2!(var"##st#838", Val{:X}(), var"##locs#839", var"##ctrl#698")
            BQCESubroutine.basic_broutine!(var"##st#838", Val{:X}(), var"##locs#839", var"##ctrl#698")
            return var"##st#838"
        end
    end
    return var"##st#838"
end
function BQCESubroutine.basic_broutine!(var"##st#840"::AbstractMatrix, ::Val{:X}, var"##locs#841"::Locations, var"##ctrl#698"::CtrlLocations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#843" = (YaoLocations.plain)(var"##locs#841")
                var"##step_1_l#844" = 1 << (var"##plain_locs#843"[1] - 1)
                var"##step_1_h#845" = 1 << var"##plain_locs#843"[1]
                var"##ctrl_mask#848" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#698"))
                var"##flag_mask#849" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#698")
            end
            begin
            end
            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(for var"##m#842_1" = 0:var"##step_1_h#845":size(var"##st#840", 2) - var"##step_1_h#845", var"##m#842_2" = var"##m#842_1":(var"##m#842_1" + var"##step_1_l#844") - 1
                        nothing
                        if (BQCESubroutine.ismatch)(var"##m#842_2", var"##ctrl_mask#848", var"##flag_mask#849")
                            var"##upperbound#855" = size(var"##st#840", 1)
                            var"##Mmax#853" = size(var"##st#840", 1) - 1
                            for var"##idx2#851" = 0:var"##Mmax#853" >>> 3
                                var"##idx1#850" = var"##idx2#851" << 3 + 1
                                var"##mmax#854" = (var"##idx1#850" + 7) - 1
                                if var"##mmax#854" ≤ var"##Mmax#853"
                                    begin
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 0, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 0, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 0, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 0, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 1, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 1, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 1, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 1, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 2, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 2, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 2, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 2, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 3, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 3, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 3, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 3, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 4, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 4, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 4, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 4, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 5, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 5, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 5, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 5, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 6, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 6, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 6, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 6, var"##I#846_2"] = var"##T#847_2"
                                        end
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx1#850" + 7, var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx1#850" + 7, var"##I#846_1"]
                                            var"##st#840"[var"##idx1#850" + 7, var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx1#850" + 7, var"##I#846_2"] = var"##T#847_2"
                                        end
                                    end
                                else
                                    for var"##idx3#852" = var"##idx1#850":var"##upperbound#855"
                                        begin
                                            var"##I#846_1" = var"##m#842_2" + 1
                                            var"##I#846_2" = (var"##m#842_2" + var"##step_1_l#844") + 1
                                            var"##T#847_1" = var"##st#840"[var"##idx3#852", var"##I#846_2"]
                                            var"##T#847_2" = var"##st#840"[var"##idx3#852", var"##I#846_1"]
                                            var"##st#840"[var"##idx3#852", var"##I#846_1"] = var"##T#847_1"
                                            var"##st#840"[var"##idx3#852", var"##I#846_2"] = var"##T#847_2"
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return var"##st#840"
end
function BQCESubroutine.multi_broutine2x2!(var"##st#856"::AbstractMatrix, ::Val{:X}, var"##locs#857"::Locations, var"##ctrl#698"::CtrlLocations)
    begin
        begin
            var"##plain_locs#859" = (YaoLocations.plain)(var"##locs#857")
            var"##step_1_l#860" = 1 << (var"##plain_locs#859"[1] - 1)
            var"##step_1_h#861" = 1 << var"##plain_locs#859"[1]
            var"##ctrl_mask#862" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#698"))
            var"##flag_mask#863" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#698")
            var"##mask#870" = (BQCESubroutine.bmask)(var"##plain_locs#859")
        end
        begin
        end
        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(for var"##m#858_1" = 0:var"##step_1_h#861":size(var"##st#856", 2) - var"##step_1_h#861", var"##m#858_2" = var"##m#858_1":(var"##m#858_1" + var"##step_1_l#860") - 1
                    begin
                        var"##i#895" = var"##m#858_2" + 1
                        var"##j#896" = (var"##m#858_2" ⊻ var"##mask#870") + 1
                    end
                    if (BQCESubroutine.ismatch)(var"##m#858_2", var"##ctrl_mask#862", var"##flag_mask#863")
                        var"##upperbound#869" = size(var"##st#856", 1)
                        var"##Mmax#867" = size(var"##st#856", 1) - 1
                        for var"##idx2#865" = 0:var"##Mmax#867" >>> 3
                            var"##idx1#864" = var"##idx2#865" << 3 + 1
                            var"##mmax#868" = (var"##idx1#864" + 7) - 1
                            if var"##mmax#868" ≤ var"##Mmax#867"
                                begin
                                    begin
                                        var"##tmp#873" = var"##st#856"[var"##idx1#864" + 0, var"##i#871"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 0, var"##i#871"] = var"##st#856"[var"##idx1#864" + 0, var"##j#872"]
                                            var"##st#856"[var"##idx1#864" + 0, var"##j#872"] = var"##tmp#873"
                                        end
                                    end
                                    begin
                                        var"##tmp#876" = var"##st#856"[var"##idx1#864" + 1, var"##i#874"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 1, var"##i#874"] = var"##st#856"[var"##idx1#864" + 1, var"##j#875"]
                                            var"##st#856"[var"##idx1#864" + 1, var"##j#875"] = var"##tmp#876"
                                        end
                                    end
                                    begin
                                        var"##tmp#879" = var"##st#856"[var"##idx1#864" + 2, var"##i#877"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 2, var"##i#877"] = var"##st#856"[var"##idx1#864" + 2, var"##j#878"]
                                            var"##st#856"[var"##idx1#864" + 2, var"##j#878"] = var"##tmp#879"
                                        end
                                    end
                                    begin
                                        var"##tmp#882" = var"##st#856"[var"##idx1#864" + 3, var"##i#880"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 3, var"##i#880"] = var"##st#856"[var"##idx1#864" + 3, var"##j#881"]
                                            var"##st#856"[var"##idx1#864" + 3, var"##j#881"] = var"##tmp#882"
                                        end
                                    end
                                    begin
                                        var"##tmp#885" = var"##st#856"[var"##idx1#864" + 4, var"##i#883"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 4, var"##i#883"] = var"##st#856"[var"##idx1#864" + 4, var"##j#884"]
                                            var"##st#856"[var"##idx1#864" + 4, var"##j#884"] = var"##tmp#885"
                                        end
                                    end
                                    begin
                                        var"##tmp#888" = var"##st#856"[var"##idx1#864" + 5, var"##i#886"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 5, var"##i#886"] = var"##st#856"[var"##idx1#864" + 5, var"##j#887"]
                                            var"##st#856"[var"##idx1#864" + 5, var"##j#887"] = var"##tmp#888"
                                        end
                                    end
                                    begin
                                        var"##tmp#891" = var"##st#856"[var"##idx1#864" + 6, var"##i#889"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 6, var"##i#889"] = var"##st#856"[var"##idx1#864" + 6, var"##j#890"]
                                            var"##st#856"[var"##idx1#864" + 6, var"##j#890"] = var"##tmp#891"
                                        end
                                    end
                                    begin
                                        var"##tmp#894" = var"##st#856"[var"##idx1#864" + 7, var"##i#892"]
                                        begin
                                            var"##st#856"[var"##idx1#864" + 7, var"##i#892"] = var"##st#856"[var"##idx1#864" + 7, var"##j#893"]
                                            var"##st#856"[var"##idx1#864" + 7, var"##j#893"] = var"##tmp#894"
                                        end
                                    end
                                end
                            else
                                for var"##idx3#866" = var"##idx1#864":var"##upperbound#869"
                                    begin
                                        var"##tmp#897" = var"##st#856"[var"##idx3#866", var"##i#895"]
                                        begin
                                            var"##st#856"[var"##idx3#866", var"##i#895"] = var"##st#856"[var"##idx3#866", var"##j#896"]
                                            var"##st#856"[var"##idx3#866", var"##j#896"] = var"##tmp#897"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
    end
    return var"##st#856"
end
function BQCESubroutine.threaded_basic_broutine!(var"##st#900"::AbstractMatrix, ::Val{:X}, var"##locs#901"::Locations, var"##ctrl#698"::CtrlLocations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#902" = (YaoLocations.plain)(var"##locs#901")
                var"##nqubits#903" = (BQCESubroutine.log2i)(size(var"##st#900", 2))
                var"##nlocs_needed#904" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                var"##step_1_l#908" = 1 << (var"##plain_locs#902"[1] - 1)
                var"##step_1_h#909" = 1 << var"##plain_locs#902"[1]
                var"##ctrl_mask#912" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#698"))
                var"##flag_mask#913" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#698")
            end
            begin
            end
            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                        if var"##nlocs_needed#904" ≤ var"##nqubits#903" - var"##plain_locs#902"[1]
                            begin
                                begin
                                    if var"##step_1_l#908" == 1
                                        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#905_1" = 0:var"##step_1_h#909":size(var"##st#900", 2) - var"##step_1_h#909"
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(var"##idx#905_1" + 0, var"##ctrl_mask#912", var"##flag_mask#913")
                                                        var"##upperbound#919" = size(var"##st#900", 1)
                                                        var"##Mmax#917" = size(var"##st#900", 1) - 1
                                                        for var"##idx2#915" = 0:var"##Mmax#917" >>> 0
                                                            var"##idx1#914" = var"##idx2#915" << 0 + 1
                                                            var"##mmax#918" = (var"##idx1#914" + 0) - 1
                                                            if var"##mmax#918" ≤ var"##Mmax#917"
                                                                begin
                                                                    begin
                                                                        var"##I#910_1" = (var"##idx#905_1" + 0) + 1
                                                                        var"##I#910_2" = ((var"##idx#905_1" + 0) + var"##step_1_l#908") + 1
                                                                        var"##T#911_1" = var"##st#900"[var"##idx1#914" + 0, var"##I#910_2"]
                                                                        var"##T#911_2" = var"##st#900"[var"##idx1#914" + 0, var"##I#910_1"]
                                                                        var"##st#900"[var"##idx1#914" + 0, var"##I#910_1"] = var"##T#911_1"
                                                                        var"##st#900"[var"##idx1#914" + 0, var"##I#910_2"] = var"##T#911_2"
                                                                    end
                                                                end
                                                            else
                                                                for var"##idx3#916" = var"##idx1#914":var"##upperbound#919"
                                                                    begin
                                                                        var"##I#910_1" = (var"##idx#905_1" + 0) + 1
                                                                        var"##I#910_2" = ((var"##idx#905_1" + 0) + var"##step_1_l#908") + 1
                                                                        var"##T#911_1" = var"##st#900"[var"##idx3#916", var"##I#910_2"]
                                                                        var"##T#911_2" = var"##st#900"[var"##idx3#916", var"##I#910_1"]
                                                                        var"##st#900"[var"##idx3#916", var"##I#910_1"] = var"##T#911_1"
                                                                        var"##st#900"[var"##idx3#916", var"##I#910_2"] = var"##T#911_2"
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        return var"##st#900"
                                    end
                                end
                                #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#905_1" = 0:var"##step_1_h#909":size(var"##st#900", 2) - var"##step_1_h#909"
                                        for var"##idx#905_2" = var"##idx#905_1":1:(var"##idx#905_1" + var"##step_1_l#908") - 1
                                            begin
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(var"##idx#905_2" + 0, var"##ctrl_mask#912", var"##flag_mask#913")
                                                        var"##upperbound#927" = size(var"##st#900", 1)
                                                        var"##Mmax#925" = size(var"##st#900", 1) - 1
                                                        for var"##idx2#923" = 0:var"##Mmax#925" >>> 0
                                                            var"##idx1#922" = var"##idx2#923" << 0 + 1
                                                            var"##mmax#926" = (var"##idx1#922" + 0) - 1
                                                            if var"##mmax#926" ≤ var"##Mmax#925"
                                                                begin
                                                                    begin
                                                                        var"##I#920_1" = (var"##idx#905_2" + 0) + 1
                                                                        var"##I#920_2" = ((var"##idx#905_2" + 0) + var"##step_1_l#908") + 1
                                                                        var"##T#921_1" = var"##st#900"[var"##idx1#922" + 0, var"##I#920_2"]
                                                                        var"##T#921_2" = var"##st#900"[var"##idx1#922" + 0, var"##I#920_1"]
                                                                        var"##st#900"[var"##idx1#922" + 0, var"##I#920_1"] = var"##T#921_1"
                                                                        var"##st#900"[var"##idx1#922" + 0, var"##I#920_2"] = var"##T#921_2"
                                                                    end
                                                                end
                                                            else
                                                                for var"##idx3#924" = var"##idx1#922":var"##upperbound#927"
                                                                    begin
                                                                        var"##I#920_1" = (var"##idx#905_2" + 0) + 1
                                                                        var"##I#920_2" = ((var"##idx#905_2" + 0) + var"##step_1_l#908") + 1
                                                                        var"##T#921_1" = var"##st#900"[var"##idx3#924", var"##I#920_2"]
                                                                        var"##T#921_2" = var"##st#900"[var"##idx3#924", var"##I#920_1"]
                                                                        var"##st#900"[var"##idx3#924", var"##I#920_1"] = var"##T#921_1"
                                                                        var"##st#900"[var"##idx3#924", var"##I#920_2"] = var"##T#921_2"
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
                            return var"##st#900"
                        end
                        begin
                            var"##m#907" = Base.max(0, (var"##nqubits#903" - var"##nlocs_needed#904") - 1)
                            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:512 =# Threads.@threads for var"##base#906" = (BQCESubroutine.bsubspace)(var"##nqubits#903", (1:var"##m#907"..., var"##plain_locs#902"...))
                                    for var"##idx#905_1" = 0:1 << var"##m#907" - 1
                                        begin
                                            nothing
                                            if (BQCESubroutine.ismatch)(var"##base#906" + var"##idx#905_1", var"##ctrl_mask#912", var"##flag_mask#913")
                                                var"##upperbound#935" = size(var"##st#900", 1)
                                                var"##Mmax#933" = size(var"##st#900", 1) - 1
                                                for var"##idx2#931" = 0:var"##Mmax#933" >>> 0
                                                    var"##idx1#930" = var"##idx2#931" << 0 + 1
                                                    var"##mmax#934" = (var"##idx1#930" + 0) - 1
                                                    if var"##mmax#934" ≤ var"##Mmax#933"
                                                        begin
                                                            begin
                                                                var"##I#928_1" = (var"##base#906" + var"##idx#905_1") + 1
                                                                var"##I#928_2" = ((var"##base#906" + var"##idx#905_1") + var"##step_1_l#908") + 1
                                                                var"##T#929_1" = var"##st#900"[var"##idx1#930" + 0, var"##I#928_2"]
                                                                var"##T#929_2" = var"##st#900"[var"##idx1#930" + 0, var"##I#928_1"]
                                                                var"##st#900"[var"##idx1#930" + 0, var"##I#928_1"] = var"##T#929_1"
                                                                var"##st#900"[var"##idx1#930" + 0, var"##I#928_2"] = var"##T#929_2"
                                                            end
                                                        end
                                                    else
                                                        for var"##idx3#932" = var"##idx1#930":var"##upperbound#935"
                                                            begin
                                                                var"##I#928_1" = (var"##base#906" + var"##idx#905_1") + 1
                                                                var"##I#928_2" = ((var"##base#906" + var"##idx#905_1") + var"##step_1_l#908") + 1
                                                                var"##T#929_1" = var"##st#900"[var"##idx3#932", var"##I#928_2"]
                                                                var"##T#929_2" = var"##st#900"[var"##idx3#932", var"##I#928_1"]
                                                                var"##st#900"[var"##idx3#932", var"##I#928_1"] = var"##T#929_1"
                                                                var"##st#900"[var"##idx3#932", var"##I#928_2"] = var"##T#929_2"
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                        end
                        return var"##st#900"
                    end)
        end
    end
    return var"##st#900"
end
function BQCESubroutine.threaded_multi_broutine2x2!(var"##st#936"::AbstractMatrix, ::Val{:X}, var"##locs#937"::Locations, var"##ctrl#698"::CtrlLocations)
    begin
        begin
            var"##plain_locs#938" = (YaoLocations.plain)(var"##locs#937")
            var"##nqubits#939" = (BQCESubroutine.log2i)(size(var"##st#936", 2))
            var"##nlocs_needed#940" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
            var"##step_1_l#944" = 1 << (var"##plain_locs#938"[1] - 1)
            var"##step_1_h#945" = 1 << var"##plain_locs#938"[1]
            var"##ctrl_mask#946" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#698"))
            var"##flag_mask#947" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#698")
            var"##mask#954" = (BQCESubroutine.bmask)(var"##plain_locs#938")
        end
        begin
        end
        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                    if var"##nlocs_needed#940" ≤ var"##nqubits#939" - var"##plain_locs#938"[1]
                        begin
                            begin
                                if var"##step_1_l#944" == 1
                                    #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#941_1" = 0:var"##step_1_h#945":size(var"##st#936", 2) - var"##step_1_h#945"
                                            begin
                                                begin
                                                    var"##i#958" = (var"##idx#941_1" + 0) + 1
                                                    var"##j#959" = ((var"##idx#941_1" + 0) ⊻ var"##mask#954") + 1
                                                end
                                                if (BQCESubroutine.ismatch)(var"##idx#941_1" + 0, var"##ctrl_mask#946", var"##flag_mask#947")
                                                    var"##upperbound#953" = size(var"##st#936", 1)
                                                    var"##Mmax#951" = size(var"##st#936", 1) - 1
                                                    for var"##idx2#949" = 0:var"##Mmax#951" >>> 0
                                                        var"##idx1#948" = var"##idx2#949" << 0 + 1
                                                        var"##mmax#952" = (var"##idx1#948" + 0) - 1
                                                        if var"##mmax#952" ≤ var"##Mmax#951"
                                                            begin
                                                                begin
                                                                    var"##tmp#957" = var"##st#936"[var"##idx1#948" + 0, var"##i#955"]
                                                                    begin
                                                                        var"##st#936"[var"##idx1#948" + 0, var"##i#955"] = var"##st#936"[var"##idx1#948" + 0, var"##j#956"]
                                                                        var"##st#936"[var"##idx1#948" + 0, var"##j#956"] = var"##tmp#957"
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            for var"##idx3#950" = var"##idx1#948":var"##upperbound#953"
                                                                begin
                                                                    var"##tmp#960" = var"##st#936"[var"##idx3#950", var"##i#958"]
                                                                    begin
                                                                        var"##st#936"[var"##idx3#950", var"##i#958"] = var"##st#936"[var"##idx3#950", var"##j#959"]
                                                                        var"##st#936"[var"##idx3#950", var"##j#959"] = var"##tmp#960"
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    return var"##st#936"
                                end
                            end
                            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#941_1" = 0:var"##step_1_h#945":size(var"##st#936", 2) - var"##step_1_h#945"
                                    for var"##idx#941_2" = var"##idx#941_1":1:(var"##idx#941_1" + var"##step_1_l#944") - 1
                                        begin
                                            begin
                                                begin
                                                    var"##i#970" = (var"##idx#941_2" + 0) + 1
                                                    var"##j#971" = ((var"##idx#941_2" + 0) ⊻ var"##mask#954") + 1
                                                end
                                                if (BQCESubroutine.ismatch)(var"##idx#941_2" + 0, var"##ctrl_mask#946", var"##flag_mask#947")
                                                    var"##upperbound#966" = size(var"##st#936", 1)
                                                    var"##Mmax#964" = size(var"##st#936", 1) - 1
                                                    for var"##idx2#962" = 0:var"##Mmax#964" >>> 0
                                                        var"##idx1#961" = var"##idx2#962" << 0 + 1
                                                        var"##mmax#965" = (var"##idx1#961" + 0) - 1
                                                        if var"##mmax#965" ≤ var"##Mmax#964"
                                                            begin
                                                                begin
                                                                    var"##tmp#969" = var"##st#936"[var"##idx1#961" + 0, var"##i#967"]
                                                                    begin
                                                                        var"##st#936"[var"##idx1#961" + 0, var"##i#967"] = var"##st#936"[var"##idx1#961" + 0, var"##j#968"]
                                                                        var"##st#936"[var"##idx1#961" + 0, var"##j#968"] = var"##tmp#969"
                                                                    end
                                                                end
                                                            end
                                                        else
                                                            for var"##idx3#963" = var"##idx1#961":var"##upperbound#966"
                                                                begin
                                                                    var"##tmp#972" = var"##st#936"[var"##idx3#963", var"##i#970"]
                                                                    begin
                                                                        var"##st#936"[var"##idx3#963", var"##i#970"] = var"##st#936"[var"##idx3#963", var"##j#971"]
                                                                        var"##st#936"[var"##idx3#963", var"##j#971"] = var"##tmp#972"
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
                        return var"##st#936"
                    end
                    begin
                        var"##m#943" = Base.max(0, (var"##nqubits#939" - var"##nlocs_needed#940") - 1)
                        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:512 =# Threads.@threads for var"##base#942" = (BQCESubroutine.bsubspace)(var"##nqubits#939", (1:var"##m#943"..., var"##plain_locs#938"...))
                                for var"##idx#941_1" = 0:1 << var"##m#943" - 1
                                    begin
                                        begin
                                            var"##i#982" = (var"##base#942" + var"##idx#941_1") + 1
                                            var"##j#983" = ((var"##base#942" + var"##idx#941_1") ⊻ var"##mask#954") + 1
                                        end
                                        if (BQCESubroutine.ismatch)(var"##base#942" + var"##idx#941_1", var"##ctrl_mask#946", var"##flag_mask#947")
                                            var"##upperbound#978" = size(var"##st#936", 1)
                                            var"##Mmax#976" = size(var"##st#936", 1) - 1
                                            for var"##idx2#974" = 0:var"##Mmax#976" >>> 0
                                                var"##idx1#973" = var"##idx2#974" << 0 + 1
                                                var"##mmax#977" = (var"##idx1#973" + 0) - 1
                                                if var"##mmax#977" ≤ var"##Mmax#976"
                                                    begin
                                                        begin
                                                            var"##tmp#981" = var"##st#936"[var"##idx1#973" + 0, var"##i#979"]
                                                            begin
                                                                var"##st#936"[var"##idx1#973" + 0, var"##i#979"] = var"##st#936"[var"##idx1#973" + 0, var"##j#980"]
                                                                var"##st#936"[var"##idx1#973" + 0, var"##j#980"] = var"##tmp#981"
                                                            end
                                                        end
                                                    end
                                                else
                                                    for var"##idx3#975" = var"##idx1#973":var"##upperbound#978"
                                                        begin
                                                            var"##tmp#984" = var"##st#936"[var"##idx3#975", var"##i#982"]
                                                            begin
                                                                var"##st#936"[var"##idx3#975", var"##i#982"] = var"##st#936"[var"##idx3#975", var"##j#983"]
                                                                var"##st#936"[var"##idx3#975", var"##j#983"] = var"##tmp#984"
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
                    return var"##st#936"
                end)
    end
    return var"##st#936"
end