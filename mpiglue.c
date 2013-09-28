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

/*
; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Send.html
;
; int MPI_Send( void *buf, int count, MPI_Datatype datatype, int dest,
;               int tag, MPI_Comm comm )
;
; Input Parameters
;   buf 	 initial address of send buffer (choice)
;	count 	 number of elements in send buffer (nonnegative integer)
;	datatype datatype of each send buffer element (handle)
;	dest 	 rank of destination (integer)
;	tag 	 message tag (integer)
;	comm 	 communicator (handle)
*/

int sendInts(int dest, int tag, MPI_Comm comm)
{
  printf("cdbg: entered sendInts");

  int buffer[5];

  buffer[0] = 1;
  buffer[1] = -1;
  buffer[2] = 5;
  buffer[3] = -61;
  buffer[4] = 1385;
  printf("cdgb: sending message\n");
  int result = MPI_Send(buffer, 5, MPI_INT, dest, tag, comm);
  printf("cdbg: sent message\n");
  return result;
}

/* int sendInts(int len, int* vals, int dest) */
/* { */
/*   printf("cdbg: in sendInts -> %d\n", dest); */
/*   return */
/*   MPI_Send(vals, */
/*            len, */
/*            MPI_INT, */
/*            dest, */
/*            0, */
/*            MPI_COMM_WORLD); */
/* } */

/*
http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Recv.html

int MPI_Recv( void *buf, int count, MPI_Datatype datatype, int source,
              int tag, MPI_Comm comm, MPI_Status *status )

Output Parameters
    buf 	initial address of receive buffer (choice)
	status 	status object (Status)


Input Parameters
    count 	 maximum number of elements in receive buffer (integer)
	datatype datatype of each receive buffer element (handle)
	source 	 rank of source (integer)
	tag 	 message tag (integer)
	comm 	 communicator (handle)
 */

int recvInts(int source, int tag)
{
  printf("cdbg: entered recvInts");
  int buffer[5];
  MPI_Status status;
  int result = MPI_Recv(buffer, 5, MPI_INT, source, tag, MPI_COMM_WORLD, &status);
  printf("cdbg: received message\n");
  for(int i = 0; i < 5; i++)
    {
      printf("%d\n", buffer[i]);
    }
  return result;
}

/* int* recvInts(int src, int len) */
/* { */
/*   printf("cdbg: in recvInts %d <-\n", src); */
/*   int* result = (int*) malloc(sizeof(int) * len); */
/*   MPI_Status status; */
/*   MPI_Recv(&result, */
/*            len, */
/*            MPI_INT, */
/*            src, */
/*            0, */
/*            MPI_COMM_WORLD, */
/*            &status); */
/*   return result; */
/* } */
