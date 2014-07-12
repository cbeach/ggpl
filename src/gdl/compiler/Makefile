CC=g++
CFLAGS=-lfl -Wno-write-strings -g -o


lexer: lex.yy.cc
	${CC} lex.yy.c parser.tab.c ${CFLAGS} lexer

lex.yy.cc: clean parser.tab.h lexer.l
	flex lexer.l

%.tab.c %.tab.h: parser.y
	bison -vdt parser.y

clean:
	-rm *.yy.c 2> /dev/null
	-rm *.yy.cc 2> /dev/null
	-rm lexer 2> /dev/null
	-rm parser.tab.c 2> /dev/null
	-rm parser.tab.h 2> /dev/null
	-rm parser.output 2> /dev/null

test: lexer
	python test/test_lexer.py


