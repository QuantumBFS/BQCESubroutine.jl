using BQCESubroutine
using YaoLocations
using Polyester
using BQCESubroutine: broutine!
using YaoLocations: Locations

function BQCESubroutine.broutine!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(locs) == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(st, Val{:Z}(), locs)
                @assert length(locs) == 1 "number of locations mismatch operator size"
                BQCESubroutine.threaded_basic_broutine!(st, Val{:Z}(), locs)
                return st
            end
        end
        begin
            length(locs) == 1 || return BQCESubroutine.multi_broutine2x2!(st, Val{:Z}(), locs)
            @assert length(locs) == 1 "number of locations mismatch operator size"
            BQCESubroutine.basic_broutine!(st, Val{:Z}(), locs)
            return st
        end
    end
    return st
end
function BQCESubroutine.basic_broutine!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
            end
            begin
            end
            @fastmath @inbounds(begin
                        begin
                            if step_1_l == 1
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        begin
                            if step_1_l == 2
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        begin
                            if step_1_l == 4
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 2) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 3) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        begin
                            if step_1_l == 8
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 2) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 3) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 4) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 5) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 6) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 7) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        for m = 0:step_1_h:size(st, 1) - step_1_h
                            for m = m:8:(m + step_1_l) - 1
                                begin
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 2) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 3) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 4) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 5) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 6) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        begin
                                            I = ((m + 7) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return st
end
function BQCESubroutine.multi_broutine2x2!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        begin
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(begin
                    if size(st, 1) > 8
                        begin
                            upperbound = size(st, 1) - 1
                            Mmax = (size(st, 1) - 1) - 0
                            for idx2 = 0:Mmax >>> 3
                                idx1 = idx2 << 3 + 0
                                mmax = (idx1 + 7) - 0
                                if mmax ≤ Mmax
                                    begin
                                        begin
                                            begin
                                                k = count_ones((idx1 + 0) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 0) + 1] = -(st[(idx1 + 0) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 1) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 1) + 1] = -(st[(idx1 + 1) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 2) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 2) + 1] = -(st[(idx1 + 2) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 3) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 3) + 1] = -(st[(idx1 + 3) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 4) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 4) + 1] = -(st[(idx1 + 4) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 5) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 5) + 1] = -(st[(idx1 + 5) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 6) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 6) + 1] = -(st[(idx1 + 6) + 1]))
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 7) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[(idx1 + 7) + 1] = -(st[(idx1 + 7) + 1]))
                                        end
                                    end
                                else
                                    for idx3 = idx1:upperbound
                                        begin
                                            begin
                                                k = count_ones(idx3 & mask)
                                                isodd_k = isodd(k)
                                            end
                                            isodd_k && (st[idx3 + 1] = -(st[idx3 + 1]))
                                        end
                                    end
                                end
                            end
                        end
                    else
                        for m = 0:size(st, 1) - 1
                            begin
                                k = count_ones(m & mask)
                                isodd_k = isodd(k)
                            end
                            isodd_k && (st[m + 1] = -(st[m + 1]))
                        end
                    end
                end)
    end
    return st
end
function BQCESubroutine.threaded_basic_broutine!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                nqubits = (BQCESubroutine.log2i)(size(st, 1))
                nlocs_needed = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
            end
            begin
            end
            @fastmath @inbounds(begin
                        if nlocs_needed ≤ nqubits - plain_locs[1]
                            begin
                                begin
                                    if step_1_l == 1
                                        Threads.@threads for idx = 0:step_1_h:size(st, 1) - step_1_h
                                                begin
                                                    nothing
                                                    begin
                                                        I = ((idx + 0) + step_1_l) + 1
                                                        T = -(st[I])
                                                        st[I] = T
                                                    end
                                                end
                                            end
                                        return st
                                    end
                                end
                                Threads.@threads for idx = 0:step_1_h:size(st, 1) - step_1_h
                                        for idx = idx:1:(idx + step_1_l) - 1
                                            begin
                                                begin
                                                    nothing
                                                    begin
                                                        I = ((idx + 0) + step_1_l) + 1
                                                        T = -(st[I])
                                                        st[I] = T
                                                    end
                                                end
                                            end
                                        end
                                    end
                            end
                            return st
                        end
                        begin
                            m = (nqubits - nlocs_needed) - 1
                            Threads.@threads for base = (BQCESubroutine.bsubspace)(nqubits, (1:m..., plain_locs...))
                                    for idx = 0:1 << m - 1
                                        begin
                                            nothing
                                            begin
                                                I = ((base + idx) + step_1_l) + 1
                                                T = -(st[I])
                                                st[I] = T
                                            end
                                        end
                                    end
                                end
                        end
                        return st
                    end)
        end
    end
    return st
