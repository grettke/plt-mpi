#!/bin/sh

#$ -S /bin/bash
#$ -pe orte 4
#$ -cwd
#$ -N rettkehwc
#$ -j y
#$ -o hwc.$JOB_ID.log

export PATH=$PATH:/opt/mpich2/gnu/bin
MPIEXEC="/opt/mpich2/gnu/bin/mpiexec --n $NSLOTS"
$MPIEXEC hwc
