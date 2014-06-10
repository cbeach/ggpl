%{
#include <iostream>
#include <string>
#include <stdlib.h>
#include <boost.h>
using namespace std;
#define YY_DECL extern "C" int yylex()
int line_number = 1;
%}

digit       [0-9]
id          [a-z][a-zA-Z0-9_]*

%%
game  { 
    cout << "Game type: " << yytext << " on line " << endl; 
}
{digit}+          { cout << "Found an integer:" << yytext << endl; }
"[a-zA-Z0-9]+"    { cout << "Found a string: " << yytext << endl; }
%%

int main(int argc, char** argv) {
    // lex through the input:
    if(argc < 2) {
        cerr << "Leisurely: No input files present.  Please provide the path for an input file." << endl;
        return 1;
    }

    FILE* leisurely_script = fopen(argv[1], "r"); 
    if(!leisurely_script) {
        cerr << "The input path was not a valid file." << endl;
    }
    yyin = leisurely_script; 
    
    yylex();
}
