using Polyester
using BenchmarkTools

@inline function scheduler(L::Integer, tid, nthreads)
    N = L ÷ 2
    bsize = N ÷ nthreads
    tid < nthreads && return (tid-1)*bsize*2:2:tid*bsize*2-2
    return (tid-1)*bsize*2:2:N*2-2
end

@inline function kernel_vec(x, iter)
    for i in iter
        @inbounds begin
            temp = x[i+1]
            x[i+1] = x[i+2]
            x[i+2] = temp
        end
    end
    return x
end

@inline function kernel_mat(x, iter)
    bs = size(x, 1)
    for i in iter
        for b in 1:bs
            @inbounds begin
                temp = x[b, i+1]
                x[b, i+1] = x[b, i+2]
                x[b, i+2] = temp
            end
        end
    end
    return x
end

function seriel_X1(x::Vector{T}) where T
    for i in 0:2:length(x)-2
        @inbounds begin
            temp = x[i+1]
            x[i+1] = x[i+2]
            x[i+2] = temp
        end
    end
    return x
end
function batch_X1(x::Vector{T}) where T
    nthreads = Threads.nthreads()
    N = length(x)
    @batch for tid = 1:nthreads
        # t = time()
        kernel_vec(x, scheduler(N, tid, nthreads))
        # t = time() - t
        # @show tid, t
    end
    return x
end
function threads_X1(x::Vector{T}) where T
    nthreads = Threads.nthreads()
    N = length(x)
    Threads.@threads for tid = 1:nthreads
        kernel_vec(x, scheduler(N, tid, nthreads))
    end
    return x
end
function seriel_X1(x::Matrix{T}) where T
    batch_size, state_size = size(x)
    for i in 0:2:state_size-2
        @inbounds for b in 1:batch_size
            temp = x[b, i+1]
            x[b, i+1] = x[b, i+2]
            x[b, i+2] = temp
        end
    end
    return x
end
function batch_X1(x::Matrix{T}) where T
    nthreads = Threads.nthreads()
    batch_size, state_size = size(x)
    @batch for tid in 1:nthreads
        kernel_mat(x, scheduler(state_size, tid, nthreads))
    end
    return x
end
function threads_X1(x::Matrix{T}) where T
    nthreads = Threads.nthreads()
    batch_size, state_size = size(x)
    Threads.@threads for tid in 1:nthreads
        kernel_mat(x, scheduler(state_size, tid, nthreads))
    end
    return x
end

N = 29
M = 8
B = 1<<M
T = ComplexF64
nthreads = Threads.nthreads()

x=rand(T, 1<<N);
batch_X1(x);
@time seriel_X1(x);

begin
    b0_vec = @benchmark seriel_X1(x) setup=(x=rand(T, 1<<N))
    bb_vec = @benchmark batch_X1(x) setup=(x=rand(T, 1<<N))
    bt_vec = @benchmark threads_X1(x) setup=(x=rand(T, 1<<N))
    kt_vec = @benchmark kernel_vec(x, scheduler(1<<N, rand(1:nthreads), nthreads)) setup=(x=rand(T, 1<<N))
    println("nthreads = $(nthreads), N = $N, B = $B, T = $T\nvector")
    println("\ttime: single: $(mean(b0_vec).time/1e6) ms, @batch: $(mean(bb_vec).time/1e6) ms, @threads: $(mean(bt_vec).time/1e6) ms, kernel: $(mean(kt_vec).time/1e6) ms")
    println("\tspeedups: @batch = $(mean(b0_vec).time/mean(bb_vec).time), @threads = $(mean(b0_vec).time/mean(bt_vec).time)")
end
begin
    b0_mat = @benchmark seriel_X1(x) setup=(x=rand(T, B, 1<<(N-M)))
    bb_mat = @benchmark batch_X1(x) setup=(x=rand(T, B, 1<<(N-M)))
    bt_mat = @benchmark threads_X1(x) setup=(x=rand(T, B, 1<<(N-M)))
    kt_mat = @benchmark kernel_mat(x, scheduler(1<<(N-M), rand(1:nthreads), nthreads)) setup=(x=rand(T, B, 1<<(N-M)))
    println("matrix\n\ttime: single: $(mean(b0_mat).time/1e6) ms, @batch: $(mean(bb_mat).time/1e6) ms, @threads: $(mean(bt_mat).time/1e6) ms, kernel: $(mean(kt_mat).time/1e6) ms")
    println("\tspeedups: @batch = $(mean(b0_mat).time/mean(bb_mat).time), @threads = $(mean(b0_mat).time/mean(bt_mat).time)")
