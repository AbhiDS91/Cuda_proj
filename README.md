# 🔥 CUDA vs CPU Matrix Multiplication Benchmark

This project compares the performance of matrix multiplication using:
- 🧠 Standard C++ on the CPU
- 🚀 NVIDIA CUDA for GPU acceleration

## 🧪 Benchmark Results

| Matrix Size | CPU Time    | GPU Time   | Speedup |
|-------------|-------------|------------|---------|
| 512 x 512   | 147 ms      | 2.63 ms    | ~56x    |

✅ Both methods produced correct results (`C[0][0] = 512`).

---

## 📂 File Structure

-   `matrix_mult.cpp`: Standard C++ implementation for CPU-only matrix multiplication.
-   `matrix_mult_cuda.cu`: CUDA-accelerated implementation for GPU matrix multiplication.
-   `Makefile`: Automates the compilation process for both CPU and GPU versions.
-   `README.md`: This project overview and documentation.
-   `benchmark_results.txt`: Raw console output logs from the benchmark runs.

---

## 🛠️ Build Instructions

To compile and run this project, navigate to the `cuda_Project` directory in your terminal.

**1. Compile the Project:**
You can use the provided `Makefile` to compile both versions:

```bash
make
```
and the executable files you'll see, one for CPU and the other for CUDA
