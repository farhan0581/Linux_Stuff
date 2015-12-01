/*
WAP in Cuda C/C++, display resultant sum of array 
*/

#include <stdio.h>
#include <cuda.h>
#include <stdlib.h>

__global__ void myAdder(int * array, int *sum,int N)

{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	if (idx < N)
		*sum	=	*sum + array[idx];
}

int main()
{
	int i,*sum_h,*sum_d,*array_h,*array_d,N,size,n_block,block_size;
	i=0;
	sum_h=&i;
	printf("Enter size of array\n");
	scanf("%d",&N);
	size = sizeof(int)*N;

	// allocating memory in host
	array_h = (int *)malloc(size);

	// allocating memory in device
	cudaMalloc((void **)&array_d, size);
	cudaMalloc((void **)&sum_d, sizeof(int));
	for(i=0;i<N;i++)
	{
		printf("enter element %d::",i+1);
		scanf("%d",&array_h[i]);
	}
	// copy data from  host memory to device memory 
	cudaMemcpy(array_d,array_h,size,cudaMemcpyHostToDevice);
	cudaMemcpy(sum_d,sum_h,sizeof(int),cudaMemcpyHostToDevice);

	// Number of thread per block
	printf("Enter block size (Number of thread per block):: ");
	scanf("%d",&block_size);

	// number of block
	n_block = N/block_size + (N%block_size == 0 ? 0:1);

	// Calling  device function
	myAdder<<< n_block,block_size >>>(array_d,sum_d,N-1);

	// copy data from device memory to host memory
	cudaMemcpy(sum_h,sum_d,sizeof(int),cudaMemcpyDeviceToHost);

	printf("Final Answer is %d\n",*sum_h);
	return 0;
}