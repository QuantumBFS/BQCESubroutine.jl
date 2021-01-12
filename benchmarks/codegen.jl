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
using BQCESubroutine: BitContext, BitRoutine, multi_broutine2x2!
using BQCESubroutine: diag_kernel, perm_kernel, generic_kernel
using BQCESubroutine: codegen_broutine2x2_multi, codegen_broutine, hoist_entries!

@macroexpand @broutine Y = [0 -im;im 0]
# basic-20-bits-Y-i=1-multi
@benchmark broutine!(st, $(Val(:Z)), $(Locations((3, 17)))) setup=(st=rand(ComplexF64, 1 << 20))
@benchmark instruct!(st, Val(:Z), (3, 17)) setup=(st=rand(ComplexF64, 1 << 20))

# basic-20-bits-S-i=17-gate ┤ 0.8832465838348875
# basic-20-bits-S-i=3-gate ┤ 0.795579209622498
# basic-20-bits-S-i=18-gate ┤ 0.8926513063755366
# basic-20-bits-Sdag-i=3-gate ┤ 0.9529207340082902
# basic-20-bits-X-i=3-ctrl ┤ 0.7848519929895648
# basic-10-bits-Z-i=2-multi ┤ 0.6627990369345832
# basic-10-bits-Z-i=8-multi ┤ 0.6245214469880459
# basic-10-bits-Z-i=9-multi ┤ 0.6202245454018435
# basic-10-bits-Z-i=7-multi ┤ 0.7710883355243844
# basic-10-bits-Z-i=3-multi ┤ 0.6952348346520592
# basic-10-bits-Z-i=1-multi ┤ 0.6359408894571779
# basic-15-bits-Z-i=12-multi ┤ 0.5699722332407775
# basic-15-bits-Z-i=14-multi ┤ 0.5424
# basic-15-bits-Z-i=2-multi ┤ 0.6872756282409254
# basic-15-bits-Z-i=3-multi ┤ 0.6120826709062003
# basic-15-bits-Z-i=13-multi ┤ 0.5722843450479234
# basic-15-bits-Z-i=1-multi ┤ 0.5986687392881342
# basic-15-bits-S-i=12-gate ┤ 0.8810141946795239
# basic-15-bits-S-i=14-gate ┤ 0.8860931655899354
# basic-15-bits-S-i=13-gate ┤ 0.8849728629579375
# param-20-bits-Rx-i=19-gate ┤ 0.9597644053363611
# param-20-bits-Rx-i=17-gate ┤ 0.9465065182057341
# param-20-bits-Rx-i=18-gate ┤ 0.9475768170977378
