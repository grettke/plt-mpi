MPIHOME = /opt/openmpi
CC      = $(MPIHOME)/bin/mpicc
CFLAGS 	= -std=c99 -Wall -pedantic

default: libsample.so

libsample.so: sample.o
	$(CC) $(CFLAGS) -shared -W1,-soname,libsample.so -o libsample.so sample.o

sample.o:
	$(CC) $(CFLAGS) -fPIC -c sample.c -o sample.o

clean:
	rm sample.o
	rm libsample.so
