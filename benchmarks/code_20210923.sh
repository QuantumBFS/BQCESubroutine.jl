#!/bin/bash
for i in {1..64}
do
   JULIA_NUM_THREADS=$i julia --project=@. code_20210923.jl
done
