/* Write a program in cuda c/c++ to add two number and display result*/
#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
__global__ void add(int *x,int *y,int *z)
{
	*z = *x + *y;
}
int main()
{
	int a,b,c;
	int *d_a,*d_b,*d_c;
	
	cudaMalloc((void **)&d_a,sizeof(int));
	cudaMalloc((void **)&d_b,sizeof(int));
	cudaMalloc((void **)&d_c,sizeof(int));
	printf("enter first number\n");
	scanf("%d",&a);
	printf("enter second number\n");
	scanf("%d",&b);
	cudaMemcpy(d_a,&a,sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(d_b,&b,sizeof(int),cudaMemcpyHostToDevice);
	add<<<1,1>>>(d_a,d_b,d_c);
	cudaMemcpy(&c,d_c,sizeof(int),cudaMemcpyDeviceToHost);
	
	printf("result is %d\n",c);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	
	return(0);
}