end
function BQCESubroutine.threaded_multi_broutine2x2!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        begin
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(begin
                    if size(st, 1) > Threads.nthreads() * 1
                        begin
                            upperbound = size(st, 1) - 1
                            Mmax = (size(st, 1) - 1) - 0
                            Threads.@threads for idx2 = 0:Mmax >>> 0
                                    idx1 = idx2 << 0 + 0
                                    mmax = (idx1 + 0) - 0
                                    if mmax ≤ Mmax
                                        begin
                                            begin
                                                begin
                                                    k = count_ones((idx1 + 0) & mask)
                                                    isodd_k = isodd(k)
                                                end
                                                isodd_k && (st[(idx1 + 0) + 1] = -(st[(idx1 + 0) + 1]))
                                            end
                                        end
                                    else
                                        for idx3 = idx1:upperbound
                                            begin
                                                begin
                                                    k = count_ones(idx3 & mask)
                                                    isodd_k = isodd(k)
                                                end
                                                isodd_k && (st[idx3 + 1] = -(st[idx3 + 1]))
                                            end
                                        end
                                    end
                                end
                        end
                    else
                        Threads.@threads for m = 0:size(st, 1) - 1
                                begin
                                    begin
                                        k = count_ones(m & mask)
                                        isodd_k = isodd(k)
                                    end
                                    isodd_k && (st[m + 1] = -(st[m + 1]))
                                end
                            end
                    end
                end)
    end
    return st
end

function polyester_multi_broutine2x2!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        begin
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(begin
                    if size(st, 1) > Threads.nthreads() * 1
                        begin
                            upperbound = size(st, 1) - 1
                            Mmax = (size(st, 1) - 1) - 0
                            @batch for idx2 = 0:Mmax >>> 0
                                    idx1 = idx2 << 0 + 0
                                    mmax = (idx1 + 0) - 0
                                    if mmax ≤ Mmax
                                        begin
                                            begin
                                                begin
                                                    k = count_ones((idx1 + 0) & mask)
                                                    isodd_k = isodd(k)
                                                end
                                                isodd_k && (st[(idx1 + 0) + 1] = -(st[(idx1 + 0) + 1]))
                                            end
                                        end
                                    else
                                        for idx3 = idx1:upperbound
                                            begin
                                                begin
                                                    k = count_ones(idx3 & mask)
                                                    isodd_k = isodd(k)
                                                end
                                                isodd_k && (st[idx3 + 1] = -(st[idx3 + 1]))
                                            end
                                        end
                                    end
                                end
                        end
                    else
                        Threads.@threads for m = 0:size(st, 1) - 1
                                begin
                                    begin
                                        k = count_ones(m & mask)
                                        isodd_k = isodd(k)
                                    end
                                    isodd_k && (st[m + 1] = -(st[m + 1]))
                                end
                            end
                    end
                end)
    end
    return st
end

function BQCESubroutine.broutine!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(locs) == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(st, Val{:Z}(), locs, ctrl)
                @assert length(locs) == 1 "number of locations mismatch operator size"
                BQCESubroutine.threaded_basic_broutine!(st, Val{:Z}(), locs, ctrl)
                return st
            end
        end
        begin
            length(locs) == 1 || return BQCESubroutine.multi_broutine2x2!(st, Val{:Z}(), locs, ctrl)
            @assert length(locs) == 1 "number of locations mismatch operator size"
            BQCESubroutine.basic_broutine!(st, Val{:Z}(), locs, ctrl)
            return st
        end
    end
    return st
