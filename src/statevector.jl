# level 1 - generic routines

function broutine2x2!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations)
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    for loc in locs
        _broutine2x2!(st, (U11,U12,U21,U22), loc)
    end
    return st
end

# NOTE:
# wrapping the following code seems to have a small overhead
# so we are not wrapping them in a function here
function broutine2x2_kernel_expr(idx_1, idx_2)
    return quote
        ST1 = U11 * st[$idx_1] + U12 * st[$idx_2]
        ST2 = U21 * st[$idx_1] + U22 * st[$idx_2]
    
        st[$idx_1] = ST1
        st[$idx_2] = ST2
    end
end

function broutine2x2_m_kernel_expr(idx_1, idx_2)
    return quote
        ST1 = U11 * st[b, $idx_1] + U12 * st[b, $idx_2]
        ST2 = U21 * st[b, $idx_1] + U22 * st[b, $idx_2]
    
        st[b, $idx_1] = ST1
        st[b, $idx_2] = ST2
    end
end

# ST1 = U11 * st[j+i] + U12 * st[j+i+step_1]
# ST2 = U21 * st[j+i] + U22 * st[j+i+step_1]
# st[j+i] = ST1
# st[j+i+step_1] = ST2
body_broutine2x2 = quote
    step_1 = 1 << (plain(locs) - 1)
    step_2 = 1 << plain(locs)

    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 1)-step_1
            $(broutine2x2_kernel_expr(:(j+1), :(j+2)))
        end
        return st
    end
end

body_broutine2x2_m = quote
    step_1 = 1 << (plain(locs) - 1)
    step_2 = 1 << plain(locs)

    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 2)-step_1, b in 1:size(st, 1)
            $(broutine2x2_m_kernel_expr(:(j+1), :(j+2)))
        end
        return st
    end
end

init_broutine2x2_ctrl = quote
    raw = first(plain(locs))
    raw_ctrl = plain(ctrl)
    step_1 = 1 << (raw - 1)
    step_2 = 1 << raw
    ctrl_mask = bmask(raw_ctrl)
    flag_mask = reduce(+, one(Int) << (raw_ctrl[i] - 1) for i in 1:length(ctrl) if ctrl.flags[i])
end

body_broutine2x2_ctrl = quote
    $init_broutine2x2_ctrl
    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 1)-step_1
            if ismatch(j, ctrl_mask, flag_mask)
                $(broutine2x2_kernel_expr(:(j+1), :(j+2)))
            end
        end
        return st
    end
end

body_broutine2x2_ctrl_m = quote
    $init_broutine2x2_ctrl
    @inbounds if step_1 == 1
        for j in 0:step_2:size(st, 2)-step_1, b in 1:size(st, 1)
            if ismatch(j, ctrl_mask, flag_mask)
                $(broutine2x2_m_kernel_expr(:(j+1), :(j+2)))
            end
        end
        return st
    end
end

# case 1: we expand the inner loop of step_1 if it's smaller than 16
for k in [2,4,8,16]
    push!(body_broutine2x2.args, quote
        @inbounds if step_1 == $k
            for j in 0:step_2:size(st, 1)-step_1
                Base.Cartesian.@nexprs $k i-> begin
                    $(broutine2x2_kernel_expr(:(j+i), :(j+i+step_1)))
                end
            end
            return st
        end
    end)

    push!(body_broutine2x2_m.args, quote
        @inbounds if step_1 == $k
            for j in 0:step_2:size(st, 2)-step_1, b in 1:size(st, 1)
                Base.Cartesian.@nexprs $k i-> begin
                    $(broutine2x2_m_kernel_expr(:(j+i), :(j+i+step_1)))
                end
            end
            return st
        end
    end)

    push!(body_broutine2x2_ctrl.args, quote
        @inbounds if step_1 == $k
            for j in 0:step_2:size(st, 1)-step_1
                Base.Cartesian.@nexprs $k i->begin
                    if ismatch(j+i-1, ctrl_mask, flag_mask)
                        $(broutine2x2_kernel_expr(:(j+i), :(j+i+step_1)))
                    end
                end
            end
            return st
        end
    end)

    push!(body_broutine2x2_ctrl_m.args, quote
        @inbounds if step_1 == $k
            for j in 0:step_2:size(st, 2)-step_1, b in 1:size(st, 1)
                Base.Cartesian.@nexprs $k i->begin
                    if ismatch(j+i-1, ctrl_mask, flag_mask)
                        $(broutine2x2_m_kernel_expr(:(j+i), :(j+i+step_1)))
                    end
                end
            end
            return st
        end
    end)
