CC=gcc
PROGRAMS=controller
CFLAGS=-Wall
LIB=/usr/local/lib/libpapi.a


controller:
	$(CC) $(CFLAGS) -o controller controller.c $(LIB)


clean:
	rm $(PROGRAMS)
