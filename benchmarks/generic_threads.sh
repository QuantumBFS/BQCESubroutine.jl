#!/bin/bash
for i in {1..6}
do
   JULIA_NUM_THREADS=$i julia --project=@. generic_threads.jl
done

