#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

void sayHi(void)
{
  printf("Hello, world.\n");
}

int* getSimpleInts(void)
{
	int* result = (int*) malloc(sizeof(int)*5);
	result[0] = 1;
	result[1] = 2;
	result[2] = 3;
	result[3] = 4;
	result[4] = 5;
	return result;
}

void printSimpleInts(int len, int* vals)
{
	for(int i = 0; i < len; i++)
	{
		printf("%d\n", vals[i]);
	}
}

int getInt42(void)
{
  return 42;
}

char* getHw(void)
{
  return "Hello, world.";
}

int addInt(int a, int b)
{
  return a + b;
}
