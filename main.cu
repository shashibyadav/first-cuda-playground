#include <iostream>

// Kernel definition

__global__ void VecAdd(float* A, float* B, float* C) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    C[i] = A[i] + B[i];
}

int main() {
    std::cout << "Hello, World!" << std::endl;
    int N = 10;
    float* A = new float[N];
    float* B = new float[N];
    float* C = new float[N];

    for (int i = 0; i < N; ++i) {
        A[i] = 1;
        B[i] = 1;
    }

    // Allocate memory on the device (GPU)
    float *d_A, *d_B, *d_C;
    cudaMalloc(&d_A, N * sizeof(float));
    cudaMalloc(&d_B, N * sizeof(float));
    cudaMalloc(&d_C, N * sizeof(float));

    // Copy data from host to device
    cudaMemcpy(d_A, A, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, N * sizeof(float), cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    VecAdd<<<(N + threadsPerBlock - 1) / threadsPerBlock, threadsPerBlock>>>(d_A, d_B, d_C);

    cudaDeviceSynchronize();

    cudaMemcpy(C, d_C, N * sizeof(float), cudaMemcpyDeviceToHost);

    for (int i = 0; i < N; ++i) {
        std::cout << "Result " << i << " :- " << C[i] << std::endl;
    }

    // Free device memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    delete[] A;
    delete[] B;
    delete[] C;

    return 0;
}
