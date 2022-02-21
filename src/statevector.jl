# level 1 - generic routines

# level 2 - special matrix routines

# level 3 - intrinsic gate routines
@broutine X = [0 1;1 0]
@broutine Y = [0 -im;im 0]
@broutine Z = [1 0;0 -1]
@broutine H = [1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2)]
@broutine T = [1 0;0 exp(im * π / 4)]
@broutine S = [1 0;0 im]
@broutine Sdag = [1 0;0 -im]
@broutine Tdag = [1 0;0 exp(-im * π / 4)]
@broutine Rx(θ::Real) = [cos(θ / 2) -im*sin(θ / 2); -im*sin(θ / 2) cos(θ / 2)]
@broutine Ry(θ::Real) = [cos(θ / 2) -sin(θ / 2); sin(θ / 2) cos(θ / 2)]
@broutine Rz(θ::Real) = [exp(-im * θ / 2) 0; 0 exp(im * θ / 2)]

@broutine PSWAP(θ) = [-im * sin(θ/2) + cos(θ/2) 0 0 0;
                0 cos(θ/2) -im * sin(θ/2) 0;
                0 -im * sin(θ/2) cos(θ/2) 0;
                0 0 0 -im * sin(θ/2) + cos(θ/2)]

# @broutine SWAP = [1 0 0 0;
#                 0 0 1 0;
#                 0 1 0 0;
#                 0 0 0 1]
#
# NOTE: the compiler seems to be happier without us optimizing the kernel function
#      don't remove T1 and T4, so let's just define this manually :(

const BSWAP = [1 0 0 0;
                0 0 1 0;
                0 1 0 0;
                0 0 0 1]

@inline function unsafe_swap_kernel(st, b3, step_2, step_4)
    @fastmath @inbounds begin
        i1 = b3+1
        i2 = b3+step_2+1
        i3 = b3+step_4+1
        i4 = b3+step_2+step_4+1

        T1 = st[i1]
        T2 = st[i3]
        T3 = st[i2]
        T4 = st[i4]

        st[i1] = T1
        st[i2] = T2
        st[i3] = T3
        st[i4] = T4
    end
end

@inline function unsafe_swap_kernel(st, b, b3, step_2, step_4)
    @fastmath @inbounds begin
        i1 = b3+1
        i2 = b3+step_2+1
        i3 = b3+step_4+1
        i4 = b3+step_2+step_4+1

        T1 = st[b, i1]
        T2 = st[b, i3]
        T3 = st[b, i2]
        T4 = st[b, i4]

        st[b, i1] = T1
        st[b, i2] = T2
        st[b, i3] = T3
        st[b, i4] = T4
    end
end

function _swap_step(locs)
    loc_1 = first(plain(locs))
    loc_2 = last(plain(locs))

    if loc_1 > loc_2
        loc_1 = last(plain(locs))
        loc_2 = first(plain(locs))
    end

    step_1 = 1 << loc_1
    step_2 = 1 << (loc_1 - 1)
    step_3 = 1 << loc_2
    step_4 = 1 << (loc_2 - 1)

    return step_1, step_2, step_3, step_4
end

function broutine!(st::AbstractVector, ::Val{:SWAP}, locs::Locations)
    @assert length(locs) == 2 "number of locations mismatch"
    step = _swap_step(locs)

    @fastmath @inbounds for b1 in 0:step[3]:size(st, 1)-step[3]
        for b2 in b1:step[1]:b1+step[4]-step[1]
            for b3 in b2:b2+step[2]-1
                unsafe_swap_kernel(st, b3, step[2], step[4])
            end
        end
    end
    return st
end

function broutine!(st::AbstractMatrix, ::Val{:SWAP}, locs::Locations)
    @assert length(locs) == 2 "number of locations mismatch"
    step = _swap_step(locs)

    @fastmath @inbounds for b1 in 0:step[3]:size(st, 2)-step[3]
        for b2 in b1:step[1]:b1+step[4]-step[1]
            for b3 in b2:b2+step[2]-1, b in axes(st, 1)
                unsafe_swap_kernel(st, b, b3, step[2], step[4])
            end
        end
    end
    return st
end

function broutine!(st::AbstractVector, ::Val{:SWAP}, locs::Locations, ctrl::CtrlLocations)
    @assert length(locs) == 2 "number of locations mismatch"
    step = _swap_step(locs)

    raw_ctrl = plain(ctrl)
    ctrl_mask = bmask(raw_ctrl)
    flag_mask = reduce(+, one(Int) << (raw_ctrl[i] - 1) for i in 1:length(ctrl) if ctrl.flags[i])

    @fastmath @inbounds for b1 in 0:step[3]:size(st, 1)-step[3]
        for b2 in b1:step[1]:b1+step[4]-step[1]
            for b3 in b2:b2+step[2]-1
                if ismatch(b3, ctrl_mask, flag_mask)
                    unsafe_swap_kernel(st, b3, step[2], step[4])
                end
            end
        end
    end
    return st
end

function broutine!(st::AbstractMatrix, ::Val{:SWAP}, locs::Locations, ctrl::CtrlLocations)
    @assert length(locs) == 2 "number of locations mismatch"
    step = _swap_step(locs)

    raw_ctrl = plain(ctrl)
    ctrl_mask = bmask(raw_ctrl)
    flag_mask = reduce(+, one(Int) << (raw_ctrl[i] - 1) for i in 1:length(ctrl) if ctrl.flags[i])

    @fastmath @inbounds for b1 in 0:step[3]:size(st, 2)-step[3]
        for b2 in b1:step[1]:b1+step[4]-step[1]
            for b3 in b2:b2+step[2]-1, b in axes(st, 1)
                if ismatch(b3, ctrl_mask, flag_mask)
                    unsafe_swap_kernel(st, b, b3, step[2], step[4])
                end
            end
        end
    end
    return st
end
