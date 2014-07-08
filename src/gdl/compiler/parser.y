%{
#include <string.h>
%}

%token GAME 
%token PLAYERS 
%token INPUT 
%token BOARD TILE_TYPE TRIANGLE SQUARE HEX OCT SHAPE SIZE
%token END LAST_PLAYER WINS ALL DRAW 
%token PIECES PIECE MOVES MOVE PRE ACTION I_NBORS NO_D_NBORS PUSH POP EMPTY 
%token SOURCE DEST
%token ID

%token CHAR_CONST
%token FLOAT_CONST
%token INT_CONST
%token STRING_CONST

%token BOOL_TYPE CHAR_TYPE FLOAT_TYPE INT_TYPE STRING_TYPE UINT_TYPE

%token BOOL_TRUE BOOL_FALSE
%token AND OR NOT

%start input
%%
game_rules_definition: 
      game

line:
      '\n'
    | expr '\n'
    | stmt '\n'

/* 
Operators:
    Arithmatic: + - * / %
    Assignment: = += -= *= /= %= &= |= ~=
    Bitwise: & | ~ ^ << >> 
    Boolean: and or not == != > < >= <=
*/

input:
     input line

line:
      '\n'
    | sexp '\n'

sexp:
      atom
    | list
    | BOOLEAN_EXPRESSION
    | ARITHMETIC_EXPRESSION
    | BITWISE_EXPRESSION
    | ASSIGNMENT_EXPRESSION
    | COMPARISON_EXPRESSION

list:
      '(' ')'
    | '(' sexp ')'
    | '(' sexp_list sexp ')'

sexp_list:
      sexp
    | sexp_list sexp

atom:
      NUMBER
    | SYMBOL
    | KEYWORD  

ARITHMETIC_EXPRESSION:
      + sexp sexp
    | - sexp sexp
    | * sexp sexp
    | / sexp sexp
    | % sexp sexp

/* Assignment: = += -= *= /= %= &= |= ~= */

ASSIGNMENT_EXPRESSION
      =
    | +=
    | -=
    | *=
    | /=
    | %=
    | &=
    | |=
    | ~=

KEYWORDS:
      GAME
    | PLAYERS
    | INPUT
    | BOARD
    | TILE_TYPE
    | TRIANGLE
    | SQUARE
    | HEX
    | OCT
    | SHAPE
    | SIZE
    | END
    | LAST_PLAYER
    | WINS
    | ALL
    | DRAW
    | PIECES
    | PIECE
    | MOVES
    | MOVE
    | PRE
    | ACTION
    | I_NBORS
    | NO_D_NBORS
    | PUSH
    | POP
    | EMPTY
    | SOURCE
    | DEST
    | ID
    | CHAR_CONST
    | FLOAT_CONST
    | INT_CONST
    | STRING_CONST
    | BOOL_TYPE
    | CHAR_TYPE
    | FLOAT_TYPE
    | INT_TYPE
    | STRING_TYPE
    | UINT_TYPE
    | BOOL_TRUE
    | BOOL_FALSE
    | AND
    | OR
    | NOT

%%
