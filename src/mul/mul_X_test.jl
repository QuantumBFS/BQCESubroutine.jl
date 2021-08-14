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
        # subspace_mul_X_test_kernel_1!(st, n, loc)
        # subspace_mul_X_test_kernel_2!(st, n, loc)
    end
end


@inline function subspace_mul_X_test_large_loc_1!(st::AbstractVector, n::Int, loc::Int) #loc≥5
    loc_bit = 1 << (loc-1)
    mask_highbits = -1 << loc
    mask_lowbits = ((1<<loc) - 1) & (-1 << 4)
    @inbounds @batch for k_highbits in 0 : (1<<loc) : ((1<<n)-1)
        for k in k_highbits : 8 : ((k_highbits | loc_bit) - 1)
            subspace_mul_X_test_large_loc_kernel!(st, k, loc_bit)
        end
    end
end


@inline function subspace_mul_X_test_large_loc_2!(st::AbstractVector, n::Int, loc::Int) #loc≥5
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
