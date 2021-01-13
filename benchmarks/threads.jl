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

ctx = BitContext()
brt = BitRoutine(Main, :(X = [0 1;1 0]))
brt = BitRoutine(Main, :(SWAP = [1 0 0 0;
                0 0 1 0;
                0 1 0 0;
                0 0 0 1]))
ctx.expand_sz = 0

codegen_basic_broutine(ctx, brt)|>flatten_block
codegen_broutine2x2_multi(ctx, brt)
BQCESubroutine.BQCES_nthreads[] = 6

function threaded_broutine!(st::AbstractVector{T} where T, ::Val{:SWAP}, locs::Locations)
    plain_locs = (YaoLocations.plain)(locs)
    if plain_locs[1] > plain_locs[2]
        locs = Locations((plain_locs[2], plain_locs[1]))
    end

    step_1_l = 1 << (plain_locs[1] - 1)
    step_1_h = 1 << plain_locs[1]
    step_2_l = 1 << (plain_locs[2] - 1)
    step_2_h = 1 << plain_locs[2]

    nqubits = log2i(size(st, 1))
    nlocs_needed = log2i(BQCESubroutine.BQCES_nthreads[]-1) + 1

    # xxx|x0x0xxx
    if nlocs_needed ≤ nqubits - plain_locs[2]
        for idx1 = 0:step_2_h:size(st, 1) - step_2_h
            for idx2 = idx1:step_1_h:(idx1 + step_2_l) - step_1_h
                for idx3 = idx2:(idx2 + step_1_l) - 1
                    I2 = (idx3 + step_1_l) + 1
                    I3 = (idx3 + step_2_l) + 1
                    T2 = st[I3]
                    T3 = st[I2]
                    st[I2] = T2
                    st[I3] = T3
                end
            end
        end
        return st
    end

    # x0xx|xx0xxx
    # nlocs ≤ 10 - 4 - 1
    # 10 - 3 - 2
    # m = 10 - 3 - 1
    if nlocs_needed ≤ nqubits - plain_locs[1] - 1
        m = nqubits - nlocs_needed - 1
        c = 0
        for base in bsubspace(nqubits, (1:m..., plain_locs[2]))
            for idx2 in 0:step_1_h:(1 << m)-step_1_h
                for idx1 in idx2:idx2+step_1_l-1
                    I2 = (base + idx1 + step_1_l) + 1
                    I3 = (base + idx1 + step_2_l) + 1
                    T2 = st[I3]
                    T3 = st[I2]
                    st[I2] = T2
                    st[I3] = T3
                end
                c += 1
            end
        end
        return st
    end

    # x0x0x|xxxxx
    # m = 10 - 3 - 2
    m = nqubits - nlocs_needed - 2
    for base in bsubspace(nqubits, (1:m..., plain_locs...))
        for idx in 0:(1 << m)-1
            I2 = (base + idx + step_1_l) + 1
            I3 = (base + idx + step_2_l) + 1
            T2 = st[I3]
            T3 = st[I2]
            st[I2] = T2
            st[I3] = T3
        end
    end
    return st
end

st = rand(ComplexF64, 1 << 10);
threaded_broutine!(copy(st), Val(:SWAP), Locations((4, 9))) ≈ broutine!(copy(st), Val(:SWAP), Locations((4, 9)))
threaded_broutine!(copy(st), Val(:SWAP), Locations((7, 9))) ≈ broutine!(copy(st), Val(:SWAP), Locations((7, 9)))

function threaded_broutine!(st::AbstractVector{T} where T, ::Val{:X}, locs::Locations)
    plain_locs = plain(locs)
    step_1_l = 1 << (plain_locs[1] - 1)
    step_1_h = 1 << plain_locs[1]

    nqubits = log2i(size(st, 1))
    nlocs_needed = log2i(BQCESubroutine.BQCES_nthreads[]-1) + 1

    if nlocs_needed ≤ nqubits - plain_locs[1]
        for idx1 = 0:step_1_h:size(st, 1) - step_1_h
            for idx2 = idx1:(idx1 + step_1_l) - 1
                I1 = idx2 + 1
                I2 = (idx2 + step_1_l) + 1
                T1 = st[I2]
                T2 = st[I1]
                st[I1] = T1
                st[I2] = T2
            end
        end
        return st
    end

    m = nqubits - nlocs_needed - 1
    for base in bsubspace(nqubits, (1:m..., plain_locs[1]))
        for idx in 0:(1 << m)-1
            I1 = base + idx + 1
            I2 = base + idx + step_1_l + 1
            T1 = st[I2]
            T2 = st[I1]
            st[I1] = T1
            st[I2] = T2
        end
    end    
    return st
end

st = rand(ComplexF64, 1 << 10);
threaded_broutine!(copy(st), Val(:SWAP), Locations(9)) ≈ broutine!(copy(st), Val(:X), Locations(9))

x0xx|000000

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