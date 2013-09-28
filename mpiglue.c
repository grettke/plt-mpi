#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

char* glue_Get_processor_name(void)
{
  int namelen;
  char* processor_name = (char*) malloc(MPI_MAX_PROCESSOR_NAME);
  MPI_Get_processor_name(processor_name, &namelen);
  return processor_name;
}

int sendInts(int len, int* vals, int dest, int tag, MPI_Comm comm)
{
/*   printf("cdbg: entered sendInts\n"); */
/*   for(int i = 0; i < len; i++) */
/*     { */
/*       printf("sendInts value: %d\n", vals[i]); */
/*     } */

/*   int buffer[5]; */

/*   buffer[0] = 1; */
/*   buffer[1] = -1; */
/*   buffer[2] = 5; */
/*   buffer[3] = -61; */
/*   buffer[4] = 1385; */
/*   printf("cdgb: sending message\n"); */
  int result = MPI_Send(vals, len, MPI_INT, dest, tag, comm);
/*   printf("cdbg: sent message\n"); */
  return result;
}

int recvInts(int source, int tag, MPI_Comm comm)
{
  printf("cdbg: entered recvInts");
  int buffer[5];
  MPI_Status status;
  int result = MPI_Recv(buffer, 5, MPI_INT, source, tag, comm, &status);
  printf("cdbg: received message\n");
  for(int i = 0; i < 5; i++)
    {
      printf("%d\n", buffer[i]);
    }
  return result;
}
