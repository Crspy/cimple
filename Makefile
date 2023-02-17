CFLAGS=-std=c99 -g -static -pedantic-errors -Wall


cimple: main.o
	$(CC) -o $@ $? $(LDFLAGS)

test:
	./test.sh
clean:
	rm -f cimple *.o *~ tmp*

.PHONY: test clean