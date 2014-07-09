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
input:
     input line {}

line:
      '\n' {}
    | GAME_OBJECT '\n' {}

GAME_OBJECT:
      '(' game GAME_DEFINITION ')' {}
    | '(' game ID GAME_DEFINITION ')' {}

GAME_DEFINITION:
      PLAYERS_OBJECT INPUT_OBJECT BOARD_OBJECT END_OBJECT PIECES_OBJECT {}

PLAYERS_OBJECT:
    '(' players ID_LIST ')' {}

ID_LIST:
      ID {}
    | ID_LIST ID {}

INPUT_OBJECT:
    '(' input VARIABLE_LIST ')' {}

VARIABLE_LIST:
      VARIABLE {}
    | VARIABLE_LIST VARIABLE {}

VARIABLE:
    '(' TYPE ID ')' {}

BOARD_OBJECT:
    '(' board BOARD_DEFINITION ')' {}

BOARD_DEFINITION:
      TILE_TYPE {}
    | BOARD_SHAPE {}
    | BOARD_SIZE {}

TILE_TYPE:
      '(' tile_type TILE_SHAPE ')' {}
   
SHAPE:
      triangle {}
    | square {}

BOARD_SHAPE:
    '(' shape SHAPE ')' {}

BOARD_SIZE:
      '(' size INT ')' {}
    | '(' size INT INT ')' {}
    | '(' size INT INT INT ')' {}

END_OBJECT:
    '(' end END_DEFINITION ')' {}

END_DEFINITION:
      '(' PLAYER_RECORDS END_RESULT END_CONDITION ')' {}

PLAYER_RECORD:
      all  {}
    | last_player {}
     
END_RESULT:
      win {}
    | lose {}
    | draw {}

END_CONDITION:
      BOOLEAN_EXPRESSION {}

PIECES_OBJECT:
      '(' pieces PIECE_LIST')' {}

PIECE_LIST:
      PIECE {}
    | PIECE_LIST PIECE {}

PIECE:
      piece ID PLAYER_RECORD MOVE_LIST {}
    | '(' PIECE ')' {}

MOVES_OBJECT:
      '(' moves MOVES_LIST')' {}

MOVE_LIST:
      MOVE {}
    | MOVE_LIST MOVE {}

MOVE:
      move ACTION PRE {}

ACTION:
      action ACTION_DEF_LIST {}

ACTION_DEF_LIST:
      ACTION_DEF {}
    | ACTION_DEF_LIST ACTION_DEF {}

ACTION_DEF:
      '(' ACTION_DEF ')' {}
    | push NODE_RECORD {}

NODE_RECORD:
      source {}
    | dest {}

sexp:
      atom {}
    | list {}
    | KEYWORD {}
    | ASSIGNMENT_EXPRESSION {}
    | ARITHMETIC_EXPRESSION {}
    | BITWISE_EXPRESSION    {}
    | BOOLEAN_EXPRESSION    {}
    | COMPARISON_EXPRESSION {}

list:
      '(' ')' {}
    | '(' sexp ')' {}
    | '(' sexp_list ')' {}

sexp_list:
      sexp {}
    | sexp_list sexp {}

atom:
      NUMBER {}
    | SYMBOL {}

GAME_RULES_DEFINITION: 
    game {}

KEYWORDS:
      GAME {}
    | PLAYERS {}
    | INPUT {}
    | BOARD {}
    | TILE_TYPE {}
    | TRIANGLE {}
    | SQUARE {}
    | HEX {}
    | OCT {}
    | SHAPE {}
    | SIZE {}
    | END {}
    | LAST_PLAYER {}
    | WINS {}
    | ALL {}
    | DRAW {}
    | PIECES {}
    | PIECE {}
    | MOVES {}
    | MOVE {}
    | PRE {}
    | ACTION {}
    | I_NBORS {}
    | NO_D_NBORS {}
    | PUSH {}
    | POP {}
    | EMPTY {}
    | SOURCE {}
    | DEST {}
    | ID {}
    | CHAR_CONST {}
    | FLOAT_CONST {}
    | INT_CONST {}
    | STRING_CONST {}
    | BOOL_TYPE {}
    | CHAR_TYPE {}
    | FLOAT_TYPE {}
    | INT_TYPE {}
    | STRING_TYPE {}
    | UINT_TYPE {}
    | BOOL_TRUE {}
    | BOOL_FALSE {}
    | AND {}
    | OR {}
    | NOT {}

ASSIGNMENT_EXPRESSION
      =  sexp sexp {}
    | += sexp sexp {}
    | -= sexp sexp {}
    | *= sexp sexp {}
    | /= sexp sexp {}
    | %= sexp sexp {}
    | &= sexp sexp {}
    | |= sexp sexp {}
    | ~= sexp sexp {}

ARITHMETIC_EXPRESSION:
      + sexp sexp {} 
    | - sexp sexp {}
    | * sexp sexp {}
    | / sexp sexp {}
    | % sexp sexp {}

BITWISE_EXPRESSION:
      '&' sexp sexp {} 
    | '|' sexp sexp {}
    | '~' sexp sexp {}
    | >>  sexp sexp {}
    | <<  sexp sexp {}
    | ^   sexp sexp {}

BOOLEAN_EXPRESSION:
      BOOL_TRUE {}
    | BOOL_FALSE {}
    | '('  BOOLEAN_EXPRESSION ')' {}
    | and  BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | or   BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | not  BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | &&   BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | '||' BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | !    BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | ==   BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | !=   BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | >    BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | <    BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | >=   BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | <=   BOOLEAN_EXPRESSION BOOLEAN_EXPRESSION {}
    | N_IN_A_ROW INTEGER NBORS PIECE {}
    | IS_BOARD_FULL {}
    | NODE_EMPTY NODE_RECORD {}
%%
/* 
Operators:
    Arithmatic: + - * / %
    Assignment: = += -= *= /= %= &= |= ~=
    Bitwise: & | ~ ^ << >> 
    Boolean: and or not 
    Comparison: == != > < >= <=
*/
