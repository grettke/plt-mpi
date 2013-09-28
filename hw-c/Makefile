MPIHOME = /opt/mpich2/gnu
CC      = $(MPIHOME)/bin/mpicc
CLINKER = $(MPIHOME)/bin/mpicc
CFLAGS 	= -std=c99 -Wall -pedantic

default: hwc

hwc: hwc.o
	$(CLINKER) -o hwc hwc.o

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o *.log hwc
