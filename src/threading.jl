const BQCES_nthreads = Ref(1)

function set_nthreads(n::Int)
    @assert n ≤ Threads.nthreads() "JULIA_NUM_THREADS is set to $(Threads.nthreads())"
    BQCES_nthreads[] = n
    return
end

macro threads(ex)
    return threads_m(ex)
end

macro threads(min_threads_len::Int, ex)
    return threads_m(ex, min_threads_len)
end

function threads_m(ex::Expr, min_threads_len::Int=1024)
    return quote
        if $BQCES_nthreads[] > 1 && length($(esc(it.args[2]))) > $min_threads_len
            $(threaded_for(ex))
        else
            $(esc(ex))
        end
    end
end

function threaded_for(ex)
    ex isa Expr || return ex
    if ex.head === :for
        it = ex.args[1]
        return spawn_task_closure(it.args[1], it.args[2], ex.args[2])
    end

    if ex.head === :block
        return Expr(ex.head, map(threaded_for, ex.args)...)
    end
    return ex
end

# copied from Base.Threads
function threading_run(func)
    ccall(:jl_enter_threaded_region, Cvoid, ())
    n = BQCES_nthreads[]
    tasks = Vector{Task}(undef, n)
    for i = 1:n
        t = Task(func)
        t.sticky = true
        ccall(:jl_set_task_tid, Cvoid, (Any, Cint), t, i-1)
        tasks[i] = t
        Threads.schedule(t)
    end
    try
        for i = 1:n
            wait(tasks[i])
        end
    finally
        ccall(:jl_exit_threaded_region, Cvoid, ())
    end
end

function spawn_task_closure(lidx, range, lbody)
    return quote
        local threadsfor_fun
        let range = $(esc(range))
            function task_closure()
                r = range
                lenr = length(r)
                tid = Threads.threadid()
                len, rem = divrem(lenr, nthreads())
                
                if len == 0
                    tid > rem && return
                    len, rem = 1, 0
                end

                # compute this thread's iterations
                f = firstindex(r) + ((tid-1) * len)
                l = f + len - 1
                # distribute remaining iterations evenly
                if rem > 0
                    if tid <= rem
                        f = f + (tid-1)
                        l = l + tid
                    else
                        f = f + rem
                        l = l + rem
                    end
                end
                # run this thread's iterations
                for i = f:l
                    local $(esc(lidx)) = @inbounds r[i]
                    $(esc(lbody))
                end
            end
        end # let
        threading_run(task_closure)
    end
end
