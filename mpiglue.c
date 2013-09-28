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
