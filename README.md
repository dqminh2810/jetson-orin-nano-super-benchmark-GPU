# jetson-orin-nano-super-benchmark-GPU

## REQUIREMENTS

*Hardware*
- Nvidia Jetson Orin Nano Super 8GB
- SSD NVME 128GB

*Software*
- Ubuntu 22.04 Jammy Jellyfish
- L4T 36.5.0
- Jetpack 6.2.2

## BENCHMARK

[Overview](https://developer.nvidia.com/blog/nvidia-jetpack-6-2-brings-super-mode-to-nvidia-jetson-orin-nano-and-jetson-orin-nx-modules/)

#### cutclass_profiler
`. ./run_cutclass_profiler.sh`

*RESULT*

`Sparse GEMM + INT8` & `m=512 n=512 k=8192` give `32.142 TOPS` about `50% SOL`

`Sparse GEMM + FLOAT16` & `m=512 n=512 k=8192` give `19.283 TFLOPS` 


#### ollama gemma2:2B
you can run ollama model on different PCs to compare the performance

`. ./run_ollama_gemma2-2b.sh`

*RESULT*

```
=============GEMMA2:2B================
total duration:       13.819142328s
load duration:        383.585298ms
prompt eval count:    521 token(s)
prompt eval duration: 448.118ms
prompt eval rate:     1162.64 tokens/s
eval count:           338 token(s)
eval duration:        12.981716s
eval rate:            26.04 tokens/s        //about 75% SOL
```