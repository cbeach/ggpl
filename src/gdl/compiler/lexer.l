%top {

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
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
    printf("Symbol: (\n");
}

\) {
    printf("Symbol: )\n");
}

game  { 
    printf("Symbol: game\n"); 
}

players { 
    printf("Symbol: players\n"); 
}

input {
    printf("Symbol: input\n"); 
}

board { 
    printf("Symbol: board\n"); 
}

tile_type { 
    printf("Symbol: tiling\n"); 
}

triangle { 
    printf("Symbol: triangle\n"); 
}

square { 
    printf("Symbol: square\n"); 
}

hex { 
    printf("Symbol: hex\n"); 
}

truncated_square { 
    printf("Symbol: truncated_square\n"); 
}

shape { 
    printf("Symbol: shape\n"); 
}

size { 
    printf("Symbol: size\n"); 
}

end { 
    printf("Symbol: end\n"); 
}

last_player { 
    printf("Symbol: last_player\n"); 
}

wins { 
    printf("Symbol: wins\n"); 
}

all { 
    printf("Symbol: all\n"); 
}

draw { 
    printf("Symbol: draw\n"); 
}

pieces { 
    printf("Symbol: pieces\n"); 
}

piece { 
    printf("Symbol: piece\n"); 
}

moves { 
    printf("Symbol: moves\n"); 
}

move { 
    printf("Symbol: move\n"); 
}

pre { 
    printf("Symbol: pre\n"); 
}

action { 
    printf("Symbol: action\n"); 
}

i_nbors { 
    printf("Symbol: i_nbors\n"); 
}

no_d_nbors { 
    printf("Symbol: no_d_nbors\n"); 
}

push {
    printf("Symbol: push\n");
}

pop {
    printf("Symbol: pop\n");
}

empty {
    printf("Symbol: empty\n");
}

source {
    printf("Symbol: source\n");
}

dest {
    printf("Symbol: dest\n");
}

int|float|uint|char|string {
    str_toupper(yytext);
    printf("Symbol: %s\n", yytext); 
}

True {
    printf("Symbol: True\n"); 
}

False {
    printf("Symbol: False\n"); 
}

and {
    printf("Symbol: and\n"); 
}

or {
    printf("Symbol: or\n"); 
}

not {
    printf("Symbol: not\n"); 
}

{digit}+ { 
    printf("Symbol: INTEGER_CONSTANT: %s\n", yytext);
}

{id} { 
    printf("Symbol: ID: %s\n", yytext); 
}

[ ] ;

[ \t\n] ;
%%

int main(int argc, char** argv) {
    if(argc < 2) {
        printf("Symbol: Leisurely: No input files present.  Please provide the path for an input file.\n");
        return 1;
    }

    FILE* leisurely_script = fopen(argv[1], "r"); 
    if(!leisurely_script) {
        printf("The input path was not a valid file.\n");
    }
    yyin = leisurely_script; 
    yylex();
}
