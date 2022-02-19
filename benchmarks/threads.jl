using BQCESubroutine
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
# using PaddedMatrices
# using MatchCore
using MLStyle
using BQCESubroutine: BitContext, BitRoutine
using BQCESubroutine: diag_kernel, perm_kernel, generic_kernel, codegen_basic_broutine
using BQCESubroutine: codegen_broutine2x2_multi, codegen_broutine, hoist_entries!

BQCESubroutine.ENABLE_THREADS[]
BQCESubroutine.disable_threads()
U = rand(ComplexF64, 4, 4);
@benchmark broutine!(st, $U, Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
# BenchmarkTools.Trial: 10 samples with 1 evaluation.
#  Range (min … max):  113.962 ms … 153.278 ms  ┊ GC (min … max): 0.00% … 0.00%
#  Time  (median):     126.787 ms               ┊ GC (median):    0.00%
#  Time  (mean ± σ):   127.932 ms ±  12.216 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

#   ██     ██         █ █        ██       █                     █  
#   ██▁▁▁▁▁██▁▁▁▁▁▁▁▁▁█▁█▁▁▁▁▁▁▁▁██▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▁
#   114 ms           Histogram: frequency by time          153 ms <

#  Memory estimate: 688 bytes, allocs estimate: 11.

@benchmark instruct!(st, $U, (3, 24)) setup=(st=rand(ComplexF64, 1 << 25))
# BenchmarkTools.Trial: 12 samples with 1 evaluation.
#  Range (min … max):  46.249 ms … 65.934 ms  ┊ GC (min … max): 0.00% … 0.00%
#  Time  (median):     53.247 ms              ┊ GC (median):    0.00%
#  Time  (mean ± σ):   54.134 ms ±  6.104 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

#   █      ▁      █    ▁  ▁   ▁      ▁ ▁             ▁        ▁  
#   █▁▁▁▁▁▁█▁▁▁▁▁▁█▁▁▁▁█▁▁█▁▁▁█▁▁▁▁▁▁█▁█▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁█ ▁
#   46.2 ms         Histogram: frequency by time        65.9 ms <

#  Memory estimate: 7.04 KiB, allocs estimate: 91.

BQCESubroutine.enable_threads()
@code_lowered broutine!(rand(ComplexF64, 1<<25), Val(:Y), Locations((3, 24)))
@benchmark broutine!(st, $U, Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
# BenchmarkTools.Trial: 11 samples with 1 evaluation.
#  Range (min … max):  111.608 ms … 124.550 ms  ┊ GC (min … max): 0.00% … 0.00%
#  Time  (median):     115.227 ms               ┊ GC (median):    0.00%
#  Time  (mean ± σ):   116.064 ms ±   4.423 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

#   █                                                              
#   █▁▁▇▁▁▁▁▁▇▁▁▁▁▁▁▁▇▁▁▁▇▁▁▁▁▁▁▁▁▁▁▇▁▁▁▁▁▁▁▁▇▁▇▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▇ ▁
#   112 ms           Histogram: frequency by time          125 ms <

#  Memory estimate: 688 bytes, allocs estimate: 11.

BQCESubroutine.disable_threads()
# @benchmark broutine!(st, Val(:Z), Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
@benchmark broutine!(st, Val(:Y), Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
# BenchmarkTools.Trial: 13 samples with 1 evaluation.
#  Range (min … max):  57.518 ms … 74.135 ms  ┊ GC (min … max): 0.00% … 0.00%
#  Time  (median):     63.897 ms              ┊ GC (median):    0.00%
#  Time  (mean ± σ):   64.866 ms ±  5.459 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

#   ▁▁       ▁    ▁▁     ▁▁   ▁▁       ▁          ▁           █  
#   ██▁▁▁▁▁▁▁█▁▁▁▁██▁▁▁▁▁██▁▁▁██▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁█ ▁
#   57.5 ms         Histogram: frequency by time        74.1 ms <

#  Memory estimate: 0 bytes, allocs estimate: 0.

BQCESubroutine.enable_threads()
@benchmark broutine!(st, Val(:Y), Locations((3, 24))) setup=(st=rand(ComplexF64, 1 << 25))
# BenchmarkTools.Trial: 14 samples with 1 evaluation.
#  Range (min … max):  25.854 ms … 36.513 ms  ┊ GC (min … max): 0.00% … 0.00%
#  Time  (median):     29.662 ms              ┊ GC (median):    0.00%
#  Time  (mean ± σ):   30.505 ms ±  3.565 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

#   █   ██      ██   █ █  █  █  █               █       █  █  █  
#   █▁▁▁██▁▁▁▁▁▁██▁▁▁█▁█▁▁█▁▁█▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁█▁▁█▁▁█ ▁
#   25.9 ms         Histogram: frequency by time        36.5 ms <

#  Memory estimate: 3.66 KiB, allocs estimate: 41.

@benchmark instruct!(st, Val(:Y), (3, 24)) setup=(st=rand(ComplexF64, 1 << 25))
# BenchmarkTools.Trial: 14 samples with 1 evaluation.
#  Range (min … max):  24.012 ms … 40.079 ms  ┊ GC (min … max): 0.00% … 0.00%
#  Time  (median):     27.757 ms              ┊ GC (median):    0.00%
#  Time  (mean ± σ):   28.431 ms ±  3.943 ms  ┊ GC (mean ± σ):  0.00% ± 0.00%

#   ▁▁  ▁    █ █   ▁▁ ▁ ▁  ▁▁                                 ▁  
#   ██▁▁█▁▁▁▁█▁█▁▁▁██▁█▁█▁▁██▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▁
#   24 ms           Histogram: frequency by time        40.1 ms <

#  Memory estimate: 3.66 KiB, allocs estimate: 41.