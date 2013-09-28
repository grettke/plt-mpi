CC	= /opt/openmpi/bin/mpicc
CLINKER = /opt/openmpi/bin/mpicc
CFLAGS 	= -Wall

default: hello_world

hello_world: hello_world.o
	$(CLINKER) -o hello_world hello_world.o

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o hello_world
