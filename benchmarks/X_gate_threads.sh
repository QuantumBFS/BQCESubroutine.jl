#!/bin/bash
for i in {1..6}
do
   JULIA_NUM_THREADS=$i julia --project=@. X_gate_threads.jl
done

