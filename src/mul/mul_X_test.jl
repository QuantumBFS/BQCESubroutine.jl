# specialize on the X gate
function subspace_mul!(st::AbstractVector, U::Val{:X_test}, loc::Int)
    n = log2dim(st)

    if loc == 1
        # nthreads=1, N=27, loc=1
        # (:X)        79.497 ms (0 allocations: 0 bytes)
        # (:X_test)   84.092 ms (0 allocations: 0 bytes)
        # nthreads=2, N=27, loc=1
        # (:X)        76.943 ms (11 allocations: 1008 bytes)
        # (:X_test)   76.635 ms (0 allocations: 0 bytes)
        # nthreads=3, N=27, loc=1
        # (:X)        75.951 ms (16 allocations: 1.44 KiB)
        # (:X_test)   75.351 ms (0 allocations: 0 bytes)
        # nthreads=4, N=27, loc=1
        # (:X)        77.309 ms (21 allocations: 1.88 KiB)
        # (:X_test)   76.227 ms (0 allocations: 0 bytes)
        # nthreads=5, N=27, loc=1
        # (:X)        79.376 ms (27 allocations: 2.36 KiB)
        # (:X_test)   77.396 ms (0 allocations: 0 bytes)
        # nthreads=6, N=27, loc=1
        # (:X)        81.263 ms (31 allocations: 2.77 KiB)
        # (:X_test)   79.233 ms (0 allocations: 0 bytes)
        @inbounds @batch for k in 0:2:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 1
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    elseif loc == 2
        @inbounds @batch for k in 0:4:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 0b10
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b01
            idx_2 = k | 0b11
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    elseif loc == 3
        @inbounds @batch per=thread for k in 0:8:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 0b100
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b001
            idx_2 = k | 0b101
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b010
            idx_2 = k | 0b110
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b011
            idx_2 = k | 0b111
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    elseif loc == 4
        @inbounds @batch for k in 0:16:((1<<n)-1)
            idx_1 = k
            idx_2 = k | 0b1000
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0001
            idx_2 = k | 0b1001
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0010
            idx_2 = k | 0b1010
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0011
            idx_2 = k | 0b1011
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0100
            idx_2 = k | 0b1100
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0101
            idx_2 = k | 0b1101
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0110
            idx_2 = k | 0b1110
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | 0b0111
            idx_2 = k | 0b1111
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    else
        # subspace_mul_X_test_large_loc_1!(st, n, loc)
        # subspace_mul_X_test_large_loc_2!(st, n, loc)
        # subspace_mul_X_test_large_loc_3!(st, n, loc)
        subspace_mul_X_test_large_loc_4!(st, n, loc)
    end
end


@inline function subspace_mul_X_test_large_loc_1!(st::AbstractVector, n::Int, loc::Int)
    # the original loops for large loc (loc≥5)
    loc_bit = 1 << (loc-1)
    @inbounds @batch for k_highbits in 0 : (1<<loc) : ((1<<n)-1)
        for k in k_highbits : 8 : ((k_highbits | loc_bit) - 1)
            subspace_mul_X_test_large_loc_kernel!(st, k, loc_bit)
        end
    end
end


@inline function subspace_mul_X_test_large_loc_2!(st::AbstractVector, n::Int, loc::Int)
    # for loc≥5.
    # better load balance but (a little bit?) larger kernel for each thread,
    # since we need to recover k from k_continuous.
    #
    # nthreads=1, N=20, loc=19
    # (:X)        392.256 μs (0 allocations: 0 bytes)
    # (:X_test)   419.247 μs (0 allocations: 0 bytes)
    # nthreads=2, N=20, loc=19
    # (:X)        259.664 μs (10 allocations: 976 bytes)
    # (:X_test)   377.814 μs (0 allocations: 0 bytes)
    # nthreads=3, N=20, loc=19
    # (:X)        301.173 μs (42 allocations: 2.50 KiB)
    # (:X_test)   242.846 μs (0 allocations: 0 bytes)
    # nthreads=4, N=20, loc=19
    # (:X)        153.409 μs (47 allocations: 2.94 KiB)
    # (:X_test)   182.374 μs (0 allocations: 0 bytes)
    # nthreads=5, N=20, loc=19
    # (:X)        165.485 μs (51 allocations: 3.34 KiB)
    # (:X_test)   154.933 μs (0 allocations: 0 bytes)
    # nthreads=6, N=20, loc=19
    # (:X)        157.965 μs (56 allocations: 3.78 KiB)
    # (:X_test)   133.584 μs (0 allocations: 0 bytes)

    loc_bit = 1 << (loc-1)
    mask_highbits = -1 << loc
    mask_lowbits = ((1<<loc) - 1) & (-1 << 4)
    @inbounds @batch for k_continuous in 0 : 16 : ((1<<n)-1)
        k_highbits = k_continuous & mask_highbits
        k_lowbits = (k_continuous & mask_lowbits) >> 1
        k = k_highbits | k_lowbits
        subspace_mul_X_test_large_loc_kernel!(st, k, loc_bit)
    end
