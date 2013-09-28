// via http://mpi.deino.net/mpi_functions/MPI_Recv.html

#include "mpi.h"
#include <stdio.h>
 
int main(int argc, char *argv[])
{
    int rank, size, i;
    int buffer[5];
    MPI_Status status;
 
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    
    if (rank == 0)
    {
        for (i=0; i<5; i++)
            buffer[i] = i;
        MPI_Send(buffer, 5, MPI_INT, 1, 0, MPI_COMM_WORLD);
	printf("[%d]Send buffer\n", rank);
    }
    
    if (rank == 1)
    {
        for (i=0; i<5; i++)
            buffer[i] = -1;
        MPI_Recv(buffer, 5, MPI_INT, 0, 0, MPI_COMM_WORLD, &status);
	printf("[%d]Received buffer\n", rank);
    }
    MPI_Finalize();
    return 0;
}
