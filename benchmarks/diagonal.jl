using Test
using BenchmarkTools
using LinearAlgebra
using BQCESubroutine
using YaoLocations

# TODO: complex + diagonal ?
# TODO: check if (dense) Matrix is diagonal?

N = 15
M = 4

@testset "diagonal (real)" begin
    st = rand(Float64, 1<<N)
    st_mat = rand(Float64, 5, 1<<N)
    U = Diagonal(rand(Float64, 1<<M))
    U_dense = Matrix(U)
    locs = Locations(1:M)

    st1 = broutine!(copy(st), U, locs)          # @benchmark
    st2 = broutine!(copy(st), U_dense, locs)    # @benchmark
    @test st1 ≈ st2

    st1 = broutine!(copy(st_mat), U, locs)          # @benchmark
    st2 = broutine!(copy(st_mat), U_dense, locs)    # @benchmark
    @test st1 ≈ st2
end

@testset "diagonal (complex)" begin
    st = rand(ComplexF64, 1<<N)
    st_mat = rand(ComplexF64, 5, 1<<N)
    U = Diagonal(rand(ComplexF64, 1<<M))
    U_dense = Matrix(U)
    locs = Locations(1:M)

    st1 = broutine!(copy(st), U, locs)          # @benchmark
    st2 = broutine!(copy(st), U_dense, locs)    # @benchmark
    @test st1 ≈ st2

    st1 = broutine!(copy(st_mat), U, locs)          # @benchmark
    st2 = broutine!(copy(st_mat), U_dense, locs)    # @benchmark
    @test st1 ≈ st2
end
