using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test

function naive_routine!(r::AbstractVecOrMat, U::AbstractMatrix, loc::Int)
    n = log2i(size(r, 1))
    return kron(I(1<<(n-loc+1)), U, I(1<<loc))
end

using StaticArrays
using BenchmarkTools
using YaoArrayRegister

st = rand(ComplexF64, 1 << 8)
U = rand(ComplexF64, 1 << 5, 1 << 5)
SU = @SMatrix rand(ComplexF64, 1 << 2, 1 << 2)
locs = Locations((1, 3, 4, 5, 6))

@test instruct!(copy(st), U, locs.storage) ≈ broutine!(copy(st), U, locs)

@benchmark broutine!($(copy(st)), $U, locs)
@benchmark broutine!($(copy(st)), $SU, locs)
@benchmark instruct!($(copy(st)), $U, $(locs.storage))
@benchmark instruct!($(copy(st)), $SU, $(locs.storage))

st = transpose(rand(ComplexF64, 1000, 1 << 8))
@test instruct!(copy(st), U, locs.storage) ≈ broutine!(copy(st), U, locs)

U = rand(ComplexF64, 1 << 3, 1 << 3)
SU = @SMatrix rand(ComplexF64, 1 << 3, 1 << 3)
locs = Locations((1, 3, 4))

@benchmark broutine!($(deepcopy(st)), $U, locs)
@benchmark instruct!($(deepcopy(st)), $U, $(locs.storage))

st = rand(ComplexF64, 1 << 8, 1000);
@benchmark broutine!($(deepcopy(st)), $SU, locs)

@benchmark broutine!($(copy(st)), $SU, locs)
@benchmark instruct!($(copy(st)), $SU, $(locs.storage))

U = rand(ComplexF64, 1 << 2, 1 << 2)
SU = @SMatrix rand(ComplexF64, 1 << 2, 1 << 2)
locs = Locations((1, 3))

@benchmark broutine!($(copy(st)), $U, locs)
@benchmark instruct!($(copy(st)), $U, $(locs.storage))

using BQCESubroutine: ctrl_offset

ctrl = CtrlLocations((2, ))

for i in bsubspace(8, locs)
    for k in bcomspace(8, locs)
        @show i + k + 1 + ctrl_offset(ctrl)
    end
end

bsubspace(8, locs)

bcomspace(8, locs) .+ ctrl_offset(ctrl)
string.(bcomspace(8, locs) .+ ctrl_offset(ctrl); base=2, pad=8)
locs = locs[1:2]

@test broutine!(copy(st), SU, locs, ctrl) ≈ instruct!(copy(st), SU, plain(locs), plain(ctrl), (1, ))
@benchmark broutine!($(copy(st)), $SU, $locs, $ctrl)
@benchmark instruct!($(copy(st)), $SU, $(plain(locs)), $(plain(ctrl)), (1, ))

string(ctrl_offset(ctrl);base=2, pad=8)
_locs = sort(merge_locations(locs, ctrl.storage))
subspace = bsubspace(8, _locs)
comspace = bcomspace(8, _locs)

for i in subspace
    for k in comspace
        println(string(k;base=2, pad=8))
        # println(string(i + k + 2;base=2, pad=8))
    end
end

st = rand(ComplexF64, 1 << 8);
U = rand(ComplexF64, 2, 2);
loc = Locations(2);
broutine!(copy(st), U, loc) ≈ instruct!(copy(st), U, (plain(loc),))
@benchmark broutine!($(copy(st)), $U, $loc)
@benchmark instruct!($(copy(st)), $U, ($(plain(loc)),))
