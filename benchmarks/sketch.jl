using LinearAlgebra: Matrix
using BQCESubroutine, YaoLocations, LinearAlgebra
using BenchmarkTools

st0 = rand(Float64, 1<<10)
st1 = copy(st0)
st2 = copy(st0)
U = Diagonal(rand(Float64, 16))
U_dense = Matrix(U)
locs = Locations(1:4)

broutine!(st1, U, locs)
broutine!(st2, U, locs)

st1 == st2

@benchmark broutine!($st, $U, locs)
@benchmark broutine!($st, $U_dense, locs)

n = log2dim(st)
subspace = bsubspace(n, locs)
comspace = bcomspace(n, locs)
subspace_mul!(st, comspace, U, subspace)
@which subspace_mul!(st, comspace, U, subspace)

ex = :(1 + 2 * 3)