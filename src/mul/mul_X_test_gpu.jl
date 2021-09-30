# specialize on the X gate
function subspace_mul!(st::AbstractVector, U::Val{:X_test_gpu}, loc::Int)
    n = log2dim(st)

    if loc == 1
        @cuda threads=1<<(n-1) subspace_mul_X_test_gpu_kernel_loc_1(st)
    elseif loc == 2
        nothing
    else
        nothing
    end

    return st
end

function subspace_mul_X_test_gpu_kernel_loc_1(st)
    i = threadIdx().x - 1
    @inbounds begin
        tmp = st[i+1]
        st[i+1] = st[(i|1)+1]
        st[(i|1)+1] = tmp
    end
end
