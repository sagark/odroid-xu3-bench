#!/bin/bash

# benchmarks that are currently broken: (lbm, opencl_base, long or short), (tpacf, opencl_base, small/medium/large), (mri-gridding, opencl_base, small), (histo, opencl_base, small/default), (sad, opencl_base, large/default)

benchmarks=(bfs stencil cutcp spmv sgemm mri-q)
version=(opencl_base opencl_base opencl_base opencl_base opencl_base opencl) 

dset=(1M default large large medium large)

for ((i=0;i<${#benchmarks[@]};++i)); do
	echo "${benchmarks[i]} -------------------------------"
	./parboil run ${benchmarks[i]} ${version[i]} ${dset[i]}
done
