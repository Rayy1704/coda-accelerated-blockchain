#ifndef MINING_GPU_H
#define MINING_GPU_H

#include <stdio.h>
#include <string>
#include <stdint.h>
#include <utility> // Required for std::pair
#include <cuda_runtime.h>

// CUDA error checking macro
#define CUDA_CHECK(call) \
    { \
        cudaError_t err = call; \
        if (err != cudaSuccess) { \
            fprintf(stderr, "CUDA Error at %s:%d - %s\n", __FILE__, __LINE__, cudaGetErrorString(err)); \
            return std::make_pair("", ""); \
        } \
    }

#define CUDA_CHECK_KERNEL() \
    { \
        cudaError_t err = cudaGetLastError(); \
        if (err != cudaSuccess) { \
            fprintf(stderr, "CUDA Kernel Launch Error at %s:%d - %s\n", __FILE__, __LINE__, cudaGetErrorString(err)); \
            return std::make_pair("", ""); \
        } \
    }

// Declaration of the GPU mining wrapper function
std::pair<std::string, std::string> findHashGPU(char* header);

#endif // MINING_GPU_H