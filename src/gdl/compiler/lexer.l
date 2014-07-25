%top {

#include <stdlib.h>
#include <stdio.h>
#include <cstring>
#include <ctype.h>
#include <iostream>
#include <string>
#include <cstring>
#include "parser.tab.h"

#define YY_DECL extern "C" int yylex()


using namespace std;

void str_toupper(char* str) {
    int i = 0;
    int len = strlen(str);
    for(i = 0; i < len; i++) {
        str[i] = toupper(str[i]);
    }
}
int line_number = 1;
}

digit       [0-9]
id          [a-zA-Z][a-zA-Z0-9_]*
space       [ ]
tab         [\t]

%%
\( {
    printf("\nLexer: (\n");
    return yytext[0];
}

\) {
    printf("\nLexer: )\n");
    return yytext[0];
}

game  { 
    printf("\nLexer: game\n"); 
    return GAME;
}

players { 
    printf("\nLexer: players\n"); 
    return PLAYERS;
}

input {
    printf("\nLexer: input\n"); 
    return INPUT;
}

board { 
    printf("\nLexer: board\n"); 
    return BOARD;
}

tile_type { 
    printf("\nLexer: tiling\n"); 
    return TILE_TYPE;
}

triangle { 
    printf("\nLexer: triangle\n"); 
    return TRIANGLE;
}

square { 
    printf("\nLexer: square\n"); 
    return SQUARE;
}

hex { 
    printf("\nLexer: hex\n"); 
    return HEX;
}

oct { 
    printf("\nLexer: truncated_square\n"); 
    return OCT;
}

shape { 
    printf("\nLexer: shape\n"); 
    return SHAPE;
}

size { 
    printf("\nLexer: size\n"); 
    return SIZE;
}

end { 
    printf("\nLexer: end\n"); 
    return END;
}

last_player { 
    printf("\nLexer: last_player\n"); 
    yylval.c_string = strdup(yytext);
    return LAST_PLAYER;
}

wins { 
    printf("\nLexer: wins\n"); 
    return WINS;
}

loses {
    printf("\nLexer: loses\n"); 
    return LOSES;
}

all { 
    printf("\nLexer: all\n"); 
    yylval.c_string = strdup(yytext);
    return ALL;
}

draw { 
    printf("\nLexer: draw\n"); 
    return DRAW;
}

pieces { 
    printf("\nLexer: pieces\n"); 
    return PIECES;
}

piece { 
    printf("\nLexer: piece\n"); 
    return PIECE;
}

moves { 
    printf("\nLexer: moves\n"); 
    return MOVES;
}

move { 
    printf("\nLexer: move\n"); 
    return MOVE;
}

pre { 
    printf("\nLexer: pre\n"); 
    return PRE;
}

action { 
    printf("\nLexer: action\n"); 
    return ACTION;
}

i_nbors { 
    printf("\nLexer: i_nbors\n"); 
    return I_NBORS;
}

no_d_nbors { 
    printf("\nLexer: no_d_nbors\n"); 
    return NO_D_NBORS;
}

push {
    printf("\nLexer: push\n");
    return PUSH;
}

pop {
    printf("\nLexer: pop\n");
    return POP;
}

empty {
    printf("\nLexer: empty\n");
    return NODE_EMPTY;
}

source {
    printf("\nLexer: source\n");
    return SOURCE;
}

dest {
    printf("\nLexer: dest\n");
    return DEST;
}

int {
    str_toupper(yytext);
    printf("\nLexer: %s\n", yytext); 
    return INT_TYPE;
}

float {
    str_toupper(yytext);
    printf("\nLexer: %s\n", yytext); 
    return FLOAT_TYPE;
}

uint {
    str_toupper(yytext);
    printf("\nLexer: %s\n", yytext); 
    return UINT_TYPE;
}
char {
    str_toupper(yytext);
    printf("\nLexer: %s\n", yytext); 
    return CHAR_TYPE;
}



True {
    printf("\nLexer: True\n"); 
    return BOOL_TRUE;
}

False {
    printf("\nLexer: False\n"); 
    return BOOL_FALSE;
}

and {
    printf("\nLexer: and\n"); 
    return AND;
}

or {
    printf("\nLexer: or\n"); 
    return OR;
}

not {
    printf("\nLexer: not\n"); 
    return NOT;
}

n_in_a_row {
    printf("\nLexer: n_in_a_row\n"); 
    return N_IN_A_ROW;
}

i_nbors {
    printf("\nLexer: i_nbors\n"); 
    return I_NBORS;
}

is_board_full {
    printf("\nLexer: is_board_full\n"); 
    return IS_BOARD_FULL;
}

{digit}+ { 
    printf("\nLexer: INTEGER_CONSTANT: %s\n", yytext);
    return INT_CONST;
}

{id} { 
    printf("\nLexer: ID: %s\n", yytext); 
    yylval.c_string = strdup(yytext);
    return ID;
}

[ ] ;

[ \t\n] ;
%%

/*
int main(int argc, char** argv) {
    if(argc < 2) {
        printf("\nLexer: Leisurely: No input files present.  Please provide the path for an input file.\n");
        return 1;
    }

    FILE* leisurely_script = fopen(argv[1], "r"); 
    if(!leisurely_script) {
        printf("The input path was not a valid file.\n");
    }
    yyin = leisurely_script; 
    for(int i = 0; i < 1000; i++) {
        yylex();
	}
}
*/


