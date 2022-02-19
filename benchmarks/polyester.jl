using Polyester, LinearAlgebra, BenchmarkTools
# Single threaded.
function axpy_serial!(y, a, x)
    @inbounds for i in eachindex(y,x)
        y[i] = muladd(a, x[i], y[i])
    end
end
# One thread per core, the default (the threads are not pinned)
function axpy_per_core!(y, a, x)
    @batch per=core for i in eachindex(y,x)
        y[i] = muladd(a, x[i], y[i])
    end
end
# One thread per thread
function axpy_per_thread!(y, a, x)
    @batch per=thread for i in eachindex(y,x)
        y[i] = muladd(a, x[i], y[i])
    end
end
# Set a minimum batch size of `200`
function axpy_minbatch!(y, a, x)
    @batch minbatch=2000 for i in eachindex(y,x)
        y[i] = muladd(a, x[i], y[i])
    end
end
# benchmark against `Threads.@threads`
function axpy_atthread!(y, a, x)
    Threads.@threads for i in eachindex(y,x)
        @inbounds y[i] = muladd(a, x[i], y[i])
    end
end

y = rand(10_000);
x = rand(10_000);
@benchmark axpy_serial!($y, eps(), $x)
@benchmark axpy!(eps(), $x, $y)
@benchmark axpy_atthread!($y, eps(), $x)
@benchmark axpy_per_core!($y, eps(), $x)
@benchmark axpy_per_thread!($y, eps(), $x)
@benchmark axpy_minbatch!($y, eps(), $x)
Threads.nthreads()
versioninfo()
