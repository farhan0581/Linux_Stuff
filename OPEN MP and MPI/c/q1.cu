#include<stdio.h>
#include<cuda.h>
__global__ void myker(void)
{
	
}

int main()
{
	myker<<<1,1>>>();
	printf("Hello");
	return 0;
}