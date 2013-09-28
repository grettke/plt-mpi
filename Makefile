MPIHOME = /opt/openmpi
CC      = $(MPIHOME)/bin/mpicc
CLINKER = $(MPIHOME)/bin/mpicc
CFLAGS 	= -std=c99 -Wall -pedantic

default: libmpiglue.so

libmpiglue.so: mpiglue.o
	$(CLINKER) -shared -W1,-soname,libmpiglue.so -o libmpiglue.so mpiglue.o

mpiglue.o:
	$(CC) $(CFLAGS) -fPIC -c mpiglue.c -o mpiglue.o

clean:
	rm mpiglue.o
	rm libmpiglue.so
	rm log*
