using BQCESubroutine

# job dispatch
function get_indices(idx, stride)
    # subspace indices start from 1
    # batch indices start from 0
    x, y = divrem(idx-1, stride)
    return x+1, y
end

function div_thread(tid, len, rem)
    f = (tid - 1) * len + 1
    l = f + len - 1

    if rem > 0
        if tid <= rem
            f = f + (tid - 1)
            l = l + tid
        else
            f = f + rem
            l = l + rem
        end
    end
    return f:l
end

total_tasks(::AbstractVector, subspace) = length(subspace)
total_tasks(S::AbstractMatrix, subspace) = length(subspace) * (((size(S, 1)-1)>>>3)+1)



space = vec(collect(Iterators.product(1:10, 1:20, 1:15)))

len, rem = divrem(200, 12)

div_thread(2, len, rem)
get_indices(5, 20)
space[18]
stride = length(1:20)

i2, i1 = divrem(32, 10)

space[32]

xs = (1:10, 2:20, 3:10)
first.(xs)
space = CartesianSpace((10, 20, 15))

space[331]
strides(A)
space[331]
get_indices(331, 10)
get_indices(331, (10, 20))

space = BQCESubroutine.CartesianSpace(1:10, 0:20)
it = BQCESubroutine.schedule_task(space, 1, 12)
collect(it)

space[2]
prod(space.dims)
collect(space)
