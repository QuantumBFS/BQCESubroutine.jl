struct Kernel
    st::Symbol
    locs::Symbol
    init::Vector{Any}
    brt
end

function Kernel(brt::BitRoutine)
    @gensym st locs
    return Kernel(st, locs, [], brt)
end