end
function BQCESubroutine.basic_broutine!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
                ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
                flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            end
            begin
            end
            @fastmath @inbounds(begin
                        begin
                            if step_1_l == 1
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 0, ctrl_mask, flag_mask)
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        begin
                            if step_1_l == 2
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 0, ctrl_mask, flag_mask)
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 1, ctrl_mask, flag_mask)
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        begin
                            if step_1_l == 4
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 0, ctrl_mask, flag_mask)
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 1, ctrl_mask, flag_mask)
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 2, ctrl_mask, flag_mask)
                                            I = ((m + 2) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 3, ctrl_mask, flag_mask)
                                            I = ((m + 3) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        begin
                            if step_1_l == 8
                                for m = 0:step_1_h:size(st, 1) - step_1_h
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 0, ctrl_mask, flag_mask)
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 1, ctrl_mask, flag_mask)
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 2, ctrl_mask, flag_mask)
                                            I = ((m + 2) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 3, ctrl_mask, flag_mask)
                                            I = ((m + 3) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 4, ctrl_mask, flag_mask)
                                            I = ((m + 4) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 5, ctrl_mask, flag_mask)
                                            I = ((m + 5) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 6, ctrl_mask, flag_mask)
                                            I = ((m + 6) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 7, ctrl_mask, flag_mask)
                                            I = ((m + 7) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                                return st
                            end
                        end
                        for m = 0:step_1_h:size(st, 1) - step_1_h
                            for m = m:8:(m + step_1_l) - 1
                                begin
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 0, ctrl_mask, flag_mask)
                                            I = ((m + 0) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 1, ctrl_mask, flag_mask)
                                            I = ((m + 1) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 2, ctrl_mask, flag_mask)
                                            I = ((m + 2) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 3, ctrl_mask, flag_mask)
                                            I = ((m + 3) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 4, ctrl_mask, flag_mask)
                                            I = ((m + 4) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 5, ctrl_mask, flag_mask)
                                            I = ((m + 5) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 6, ctrl_mask, flag_mask)
                                            I = ((m + 6) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                    begin
                                        nothing
                                        if (BQCESubroutine.ismatch)(m + 7, ctrl_mask, flag_mask)
                                            I = ((m + 7) + step_1_l) + 1
                                            T = -(st[I])
                                            st[I] = T
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return st
end
function BQCESubroutine.multi_broutine2x2!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        begin
            ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
            flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(begin
                    if size(st, 1) > 8
                        begin
                            upperbound = size(st, 1) - 1
                            Mmax = (size(st, 1) - 1) - 0
                            for idx2 = 0:Mmax >>> 3
                                idx1 = idx2 << 3 + 0
                                mmax = (idx1 + 7) - 0
                                if mmax ≤ Mmax
                                    begin
                                        begin
                                            begin
                                                k = count_ones((idx1 + 0) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 0, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 0) + 1] = -(st[(idx1 + 0) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 1) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 1, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 1) + 1] = -(st[(idx1 + 1) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 2) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 2, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 2) + 1] = -(st[(idx1 + 2) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 3) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 3, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 3) + 1] = -(st[(idx1 + 3) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 4) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 4, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 4) + 1] = -(st[(idx1 + 4) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 5) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 5, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 5) + 1] = -(st[(idx1 + 5) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 6) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 6, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 6) + 1] = -(st[(idx1 + 6) + 1]))
                                            end
                                        end
                                        begin
                                            begin
                                                k = count_ones((idx1 + 7) & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx1 + 7, ctrl_mask, flag_mask)
                                                isodd_k && (st[(idx1 + 7) + 1] = -(st[(idx1 + 7) + 1]))
                                            end
                                        end
                                    end
                                else
                                    for idx3 = idx1:upperbound
                                        begin
                                            begin
                                                k = count_ones(idx3 & mask)
                                                isodd_k = isodd(k)
                                            end
                                            if (BQCESubroutine.ismatch)(idx3, ctrl_mask, flag_mask)
                                                isodd_k && (st[idx3 + 1] = -(st[idx3 + 1]))
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        for m = 0:size(st, 1) - 1
                            begin
                                k = count_ones(m & mask)
                                isodd_k = isodd(k)
                            end
                            if (BQCESubroutine.ismatch)(m, ctrl_mask, flag_mask)
                                isodd_k && (st[m + 1] = -(st[m + 1]))
                            end
                        end
                    end
                end)
    end
    return st
