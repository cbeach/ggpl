lexer: lex.yy.c
	g++ lex.yy.c -lfl -o lexer

lex.yy.c: lexer.l
	flex lexer.l

clean:
	rm *.yy.c
	rm lexer

test: lexer
	python test/test_lexer.py


