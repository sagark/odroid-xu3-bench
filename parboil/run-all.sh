#!/bin/bash

benchmarks=(bfs stencil tpacf cutcp mri-gridding sad spmv histo sgemm mri-q lbm)
version=(opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl opencl_base) 

dset=(1M default large large small large large large medium large long)

for ((i=0;i<${#benchmarks[@]};++i)); do
	echo "${benchmarks[i]} -------------------------------"
	./parboil run ${benchmarks[i]} ${version[i]} ${dset[i]}
done
