CC	= /opt/openmpi/bin/mpicc
CLINKER = /opt/openmpi/bin/mpicc
CFLAGS 	= -Wall

default: sendreceive

sendreceive: sendreceive.o
	$(CLINKER) -o sendreceive sendreceive.o

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o sendreceive
