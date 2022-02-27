function BQCESubroutine.broutine!(st::AbstractVector, ::Val{:X}, locs::Locations)
    if (BQCESubroutine).ENABLE_THREADS[] && Threads.nthreads() > 1
        length(locs) == 1 || return BQCESubroutine.threaded_multi_broutine2x2!(st, Val{:X}(), locs)
        BQCESubroutine.threaded_basic_broutine!(st, Val{:X}(), locs)
        return st
    end
    length(locs) == 1 || return BQCESubroutine.multi_broutine2x2!(st, Val{:X}(), locs)
    BQCESubroutine.basic_broutine!(st, Val{:X}(), locs)
    return st
end

function BQCESubroutine.basic_broutine!(st::AbstractVector, ::Val{:X}, locs::Locations)
    plain_locs = (YaoLocations.plain)(locs)
    step_1_l = 1 << (loc - 1)
    step_1_h = 1 << loc
    nqubits = (BQCESubroutine.log2i)(size(st, 1))
    loc = plain_locs[1]
    if loc <= 3
        BQCESubroutine.basic_broutine_kernel!(st, Val(:X), 0:step_1_h:(length(st)-step_1_h), step_1_l)
        return st
    end
    BQCESubroutine.basic_broutine_kernel!(st, Val(:X), BQCESubroutine.bsubspace(nqubits, Locations((1, 2, 3, loc))), step_1_l)
    return st
end

function BQCESubroutine.threaded_basic_broutine!(st::AbstractVector, ::Val{:X}, locs::Locations)
    plain_locs = (YaoLocations.plain)(locs)
    step_1_l = 1 << (loc - 1)
    step_1_h = 1 << loc
    loc = plain_locs[1]
    nqubits = (BQCESubroutine.log2i)(size(st, 1))
    nthreads = Threads.nthreads()
    if loc <= 3
        subspace = BQCESubroutine.bsubspace(nqubits, Locations(1:loc))
    else
        subspace = BQCESubroutine.bsubspace(nqubits, Locations((1, 2, 3, loc)))
    end
    space = BQCESubroutine.CartesianSpace(st, subspace)
    @batch for tid in 1:nthreads
        iter = BQCESubroutine.schedule_task(space, tid, nthreads)
        BQCESubroutine.basic_broutine_kernel!(st, Val(:X), iter, step_1_l, subspace)
    end
    return st
end