end

# nthreads = 1, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 757.138058 ms, @batch: 747.018349 ms, @threads: 711.546511 ms, kernel: 696.3118 ms
#         speedups: @batch = 1.0135468011107716, @threads = 1.064073881742356
# matrix
#         time: single: 705.013298 ms, @batch: 731.111014 ms, @threads: 767.309461 ms, kernel: 684.697886 ms
#         speedups: @batch = 0.9643040311248819, @threads = 0.9188122052883172
# nthreads = 2, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 758.948844 ms, @batch: 427.72366 ms, @threads: 380.410896 ms, kernel: 340.503834 ms
#         speedups: @batch = 1.7743906053735723, @threads = 1.995076513265803
# matrix
#         time: single: 701.143214 ms, @batch: 400.370238 ms, @threads: 423.890585 ms, kernel: 345.450667 ms
#         speedups: @batch = 1.751237098697631, @threads = 1.6540664945412742
# nthreads = 3, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 774.086713 ms, @batch: 440.598266 ms, @threads: 395.602408 ms, kernel: 228.738447 ms
#         speedups: @batch = 1.7568991363211584, @threads = 1.9567290222358809
# matrix
#         time: single: 707.916779 ms, @batch: 375.911029 ms, @threads: 326.691795 ms, kernel: 230.162201 ms
#         speedups: @batch = 1.883203003868237, @threads = 2.1669254931854045
# nthreads = 4, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 669.029929 ms, @batch: 327.990488 ms, @threads: 287.821502 ms, kernel: 166.750851 ms
#         speedups: @batch = 2.039784547044547, @threads = 2.3244612523771764
# matrix
#         time: single: 805.944257 ms, @batch: 276.879919 ms, @threads: 295.451252 ms, kernel: 176.909151 ms
#         speedups: @batch = 2.910807905141001, @threads = 2.7278417388463123
# nthreads = 5, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 811.823538 ms, @batch: 499.356784 ms, @threads: 313.638338 ms, kernel: 135.188897 ms
#         speedups: @batch = 1.6257384780017328, @threads = 2.5884065805756182
# matrix
#         time: single: 714.276448 ms, @batch: 278.286876 ms, @threads: 286.340169 ms, kernel: 136.124786 ms
#         speedups: @batch = 2.5666911004455706, @threads = 2.494503130645285
# nthreads = 6, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 668.352429 ms, @batch: 277.517347 ms, @threads: 275.808225 ms, kernel: 115.903315 ms
#         speedups: @batch = 2.4083266729989314, @threads = 2.423250535766292
# matrix
#         time: single: 685.491621 ms, @batch: 218.34573 ms, @threads: 299.880532 ms, kernel: 115.708221 ms
#         speedups: @batch = 3.139478024140889, @threads = 2.285882369316325
# nthreads = 7, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 659.121349 ms, @batch: 309.260986 ms, @threads: 369.67255 ms, kernel: 95.736375 ms
#         speedups: @batch = 2.1312786896437044, @threads = 1.7829869948417862
# matrix
#         time: single: 697.684233 ms, @batch: 348.150284 ms, @threads: 335.357419 ms, kernel: 99.306742 ms
#         speedups: @batch = 2.003974332532786, @threads = 2.080419854972703
# nthreads = 8, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 730.27713 ms, @batch: 591.467167 ms, @threads: 373.561413 ms, kernel: 88.229665 ms
#         speedups: @batch = 1.234687520702227, @threads = 1.954905149692214
# matrix
#         time: single: 716.827122 ms, @batch: 391.814804 ms, @threads: 343.247666 ms, kernel: 119.122699 ms
#         speedups: @batch = 1.829504946423617, @threads = 2.088367068459542
# nthreads = 9, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 747.910207 ms, @batch: 296.184118 ms, @threads: 402.676153 ms, kernel: 77.234656 ms
#         speedups: @batch = 2.5251529759607165, @threads = 1.857349141308599
# matrix
#         time: single: 710.844421 ms, @batch: 343.033078 ms, @threads: 338.07297 ms, kernel: 75.754215 ms
#         speedups: @batch = 2.0722328737055498, @threads = 2.1026360699585065
# nthreads = 10, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 748.423444 ms, @batch: 425.088183 ms, @threads: 333.194189 ms, kernel: 66.774203 ms
#         speedups: @batch = 1.7606310265275005, @threads = 2.246207973332932
# matrix
#         time: single: 690.749288 ms, @batch: 1022.177578 ms, @threads: 327.080302 ms, kernel: 68.250646 ms
#         speedups: @batch = 0.6757625121767248, @threads = 2.1118645292188827
# nthreads = 11, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 697.302823 ms, @batch: 321.932681 ms, @threads: 321.686354 ms, kernel: 65.325055 ms
#         speedups: @batch = 2.16598955046754, @threads = 2.167648127840698
# matrix
#         time: single: 706.656784 ms, @batch: 312.188245 ms, @threads: 266.225318 ms, kernel: 62.370552 ms
#         speedups: @batch = 2.26355987234561, @threads = 2.6543560518913534
# nthreads = 12, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 781.198529 ms, @batch: 267.114262 ms, @threads: 394.873738 ms, kernel: 57.76933 ms
#         speedups: @batch = 2.924585617970485, @threads = 1.9783501758225308
# matrix
#         time: single: 687.501855 ms, @batch: 287.455688 ms, @threads: 316.850428 ms, kernel: 57.841534 ms
#         speedups: @batch = 2.391679426430414, @threads = 2.1697993571907057
# nthreads = 13, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 777.750496 ms, @batch: 585.038665 ms, @threads: 314.500428 ms, kernel: 53.187863 ms
#         speedups: @batch = 1.3294001619533984, @threads = 2.4729711846369886
# matrix
#         time: single: 687.835125 ms, @batch: 304.654148 ms, @threads: 266.961579 ms, kernel: 53.604497 ms
#         speedups: @batch = 2.2577572946750095, @threads = 2.576532276953606
# nthreads = 14, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 705.870263 ms, @batch: 278.763078 ms, @threads: 297.819495 ms, kernel: 48.62953 ms
#         speedups: @batch = 2.532151201889082, @threads = 2.3701277950256414
# matrix
#         time: single: 697.629396 ms, @batch: 297.495934 ms, @threads: 258.19076 ms, kernel: 50.496978 ms
#         speedups: @batch = 2.3450048093766553, @threads = 2.7019921084704968
# nthreads = 15, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 738.90586 ms, @batch: 261.42902 ms, @threads: 293.810003 ms, kernel: 44.562994 ms
#         speedups: @batch = 2.8264110082346634, @threads = 2.5149104947253957
# matrix
#         time: single: 796.007575 ms, @batch: 284.122042 ms, @threads: 260.419643 ms, kernel: 45.889936 ms
#         speedups: @batch = 2.8016396383635733, @threads = 3.056634153361465
# nthreads = 16, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 709.144846 ms, @batch: 292.776133 ms, @threads: 294.045452 ms, kernel: 43.102211 ms
#         speedups: @batch = 2.4221402159171217, @threads = 2.4116844561840054
# matrix
#         time: single: 707.602967 ms, @batch: 273.216199 ms, @threads: 274.358148 ms, kernel: 42.87096 ms
#         speedups: @batch = 2.5899012195832505, @threads = 2.5791213862545828
# nthreads = 17, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 665.487425 ms, @batch: 250.386347 ms, @threads: 256.360359 ms, kernel: 39.127386 ms
#         speedups: @batch = 2.657842302399979, @threads = 2.5959061205714726
# matrix
#         time: single: 693.565923 ms, @batch: 260.139034 ms, @threads: 262.635451 ms, kernel: 39.772669 ms
#         speedups: @batch = 2.6661355365838717, @threads = 2.640793237772002
# nthreads = 18, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 743.776624 ms, @batch: 838.389326 ms, @threads: 678.32539 ms, kernel: 38.927632 ms
#         speedups: @batch = 0.887149443503292, @threads = 1.0964894355495083
# matrix
#         time: single: 787.243313 ms, @batch: 982.976386 ms, @threads: 286.746328 ms, kernel: 96.303057 ms
#         speedups: @batch = 0.8008771362285808, @threads = 2.7454346791147053
# nthreads = 19, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 741.951064 ms, @batch: 271.133155 ms, @threads: 276.87823 ms, kernel: 35.899063 ms
#         speedups: @batch = 2.7364822424612734, @threads = 2.67970170135803
# matrix
#         time: single: 685.204285 ms, @batch: 273.751373 ms, @threads: 277.134742 ms, kernel: 37.132847 ms
#         speedups: @batch = 2.503016797654564, @threads = 2.4724589925286233
# nthreads = 20, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 702.165858 ms, @batch: 254.476731 ms, @threads: 293.005002 ms, kernel: 34.01893 ms
#         speedups: @batch = 2.7592536859489916, @threads = 2.3964295940586027
# matrix
#         time: single: 682.399841 ms, @batch: 263.685864 ms, @threads: 269.513592 ms, kernel: 35.727563 ms
#         speedups: @batch = 2.587927280773762, @threads = 2.5319681873409934
# nthreads = 21, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 666.356674 ms, @batch: 380.749845 ms, @threads: 358.705724 ms, kernel: 32.354834 ms
#         speedups: @batch = 1.7501167308420047, @threads = 1.8576694750485776
# matrix
#         time: single: 1411.334044 ms, @batch: 285.669809 ms, @threads: 282.373323 ms, kernel: 32.929529 ms
#         speedups: @batch = 4.940438224607767, @threads = 4.9981139471875675
# nthreads = 22, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 656.312092 ms, @batch: 254.669337 ms, @threads: 258.073944 ms, kernel: 31.951392 ms
#         speedups: @batch = 2.5771146999137944, @threads = 2.5431164488267752
# matrix
#         time: single: 713.862002 ms, @batch: 265.696419 ms, @threads: 272.050217 ms, kernel: 31.883237 ms
#         speedups: @batch = 2.6867580853620763, @threads = 2.6240082065437207
# nthreads = 23, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 664.87585 ms, @batch: 260.759646 ms, @threads: 263.628083 ms, kernel: 29.967598 ms
#         speedups: @batch = 2.549765119714881, @threads = 2.522022094285001
# matrix
#         time: single: 700.647975 ms, @batch: 272.431587 ms, @threads: 270.844119 ms, kernel: 30.488807 ms
#         speedups: @batch = 2.5718309052026336, @threads = 2.5869048867920963
# nthreads = 24, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 665.329581 ms, @batch: 267.937814 ms, @threads: 276.118359 ms, kernel: 28.745043 ms
#         speedups: @batch = 2.483149246712896, @threads = 2.409581106484846
# matrix
#         time: single: 699.343092 ms, @batch: 254.186002 ms, @threads: 258.328945 ms, kernel: 28.99127 ms
#         speedups: @batch = 2.7513045033848873, @threads = 2.7071805368151836
# nthreads = 25, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 745.157716 ms, @batch: 256.145497 ms, @threads: 256.815567 ms, kernel: 27.833451 ms
#         speedups: @batch = 2.9091189371952924, @threads = 2.90152861333363
# matrix
#         time: single: 700.003726 ms, @batch: 258.74734 ms, @threads: 258.908896 ms, kernel: 27.296501 ms
#         speedups: @batch = 2.7053562212465643, @threads = 2.703668111890601
# nthreads = 26, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 780.257185 ms, @batch: 730.540519 ms, @threads: 536.136618 ms, kernel: 26.440887 ms
#         speedups: @batch = 1.0680546317513704, @threads = 1.4553327618446685
# matrix
#         time: single: 808.8797 ms, @batch: 251.729896 ms, @threads: 256.998632 ms, kernel: 27.376422 ms
#         speedups: @batch = 3.213284209993079, @threads = 3.147408582314944
# nthreads = 27, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 746.587495 ms, @batch: 255.195441 ms, @threads: 252.101746 ms, kernel: 25.166156 ms
#         speedups: @batch = 2.9255518518451904, @threads = 2.9614530912451515
# matrix
#         time: single: 690.409756 ms, @batch: 258.808263 ms, @threads: 263.915633 ms, kernel: 24.704785 ms
#         speedups: @batch = 2.6676495873704003, @threads = 2.6160244777921133
# nthreads = 28, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 779.558091 ms, @batch: 381.597038 ms, @threads: 381.095923 ms, kernel: 23.894243 ms
#         speedups: @batch = 2.042882971748853, @threads = 2.0455692227387066
# matrix
#         time: single: 686.203753 ms, @batch: 315.508825 ms, @threads: 316.898484 ms, kernel: 24.971503 ms
#         speedups: @batch = 2.1749114402742933, @threads = 2.165374047671367
# nthreads = 29, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 703.406898 ms, @batch: 271.447526 ms, @threads: 260.400939 ms, kernel: 23.125941 ms
#         speedups: @batch = 2.5913181393298093, @threads = 2.701245627996756
# matrix
#         time: single: 680.774669 ms, @batch: 260.758882 ms, @threads: 260.677492 ms, kernel: 23.557653 ms
#         speedups: @batch = 2.6107439323965194, @threads = 2.611559071620959
# nthreads = 30, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 754.182646 ms, @batch: 391.590996 ms, @threads: 467.459933 ms, kernel: 23.180966 ms
#         speedups: @batch = 1.9259448090067934, @threads = 1.6133631842196836
# matrix
#         time: single: 720.521694 ms, @batch: 333.620961 ms, @threads: 326.061575 ms, kernel: 22.574419 ms
#         speedups: @batch = 2.1597015122799794, @threads = 2.2097718628759
# nthreads = 31, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 744.230423 ms, @batch: 288.013513 ms, @threads: 363.069175 ms, kernel: 22.316519 ms
#         speedups: @batch = 2.5840121709844914, @threads = 2.0498309254703324
# matrix
#         time: single: 829.604388 ms, @batch: 328.160693 ms, @threads: 329.372495 ms, kernel: 22.252045 ms
#         speedups: @batch = 2.5280431376953487, @threads = 2.518742155443186
# nthreads = 32, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 675.725126 ms, @batch: 287.47809 ms, @threads: 278.195054 ms, kernel: 21.702331 ms
#         speedups: @batch = 2.3505273949746917, @threads = 2.4289616809650396
# matrix
#         time: single: 853.652639 ms, @batch: 383.030903 ms, @threads: 274.777271 ms, kernel: 22.01894 ms
#         speedups: @batch = 2.22867824061705, @threads = 3.1067076104704454
# nthreads = 33, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 665.421467 ms, @batch: 504.189368 ms, @threads: 271.266777 ms, kernel: 21.319316 ms
#         speedups: @batch = 1.3197848055375891, @threads = 2.453014977945493
# matrix
#         time: single: 847.276458 ms, @batch: 443.406448 ms, @threads: 278.649562 ms, kernel: 20.902656 ms
#         speedups: @batch = 1.9108347698182324, @threads = 3.0406523947810835
# nthreads = 34, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 788.361148 ms, @batch: 251.922923 ms, @threads: 418.121858 ms, kernel: 20.730752 ms
#         speedups: @batch = 3.1293744079017376, @threads = 1.8854817869866063
# matrix
#         time: single: 708.964377 ms, @batch: 951.793269 ms, @threads: 329.609682 ms, kernel: 20.166765 ms
#         speedups: @batch = 0.744872232333469, @threads = 2.1509209702159175
# nthreads = 35, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 744.039471 ms, @batch: 275.860489 ms, @threads: 254.037394 ms, kernel: 19.749214 ms
#         speedups: @batch = 2.697158530013336, @threads = 2.928858068037023
# matrix
#         time: single: 691.423121 ms, @batch: 216.359901 ms, @threads: 298.365148 ms, kernel: 19.367871 ms
#         speedups: @batch = 3.1957082518724205, @threads = 2.317372272313789
# nthreads = 36, N = 29, B = 256, T = ComplexF64
# vector
#         time: single: 677.28587 ms, @batch: 406.072883 ms, @threads: 526.884894 ms, kernel: 19.296215 ms
#         speedups: @batch = 1.6678923866974884, @threads = 1.2854531942606804
# matrix
#         time: single: 717.661213 ms, @batch: 336.283309 ms, @threads: 318.689037 ms, kernel: 18.729176 ms
#         speedups: @batch = 2.1340970360203038, @threads = 2.2519168521005635