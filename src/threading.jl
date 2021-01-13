const ENABLE_THREADS = Ref(true)

function disable_threads()
    ENABLE_THREADS[] = false
end

function enable_threads()
    ENABLE_THREADS[] = true
end

macro threads(ex)
    return esc(threads_m(ex))
end

macro threads(min_threads_len::Int, ex)
    return esc(threads_m(ex, min_threads_len))
end

function threads_m(ex::Expr, min_threads_len::Int=1024)
    range = ex.args[1].args[2]
    enable = GlobalRef(BQCESubroutine, :ENABLE_THREADS)
    return quote
        if $enable[] && length($range) > $min_threads_len
            Threads.@threads $ex
        else
            $ex
        end
    end
end
