CFLAGS=-std=c99 -g -static -pedantic-errors -Wall -Wno-switch -fstrict-aliasing
INCS=-I .
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
TEST_SRCS=$(wildcard tests/*.c)
TESTS=$(TEST_SRCS:.c=.test)

all: cimple

tests/%.test: cimple tests/%.c
	$(CC) -o- -E -P -C tests/$*.c | ./cimple -o tests/$*.s -
	$(CC) -o $@ tests/$*.s -xc tests/common

test: $(TESTS)
	for i in $^; do echo $$i; ./$$i || exit 1; echo; done
	tests/driver.sh

%.o : %.c Makefile
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

cimple: $(OBJS)
	$(CC) $(CFLAGS) $(INCS) $(OBJS) -o $@

clean:
	rm -rf cimple tmp* $(TESTS) tests/*.s tests/*.test
	find * -type f '(' -name '*~' -o -name '*.o' ')' -exec rm {} ';'

.PHONY: test clean