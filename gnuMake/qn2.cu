#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<math.h>

#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


__global__ void calculate(long * gpu_mem,long nthreads,long pwr, long start, long end)
{
      int tid = blockDim.x * blockIdx.x + threadIdx.x;
      if(tid >= nthreads)
           return;
               
      if(tid%2==0){
      		gpu_mem[start+tid*pwr]=gpu_mem[start+tid*pwr]^gpu_mem[start+tid*pwr+pwr-1];
      }
      else{
      		gpu_mem[start+tid*pwr+pwr-1]=gpu_mem[start+tid*pwr]^gpu_mem[start+tid*pwr+pwr-1];
      }     
}

int main(int argc, char **argv)
{
    struct timeval t_start, t_end;
    long i;
    long *gpu_mem;   
    unsigned long num = NUM;   /*Default value of num from MACRO*/
    int SEED;
    long blocks;

    if(argc == 3){
         num = atoi(argv[1]);   /*Update after checking*/
         if(num <= 0)
               num = NUM;
	SEED=atoi(argv[2]);
    }
    unsigned long n=num;	
    /* Allocate host (CPU) memory and initialize*/
    srand(SEED);
    long * ar = (long *)malloc(num*sizeof(long));
    for(i=0; i<num; ++i){
    	*(ar+i)= (long)(random());
    }
   
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

 
    	
	
    long start=0;
    long end=-1;
    long ans=0;
    while(1){
	cudaMalloc(&gpu_mem, n * sizeof(long));
	CUDA_ERROR_EXIT("cudaMalloc");
	cudaMemcpy(gpu_mem, ar, n * sizeof(long) , cudaMemcpyHostToDevice);
    	CUDA_ERROR_EXIT("cudaMemcpy");

	if(num==0)break;
    	start=end+1;
    	long lg=floor(log(num)*1.00/log(2));
    	end=(long)(start+pow(2,lg)-1);
    	if(num==1){
    		ans=(ans^ar[start]);
    		break;
    	}
	
    	long j;
    	long size=end+1-start;
    	long times=(long)(log(size)/log(2));
    	for(j=1;j<=times;j++){
    		long nthreads=size/((long)(pow(2,j)));
    		long pwr=(long)(pow(2,j)); 
    		blocks=nthreads/1024;
    		if(nthreads%1024)blocks++;
    		calculate<<<blocks, 1024>>>(gpu_mem,nthreads,pwr,start,end); 		
    		CUDA_ERROR_EXIT("kernel invocation");
    	}
    	cudaMemcpy(ar, gpu_mem, n * sizeof(long) , cudaMemcpyDeviceToHost);
    	CUDA_ERROR_EXIT("memcpy");
	cudaFree(gpu_mem);

    	ans=(ans^ar[start]);
    	num=num-(long)(pow(2,lg));
    }
    
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs\n", TDIFF(t_start, t_end));
    cudaFree(gpu_mem);
   
    printf("result = %ld\n", ans);
    free(ar);
}
 
