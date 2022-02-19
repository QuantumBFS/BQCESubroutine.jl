using BQCESubroutine

ex = @macroexpand1 @broutine Z = [1 0;0 -1]
s = string(ex)
io = open("test/codegen-Z.jl", "w")
println(io, s)
close(io)