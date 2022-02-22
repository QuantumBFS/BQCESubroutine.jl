using BenchmarkTools
using BQCESubroutine
using YaoLocations

N = 20
M = 4
T = Float64
locs = Locations(1:M)

st = rand(T, 1<<N)
U = rand(T, 1<<M, 1<<M)

subspace = BQCESubroutine.bsubspace(N, locs)
comspace = BQCESubroutine.bcomspace(N, locs)
# space = BQCESubroutine.CartesianSpace(st, subspace)
# [[subspace[s] for s in BQCESubroutine.schedule_task(space, i, Threads.nthreads())] for i = 1:Threads.nthreads()]

# isapprox(
@show BQCESubroutine.broutine!(copy(st), U, locs)[1]
@show BQCESubroutine.threaded_subspace_mul_generic!(copy(st), comspace, U, subspace)[1]
@show BQCESubroutine.threaded_subspace_mul_generic!(copy(st), comspace, U, subspace)[2]

# nthreads = Threads.nthreads()
# print("nthreads=$(nthreads), N=$N, M=$M")

# # if nthreads == 1
#     BQCESubroutine.disable_threads()
#     @benchmark BQCESubroutine.subspace_mul!(st, comspace, U, subspace) setup=(st = rand(Float64, 1<<N); U = rand(Float64, 1<<M, 1<<M))
# # else
#     BQCESubroutine.enable_threads()
#     @benchmark BQCESubroutine.threaded_subspace_mul_generic!(st, comspace, U, subspace) setup=(st = rand(Float64, 1<<N); U = rand(Float64, 1<<M, 1<<M))
# # end
