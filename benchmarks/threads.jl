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
using BQCESubroutine: diag_kernel, perm_kernel, generic_kernel
using BQCESubroutine: codegen_broutine2x2_multi, codegen_broutine, hoist_entries!


function thread_region(n::Int, sorted_locs::Locations, nthreads::Int)
    count = log2i(nthreads) + 1
    for loc in n:-1:1
        loc in plain(sorted_locs) && continue
        count -= 1
        count < 0 && return loc+1
    end
    return 1
end

thread_region(10, Locations((2, 7, 9)), 6)

n = 10
nthreads = 6
nlocs_needed = log2i(nthreads)+1
(6,8,10)
(2, 7, 9)
x0x0x|xxx0x
x0x0x|00000

foreach(bsubspace(10, (1,2,3,4,5,7,9))) do x
    println(string(x; base=2, pad=10))
end

loc = 9
step_1_h = 1 << loc
step_1_l = 1 << (loc - 1)
step_2_h = 1 << (n - log2i(nthreads) - 2)

for idx1 in 0:step_1_h:((1<<n)-step_1_h)
    for idx2 in idx1:step_2_h:idx1+step_1_l-1
        println(string(idx2; base=2, pad=10))
    end
end


m = n - log2i(nthreads) - 2
for base in bsubspace(n, (1:m..., loc))
    for x in 0:(1<<m)-1
        println(string(base + x; base=2, pad=10))
    end
end

step_1_h = 1 << loc
step_1_l = 1 << (loc - 1)

for idx1 in 0:step_1_h:(1<<n)-step_1_h
    for idx2 in idx1:idx1 + step_1_l-1
        println(string(idx2; base=2, pad=10))
    end
end

string((1 <<(m))-1;base=2, pad=10)

# xxx0xx
10 - 9
xxx0xxxxxx
if n - loc ≥ log2i(nthreads) + 1
else # x0xx|xxx0xx
    m = n - log2i(nthreads) - 2
    for base in bsubspace(n, (1:m..., loc))
        for x in 0:1<<(m+1)-1
            println(string(base + x; base=2, pad=10))
        end
    end
end
10 - 3