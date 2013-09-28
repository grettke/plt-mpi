#!/bin/sh

#$ -S /bin/bash
#$ -pe orte 4
#$ -cwd
#$ -N rettkehwc
#$ -j y
#$ -o hwc.$JOB_ID.log

export PATH=$PATH:/opt/MPICH2-1.1/bin
MPIEXEC="/opt/MPICH2-1.1/bin/mpiexec --n $NSLOTS"
$MPIEXEC hwc
