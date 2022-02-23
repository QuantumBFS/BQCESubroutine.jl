using BQCESubroutine
using BQCESubroutine: CartesianSpace, CartesianPartition, 
    broutine!, threaded_subspace_mul_generic!
using YaoLocations
using YaoArrayRegister
using Test

@testset "threaded_subspace_mul_generic!" for M = 2:4
    N = 20
    T = Float64
    locs = Locations(1:M)

    st = rand(T, 1<<N)
    st_mat = rand(T, 1<<N, 1<<M)
    st_mat2 = Matrix(st_mat')
    U = rand(T, 1<<M, 1<<M)

    nthreads = 4
    subspace = BQCESubroutine.bsubspace(N, locs)
    comspace = BQCESubroutine.bcomspace(N, locs)
    space = CartesianSpace(st, subspace)
    space_mat = CartesianSpace(st_mat2, subspace)
    @test space[1] == 1 && space_mat[1] == (1, 1)
    @test isapprox(broutine!(copy(st), U, locs), instruct!(copy(st), U, tuple(1:M...)))
    @test isapprox(broutine!(copy(st), U, locs), threaded_subspace_mul_generic!(copy(st), comspace, U, subspace))
    @test isapprox(instruct!(copy(st_mat), U, tuple(1:M...)), broutine!(copy(st_mat2), U, locs)')
    @test isapprox(instruct!(copy(st_mat), U, tuple(1:M...)), threaded_subspace_mul_generic!(copy(st_mat2), comspace, U, subspace)')
end
