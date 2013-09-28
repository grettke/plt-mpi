#!/bin/sh

#$ -S /bin/bash
#$ -pe orte 2
#$ -cwd
#$ -N scheme_mpi_demo
#$ -j y
#$ -o log.schemedemo.$JOB_ID

export PATH=/home/grettke//bin/plt-4.2.5/bin:/opt/openmpi/bin:$PATH
MPIRUN="/opt/openmpi/bin/mpirun -np $NSLOTS"
$MPIRUN mzscheme ./demo.ss

# -S Specifies  the interpreting shell for the job.
# -pe orte 8 Start  parallel programming environment (PE),
# specifically orte with 8 cpus
# -cwd Execute the job from the current working directory.
# -N The name of the job.
# -j y  Specifies whether or not the standard error stream of the job is
#       merged into the standard output stream.

# Run this by typing: qsub ./<this file name>
# The output will get stored in a logfile like above in the -o line