end
nothing
function BQCESubroutine.threaded_basic_broutine!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                nqubits = (BQCESubroutine.log2i)(size(st, 1))
                nlocs_needed = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
                ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
                flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            end
            begin
            end
            @fastmath @inbounds(begin
                        if nlocs_needed ≤ nqubits - plain_locs[1]
                            begin
                                begin
                                    if step_1_l == 1
                                        Threads.@threads for idx = 0:step_1_h:size(st, 1) - step_1_h
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(idx + 0, ctrl_mask, flag_mask)
                                                        I = ((idx + 0) + step_1_l) + 1
                                                        T = -(st[I])
                                                        st[I] = T
                                                    end
                                                end
                                            end
                                        return st
                                    end
                                end
                                Threads.@threads for idx = 0:step_1_h:size(st, 1) - step_1_h
                                        for idx = idx:1:(idx + step_1_l) - 1
                                            begin
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(idx + 0, ctrl_mask, flag_mask)
                                                        I = ((idx + 0) + step_1_l) + 1
                                                        T = -(st[I])
                                                        st[I] = T
                                                    end
                                                end
                                            end
                                        end
                                    end
                            end
                            return st
                        end
                        begin
                            m = (nqubits - nlocs_needed) - 1
                            Threads.@threads for base = (BQCESubroutine.bsubspace)(nqubits, (1:m..., plain_locs...))
                                    for idx = 0:1 << m - 1
                                        begin
                                            nothing
                                            if (BQCESubroutine.ismatch)(base + idx, ctrl_mask, flag_mask)
                                                I = ((base + idx) + step_1_l) + 1
                                                T = -(st[I])
                                                st[I] = T
                                            end
                                        end
                                    end
                                end
                        end
                        return st
                    end)
        end
    end
    return st
