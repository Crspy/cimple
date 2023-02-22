CFLAGS=-std=c99 -g -static -pedantic-errors -Wall -Wno-switch -fstrict-aliasing
INCS=-I .
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)

all: cimple

test:
	./test.sh
	./test-driver.sh

%.o : %.c Makefile
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

cimple: $(OBJS)
	$(CC) $(CFLAGS) $(INCS) $(OBJS) -o $@

clean:
	rm -f cimple *.o *~ tmp*

.PHONY: test clean