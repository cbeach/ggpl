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

%x string

digit       [0-9]
id          [a-zA-Z][a-zA-Z0-9_]*
space       [ ]
tab         [\t]

%%
game  { 
    printf("GAME\n"); 
}

input {
    printf("INPUT\n"); 
}

piece { 
    printf("PIECE\n"); 
}

player { 
    printf("PLAYER\n"); 
}

start { 
    printf("START\n"); 
}

end { 
    printf("END\n"); 
}

play { 
    printf("PLAY\n"); 
}

move { 
    printf("MOVE\n"); 
}

dirn { 
    printf("DIRN\n"); 
}

label { 
    printf("LABEL\n"); 
}

mandatory { 
    printf("MANDATORY\n"); 
}

owner { 
    printf("OWNER\n"); 
}

post { 
    printf("POST\n"); 
}

pre { 
    printf("PRE\n"); 
}

priority { 
    printf("PRIORITY\n"); 
}

action { 
    printf("ACTION\n"); 
}

play_area { 
    printf("PLAY_AREA\n"); 
}

number_set { 
    printf("NUMBER_SET\n"); 
}

integers { 
    printf("INTEGERS\n"); 
}

real { 
    printf("REAL\n"); 
}

coordinates { 
    printf("COORDINATES\n"); 
}

coordinate_system { 
    printf("COORDINATE_SYSTEM\n"); 
}

cartesian { 
    printf("Cartesian\n"); 
}

polar { 
    printf("POLAR\n"); 
}

cylindrical { 
    printf("CYLINDRICAL\n"); 
}

spherical { 
    printf("SPHERICAL\n"); 
}

axes { 
    printf("AXES\n"); 
}

[xyz]_axis { 
    str_toupper(yytext);
    printf("%s\n", yytext); 
}

type { 
    printf("TYPE\n"); 
}

discrete { 
    printf("DISCRETE\n"); 
}

continuous { 
    printf("CONTINUOUS\n"); 
}

range { 
    printf("RANGE\n"); 
}

max { 
    printf("MAX\n"); 
}

min { 
    printf("MIN\n"); 
}

area_structure { 
    printf("AREA_STRUCTURE\n"); 
}

graph { 
    printf("GRAPH\n"); 
}

plane { 
    printf("PLANE\n"); 
}

volume { 
    printf("VOLUME\n"); 
}

board { 
    printf("BOARD\n"); 
}

tiling { 
    printf("TILING\n"); 
}

triangle { 
    printf("TRIANGLE\n"); 
}

square { 
    printf("SQUARE\n"); 
}

hex { 
    printf("HEX\n"); 
}

truncated_square { 
    printf("TRUNCATED_SQUARE\n"); 
}

i_nbors { 
    printf("I_NBORS\n"); 
}

no_d_nbors { 
    printf("NO_D_NBORS\n"); 
}

shape { 
    printf("SHAPE\n"); 
}

size { 
    printf("SIZE\n"); 
}

regions { 
    printf("REGIONS\n"); 
}

: { 
    printf("COLON\n"); 
}

int|float|uint|char|string {

    str_toupper(yytext);
    printf("%s\n", yytext); 
}

True {
    return BOOL_TRUE;
}

False {
    return BOOL_FALSE;

}

^{space}+ { /* Use a start condition to get the beginning indent. */
    printf("INDENT\n"); 
}

{digit}+ { 
    printf("INTEGER_CONSTANT: %s\n", yytext);
}

{id} { 
    printf("ID: %s\n", yytext); 
}

"\n" {
    printf("NEW_LINE\n"); 
    line_number++;
}
{space} ;

%%

int main(int argc, char** argv) {
    // \"                  { BEGIN string; ClearBuffer(strbuf); }
    // <string>[^\\"\n]*   { AppendBufferString(strbuf, yytext); }
    // <string>\\n         { AppendBufferChar(strbuf, '\n'); }
    // <string>\\t         { AppendBufferChar(strbuf, '\t'); }
    // <string>\\[0-7]*    { AppendBufferChar(strbuf, strtol(yytext+1, 0, 8)); }
    // <string>\\[\\"]     { AppendBufferChar(strbuf, yytext[1]); }
    // <string>\"          { yylval.str = strdup(BufferData(strbuf)); BEGIN 0; return STRING; }
    // <string>\\.         { error("bogus escape '%s' in string\n", yytext); }
    // <string>\n          { error("newline in string\n"); }
    // lex through the input:
    if(argc < 2) {
        printf("Leisurely: No input files present.  Please provide the path for an input file.\n");
        return 1;
    }

    FILE* leisurely_script = fopen(argv[1], "r"); 
    if(!leisurely_script) {
        printf("The input path was not a valid file.\n");
    }
    yyin = leisurely_script; 
    yylex();
}
