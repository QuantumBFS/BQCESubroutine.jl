#!/bin/bash
for i in {1..36}
do
   JULIA_NUM_THREADS=$i julia --project=@. polyester_X1.jl
done
