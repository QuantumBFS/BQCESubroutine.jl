using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using StaticArrays
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using BQCESubroutine: subspace_mul!, subspace_mul_generic!, subspace_mul4x4!
using StrideArrays

function subspace_smm!(st::AbstractMatrix, indices, U::AbstractMatrix, subspace)
    @inbounds @views for k in subspace
        idx = k .+ indices
        for b in 1:size(st, 1)
            st[b, idx] = U * st[b, idx]
        end
    end
    return st
end

n = 20
locs = Locations((3,4,5))
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
U = rand(ComplexF64, 8, 8)
static_indices = @SVector [i+1 for i in comspace]
stride_indices = StrideArray(MVector(static_indices));
st=rand(ComplexF64, 100, 1 << n)
subspace_smm!(copy(st), static_indices, U, subspace) ≈ subspace_mul_generic!(copy(st), stride_indices, U, subspace)

subspace_smm!(copy(st), static_indices, U, subspace) ≈ subspace_mul!(copy(st), comspace, U, subspace)
@benchmark subspace_smm!(st, $static_indices, $U, $subspace) setup=(st=rand(ComplexF64, 100, 1 << $n))
@benchmark subspace_mul_generic!(st, $stride_indices, $U, $subspace) setup=(st=rand(ComplexF64, 100, 1 << $n))
@benchmark subspace_mul!(st, $comspace, $U, $subspace) setup=(st=rand(ComplexF64, 100, 1 << $n))

locs = Locations((3,5,15))
broutine!(copy(st), U, locs) ≈ transpose(instruct!(transpose(copy(st)), U, Tuple(locs)))
@benchmark broutine!($(copy(st)), $U, $locs)
@benchmark instruct!(st, $U, $(Tuple(locs))) setup=(st=transpose(rand(ComplexF64, 100, 1 << $n)))


n = 20
locs = Locations((3,4,5,6))
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
U = rand(ComplexF64, 16, 16)
static_indices = @SVector [i+1 for i in comspace]
stride_indices = StrideArray(MVector(static_indices));
st=rand(ComplexF64, 1 << n)
broutine!(copy(st), U, locs) ≈ instruct!(copy(st), U, Tuple(locs))
@benchmark broutine!(st, $U, $locs) setup=(st=rand(ComplexF64, 1 << $n))
@benchmark instruct!(st, $U, $(Tuple(locs))) setup=(st=rand(ComplexF64, 1 << $n))
