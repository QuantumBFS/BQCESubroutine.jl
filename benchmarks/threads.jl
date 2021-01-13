using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using PaddedMatrices
using MatchCore
using MLStyle
using BQCESubroutine: BitContext, BitRoutine
using BQCESubroutine: diag_kernel, perm_kernel, generic_kernel, codegen_basic_broutine
using BQCESubroutine: codegen_broutine2x2_multi, codegen_broutine, hoist_entries!

BQCESubroutine.ENABLE_THREADS[]
BQCESubroutine.disable_threads()
U = rand(ComplexF64, 4, 4);
@benchmark broutine!(st, $U, Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark instruct!(st, $U, (3, 24)) setup=(st=rand(ComplexF64, 1 << 25))

BQCESubroutine.disable_threads()
@benchmark broutine!(st, Val(:Z), Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))

BQCESubroutine.enable_threads()
@benchmark broutine!(st, Val(:Y), Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark instruct!(st, Val(:Y), (3, 24)) setup=(st=rand(ComplexF64, 1 << 25))