end
function BQCESubroutine.threaded_multi_broutine2x2!(st::AbstractVector, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        begin
            ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
            flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(begin
                    if size(st, 1) > Threads.nthreads() * 1
                        begin
                            upperbound = size(st, 1) - 1
                            Mmax = (size(st, 1) - 1) - 0
                            Threads.@threads for idx2 = 0:Mmax >>> 0
                                    idx1 = idx2 << 0 + 0
                                    mmax = (idx1 + 0) - 0
                                    if mmax ≤ Mmax
                                        begin
                                            begin
                                                begin
                                                    k = count_ones((idx1 + 0) & mask)
                                                    isodd_k = isodd(k)
                                                end
                                                if (BQCESubroutine.ismatch)(idx1 + 0, ctrl_mask, flag_mask)
                                                    isodd_k && (st[(idx1 + 0) + 1] = -(st[(idx1 + 0) + 1]))
                                                end
                                            end
                                        end
                                    else
                                        for idx3 = idx1:upperbound
                                            begin
                                                begin
                                                    k = count_ones(idx3 & mask)
                                                    isodd_k = isodd(k)
                                                end
                                                if (BQCESubroutine.ismatch)(idx3, ctrl_mask, flag_mask)
                                                    isodd_k && (st[idx3 + 1] = -(st[idx3 + 1]))
                                                end
                                            end
                                        end
                                    end
                                end
                        end
                    else
                        Threads.@threads for m = 0:size(st, 1) - 1
                                begin
                                    begin
                                        k = count_ones(m & mask)
                                        isodd_k = isodd(k)
                                    end
                                    if (BQCESubroutine.ismatch)(m, ctrl_mask, flag_mask)
                                        isodd_k && (st[m + 1] = -(st[m + 1]))
                                    end
                                end
                            end
                    end
                end)
    end
    return st
end
function BQCESubroutine.broutine!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(locs) == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(st, Val{:Z}(), locs)
                @assert length(locs) == 1 "number of locations mismatch operator size"
                BQCESubroutine.threaded_basic_broutine!(st, Val{:Z}(), locs)
                return st
            end
        end
        begin
            length(locs) == 1 || return BQCESubroutine.multi_broutine2x2!(st, Val{:Z}(), locs)
            @assert length(locs) == 1 "number of locations mismatch operator size"
            BQCESubroutine.basic_broutine!(st, Val{:Z}(), locs)
            return st
        end
    end
    return st
end
function BQCESubroutine.basic_broutine!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
            end
            begin
            end
            @fastmath @inbounds(for m = 0:step_1_h:size(st, 2) - step_1_h, m = m:(m + step_1_l) - 1
                        nothing
                        begin
                            upperbound = size(st, 1)
                            Mmax = size(st, 1) - 1
                            for idx2 = 0:Mmax >>> 3
                                idx1 = idx2 << 3 + 1
                                mmax = (idx1 + 7) - 1
                                if mmax ≤ Mmax
                                    begin
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 0, I])
                                            st[idx1 + 0, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 1, I])
                                            st[idx1 + 1, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 2, I])
                                            st[idx1 + 2, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 3, I])
                                            st[idx1 + 3, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 4, I])
                                            st[idx1 + 4, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 5, I])
                                            st[idx1 + 5, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 6, I])
                                            st[idx1 + 6, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 7, I])
                                            st[idx1 + 7, I] = T
                                        end
                                    end
                                else
                                    for idx3 = idx1:upperbound
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx3, I])
                                            st[idx3, I] = T
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return st
end
function BQCESubroutine.multi_broutine2x2!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        begin
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(for m = 0:size(st, 2) - 1
                    begin
                        k = count_ones(m & mask)
                        isodd_k = isodd(k)
                    end
                    begin
                        upperbound = size(st, 1)
                        Mmax = size(st, 1) - 1
                        for idx2 = 0:Mmax >>> 3
                            idx1 = idx2 << 3 + 1
                            mmax = (idx1 + 7) - 1
                            if mmax ≤ Mmax
                                begin
                                    isodd_k && (st[idx1 + 0, m + 1] = -(st[idx1 + 0, m + 1]))
                                    isodd_k && (st[idx1 + 1, m + 1] = -(st[idx1 + 1, m + 1]))
                                    isodd_k && (st[idx1 + 2, m + 1] = -(st[idx1 + 2, m + 1]))
                                    isodd_k && (st[idx1 + 3, m + 1] = -(st[idx1 + 3, m + 1]))
                                    isodd_k && (st[idx1 + 4, m + 1] = -(st[idx1 + 4, m + 1]))
                                    isodd_k && (st[idx1 + 5, m + 1] = -(st[idx1 + 5, m + 1]))
                                    isodd_k && (st[idx1 + 6, m + 1] = -(st[idx1 + 6, m + 1]))
                                    isodd_k && (st[idx1 + 7, m + 1] = -(st[idx1 + 7, m + 1]))
                                end
                            else
                                for idx3 = idx1:upperbound
                                    isodd_k && (st[idx3, m + 1] = -(st[idx3, m + 1]))
                                end
                            end
                        end
                    end
                end)
    end
    return st