end

# case 2: we expand the inner loop by 16, if step_1 is larger than 16
push!(body_broutine2x2.args, quote
    for j in 0:step_2:size(st, 1)-step_1
        for i in j:16:j+step_1-1
            Base.Cartesian.@nexprs 16 k->begin
                $(broutine2x2_kernel_expr(:(i+k), :(i+step_1+k)))
            end
        end
    end
    return st
end)

push!(body_broutine2x2_m.args, quote
    for j in 0:step_2:size(st, 2)-step_1, b in 1:size(st, 1)
        for i in j:16:j+step_1-1
            Base.Cartesian.@nexprs 16 k->begin
                $(broutine2x2_m_kernel_expr(:(i+k), :(i+step_1+k)))
            end
        end
    end
    return st
end)

push!(body_broutine2x2_ctrl.args, quote
    for j in 0:step_2:size(st, 1)-step_1
        for i in j:16:j+step_1-1
            Base.Cartesian.@nexprs 16 k->begin
                if ismatch(i+k-1, ctrl_mask, flag_mask)
                    $(broutine2x2_kernel_expr(:(i+k), :(i+step_1+k)))
                end
            end
        end
    end
    return st
end)

push!(body_broutine2x2_ctrl_m.args, quote
    for j in 0:step_2:size(st, 2)-step_1, b in 1:size(st, 1)
        for i in j:16:j+step_1-1
            Base.Cartesian.@nexprs 16 k->begin
                if ismatch(i+k-1, ctrl_mask, flag_mask)
                    $(broutine2x2_m_kernel_expr(:(i+k), :(i+step_1+k)))
                end
            end
        end
    end
    return st
end)

# create broutine2x2 function expr
def_broutine2x2 = Dict{Symbol, Any}(
    :name => :_broutine2x2!,
    :args => [:(st::AbstractVector), :((U11,U12,U21,U22)), :(locs::Locations)],
    :body => body_broutine2x2
)

def_broutine2x2_m = Dict{Symbol, Any}(
    :name => :_broutine2x2!,
    :args => [:(st::AbstractMatrix), :((U11,U12,U21,U22)), :(locs::Locations)],
    :body => body_broutine2x2_m
)

def_broutine2x2_ctrl = Dict{Symbol, Any}(
    :name => :_broutine2x2!,
    :args => [:(st::AbstractVector), :((U11,U12,U21,U22)), :(locs::Locations), :(ctrl::CtrlLocations)],
    :body => body_broutine2x2_ctrl,
)

def_broutine2x2_ctrl_m = Dict{Symbol, Any}(
    :name => :_broutine2x2!,
    :args => [:(st::AbstractMatrix), :((U11,U12,U21,U22)), :(locs::Locations), :(ctrl::CtrlLocations)],
    :body => body_broutine2x2_ctrl_m,
)

@eval $(combinedef(def_broutine2x2))
@eval $(combinedef(def_broutine2x2_m))
@eval $(combinedef(def_broutine2x2_ctrl))
@eval $(combinedef(def_broutine2x2_ctrl_m))

function broutine2x2!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations, ctrl::CtrlLocations)
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    for loc in locs
        _broutine2x2!(st, (U11,U12,U21,U22), locs, ctrl)
    end
    return st
end

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
