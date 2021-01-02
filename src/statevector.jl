# level 1 - generic routines
function broutine!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations)
    size(U, 1) == 2 && return broutine2x2!(st, U, locs)
    # NOTE: this is a very small overhead, and is very likely
    # to get optimized, we will always check these for the
    # sake of correctness.
    @assert log2dim(U) == length(locs) "operator dimension mismatch locs"
    n = log2dim(st)
    @assert n >= maximum(plain(locs)) "locs is too large"
    subspace = bsubspace(n, locs)
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace)
    return st
end

function broutine!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations, ctrl::CtrlLocations)
    size(U, 1) == 2 && return broutine2x2!(st, U, locs, ctrl)
    @assert log2dim(U) == length(locs) "operator dimension mismatch locs"
    n = log2dim(st)
    @assert n >= maximum(plain(locs)) "locs is too large"
    @assert isempty(intersect(locs, ctrl.storage)) "locs is overlapping with ctrl"
    # NOTE: this only adds a small constant overhead anyway
    # TODO: use StrideArray to optimize this away since its
    # stack allocated.
    subspace = bsubspace(n, sort(merge_locations(locs, ctrl.storage)))
    comspace = bcomspace(n, locs)
    subspace_mul!(st, comspace, U, subspace, ctrl_offset(ctrl))
    return st
end


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

function ctrl_offset(ctrl::CtrlLocations)
    locs = plain(ctrl)
    mask = 0
    for i in 1:length(ctrl)
        if ctrl.flags[i]
            mask += (1 << (locs[i] - 1))
        end
    end
    return mask
end

function broutine2x2!(st::AbstractVecOrMat, U::AbstractMatrix, locs::Locations, ctrl::CtrlLocations)
    U11 = U[1, 1]; U12 = U[1, 2];
    U21 = U[2, 1]; U22 = U[2, 2];
    _broutine2x2!(st, (U11,U12,U21,U22), locs, ctrl)
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