end


@inline function subspace_mul_X_test_large_loc_3!(st::AbstractVector, n::Int, loc::Int)
    # for loc≥5.
    # very poor performance when the number of threads is small,
    # probably due to bad cache locality
    #
    # nthreads=1, N=20, loc=19
    # (:X)        392.319 μs (0 allocations: 0 bytes)
    # (:X_test)   433.751 μs (0 allocations: 0 bytes)
    # nthreads=2, N=20, loc=19
    # (:X)        260.719 μs (11 allocations: 1008 bytes)
    # (:X_test)   340.407 μs (0 allocations: 0 bytes)
    # nthreads=3, N=20, loc=19
    # (:X)        252.732 μs (42 allocations: 2.50 KiB)
    # (:X_test)   242.285 μs (0 allocations: 0 bytes)
    # nthreads=4, N=20, loc=19
    # (:X)        156.153 μs (47 allocations: 2.94 KiB)
    # (:X_test)   179.441 μs (0 allocations: 0 bytes)
    # nthreads=5, N=20, loc=19
    # (:X)        166.203 μs (51 allocations: 3.34 KiB)
    # (:X_test)   154.551 μs (0 allocations: 0 bytes)
    # nthreads=6, N=20, loc=19
    # (:X)        162.312 μs (56 allocations: 3.78 KiB)
    # (:X_test)   127.741 μs (0 allocations: 0 bytes)
    #
    # nthreads=1, N=27, loc=26
    # (:X)        86.306 ms (0 allocations: 0 bytes)
    # (:X_test)   168.872 ms (0 allocations: 0 bytes)
    # nthreads=2, N=27, loc=26
    # (:X)        81.571 ms (12 allocations: 1.02 KiB)
    # (:X_test)   104.165 ms (0 allocations: 0 bytes)
    # nthreads=3, N=27, loc=26
    # (:X)        80.946 ms (50 allocations: 3.20 KiB)
    # (:X_test)   99.071 ms (0 allocations: 0 bytes)
    # nthreads=4, N=27, loc=26
    # (:X)        82.700 ms (56 allocations: 3.67 KiB)
    # (:X_test)   96.059 ms (0 allocations: 0 bytes)
    # nthreads=5, N=27, loc=26
    # (:X)        82.321 ms (58 allocations: 3.62 KiB)
    # (:X_test)   95.548 ms (0 allocations: 0 bytes)
    # nthreads=6, N=27, loc=26
    # (:X)        84.283 ms (63 allocations: 4.06 KiB)
    # (:X_test)   91.106 ms (0 allocations: 0 bytes)
    #
    # nthreads=1, N=27, loc=27
    # (:X)        84.698 ms (0 allocations: 0 bytes)
    # (:X_test)   92.401 ms (0 allocations: 0 bytes)
    # nthreads=2, N=27, loc=27
    # (:X)        77.652 ms (46 allocations: 2.80 KiB)
    # (:X_test)   85.059 ms (0 allocations: 0 bytes)
    # nthreads=3, N=27, loc=27
    # (:X)        79.531 ms (50 allocations: 3.20 KiB)
    # (:X_test)   82.511 ms (0 allocations: 0 bytes)
    # nthreads=4, N=27, loc=27
    # (:X)        81.083 ms (56 allocations: 3.67 KiB)
    # (:X_test)   83.683 ms (0 allocations: 0 bytes)
    # nthreads=5, N=27, loc=27
    # (:X)        81.315 ms (58 allocations: 3.62 KiB)
    # (:X_test)   83.755 ms (0 allocations: 0 bytes)
    # nthreads=6, N=27, loc=27
    # (:X)        83.287 ms (63 allocations: 4.06 KiB)
    # (:X_test)   85.378 ms (0 allocations: 0 bytes)

    n_minus_loc = n - loc
    if n_minus_loc == 0
        loc_bit = 1<<(n-1)
        @inbounds @batch for k in 0 : (loc_bit - 1)
            idx_1 = k
            idx_2 = k | (1<<(n-1))
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    elseif n_minus_loc == 1
        loc_bit = 1<<(n-2)
        mask_1 = 1<<(n-1)
        @inbounds @batch for k in 0 : (loc_bit - 1)
            idx_1 = k 
            idx_2 = k | loc_bit
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_1
            idx_2 = k | (mask_1 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    elseif n_minus_loc == 2
        loc_bit = 1<<(n-3)
        mask_01 =            1<<(n-2)
        mask_10 = 1<<(n-1)
        mask_11 = 1<<(n-1) | 1<<(n-2)
        @inbounds @batch for k in 0 : (loc_bit - 1)
            idx_1 = k 
            idx_2 = k | loc_bit
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_01
            idx_2 = k | (mask_01 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_10
            idx_2 = k | (mask_10 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_11
            idx_2 = k | (mask_11 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    elseif n_minus_loc == 3
        loc_bit = 1<<(n-4)
        mask_001 =                       1<<(n-3)
        mask_010 =            1<<(n-2)
        mask_011 =            1<<(n-2) | 1<<(n-3)
        mask_100 = 1<<(n-1)
        mask_101 = 1<<(n-1)            | 1<<(n-3)
        mask_110 = 1<<(n-1) | 1<<(n-2)
        mask_111 = 1<<(n-1) | 1<<(n-2) | 1<<(n-3)
        @inbounds @batch for k in 0 : (loc_bit - 1)
            idx_1 = k 
            idx_2 = k | loc_bit
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_001
            idx_2 = k | (mask_001 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_010
            idx_2 = k | (mask_010 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_011
            idx_2 = k | (mask_011 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_100
            idx_2 = k | (mask_100 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_101
            idx_2 = k | (mask_101 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_110
            idx_2 = k | (mask_110 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
            idx_1 = k | mask_111
            idx_2 = k | (mask_111 | loc_bit)
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    else
        subspace_mul_X_test_large_loc_1!(st, n, loc)
    end
end

@inline function subspace_mul_X_test_large_loc_4!(st::AbstractVector, n::Int, loc::Int)
    # for loc≥5.
    # Features of this method:
    # (1) The number of iterations of the outer loop matches the number of threads,
    #     thereby fixing the highest bits of k in each thread, striving for good cache locality
    # (2) Compared to subspace_mul_X_test_large_loc_2!, this method only requires
    #     one operation of "recover k from k_continuous" in each thread
    #
    # nthreads=1, N=27, loc=27
    # (:X)        82.727 ms (0 allocations: 0 bytes)
    # (:X_test)   92.345 ms (0 allocations: 0 bytes)
    # nthreads=2, N=27, loc=27
    # (:X)        78.819 ms (46 allocations: 2.80 KiB)
    # (:X_test)   85.696 ms (0 allocations: 0 bytes)
    # nthreads=3, N=27, loc=27
    # (:X)        80.553 ms (50 allocations: 3.20 KiB)
    # (:X_test)   83.153 ms (0 allocations: 0 bytes)
    # nthreads=4, N=27, loc=27
    # (:X)        80.449 ms (55 allocations: 3.64 KiB)
    # (:X_test)   84.036 ms (0 allocations: 0 bytes)
    # nthreads=5, N=27, loc=27
    # (:X)        80.876 ms (58 allocations: 3.62 KiB)
    # (:X_test)   84.834 ms (0 allocations: 0 bytes)
    # nthreads=6, N=27, loc=27
    # (:X)        83.379 ms (63 allocations: 4.06 KiB)
    # (:X_test)   86.237 ms (0 allocations: 0 bytes)

    tot_threads = Threads.nthreads()
    tot_threads == 1 && return subspace_mul_X_test_large_loc_1!(st, n, loc)

    num_highbits = Base.min(log2i(tot_threads), n-1)
    loc < n-num_highbits && return subspace_mul_X_test_large_loc_2!(st, n, loc)

    num_threads = 1 << num_highbits
    mask_highbits = -1 << loc
    mask_lowbits = (1<<loc) - 1

    @inbounds @batch for k_continuous in 0 : (1<<(n-num_highbits)) : ((num_threads-1)<<(n-num_highbits))
        k_highbits = k_continuous & mask_highbits
        k_lowbits = (k_continuous & mask_lowbits) >> 1
        k = k_highbits | k_lowbits
        j_max = (1 << (n-1-num_highbits)) - 1
        for j in k : (k | j_max)
            idx_1 = j
            idx_2 = j | (1<<(loc-1))
            subspace_mul_X_test_swap!(st, idx_1, idx_2)
        end
    end
end

@inline function subspace_mul_X_test_large_loc_kernel!(st::AbstractVector, k::Int, loc_bit::Int)
    idx_1 = k
    idx_2 = k | loc_bit
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b001
    idx_2 = k | (0b001 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b010
    idx_2 = k | (0b010 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b011
    idx_2 = k | (0b011 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b100
    idx_2 = k | (0b100 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b101
    idx_2 = k | (0b101 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b110
    idx_2 = k | (0b110 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
    idx_1 = k | 0b111
    idx_2 = k | (0b111 | loc_bit)
    subspace_mul_X_test_swap!(st, idx_1, idx_2)
end


@inline @inbounds function subspace_mul_X_test_swap!(st::AbstractVector, idx_1::Int, idx_2::Int)
    tmp = st[idx_1+1]
    st[idx_1+1] = st[idx_2+1]
    st[idx_2+1] = tmp
end
