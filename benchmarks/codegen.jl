using BQCESubroutine
using BQCESubroutine.Utilities
using LinearAlgebra
using YaoLocations: YaoLocations, plain, Locations, CtrlLocations, merge_locations
using Test
using BenchmarkTools
using YaoArrayRegister
using LoopVectorization
using BQCESubroutine: broutine2x2!
using BQCESubroutine: BitRoutine, generic_kernel, subspace_loop, codegen_broutine

brt = BitRoutine(:(X = [0 1;1 0]))

brt = BitRoutine(:(SWAP = [1 0 0 0;
0 0 1 0;
0 1 0 0;
0 0 0 1]))

brt = BitRoutine(:(T = [1 0;0 exp(im * π / 4)]))
brt = BitRoutine(:(Rx(θ::Real) = [cos(θ / 2) -im*sin(θ / 2); -im*sin(θ / 2) cos(θ / 2)]))
init, kernel = generic_kernel(brt, :st, :locs, :step)

subspace_loop(kernel, brt, :st, :step, :b)

init
ex = quote
    for b1 in 0:step_2_h:size(st, 1)-step_2_h
        for b2 in b1:step_1_h:b1+step_2_l-step_1_h, b3 in b2:b2+step_1_l-1
        end
    end
end

quote
    $step_1 = 1 << (first($plain($locs)) - 1)
    $step_2 = 1 << first($plain($locs))
    for $j in 0:$step_2:size($st, 1) - $step_1
        for $i in $j:$n:$j+$step_1-1
        end
    end
end

collect(0:8:32-1)


ex.args[2].args[2].args
$loc_1 = first($plain($locs))
$loc_2 = last($plain($locs))

step_1 = step_1_h = 1 << loc_1
step_2 = step_1_l = 1 << (loc_1 - 1)
step_3 = step_2_h = 1 << loc_2
step_4 = step_2_l = 1 << (loc_2 - 1)