function BQCESubroutine.basic_broutine_kernel!(st::AbstractVector, ::Val{:X}, iter, mask, subspace = nothing)
    @fastmath @inbounds begin
        if mask == 1
            for m_1 in iter
                isnothing(subspace) || (m_1 = subspace[m_1])
                I_1 = (m_1 + 0) + 1
                I_2 = ((m_1 + 0) + mask) + 1
                T_1 = st[I_2]
                T_2 = st[I_1]
                st[I_1] = T_1
                st[I_2] = T_2
            end
            return st
        end
        if mask == 2
            for m_1 in iter
                isnothing(subspace) || (m_1 = subspace[m_1])
                begin
                    begin
                        I_1 = (m_1 + 0) + 1
                        I_2 = ((m_1 + 0) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 1) + 1
                        I_2 = ((m_1 + 1) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
            end
            return st
        end
        if mask == 4
            for m_1 in iter
                isnothing(subspace) || (m_1 = subspace[m_1])
                begin
                    begin
                        I_1 = (m_1 + 0) + 1
                        I_2 = ((m_1 + 0) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 1) + 1
                        I_2 = ((m_1 + 1) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 2) + 1
                        I_2 = ((m_1 + 2) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 3) + 1
                        I_2 = ((m_1 + 3) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
            end
            return st
        end
        if mask == 8
            for m_1 in iter
                isnothing(subspace) || (m_1 = subspace[m_1])
                begin
                    begin
                        I_1 = (m_1 + 0) + 1
                        I_2 = ((m_1 + 0) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 1) + 1
                        I_2 = ((m_1 + 1) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 2) + 1
                        I_2 = ((m_1 + 2) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 3) + 1
                        I_2 = ((m_1 + 3) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 4) + 1
                        I_2 = ((m_1 + 4) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 5) + 1
                        I_2 = ((m_1 + 5) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 6) + 1
                        I_2 = ((m_1 + 6) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 7) + 1
                        I_2 = ((m_1 + 7) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
            end
            return st
        end
        for m_1 in iter
            isnothing(subspace) || (m_1 = subspace[m_1])
            begin
                begin
                    begin
                        I_1 = (m_1 + 0) + 1
                        I_2 = ((m_1 + 0) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 1) + 1
                        I_2 = ((m_1 + 1) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 2) + 1
                        I_2 = ((m_1 + 2) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 3) + 1
                        I_2 = ((m_1 + 3) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 4) + 1
                        I_2 = ((m_1 + 4) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 5) + 1
                        I_2 = ((m_1 + 5) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 6) + 1
                        I_2 = ((m_1 + 6) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
                begin
                    begin
                        I_1 = (m_1 + 7) + 1
                        I_2 = ((m_1 + 7) + mask) + 1
                        T_1 = st[I_2]
                        T_2 = st[I_1]
                        st[I_1] = T_1
                        st[I_2] = T_2
                    end
                end
            end
        end
    end
    
    return st
end

# TODO: reimplement multi_broutine2x2
function BQCESubroutine.multi_broutine2x2!(st::AbstractVector, ::Val{:X}, locs::Locations)
    plain_locs = (YaoLocations.plain)(locs)
    step_1_l = 1 << (plain_locs[1] - 1)
    step_1_h = 1 << plain_locs[1]
    mask = (BQCESubroutine.bmask)(plain_locs)
    @fastmath @inbounds(begin
        if step_1_l == 1
            for m_1 = 0:step_1_h:size(st, 1) - step_1_h
                i = (m_1 + 0) + 1
                j = ((m_1 + 0) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
            end
            return st
        end
        if step_1_l == 2
            for m_1 = 0:step_1_h:size(st, 1) - step_1_h
                i = (m_1 + 0) + 1
                j = ((m_1 + 0) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 1) + 1
                j = ((m_1 + 1) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
            end
            return st
        end
        if step_1_l == 4
            for m_1 = 0:step_1_h:size(st, 1) - step_1_h
                i = (m_1 + 0) + 1
                j = ((m_1 + 0) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 1) + 1
                j = ((m_1 + 1) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 2) + 1
                j = ((m_1 + 2) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 3) + 1
                j = ((m_1 + 3) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
            end
            return st
        end
        if step_1_l == 8
            for m_1 = 0:step_1_h:size(st, 1) - step_1_h
                i = (m_1 + 0) + 1
                j = ((m_1 + 0) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 1) + 1
                j = ((m_1 + 1) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 2) + 1
                j = ((m_1 + 2) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 3) + 1
                j = ((m_1 + 3) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 4) + 1
                j = ((m_1 + 4) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 5) + 1
                j = ((m_1 + 5) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 6) + 1
                j = ((m_1 + 6) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_1 + 7) + 1
                j = ((m_1 + 7) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
            end
            return st
        end
        for m_1 = 0:step_1_h:size(st, 1) - step_1_h
            for m_2 = m_1:8:(m_1 + step_1_l) - 1
                i = (m_2 + 0) + 1
                j = ((m_2 + 0) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 1) + 1
                j = ((m_2 + 1) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 2) + 1
                j = ((m_2 + 2) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 3) + 1
                j = ((m_2 + 3) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 4) + 1
                j = ((m_2 + 4) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 5) + 1
                j = ((m_2 + 5) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 6) + 1
                j = ((m_2 + 6) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
                i = (m_2 + 7) + 1
                j = ((m_2 + 7) ⊻ mask) + 1
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
            end
        end
    end)
    return st
end

function BQCESubroutine.threaded_multi_broutine2x2!(st::AbstractVector, ::Val{:X}, locs::Locations)
    plain_locs = (YaoLocations.plain)(locs)
    nqubits = (BQCESubroutine.log2i)(size(st, 1))
    nlocs_needed = (BQCESubroutine.log2i)(Threads.nthreads() - 1) + 1
    step_1_l = 1 << (plain_locs[1] - 1)
    step_1_h = 1 << plain_locs[1]
    mask = (BQCESubroutine.bmask)(plain_locs)
    @fastmath @inbounds(begin
        if nlocs_needed ≤ nqubits - plain_locs[1]
            if step_1_l == 1
                # @batch 
                println("Case 1:")
                for idx_1 = 0:step_1_h:size(st, 1) - step_1_h
                    i = (idx_1 + 0) + 1
                    j = ((idx_1 + 0) ⊻ mask) + 1
                    println(string(i-1, base=2, pad=10), ", ", string(j-1, base=2, pad=10))
                    tmp = st[i]
                    st[i] = st[j]
                    st[j] = tmp
                end
                return st
            end
            # @batch 
            println("Case 2:")
            @show step_1_l, step_1_h
            for idx_1 = 0:step_1_h:size(st, 1) - step_1_h
                for idx_2 = idx_1:1:(idx_1 + step_1_l) - 1
                    i = (idx_2 + 0) + 1
                    j = ((idx_2 + 0) ⊻ mask) + 1
                    println(string(i-1, base=2, pad=10), ", ", string(j-1, base=2, pad=10))
                    tmp = st[i]
                    st[i] = st[j]
                    st[j] = tmp
                end
            end
            return st
        end
        m = Base.max(0, (nqubits - nlocs_needed) - 1)
        # @batch 
        for base = (BQCESubroutine.bsubspace)(nqubits, (1:m..., plain_locs...))
            for idx_1 = 0:1 << m - 1
                i = (base + idx_1) + 1
                j = ((base + idx_1) ⊻ mask) + 1
                println(string(i-1, base=2, pad=10), ", ", string(j-1, base=2, pad=10))
                tmp = st[i]
                st[i] = st[j]
                st[j] = tmp
            end
        end
        return st
    end)
    return st
end