end
nothing
function BQCESubroutine.threaded_basic_broutine!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                nqubits = (BQCESubroutine.log2i)(size(st, 2))
                nlocs_needed = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
            end
            begin
            end
            @fastmath @inbounds(begin
                        if nlocs_needed ≤ nqubits - plain_locs[1]
                            begin
                                begin
                                    if step_1_l == 1
                                        Threads.@threads for idx = 0:step_1_h:size(st, 2) - step_1_h
                                                begin
                                                    nothing
                                                    begin
                                                        upperbound = size(st, 1)
                                                        Mmax = size(st, 1) - 1
                                                        for idx2 = 0:Mmax >>> 0
                                                            idx1 = idx2 << 0 + 1
                                                            mmax = (idx1 + 0) - 1
                                                            if mmax ≤ Mmax
                                                                begin
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx1 + 0, I])
                                                                        st[idx1 + 0, I] = T
                                                                    end
                                                                end
                                                            else
                                                                for idx3 = idx1:upperbound
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx3, I])
                                                                        st[idx3, I] = T
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        return st
                                    end
                                end
                                Threads.@threads for idx = 0:step_1_h:size(st, 2) - step_1_h
                                        for idx = idx:1:(idx + step_1_l) - 1
                                            begin
                                                begin
                                                    nothing
                                                    begin
                                                        upperbound = size(st, 1)
                                                        Mmax = size(st, 1) - 1
                                                        for idx2 = 0:Mmax >>> 0
                                                            idx1 = idx2 << 0 + 1
                                                            mmax = (idx1 + 0) - 1
                                                            if mmax ≤ Mmax
                                                                begin
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx1 + 0, I])
                                                                        st[idx1 + 0, I] = T
                                                                    end
                                                                end
                                                            else
                                                                for idx3 = idx1:upperbound
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx3, I])
                                                                        st[idx3, I] = T
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
                            return st
                        end
                        begin
                            m = (nqubits - nlocs_needed) - 1
                            Threads.@threads for base = (BQCESubroutine.bsubspace)(nqubits, (1:m..., plain_locs...))
                                    for idx = 0:1 << m - 1
                                        begin
                                            nothing
                                            begin
                                                upperbound = size(st, 1)
                                                Mmax = size(st, 1) - 1
                                                for idx2 = 0:Mmax >>> 0
                                                    idx1 = idx2 << 0 + 1
                                                    mmax = (idx1 + 0) - 1
                                                    if mmax ≤ Mmax
                                                        begin
                                                            begin
                                                                I = ((base + idx) + step_1_l) + 1
                                                                T = -(st[idx1 + 0, I])
                                                                st[idx1 + 0, I] = T
                                                            end
                                                        end
                                                    else
                                                        for idx3 = idx1:upperbound
                                                            begin
                                                                I = ((base + idx) + step_1_l) + 1
                                                                T = -(st[idx3, I])
                                                                st[idx3, I] = T
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                        end
                        return st
                    end)
        end
    end
    return st
end
function BQCESubroutine.threaded_multi_broutine2x2!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations)
    begin
        begin
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(Threads.@threads(for m = 0:size(st, 2) - 1
                        begin
                            begin
                                k = count_ones(m & mask)
                                isodd_k = isodd(k)
                            end
                            begin
                                upperbound = size(st, 1)
                                Mmax = size(st, 1) - 1
                                for idx2 = 0:Mmax >>> 0
                                    idx1 = idx2 << 0 + 1
                                    mmax = (idx1 + 0) - 1
                                    if mmax ≤ Mmax
                                        begin
                                            isodd_k && (st[idx1 + 0, m + 1] = -(st[idx1 + 0, m + 1]))
                                        end
                                    else
                                        for idx3 = idx1:upperbound
                                            isodd_k && (st[idx3, m + 1] = -(st[idx3, m + 1]))
                                        end
                                    end
                                end
                            end
                        end
                    end))
    end
    return st
end
function BQCESubroutine.broutine!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
            begin
                length(locs) == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(st, Val{:Z}(), locs, ctrl)
                @assert length(locs) == 1 "number of locations mismatch operator size"
                BQCESubroutine.threaded_basic_broutine!(st, Val{:Z}(), locs, ctrl)
                return st
            end
        end
        begin
            length(locs) == 1 || return BQCESubroutine.multi_broutine2x2!(st, Val{:Z}(), locs, ctrl)
            @assert length(locs) == 1 "number of locations mismatch operator size"
            BQCESubroutine.basic_broutine!(st, Val{:Z}(), locs, ctrl)
            return st
        end
    end
    return st
