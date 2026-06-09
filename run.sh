#!/bin/bash

##PREPARE ENV
#### set to MAXN mode
sudo nvpmodel -m 2 
sudo jetson_clocks

#### increase swap memory to 16G from SSD for build step
sudo swapoff -a
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
#sudo echo "/swapfile none swap sw 0 0" >> /etc/fstabsudo 


## DOWNLOAD PROFILER
git clone https://github.com/NVIDIA/cutlass.git
cd cutlass/
mkdir build && cd build


## BUILD
#### Jetson Orin Nano ARCH + Identity2 + INT8 & FP16 + Shape + Sparse GEMM
cmake .. -DCUTLASS_NVCC_ARCHS=87 -DCUTLASS_LIBRARY_KERNELS="i16864spgemm;h16816spgemm"

#### Jetson Orin Nano ARCH + Identity2 + All data types & Shapes + Sparse GEMM
#cmake .. -DCUTLASS_NVCC_ARCHS=87 -DCUTLASS_LIBRARY_KERNELS="*spgemm*"

#### maximize CPU cores
make cutlass_profiler -j$(nproc)


## RUN BENCHMARK
#### Identity2 + Sparse GEMM + INT8
#### m=512 n=512 k=8192			  
./tools/profiler/cutlass_profiler \
--operation=sparse_gemm \
--op_class=tensorop \
--m=512 --n=512 --k=8192 \
--A=s8:row --B=s8:column --C=s32:row \
--stages=3 --warps_m=4 --warps_n=2 --warps_k=1 \
>> test_result_int8.txt

#### Identity2 + Sparse GEMM + FLOAT16
#### m=512 n=512 k=8192
./tools/profiler/cutlass_profiler \
--operation=sparse_gemm \
--op_class=tensorop \
--m=512 --n=512 --k=8192 \
--A=f16:row --B=f16:column --C=f32:row \
--stages=3 --warps_m=4 --warps_n=2 --warps_k=1 \
>> test_result_float16.txt

## reset swap memory to 4G after build
du -sh /swapfile
sudo mkswap /swapfile
sudo swapoff /swapfile
sudo rm /swapfile
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -h