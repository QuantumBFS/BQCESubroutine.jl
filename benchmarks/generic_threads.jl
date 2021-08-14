using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations

N = 20
M = 4
st = rand(Float64, 1<<N)
#st_mat = rand(Float64, 5, 1<<N)
U = rand(Float64, 1<<M, 1<<M)
locs = Locations(1:M)

subspace = BQCESubroutine.bsubspace(N, locs)
comspace = BQCESubroutine.bcomspace(N, locs)

nthreads = Threads.nthreads()
print("nthreads=$(nthreads), N=$N, M=$M")

if nthreads == 1
    BQCESubroutine.disable_threads()
    @btime st1 = BQCESubroutine.subspace_mul!(copy(st), comspace, U, subspace)
else
    BQCESubroutine.enable_threads()
    @btime st1 = BQCESubroutine.threaded_subspace_mul_generic!(copy(st), comspace, U, subspace)
end
