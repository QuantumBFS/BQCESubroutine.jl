# specialize on the X gate
function subspace_mul!(st::AbstractVector, U::Val{:X_test_gpu}, loc::Int)
    n = log2dim(st)
    cu_st = CUDA.CuArray(st)

    if loc == 1
        CUDA.@cuda threads=1<<(n-1) subspace_mul_X_test_gpu_kernel_loc_1(cu_st)
    elseif loc == 2
        nothing
    else
        nothing
    end

    copyto!(st, cu_st)
    return st
end

function subspace_mul_X_test_gpu_kernel_loc_1(st)
    i = (threadIdx().x - 1) << 1
    @inbounds begin
        tmp = st[i+1]
        st[i+1] = st[(i|1)+1]
        st[(i|1)+1] = tmp
    end
    return nothing
end
