#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

char* mpiglue_Get_processor_name(void)
{
  int namelen;
  char* processor_name = (char*) malloc(MPI_MAX_PROCESSOR_NAME);
  MPI_Get_processor_name(processor_name, &namelen);
  return processor_name;
}

int mpiglue_Send_ints(int len, int* vals, int dest, int tag, MPI_Comm comm)
{
  int result = MPI_Send(vals, len, MPI_INT, dest, tag, comm);

  return result;
}

int* mpiglue_Recv_ints(int source, int tag, MPI_Comm comm)
{
        MPI_Status status;
        int* buffer = (int*) malloc(sizeof(int) * 5);
        MPI_Recv(buffer, 5, MPI_INT, source, tag, comm, &status);
       	int* result = buffer; 
	return result;
}
