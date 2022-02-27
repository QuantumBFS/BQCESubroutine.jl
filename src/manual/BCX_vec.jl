function BQCESubroutine.broutine!(var"##st#522"::AbstractVector, ::Val{:X}, var"##locs#523"::Locations, var"##ctrl#353"::CtrlLocations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(var"##locs#523") == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(var"##st#522", Val{:X}(), var"##locs#523", var"##ctrl#353")
                BQCESubroutine.threaded_basic_broutine!(var"##st#522", Val{:X}(), var"##locs#523", var"##ctrl#353")
                return var"##st#522"
            end
        end
        begin
            length(var"##locs#523") == 1 || return BQCESubroutine.multi_broutine2x2!(var"##st#522", Val{:X}(), var"##locs#523", var"##ctrl#353")
            BQCESubroutine.basic_broutine!(var"##st#522", Val{:X}(), var"##locs#523", var"##ctrl#353")
            return var"##st#522"
        end
    end
    return var"##st#522"
end
function BQCESubroutine.basic_broutine!(var"##st#524"::AbstractVector, ::Val{:X}, var"##locs#525"::Locations, var"##ctrl#353"::CtrlLocations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#527" = (YaoLocations.plain)(var"##locs#525")
                var"##step_1_l#528" = 1 << (var"##plain_locs#527"[1] - 1)
                var"##step_1_h#529" = 1 << var"##plain_locs#527"[1]
                var"##ctrl_mask#532" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#353"))
                var"##flag_mask#533" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#353")
            end
            begin
            end
            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                        begin
                            if var"##step_1_l#528" == 1
                                for var"##m#526_1" = 0:var"##step_1_h#529":size(var"##st#524", 1) - var"##step_1_h#529"
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 0, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#530_1" = (var"##m#526_1" + 0) + 1
                                            var"##I#530_2" = ((var"##m#526_1" + 0) + var"##step_1_l#528") + 1
                                            var"##T#531_1" = var"##st#524"[var"##I#530_2"]
                                            var"##T#531_2" = var"##st#524"[var"##I#530_1"]
                                            var"##st#524"[var"##I#530_1"] = var"##T#531_1"
                                            var"##st#524"[var"##I#530_2"] = var"##T#531_2"
                                        end
                                    end
                                end
                                return var"##st#524"
                            end
                        end
                        begin
                            if var"##step_1_l#528" == 2
                                for var"##m#526_1" = 0:var"##step_1_h#529":size(var"##st#524", 1) - var"##step_1_h#529"
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 0, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#534_1" = (var"##m#526_1" + 0) + 1
                                            var"##I#534_2" = ((var"##m#526_1" + 0) + var"##step_1_l#528") + 1
                                            var"##T#535_1" = var"##st#524"[var"##I#534_2"]
                                            var"##T#535_2" = var"##st#524"[var"##I#534_1"]
                                            var"##st#524"[var"##I#534_1"] = var"##T#535_1"
                                            var"##st#524"[var"##I#534_2"] = var"##T#535_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 1, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#536_1" = (var"##m#526_1" + 1) + 1
                                            var"##I#536_2" = ((var"##m#526_1" + 1) + var"##step_1_l#528") + 1
                                            var"##T#537_1" = var"##st#524"[var"##I#536_2"]
                                            var"##T#537_2" = var"##st#524"[var"##I#536_1"]
                                            var"##st#524"[var"##I#536_1"] = var"##T#537_1"
                                            var"##st#524"[var"##I#536_2"] = var"##T#537_2"
                                        end
                                    end
                                end
                                return var"##st#524"
                            end
                        end
                        begin
                            if var"##step_1_l#528" == 4
                                for var"##m#526_1" = 0:var"##step_1_h#529":size(var"##st#524", 1) - var"##step_1_h#529"
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 0, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#538_1" = (var"##m#526_1" + 0) + 1
                                            var"##I#538_2" = ((var"##m#526_1" + 0) + var"##step_1_l#528") + 1
                                            var"##T#539_1" = var"##st#524"[var"##I#538_2"]
                                            var"##T#539_2" = var"##st#524"[var"##I#538_1"]
                                            var"##st#524"[var"##I#538_1"] = var"##T#539_1"
                                            var"##st#524"[var"##I#538_2"] = var"##T#539_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 1, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#540_1" = (var"##m#526_1" + 1) + 1
                                            var"##I#540_2" = ((var"##m#526_1" + 1) + var"##step_1_l#528") + 1
                                            var"##T#541_1" = var"##st#524"[var"##I#540_2"]
                                            var"##T#541_2" = var"##st#524"[var"##I#540_1"]
                                            var"##st#524"[var"##I#540_1"] = var"##T#541_1"
                                            var"##st#524"[var"##I#540_2"] = var"##T#541_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 2, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#542_1" = (var"##m#526_1" + 2) + 1
                                            var"##I#542_2" = ((var"##m#526_1" + 2) + var"##step_1_l#528") + 1
                                            var"##T#543_1" = var"##st#524"[var"##I#542_2"]
                                            var"##T#543_2" = var"##st#524"[var"##I#542_1"]
                                            var"##st#524"[var"##I#542_1"] = var"##T#543_1"
                                            var"##st#524"[var"##I#542_2"] = var"##T#543_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 3, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#544_1" = (var"##m#526_1" + 3) + 1
                                            var"##I#544_2" = ((var"##m#526_1" + 3) + var"##step_1_l#528") + 1
                                            var"##T#545_1" = var"##st#524"[var"##I#544_2"]
                                            var"##T#545_2" = var"##st#524"[var"##I#544_1"]
                                            var"##st#524"[var"##I#544_1"] = var"##T#545_1"
                                            var"##st#524"[var"##I#544_2"] = var"##T#545_2"
                                        end
                                    end
                                end
                                return var"##st#524"
                            end
                        end
                        begin
                            if var"##step_1_l#528" == 8
                                for var"##m#526_1" = 0:var"##step_1_h#529":size(var"##st#524", 1) - var"##step_1_h#529"
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 0, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#546_1" = (var"##m#526_1" + 0) + 1
                                            var"##I#546_2" = ((var"##m#526_1" + 0) + var"##step_1_l#528") + 1
                                            var"##T#547_1" = var"##st#524"[var"##I#546_2"]
                                            var"##T#547_2" = var"##st#524"[var"##I#546_1"]
                                            var"##st#524"[var"##I#546_1"] = var"##T#547_1"
                                            var"##st#524"[var"##I#546_2"] = var"##T#547_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 1, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#548_1" = (var"##m#526_1" + 1) + 1
                                            var"##I#548_2" = ((var"##m#526_1" + 1) + var"##step_1_l#528") + 1
                                            var"##T#549_1" = var"##st#524"[var"##I#548_2"]
                                            var"##T#549_2" = var"##st#524"[var"##I#548_1"]
                                            var"##st#524"[var"##I#548_1"] = var"##T#549_1"
                                            var"##st#524"[var"##I#548_2"] = var"##T#549_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 2, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#550_1" = (var"##m#526_1" + 2) + 1
                                            var"##I#550_2" = ((var"##m#526_1" + 2) + var"##step_1_l#528") + 1
                                            var"##T#551_1" = var"##st#524"[var"##I#550_2"]
                                            var"##T#551_2" = var"##st#524"[var"##I#550_1"]
                                            var"##st#524"[var"##I#550_1"] = var"##T#551_1"
                                            var"##st#524"[var"##I#550_2"] = var"##T#551_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 3, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#552_1" = (var"##m#526_1" + 3) + 1
                                            var"##I#552_2" = ((var"##m#526_1" + 3) + var"##step_1_l#528") + 1
                                            var"##T#553_1" = var"##st#524"[var"##I#552_2"]
                                            var"##T#553_2" = var"##st#524"[var"##I#552_1"]
                                            var"##st#524"[var"##I#552_1"] = var"##T#553_1"
                                            var"##st#524"[var"##I#552_2"] = var"##T#553_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 4, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#554_1" = (var"##m#526_1" + 4) + 1
                                            var"##I#554_2" = ((var"##m#526_1" + 4) + var"##step_1_l#528") + 1
                                            var"##T#555_1" = var"##st#524"[var"##I#554_2"]
                                            var"##T#555_2" = var"##st#524"[var"##I#554_1"]
                                            var"##st#524"[var"##I#554_1"] = var"##T#555_1"
                                            var"##st#524"[var"##I#554_2"] = var"##T#555_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 5, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#556_1" = (var"##m#526_1" + 5) + 1
                                            var"##I#556_2" = ((var"##m#526_1" + 5) + var"##step_1_l#528") + 1
                                            var"##T#557_1" = var"##st#524"[var"##I#556_2"]
                                            var"##T#557_2" = var"##st#524"[var"##I#556_1"]
                                            var"##st#524"[var"##I#556_1"] = var"##T#557_1"
                                            var"##st#524"[var"##I#556_2"] = var"##T#557_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 6, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#558_1" = (var"##m#526_1" + 6) + 1
                                            var"##I#558_2" = ((var"##m#526_1" + 6) + var"##step_1_l#528") + 1
                                            var"##T#559_1" = var"##st#524"[var"##I#558_2"]
                                            var"##T#559_2" = var"##st#524"[var"##I#558_1"]
                                            var"##st#524"[var"##I#558_1"] = var"##T#559_1"
                                            var"##st#524"[var"##I#558_2"] = var"##T#559_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_1" + 7, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#560_1" = (var"##m#526_1" + 7) + 1
                                            var"##I#560_2" = ((var"##m#526_1" + 7) + var"##step_1_l#528") + 1
                                            var"##T#561_1" = var"##st#524"[var"##I#560_2"]
                                            var"##T#561_2" = var"##st#524"[var"##I#560_1"]
                                            var"##st#524"[var"##I#560_1"] = var"##T#561_1"
                                            var"##st#524"[var"##I#560_2"] = var"##T#561_2"
                                        end
                                    end
                                end
                                return var"##st#524"
                            end
                        end
                        for var"##m#526_1" = 0:var"##step_1_h#529":size(var"##st#524", 1) - var"##step_1_h#529"
                            for var"##m#526_2" = var"##m#526_1":8:(var"##m#526_1" + var"##step_1_l#528") - 1
                                begin
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 0, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#562_1" = (var"##m#526_2" + 0) + 1
                                            var"##I#562_2" = ((var"##m#526_2" + 0) + var"##step_1_l#528") + 1
                                            var"##T#563_1" = var"##st#524"[var"##I#562_2"]
                                            var"##T#563_2" = var"##st#524"[var"##I#562_1"]
                                            var"##st#524"[var"##I#562_1"] = var"##T#563_1"
                                            var"##st#524"[var"##I#562_2"] = var"##T#563_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 1, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#564_1" = (var"##m#526_2" + 1) + 1
                                            var"##I#564_2" = ((var"##m#526_2" + 1) + var"##step_1_l#528") + 1
                                            var"##T#565_1" = var"##st#524"[var"##I#564_2"]
                                            var"##T#565_2" = var"##st#524"[var"##I#564_1"]
                                            var"##st#524"[var"##I#564_1"] = var"##T#565_1"
                                            var"##st#524"[var"##I#564_2"] = var"##T#565_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 2, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#566_1" = (var"##m#526_2" + 2) + 1
                                            var"##I#566_2" = ((var"##m#526_2" + 2) + var"##step_1_l#528") + 1
                                            var"##T#567_1" = var"##st#524"[var"##I#566_2"]
                                            var"##T#567_2" = var"##st#524"[var"##I#566_1"]
                                            var"##st#524"[var"##I#566_1"] = var"##T#567_1"
                                            var"##st#524"[var"##I#566_2"] = var"##T#567_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 3, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#568_1" = (var"##m#526_2" + 3) + 1
                                            var"##I#568_2" = ((var"##m#526_2" + 3) + var"##step_1_l#528") + 1
                                            var"##T#569_1" = var"##st#524"[var"##I#568_2"]
                                            var"##T#569_2" = var"##st#524"[var"##I#568_1"]
                                            var"##st#524"[var"##I#568_1"] = var"##T#569_1"
                                            var"##st#524"[var"##I#568_2"] = var"##T#569_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 4, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#570_1" = (var"##m#526_2" + 4) + 1
                                            var"##I#570_2" = ((var"##m#526_2" + 4) + var"##step_1_l#528") + 1
                                            var"##T#571_1" = var"##st#524"[var"##I#570_2"]
                                            var"##T#571_2" = var"##st#524"[var"##I#570_1"]
                                            var"##st#524"[var"##I#570_1"] = var"##T#571_1"
                                            var"##st#524"[var"##I#570_2"] = var"##T#571_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 5, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#572_1" = (var"##m#526_2" + 5) + 1
                                            var"##I#572_2" = ((var"##m#526_2" + 5) + var"##step_1_l#528") + 1
                                            var"##T#573_1" = var"##st#524"[var"##I#572_2"]
                                            var"##T#573_2" = var"##st#524"[var"##I#572_1"]
                                            var"##st#524"[var"##I#572_1"] = var"##T#573_1"
                                            var"##st#524"[var"##I#572_2"] = var"##T#573_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 6, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#574_1" = (var"##m#526_2" + 6) + 1
                                            var"##I#574_2" = ((var"##m#526_2" + 6) + var"##step_1_l#528") + 1
                                            var"##T#575_1" = var"##st#524"[var"##I#574_2"]
                                            var"##T#575_2" = var"##st#524"[var"##I#574_1"]
                                            var"##st#524"[var"##I#574_1"] = var"##T#575_1"
                                            var"##st#524"[var"##I#574_2"] = var"##T#575_2"
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(var"##m#526_2" + 7, var"##ctrl_mask#532", var"##flag_mask#533")
                                            var"##I#576_1" = (var"##m#526_2" + 7) + 1
                                            var"##I#576_2" = ((var"##m#526_2" + 7) + var"##step_1_l#528") + 1
                                            var"##T#577_1" = var"##st#524"[var"##I#576_2"]
                                            var"##T#577_2" = var"##st#524"[var"##I#576_1"]
                                            var"##st#524"[var"##I#576_1"] = var"##T#577_1"
                                            var"##st#524"[var"##I#576_2"] = var"##T#577_2"
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return var"##st#524"
end
function BQCESubroutine.multi_broutine2x2!(var"##st#578"::AbstractVector, ::Val{:X}, var"##locs#579"::Locations, var"##ctrl#353"::CtrlLocations)
    begin
        begin
            var"##plain_locs#581" = (YaoLocations.plain)(var"##locs#579")
            var"##step_1_l#582" = 1 << (var"##plain_locs#581"[1] - 1)
            var"##step_1_h#583" = 1 << var"##plain_locs#581"[1]
            var"##ctrl_mask#584" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#353"))
            var"##flag_mask#585" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#353")
            var"##mask#586" = (BQCESubroutine.bmask)(var"##plain_locs#581")
        end
        begin
        end
        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                    begin
                        if var"##step_1_l#582" == 1
                            for var"##m#580_1" = 0:var"##step_1_h#583":size(var"##st#578", 1) - var"##step_1_h#583"
                                begin
                                    begin
                                        var"##i#587" = (var"##m#580_1" + 0) + 1
                                        var"##j#588" = ((var"##m#580_1" + 0) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 0, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#589" = var"##st#578"[var"##i#587"]
                                        begin
                                            var"##st#578"[var"##i#587"] = var"##st#578"[var"##j#588"]
                                            var"##st#578"[var"##j#588"] = var"##tmp#589"
                                        end
                                    end
                                end
                            end
                            return var"##st#578"
                        end
                    end
                    begin
                        if var"##step_1_l#582" == 2
                            for var"##m#580_1" = 0:var"##step_1_h#583":size(var"##st#578", 1) - var"##step_1_h#583"
                                begin
                                    begin
                                        var"##i#590" = (var"##m#580_1" + 0) + 1
                                        var"##j#591" = ((var"##m#580_1" + 0) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 0, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#592" = var"##st#578"[var"##i#590"]
                                        begin
                                            var"##st#578"[var"##i#590"] = var"##st#578"[var"##j#591"]
                                            var"##st#578"[var"##j#591"] = var"##tmp#592"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#593" = (var"##m#580_1" + 1) + 1
                                        var"##j#594" = ((var"##m#580_1" + 1) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 1, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#595" = var"##st#578"[var"##i#593"]
                                        begin
                                            var"##st#578"[var"##i#593"] = var"##st#578"[var"##j#594"]
                                            var"##st#578"[var"##j#594"] = var"##tmp#595"
                                        end
                                    end
                                end
                            end
                            return var"##st#578"
                        end
                    end
                    begin
                        if var"##step_1_l#582" == 4
                            for var"##m#580_1" = 0:var"##step_1_h#583":size(var"##st#578", 1) - var"##step_1_h#583"
                                begin
                                    begin
                                        var"##i#596" = (var"##m#580_1" + 0) + 1
                                        var"##j#597" = ((var"##m#580_1" + 0) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 0, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#598" = var"##st#578"[var"##i#596"]
                                        begin
                                            var"##st#578"[var"##i#596"] = var"##st#578"[var"##j#597"]
                                            var"##st#578"[var"##j#597"] = var"##tmp#598"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#599" = (var"##m#580_1" + 1) + 1
                                        var"##j#600" = ((var"##m#580_1" + 1) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 1, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#601" = var"##st#578"[var"##i#599"]
                                        begin
                                            var"##st#578"[var"##i#599"] = var"##st#578"[var"##j#600"]
                                            var"##st#578"[var"##j#600"] = var"##tmp#601"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#602" = (var"##m#580_1" + 2) + 1
                                        var"##j#603" = ((var"##m#580_1" + 2) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 2, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#604" = var"##st#578"[var"##i#602"]
                                        begin
                                            var"##st#578"[var"##i#602"] = var"##st#578"[var"##j#603"]
                                            var"##st#578"[var"##j#603"] = var"##tmp#604"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#605" = (var"##m#580_1" + 3) + 1
                                        var"##j#606" = ((var"##m#580_1" + 3) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 3, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#607" = var"##st#578"[var"##i#605"]
                                        begin
                                            var"##st#578"[var"##i#605"] = var"##st#578"[var"##j#606"]
                                            var"##st#578"[var"##j#606"] = var"##tmp#607"
                                        end
                                    end
                                end
                            end
                            return var"##st#578"
                        end
                    end
                    begin
                        if var"##step_1_l#582" == 8
                            for var"##m#580_1" = 0:var"##step_1_h#583":size(var"##st#578", 1) - var"##step_1_h#583"
                                begin
                                    begin
                                        var"##i#608" = (var"##m#580_1" + 0) + 1
                                        var"##j#609" = ((var"##m#580_1" + 0) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 0, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#610" = var"##st#578"[var"##i#608"]
                                        begin
                                            var"##st#578"[var"##i#608"] = var"##st#578"[var"##j#609"]
                                            var"##st#578"[var"##j#609"] = var"##tmp#610"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#611" = (var"##m#580_1" + 1) + 1
                                        var"##j#612" = ((var"##m#580_1" + 1) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 1, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#613" = var"##st#578"[var"##i#611"]
                                        begin
                                            var"##st#578"[var"##i#611"] = var"##st#578"[var"##j#612"]
                                            var"##st#578"[var"##j#612"] = var"##tmp#613"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#614" = (var"##m#580_1" + 2) + 1
                                        var"##j#615" = ((var"##m#580_1" + 2) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 2, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#616" = var"##st#578"[var"##i#614"]
                                        begin
                                            var"##st#578"[var"##i#614"] = var"##st#578"[var"##j#615"]
                                            var"##st#578"[var"##j#615"] = var"##tmp#616"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#617" = (var"##m#580_1" + 3) + 1
                                        var"##j#618" = ((var"##m#580_1" + 3) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 3, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#619" = var"##st#578"[var"##i#617"]
                                        begin
                                            var"##st#578"[var"##i#617"] = var"##st#578"[var"##j#618"]
                                            var"##st#578"[var"##j#618"] = var"##tmp#619"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#620" = (var"##m#580_1" + 4) + 1
                                        var"##j#621" = ((var"##m#580_1" + 4) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 4, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#622" = var"##st#578"[var"##i#620"]
                                        begin
                                            var"##st#578"[var"##i#620"] = var"##st#578"[var"##j#621"]
                                            var"##st#578"[var"##j#621"] = var"##tmp#622"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#623" = (var"##m#580_1" + 5) + 1
                                        var"##j#624" = ((var"##m#580_1" + 5) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 5, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#625" = var"##st#578"[var"##i#623"]
                                        begin
                                            var"##st#578"[var"##i#623"] = var"##st#578"[var"##j#624"]
                                            var"##st#578"[var"##j#624"] = var"##tmp#625"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#626" = (var"##m#580_1" + 6) + 1
                                        var"##j#627" = ((var"##m#580_1" + 6) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 6, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#628" = var"##st#578"[var"##i#626"]
                                        begin
                                            var"##st#578"[var"##i#626"] = var"##st#578"[var"##j#627"]
                                            var"##st#578"[var"##j#627"] = var"##tmp#628"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#629" = (var"##m#580_1" + 7) + 1
                                        var"##j#630" = ((var"##m#580_1" + 7) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_1" + 7, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#631" = var"##st#578"[var"##i#629"]
                                        begin
                                            var"##st#578"[var"##i#629"] = var"##st#578"[var"##j#630"]
                                            var"##st#578"[var"##j#630"] = var"##tmp#631"
                                        end
                                    end
                                end
                            end
                            return var"##st#578"
                        end
                    end
                    for var"##m#580_1" = 0:var"##step_1_h#583":size(var"##st#578", 1) - var"##step_1_h#583"
                        for var"##m#580_2" = var"##m#580_1":8:(var"##m#580_1" + var"##step_1_l#582") - 1
                            begin
                                begin
                                    begin
                                        var"##i#632" = (var"##m#580_2" + 0) + 1
                                        var"##j#633" = ((var"##m#580_2" + 0) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 0, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#634" = var"##st#578"[var"##i#632"]
                                        begin
                                            var"##st#578"[var"##i#632"] = var"##st#578"[var"##j#633"]
                                            var"##st#578"[var"##j#633"] = var"##tmp#634"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#635" = (var"##m#580_2" + 1) + 1
                                        var"##j#636" = ((var"##m#580_2" + 1) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 1, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#637" = var"##st#578"[var"##i#635"]
                                        begin
                                            var"##st#578"[var"##i#635"] = var"##st#578"[var"##j#636"]
                                            var"##st#578"[var"##j#636"] = var"##tmp#637"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#638" = (var"##m#580_2" + 2) + 1
                                        var"##j#639" = ((var"##m#580_2" + 2) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 2, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#640" = var"##st#578"[var"##i#638"]
                                        begin
                                            var"##st#578"[var"##i#638"] = var"##st#578"[var"##j#639"]
                                            var"##st#578"[var"##j#639"] = var"##tmp#640"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#641" = (var"##m#580_2" + 3) + 1
                                        var"##j#642" = ((var"##m#580_2" + 3) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 3, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#643" = var"##st#578"[var"##i#641"]
                                        begin
                                            var"##st#578"[var"##i#641"] = var"##st#578"[var"##j#642"]
                                            var"##st#578"[var"##j#642"] = var"##tmp#643"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#644" = (var"##m#580_2" + 4) + 1
                                        var"##j#645" = ((var"##m#580_2" + 4) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 4, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#646" = var"##st#578"[var"##i#644"]
                                        begin
                                            var"##st#578"[var"##i#644"] = var"##st#578"[var"##j#645"]
                                            var"##st#578"[var"##j#645"] = var"##tmp#646"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#647" = (var"##m#580_2" + 5) + 1
                                        var"##j#648" = ((var"##m#580_2" + 5) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 5, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#649" = var"##st#578"[var"##i#647"]
                                        begin
                                            var"##st#578"[var"##i#647"] = var"##st#578"[var"##j#648"]
                                            var"##st#578"[var"##j#648"] = var"##tmp#649"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#650" = (var"##m#580_2" + 6) + 1
                                        var"##j#651" = ((var"##m#580_2" + 6) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 6, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#652" = var"##st#578"[var"##i#650"]
                                        begin
                                            var"##st#578"[var"##i#650"] = var"##st#578"[var"##j#651"]
                                            var"##st#578"[var"##j#651"] = var"##tmp#652"
                                        end
                                    end
                                end
                                begin
                                    begin
                                        var"##i#653" = (var"##m#580_2" + 7) + 1
                                        var"##j#654" = ((var"##m#580_2" + 7) ⊻ var"##mask#586") + 1
                                    end
                                    if (BQCESubroutine.ismatch)(var"##m#580_2" + 7, var"##ctrl_mask#584", var"##flag_mask#585")
                                        var"##tmp#655" = var"##st#578"[var"##i#653"]
                                        begin
                                            var"##st#578"[var"##i#653"] = var"##st#578"[var"##j#654"]
                                            var"##st#578"[var"##j#654"] = var"##tmp#655"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
    end
    return var"##st#578"
end
function BQCESubroutine.threaded_basic_broutine!(var"##st#658"::AbstractVector, ::Val{:X}, var"##locs#659"::Locations, var"##ctrl#353"::CtrlLocations)
    begin
        nothing
        begin
            begin
                var"##plain_locs#660" = (YaoLocations.plain)(var"##locs#659")
                var"##nqubits#661" = (BQCESubroutine.log2i)(size(var"##st#658", 1))
                var"##nlocs_needed#662" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                var"##step_1_l#666" = 1 << (var"##plain_locs#660"[1] - 1)
                var"##step_1_h#667" = 1 << var"##plain_locs#660"[1]
                var"##ctrl_mask#670" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#353"))
                var"##flag_mask#671" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#353")
            end
            begin
            end
            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                        if var"##nlocs_needed#662" ≤ var"##nqubits#661" - var"##plain_locs#660"[1]
                            begin
                                begin
                                    if var"##step_1_l#666" == 1
                                        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#663_1" = 0:var"##step_1_h#667":size(var"##st#658", 1) - var"##step_1_h#667"
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(var"##idx#663_1" + 0, var"##ctrl_mask#670", var"##flag_mask#671")
                                                        var"##I#668_1" = (var"##idx#663_1" + 0) + 1
                                                        var"##I#668_2" = ((var"##idx#663_1" + 0) + var"##step_1_l#666") + 1
                                                        var"##T#669_1" = var"##st#658"[var"##I#668_2"]
                                                        var"##T#669_2" = var"##st#658"[var"##I#668_1"]
                                                        var"##st#658"[var"##I#668_1"] = var"##T#669_1"
                                                        var"##st#658"[var"##I#668_2"] = var"##T#669_2"
                                                    end
                                                end
                                            end
                                        return var"##st#658"
                                    end
                                end
                                #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#663_1" = 0:var"##step_1_h#667":size(var"##st#658", 1) - var"##step_1_h#667"
                                        for var"##idx#663_2" = var"##idx#663_1":1:(var"##idx#663_1" + var"##step_1_l#666") - 1
                                            begin
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(var"##idx#663_2" + 0, var"##ctrl_mask#670", var"##flag_mask#671")
                                                        var"##I#672_1" = (var"##idx#663_2" + 0) + 1
                                                        var"##I#672_2" = ((var"##idx#663_2" + 0) + var"##step_1_l#666") + 1
                                                        var"##T#673_1" = var"##st#658"[var"##I#672_2"]
                                                        var"##T#673_2" = var"##st#658"[var"##I#672_1"]
                                                        var"##st#658"[var"##I#672_1"] = var"##T#673_1"
                                                        var"##st#658"[var"##I#672_2"] = var"##T#673_2"
                                                    end
                                                end
                                            end
                                        end
                                    end
                            end
                            return var"##st#658"
                        end
                        begin
                            var"##m#665" = Base.max(0, (var"##nqubits#661" - var"##nlocs_needed#662") - 1)
                            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:512 =# Threads.@threads for var"##base#664" = (BQCESubroutine.bsubspace)(var"##nqubits#661", (1:var"##m#665"..., var"##plain_locs#660"...))
                                    for var"##idx#663_1" = 0:1 << var"##m#665" - 1
                                        begin
                                            nothing
                                            if (BQCESubroutine.ismatch)(var"##base#664" + var"##idx#663_1", var"##ctrl_mask#670", var"##flag_mask#671")
                                                var"##I#674_1" = (var"##base#664" + var"##idx#663_1") + 1
                                                var"##I#674_2" = ((var"##base#664" + var"##idx#663_1") + var"##step_1_l#666") + 1
                                                var"##T#675_1" = var"##st#658"[var"##I#674_2"]
                                                var"##T#675_2" = var"##st#658"[var"##I#674_1"]
                                                var"##st#658"[var"##I#674_1"] = var"##T#675_1"
                                                var"##st#658"[var"##I#674_2"] = var"##T#675_2"
                                            end
                                        end
                                    end
                                end
                        end
                        return var"##st#658"
                    end)
        end
    end
    return var"##st#658"
end
function BQCESubroutine.threaded_multi_broutine2x2!(var"##st#676"::AbstractVector, ::Val{:X}, var"##locs#677"::Locations, var"##ctrl#353"::CtrlLocations)
    begin
        begin
            var"##plain_locs#678" = (YaoLocations.plain)(var"##locs#677")
            var"##nqubits#679" = (BQCESubroutine.log2i)(size(var"##st#676", 1))
            var"##nlocs_needed#680" = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
            var"##step_1_l#684" = 1 << (var"##plain_locs#678"[1] - 1)
            var"##step_1_h#685" = 1 << var"##plain_locs#678"[1]
            var"##ctrl_mask#686" = (BQCESubroutine.bmask)((YaoLocations.plain)(var"##ctrl#353"))
            var"##flag_mask#687" = (BQCESubroutine.ctrl_flag_mask)(var"##ctrl#353")
            var"##mask#688" = (BQCESubroutine.bmask)(var"##plain_locs#678")
        end
        begin
        end
        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:727 =# @fastmath #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:726 =# @inbounds(begin
                    if var"##nlocs_needed#680" ≤ var"##nqubits#679" - var"##plain_locs#678"[1]
                        begin
                            begin
                                if var"##step_1_l#684" == 1
                                    #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#681_1" = 0:var"##step_1_h#685":size(var"##st#676", 1) - var"##step_1_h#685"
                                            begin
                                                begin
                                                    var"##i#689" = (var"##idx#681_1" + 0) + 1
                                                    var"##j#690" = ((var"##idx#681_1" + 0) ⊻ var"##mask#688") + 1
                                                end
                                                if (BQCESubroutine.ismatch)(var"##idx#681_1" + 0, var"##ctrl_mask#686", var"##flag_mask#687")
                                                    var"##tmp#691" = var"##st#676"[var"##i#689"]
                                                    begin
                                                        var"##st#676"[var"##i#689"] = var"##st#676"[var"##j#690"]
                                                        var"##st#676"[var"##j#690"] = var"##tmp#691"
                                                    end
                                                end
                                            end
                                        end
                                    return var"##st#676"
                                end
                            end
                            #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:472 =# @batch for var"##idx#681_1" = 0:var"##step_1_h#685":size(var"##st#676", 1) - var"##step_1_h#685"
                                    for var"##idx#681_2" = var"##idx#681_1":1:(var"##idx#681_1" + var"##step_1_l#684") - 1
                                        begin
                                            begin
                                                begin
                                                    var"##i#692" = (var"##idx#681_2" + 0) + 1
                                                    var"##j#693" = ((var"##idx#681_2" + 0) ⊻ var"##mask#688") + 1
                                                end
                                                if (BQCESubroutine.ismatch)(var"##idx#681_2" + 0, var"##ctrl_mask#686", var"##flag_mask#687")
                                                    var"##tmp#694" = var"##st#676"[var"##i#692"]
                                                    begin
                                                        var"##st#676"[var"##i#692"] = var"##st#676"[var"##j#693"]
                                                        var"##st#676"[var"##j#693"] = var"##tmp#694"
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                        end
                        return var"##st#676"
                    end
                    begin
                        var"##m#683" = Base.max(0, (var"##nqubits#679" - var"##nlocs_needed#680") - 1)
                        #= /home/czhao/.julia/dev/BQCESubroutine/src/codegen/broutine.jl:512 =# Threads.@threads for var"##base#682" = (BQCESubroutine.bsubspace)(var"##nqubits#679", (1:var"##m#683"..., var"##plain_locs#678"...))
                                for var"##idx#681_1" = 0:1 << var"##m#683" - 1
                                    begin
                                        begin
                                            var"##i#695" = (var"##base#682" + var"##idx#681_1") + 1
                                            var"##j#696" = ((var"##base#682" + var"##idx#681_1") ⊻ var"##mask#688") + 1
                                        end
                                        if (BQCESubroutine.ismatch)(var"##base#682" + var"##idx#681_1", var"##ctrl_mask#686", var"##flag_mask#687")
                                            var"##tmp#697" = var"##st#676"[var"##i#695"]
                                            begin
                                                var"##st#676"[var"##i#695"] = var"##st#676"[var"##j#696"]
                                                var"##st#676"[var"##j#696"] = var"##tmp#697"
                                            end
                                        end
                                    end
                                end
                            end
                    end
                    return var"##st#676"
                end)
    end
    return var"##st#676"
end
