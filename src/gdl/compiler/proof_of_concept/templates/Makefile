CC=g++
FLAGS=-Wall -O3 -g
CFLAGS=-I/usr/include/python2.7/
LFLAGS=-g

all: ggpl_module.o
	${CC} $^ ${FLAGS} ${LFLAGS} -o python_test

ggpl_module.o: ggpl_module.cpp
	${CC} ${CFLAGS} ${FLAGS} -c $^

clean:
	-rm *.o
	-rm python_test
