%{
#include <string.h>
%}

%token BOOL_TRUE BOOL_FALSE

%token IMPORT
%token GAME PLAYER PIECE MOVE INPUT START PLAY END 
%token ID
%token PASS

%token CHAR_CONST
%token FLOAT_CONST
%token INT_CONST
%token STRING_CONST

%token BOOL_TYPE
%token CHAR_TYPE
%token FLOAT_TYPE
%token INT_TYPE
%token STRING_TYPE
%token UINT_TYPE

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
    Comparison: and or not == != > < >= <=
*/

expr:
      NUM
    | STRING
    | expr
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr '%' expr

    | expr '=' expr
    | expr '+=' expr
    | expr '-=' expr
    | expr '*=' expr
    | expr '/=' expr
    | expr '%=' expr
    | expr '&=' expr
    | expr '|=' expr
    | expr '~=' expr

    | expr '&' expr
    | expr '|' expr
    | expr '~' expr
    | expr '<<' expr
    | expr '>>' expr

    | expr '!' expr
    | expr '<' expr
    | expr '>=' expr
    | expr '<=' expr

stmt:
      stmt
    | block
    | stmt expr

block: 
      block_stmt ':' '\n' 
          block_code

block_stmt:
      game_def
    | player_def
    | piece_def
    | move_def
    | input_def
    | rule_def

block_code:
      INDENT PASS
    | INDENT stmt
    | INDENT expr


game_def:
      GAME ID

player_def:
      PLAYER
    | PLAYER ID

ID:
  ID

VAR:
   type ID

NUM:
      FLOAT_CONST
    | INT_CONST

STRING:
    STRING_CONST
    
%%
