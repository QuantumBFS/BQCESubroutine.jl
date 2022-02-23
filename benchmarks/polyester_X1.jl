using Polyester
using BenchmarkTools

function seriel_X1(x::Vector{T}) where T
    for i in 0:2:length(x)-2
        @inbounds begin
            temp = x[i+1]
            x[i+1] = x[i+2]
            x[i+2] = temp
        end
    end
    return x
end
function batch_X1(x::Vector{T}) where T
    @batch for i in 0:2:length(x)-2
        @inbounds begin
            temp = x[i+1]
            x[i+1] = x[i+2]
            x[i+2] = temp
        end
    end
    return x
end
function threads_X1(x::Vector{T}) where T
    Threads.@threads for i in 0:2:length(x)-2
        @inbounds begin
            temp = x[i+1]
            x[i+1] = x[i+2]
            x[i+2] = temp
        end
    end
    return x
end
function seriel_X1(x::Matrix{T}) where T
    batch_size, state_size = size(x)
    for i in 0:2:state_size-2
        @inbounds for b in 1:batch_size
            temp = x[b, i+1]
            x[b, i+1] = x[b, i+2]
            x[b, i+2] = temp
        end
    end
    return x
end
function batch_X1(x::Matrix{T}) where T
    batch_size, state_size = size(x)
    @batch for i in 0:2:state_size-2
        @inbounds for b in 1:batch_size
            temp = x[b, i+1]
            x[b, i+1] = x[b, i+2]
            x[b, i+2] = temp
        end
    end
    return x
end
function threads_X1(x::Matrix{T}) where T
    batch_size, state_size = size(x)
    Threads.@threads for i in 0:2:state_size-2
        @inbounds for b in 1:batch_size
            temp = x[b, i+1]
            x[b, i+1] = x[b, i+2]
            x[b, i+2] = temp
        end
    end
    return x
end

N = 25
B = 1<<7
T = ComplexF64
b0_vec = @benchmark seriel_X1(x) setup=(x=rand(T, 1<<N))
bb_vec = @benchmark batch_X1(x) setup=(x=rand(T, 1<<N))
bt_vec = @benchmark threads_X1(x) setup=(x=rand(T, 1<<N))
b0_mat = @benchmark seriel_X1(x) setup=(x=rand(T, B, 1<<(N-5)))
bb_mat = @benchmark batch_X1(x) setup=(x=rand(T, B, 1<<(N-5)))
bt_mat = @benchmark threads_X1(x) setup=(x=rand(T, B, 1<<(N-5)))
println("nthreads = $(Threads.nthreads()), N = $N, B = $B, T = $T")
println("vector speedups: @batch = $(mean(b0_vec).time/mean(bb_vec).time), @threads = $(mean(b0_vec).time/mean(bt_vec).time)")
println("matrix speedups: @batch = $(mean(b0_mat).time/mean(bb_mat).time), @threads = $(mean(b0_mat).time/mean(bt_mat).time)")