end
function BQCESubroutine.basic_broutine!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
                ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
                flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            end
            begin
            end
            @fastmath @inbounds(for m = 0:step_1_h:size(st, 2) - step_1_h, m = m:(m + step_1_l) - 1
                        nothing
                        if (BQCESubroutine.ismatch)(m, ctrl_mask, flag_mask)
                            upperbound = size(st, 1)
                            Mmax = size(st, 1) - 1
                            for idx2 = 0:Mmax >>> 3
                                idx1 = idx2 << 3 + 1
                                mmax = (idx1 + 7) - 1
                                if mmax ≤ Mmax
                                    begin
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 0, I])
                                            st[idx1 + 0, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 1, I])
                                            st[idx1 + 1, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 2, I])
                                            st[idx1 + 2, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 3, I])
                                            st[idx1 + 3, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 4, I])
                                            st[idx1 + 4, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 5, I])
                                            st[idx1 + 5, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 6, I])
                                            st[idx1 + 6, I] = T
                                        end
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx1 + 7, I])
                                            st[idx1 + 7, I] = T
                                        end
                                    end
                                else
                                    for idx3 = idx1:upperbound
                                        begin
                                            I = (m + step_1_l) + 1
                                            T = -(st[idx3, I])
                                            st[idx3, I] = T
                                        end
                                    end
                                end
                            end
                        end
                    end)
        end
    end
    return st
end
function BQCESubroutine.multi_broutine2x2!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        begin
            ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
            flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(for m = 0:size(st, 2) - 1
                    begin
                        k = count_ones(m & mask)
                        isodd_k = isodd(k)
                    end
                    if (BQCESubroutine.ismatch)(m, ctrl_mask, flag_mask)
                        upperbound = size(st, 1)
                        Mmax = size(st, 1) - 1
                        for idx2 = 0:Mmax >>> 3
                            idx1 = idx2 << 3 + 1
                            mmax = (idx1 + 7) - 1
                            if mmax ≤ Mmax
                                begin
                                    isodd_k && (st[idx1 + 0, m + 1] = -(st[idx1 + 0, m + 1]))
                                    isodd_k && (st[idx1 + 1, m + 1] = -(st[idx1 + 1, m + 1]))
                                    isodd_k && (st[idx1 + 2, m + 1] = -(st[idx1 + 2, m + 1]))
                                    isodd_k && (st[idx1 + 3, m + 1] = -(st[idx1 + 3, m + 1]))
                                    isodd_k && (st[idx1 + 4, m + 1] = -(st[idx1 + 4, m + 1]))
                                    isodd_k && (st[idx1 + 5, m + 1] = -(st[idx1 + 5, m + 1]))
                                    isodd_k && (st[idx1 + 6, m + 1] = -(st[idx1 + 6, m + 1]))
                                    isodd_k && (st[idx1 + 7, m + 1] = -(st[idx1 + 7, m + 1]))
                                end
                            else
                                for idx3 = idx1:upperbound
                                    isodd_k && (st[idx3, m + 1] = -(st[idx3, m + 1]))
                                end
                            end
                        end
                    end
                end)
    end
    return st
