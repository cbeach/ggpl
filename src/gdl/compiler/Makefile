CC=g++
CFLAGS=-lfl -Wno-write-strings -g -o
FILES=lex.yy.c parser.tab.c game.cpp input_list.cpp end.cpp board.cpp \
	  piece_list.cpp player_list.cpp piece.cpp base_node.cpp move_list.cpp \
	  player.cpp move.cpp precondition.cpp action.cpp action_list.cpp \
	  move_property.cpp move_property_list.cpp


lexer: lex.yy.cc parser.tab.c
	${CC} ${FILES} ${CFLAGS} lexer

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


