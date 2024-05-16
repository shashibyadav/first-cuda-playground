cmake_minimum_required(VERSION 3.28)
project(cudatest CUDA)

set(CMAKE_CUDA_STANDARD 17)

add_executable(cudatest main.cu)

set_target_properties(cudatest PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