end
nothing
function BQCESubroutine.threaded_basic_broutine!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        nothing
        begin
            begin
                plain_locs = (YaoLocations.plain)(locs)
                nqubits = (BQCESubroutine.log2i)(size(st, 2))
                nlocs_needed = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
                step_1_l = 1 << (plain_locs[1] - 1)
                step_1_h = 1 << plain_locs[1]
                ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
                flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            end
            begin
            end
            @fastmath @inbounds(begin
                        if nlocs_needed ≤ nqubits - plain_locs[1]
                            begin
                                begin
                                    if step_1_l == 1
                                        Threads.@threads for idx = 0:step_1_h:size(st, 2) - step_1_h
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(idx + 0, ctrl_mask, flag_mask)
                                                        upperbound = size(st, 1)
                                                        Mmax = size(st, 1) - 1
                                                        for idx2 = 0:Mmax >>> 0
                                                            idx1 = idx2 << 0 + 1
                                                            mmax = (idx1 + 0) - 1
                                                            if mmax ≤ Mmax
                                                                begin
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx1 + 0, I])
                                                                        st[idx1 + 0, I] = T
                                                                    end
                                                                end
                                                            else
                                                                for idx3 = idx1:upperbound
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx3, I])
                                                                        st[idx3, I] = T
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        return st
                                    end
                                end
                                Threads.@threads for idx = 0:step_1_h:size(st, 2) - step_1_h
                                        for idx = idx:1:(idx + step_1_l) - 1
                                            begin
                                                begin
                                                    nothing
                                                    if (BQCESubroutine.ismatch)(idx + 0, ctrl_mask, flag_mask)
                                                        upperbound = size(st, 1)
                                                        Mmax = size(st, 1) - 1
                                                        for idx2 = 0:Mmax >>> 0
                                                            idx1 = idx2 << 0 + 1
                                                            mmax = (idx1 + 0) - 1
                                                            if mmax ≤ Mmax
                                                                begin
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx1 + 0, I])
                                                                        st[idx1 + 0, I] = T
                                                                    end
                                                                end
                                                            else
                                                                for idx3 = idx1:upperbound
                                                                    begin
                                                                        I = ((idx + 0) + step_1_l) + 1
                                                                        T = -(st[idx3, I])
                                                                        st[idx3, I] = T
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
                            return st
                        end
                        begin
                            m = (nqubits - nlocs_needed) - 1
                            Threads.@threads for base = (BQCESubroutine.bsubspace)(nqubits, (1:m..., plain_locs...))
                                    for idx = 0:1 << m - 1
                                        begin
                                            nothing
                                            if (BQCESubroutine.ismatch)(base + idx, ctrl_mask, flag_mask)
                                                upperbound = size(st, 1)
                                                Mmax = size(st, 1) - 1
                                                for idx2 = 0:Mmax >>> 0
                                                    idx1 = idx2 << 0 + 1
                                                    mmax = (idx1 + 0) - 1
                                                    if mmax ≤ Mmax
                                                        begin
                                                            begin
                                                                I = ((base + idx) + step_1_l) + 1
                                                                T = -(st[idx1 + 0, I])
                                                                st[idx1 + 0, I] = T
                                                            end
                                                        end
                                                    else
                                                        for idx3 = idx1:upperbound
                                                            begin
                                                                I = ((base + idx) + step_1_l) + 1
                                                                T = -(st[idx3, I])
                                                                st[idx3, I] = T
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                        end
                        return st
                    end)
        end
    end
    return st
end
function BQCESubroutine.threaded_multi_broutine2x2!(st::AbstractMatrix, ::Val{:Z}, locs::YaoLocations.Locations, ctrl::YaoLocations.CtrlLocations)
    begin
        begin
            ctrl_mask = (BQCESubroutine.bmask)((YaoLocations.plain)(ctrl))
            flag_mask = (BQCESubroutine.ctrl_flag_mask)(ctrl)
            plain_locs = (YaoLocations.plain)(locs)
            mask = (BQCESubroutine.bmask)(plain_locs)
        end
        begin
        end
        @fastmath @inbounds(Threads.@threads(for m = 0:size(st, 2) - 1
                        begin
                            begin
                                k = count_ones(m & mask)
                                isodd_k = isodd(k)
                            end
                            if (BQCESubroutine.ismatch)(m, ctrl_mask, flag_mask)
                                upperbound = size(st, 1)
                                Mmax = size(st, 1) - 1
                                for idx2 = 0:Mmax >>> 0
                                    idx1 = idx2 << 0 + 1
                                    mmax = (idx1 + 0) - 1
                                    if mmax ≤ Mmax
                                        begin
                                            isodd_k && (st[idx1 + 0, m + 1] = -(st[idx1 + 0, m + 1]))
                                        end
                                    else
                                        for idx3 = idx1:upperbound
                                            isodd_k && (st[idx3, m + 1] = -(st[idx3, m + 1]))
                                        end
                                    end
                                end
                            end
                        end
                    end))
    end
    return st
end
const BZ = [1 0; 0 -1]

using BenchmarkTools
@benchmark BQCESubroutine.multi_broutine2x2!(st, Val(:Z), Locations((9, 10))) setup=(st=rand(ComplexF64, 1<<25))
@benchmark BQCESubroutine.threaded_multi_broutine2x2!(st, Val(:Z), Locations((9, 10))) setup=(st=rand(ComplexF64, 1<<25))
@benchmark polyester_multi_broutine2x2!(st, Val(:Z), Locations((9, 10))) setup=(st=rand(ComplexF64, 1<<25))
@benchmark broutine!(st, Val(:Z), Locations((9, 10))) setup=(st=rand(ComplexF64, 1<<25))
