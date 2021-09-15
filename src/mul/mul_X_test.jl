# specialize on the X gate
function subspace_mul!(st::AbstractVector, U::Val{:X_test}, loc::Int)
    n = log2dim(st)

    if loc == 1
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

    loc_bit = 1 << (loc-1)
    mask_highbits = -1 << loc
    mask_lowbits = ((1<<loc) - 1) & (-1 << 4)
    @inbounds @batch for k_continuous in 0 : 16 : ((1<<n)-1)
        k_highbits = k_continuous & mask_highbits
        k_lowbits = (k_continuous & mask_lowbits) >>> 1
        k = k_highbits | k_lowbits
        subspace_mul_X_test_large_loc_kernel!(st, k, loc_bit)
    end
end


@inline function subspace_mul_X_test_large_loc_3!(st::AbstractVector, n::Int, loc::Int)
    # for loc≥5.
    # very poor performance when the number of threads is small,
    # probably due to bad cache locality

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

    tot_threads = Threads.nthreads()
    tot_threads == 1 && return subspace_mul_X_test_large_loc_1!(st, n, loc)

    num_highlocs = Base.min(log2i(tot_threads), n-1)
    loc < n-num_highlocs && return subspace_mul_X_test_large_loc_2!(st, n, loc)

    num_threads = 1 << num_highlocs
    mask_highbits = -1 << loc
    mask_lowbits = (1<<loc) - 1

    @inbounds @batch for k_continuous in 0 : (1<<(n-num_highlocs)) : ((num_threads-1)<<(n-num_highlocs))
        k_highbits = k_continuous & mask_highbits
        k_lowbits = (k_continuous & mask_lowbits) >>> 1
        k = k_highbits | k_lowbits
        j_max = (1 << (n-1-num_highlocs)) - 1
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
