all: cpu gpu

cpu:
	g++ matrix_mult.cpp -o matrix_mult

gpu:
	nvcc matrix_mult_cuda.cu -o matrix_mult_cuda

clean:
	rm -f matrix_mult matrix_mult_cuda
