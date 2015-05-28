#!/bin/bash

benchmarks=(bfs stencil tpacf cutcp mri-gridding sad spmv histo sgemm mri-q lbm)
version=(opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl_base opencl opencl_base) 

for ((i=0;i<${#benchmarks[@]};++i)); do
	echo "${benchmarks[i]} -------------------------------"
	./parboil compile ${benchmarks[i]} ${version[i]}
done
