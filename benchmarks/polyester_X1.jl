using Polyester
using BenchmarkTools

@inline function scheduler(L::Integer, tid, nthreads)
    N = L ÷ 2
    bsize = N ÷ nthreads
    tid < nthreads && return (tid-1)*bsize*2:2:tid*bsize*2-2
    return (tid-1)*bsize*2:2:N*2-2
end

@inline function kernel_vec(x, iter)
    for i in iter
        @inbounds begin
            temp = x[i+1]
            x[i+1] = x[i+2]
            x[i+2] = temp
        end
    end
    return x
end

@inline function kernel_mat(x, iter)
    bs = size(x, 1)
    for b in 1:bs
        for i in iter
            @inbounds begin
                temp = x[b, i+1]
                x[b, i+1] = x[b, i+2]
                x[b, i+2] = temp
            end
        end
    end
    return x
end

function seriel_X1(x::Vector{T}) where T
    # for i in 0:2:length(x)-2
    #     @inbounds begin
    #         temp = x[i+1]
    #         x[i+1] = x[i+2]
    #         x[i+2] = temp
    #     end
    # end
    kernel_vec(x, 0:2:length(x)-2)
    return x
end
function batch_X1(x::Vector{T}) where T
    nthreads = Threads.nthreads()
    N = length(x)
    @batch for tid = 1:nthreads
        # for i in scheduler(N, tid, nthreads)
        #     @inbounds begin
        #         temp = x[i+1]
        #         x[i+1] = x[i+2]
        #         x[i+2] = temp
        #     end
        # end
        kernel_vec(x, scheduler(N, tid, nthreads))
    end
    return x
end
function threads_X1(x::Vector{T}) where T
    nthreads = Threads.nthreads()
    N = length(x)
    Threads.@threads for tid = 1:nthreads
        # for i in scheduler(N, tid, nthreads)
        #     @inbounds begin
        #         temp = x[i+1]
        #         x[i+1] = x[i+2]
        #         x[i+2] = temp
        #     end
        # end
        kernel_vec(x, scheduler(N, tid, nthreads))
    end
    return x
end
function seriel_X1(x::Matrix{T}) where T
    batch_size, state_size = size(x)
    # for i in 0:2:state_size-2
        # @inbounds for b in 1:batch_size
        #     temp = x[b, i+1]
        #     x[b, i+1] = x[b, i+2]
        #     x[b, i+2] = temp
        # end
    # end
    kernel_mat(x, 0:2:state_size-2)
    return x
end
function batch_X1(x::Matrix{T}) where T
    nthreads = Threads.nthreads()
    batch_size, state_size = size(x)
    @batch for tid in 1:nthreads
        # for i in scheduler(state_size, tid, nthreads)
        #     @inbounds for b in 1:batch_size
        #         temp = x[b, i+1]
        #         x[b, i+1] = x[b, i+2]
        #         x[b, i+2] = temp
        #     end
        # end
        kernel_mat(x, scheduler(state_size, tid, nthreads))
    end
    return x
end
function threads_X1(x::Matrix{T}) where T
    nthreads = Threads.nthreads()
    batch_size, state_size = size(x)
    Threads.@threads for tid in 1:nthreads
        # for i in scheduler(state_size, tid, nthreads)
        #     @inbounds for b in 1:batch_size
        #         temp = x[b, i+1]
        #         x[b, i+1] = x[b, i+2]
        #         x[b, i+2] = temp
        #     end
        # end
        kernel_mat(x, scheduler(state_size, tid, nthreads))
    end
    return x
end

N = 28
M = 8
B = 1<<M
T = ComplexF64
nthreads = Threads.nthreads()
begin
    b0_vec = @benchmark seriel_X1(x) setup=(x=rand(T, 1<<N))
    bb_vec = @benchmark batch_X1(x) setup=(x=rand(T, 1<<N))
    bt_vec = @benchmark threads_X1(x) setup=(x=rand(T, 1<<N))
    kt_vec = @benchmark kernel_vec(x, scheduler(1<<N, rand(1:nthreads), nthreads)) setup=(x=rand(T, 1<<N))
    println("nthreads = $(nthreads), N = $N, B = $B, T = $T")
    println("time: single: $(mean(b0_vec).time/1e6) ms, @batch: $(mean(bb_vec).time/1e6) ms, @threads: $(mean(bt_vec).time/1e6) ms, kernel: $(mean(kt_vec).time/1e6) ms")
    println("vector speedups: @batch = $(mean(b0_vec).time/mean(bb_vec).time), @threads = $(mean(b0_vec).time/mean(bt_vec).time)")
end
begin
    b0_mat = @benchmark seriel_X1(x) setup=(x=rand(T, B, 1<<(N-M)))
    bb_mat = @benchmark batch_X1(x) setup=(x=rand(T, B, 1<<(N-M)))
    bt_mat = @benchmark threads_X1(x) setup=(x=rand(T, B, 1<<(N-M)))
    kt_mat = @benchmark kernel_mat(x, scheduler(1<<(N-M), rand(1:nthreads), nthreads)) setup=(x=rand(T, B, 1<<(N-M)))
    println("time: single: $(mean(b0_mat).time/1e6) ms, @batch: $(mean(bb_mat).time/1e6) ms, @threads: $(mean(bt_mat).time/1e6) ms, kernel: $(mean(kt_mat).time/1e6) ms")
    println("matrix speedups: @batch = $(mean(b0_mat).time/mean(bb_mat).time), @threads = $(mean(b0_mat).time/mean(bt_mat).time)")
end