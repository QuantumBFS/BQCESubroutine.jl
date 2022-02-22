using BenchmarkTools
using BQCESubroutine
using YaoLocations

N = 25
M = 4
shift = 5
T = Float64
locs = Locations(shift+1:shift+M)
subspace = BQCESubroutine.bsubspace(N, locs)
comspace = BQCESubroutine.bcomspace(N, locs)
st = rand(T, 1<<N); U = rand(Float64, 1<<M, 1<<M);

nthreads = Threads.nthreads()
print("nthreads=$(nthreads), N=$N, M=$M")

if nthreads == 1
    BQCESubroutine.disable_threads()
    @benchmark BQCESubroutine.subspace_mul!(st, comspace, U, subspace) setup=(st = rand(T, 1<<N); U = rand(T, 1<<M, 1<<M))
else
    BQCESubroutine.enable_threads()
    @benchmark BQCESubroutine.threaded_subspace_mul_generic!(st, comspace, U, subspace) setup=(st = rand(T, 1<<N); U = rand(T, 1<<M, 1<<M))
end
