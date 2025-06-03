#include <iostream>
#include <cuda_runtime.h>
#include <chrono>

#define N 512

// CUDA Kernel
__global__ void matMul(int* A, int* B, int* C, int n) {
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int col = threadIdx.x + blockIdx.x * blockDim.x;
    if (row < n && col < n) {
        int sum = 0;
        for (int k = 0; k < n; ++k) {
            sum += A[row * n + k] * B[k * n + col];
        }
        C[row * n + col] = sum;
    }
}

int main() {
    int size = N * N * sizeof(int);
    int *A, *B, *C;
    int *d_A, *d_B, *d_C;

    A = (int*)malloc(size);
    B = (int*)malloc(size);
    C = (int*)malloc(size);

    // Init matrices
    for (int i = 0; i < N * N; ++i) {
        A[i] = 1;
        B[i] = 1;
    }

    cudaMalloc(&d_A, size);
    cudaMalloc(&d_B, size);
    cudaMalloc(&d_C, size);

    cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(16, 16);
    dim3 blocksPerGrid((N + 15) / 16, (N + 15) / 16);

    auto start = std::chrono::high_resolution_clock::now();

    matMul<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, N);
    cudaDeviceSynchronize();

    auto end = std::chrono::high_resolution_clock::now();
    float duration = std::chrono::duration<float, std::milli>(end - start).count();
    std::cout << "GPU Matrix multiplication took " << duration << " ms\n";

    cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

    std::cout << "C[0][0] = " << C[0] << "\n";

    cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
    free(A); free(B); free(C);

    return 0;
}
