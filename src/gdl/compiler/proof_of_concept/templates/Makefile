CC=g++
FLAGS=-Wall -O3 -g
CFLAGS=-I/usr/include/python2.7
LFLAGS=-g

all: ggpl_module.o
	${CC} $^ ${FLAGS} ${LFLAGS} -o python_test

python_test.o: ggpl_module.cpp
	${CC} ${FLAGS} ${CFLAGS} -c $^
