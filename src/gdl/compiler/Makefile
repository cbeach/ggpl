CC=gcc
CFLAGS=-lfl -Wno-write-strings -g -o


lexer: lex.yy.cc
	${CC} lex.yy.c ${CFLAGS} lexer

lex.yy.cc: clean lexer.l
	flex lexer.l

clean:
	-rm *.yy.c
	-rm *.yy.cc
	-rm lexer

test: lexer
	python test/test_lexer.py


