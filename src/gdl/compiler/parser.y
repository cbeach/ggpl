%code requires {
    #include "piece_list.hpp"
    #include "player.hpp"
    #include "piece.hpp"
    #include "move_list.hpp"
    #include "player.hpp"
    #include "move.hpp"
    #include "action_list.hpp"
    #include "action.hpp"
    #include "move_property_list.hpp"
}

%{
#define YYDEBUG 1
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <iostream>
#include <alloca.h>
#include "game.hpp"

using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
void str_toupper(char* str);

Game game_object;
//SymbolTable symbols;
%}

%union {
    int int_type;
    float float_time;
    char* c_string; 
    Piece* cpp_piece;
    PieceList* cpp_piece_list;
    Player* cpp_player;
    MoveList* cpp_move_list;
    Move* cpp_move;
    ActionList* cpp_action_list;
    Action* cpp_action;
    MovePropertyList* cpp_move_property_list;
    MoveProperty* cpp_move_property;
    MovePrecondition* cpp_precondition;
}

%token GAME 
%token PLAYERS 
%token INPUT 
%token BOARD TILE_TYPE TRIANGLE SQUARE HEX OCT SHAPE SIZE
%token END  
%token WINS LOSES DRAW 
%token PIECES 
%token PIECE 
%token MOVES MOVE PRE ACTION I_NBORS NO_D_NBORS PUSH POP
%token SOURCE DEST
%token CHAR_CONST
%token FLOAT_CONST
%token INT_CONST 
%token STRING_CONST
%token BOOL_TYPE CHAR_TYPE FLOAT_TYPE INT_TYPE STRING_TYPE UINT_TYPE
%token BOOL_TRUE BOOL_FALSE
%token AND OR NOT
%token N_IN_A_ROW NBORS IS_BOARD_FULL NODE_EMPTY

%token<c_string> ALL LAST_PLAYER
%token<c_string> ID

%type<cpp_piece> piece_definition
%type<cpp_piece_list> piece_list
%type<cpp_player> player_record
%type<cpp_move_list> moves_object
%type<cpp_move_list> move_list
%type<cpp_move> move_definition
%type<cpp_action_list> action_def_list
%type<cpp_action> action_definition
%type<cpp_move_property_list> move_property_list
%type<cpp_move_property> move_property
%type<cpp_precondition> precondition_definition

%start game_object
%%
game_object:
      '(' GAME game_definition_term_list ')' { 
        Game(game_definition_term_list);
        //symbols.add_symbol("game", "", "");
    }
    | '(' GAME ID game_definition_term_list ')' { 
        //symbols.add_symbol("game", "", "");
    }

game_definition_term_list:
      game_definition_term
    | game_definition_term_list game_definition_term {}

game_definition_term:
      '(' game_definition_term ')'
    | players_object {}
    | input_object {} 
    | board_object {}
    | end_object {}
    | pieces_object {}

players_object:
    PLAYERS player_id_list { printf("Parser: players_object -> '(' PLAYERS id_list ')'\n");}

player_id_list:
      ID {printf("Parser: id_list -> ID");}
    | player_id_list ID {}

input_object:
    INPUT variable_list {}

variable_list:
      variable {}
    | variable_list variable {}

variable:
    '(' type ID ')' {}

type:
      BOOL_TYPE
    | CHAR_TYPE
    | FLOAT_TYPE
    | INT_TYPE
    | STRING_TYPE
    | UINT_TYPE

board_object:
    BOARD board_definition_list {}

board_definition_list:
      board_definition {}
    | board_definition_list board_definition {}

board_definition:
      tile_type_definition {}
    | board_shape {}
    | board_size {}

tile_type_definition:
      '(' TILE_TYPE shape_definition ')' {}
   
shape_definition:
      TRIANGLE {}
    | SQUARE {}
    | HEX {}
    | OCT {}

board_shape:
    '(' SHAPE shape_definition ')' {}

board_size:
      '(' board_size ')' 
    | SIZE INT_CONST  {}
    | SIZE INT_CONST INT_CONST  {}
    | SIZE INT_CONST INT_CONST INT_CONST  {}

end_object:
    END end_definition_list {printf("Parser: end_object");}

end_definition_list:
      end_definition  {printf("Parser: '(' end_definition ')'");}
    | end_definition_list end_definition  {printf("Parser: end_definition_list end_definition");}

end_definition:
      '(' player_record end_result '(' boolean_expression ')' ')' {printf("Parser: player_record end_result '(' boolean_expression ')'");}

player_record:
      ALL  {
        $$ = new Player($1);
    } | LAST_PLAYER {
        $$ = new Player($1);
    }
     
end_result:
      WINS {printf("Parser: WINS");}
    | LOSES {printf("Parser: LOSES");}
    | DRAW {printf("Parser: DRAW");}

pieces_object:
      PIECES piece_list {}

piece_list:
      piece_definition {}
    | piece_list piece_definition  {}

piece_definition:
      '(' PIECE ID player_record moves_object ')' {
        $$->add_name($3);
        $$->set_player($4);
        $$->set_move_list($5);
    }

moves_object:
      '(' MOVES move_list ')' {
        $$ = $3 
    }

move_list:
      move_definition {
        $$->add_move($1); 
    } | move_list move_definition { 
        $1->add_move($2); 
    }

move_definition:
      '(' MOVE move_property_list ')' {
        $$ = new Move();
        $$->add_property_list($3);
    }

move_property_list:
      move_property {
        $$->add_property($1);   
    } | move_property_list move_property {
        $$->add_property($2);   
    }
      
move_property:
      action_definition {
        $$ = $1;
    } | precondition_definition {
        $$ = $1;
    }

action_definition:
      '(' ACTION action_def_list ')' {}

action_def_list:
      action_definition {}
    | action_def_list action_definition {}

precondition_definition:
      '(' PRE boolean_expression ')' {
        $$ = new MovePrecondition();
    }

action_definition:
      '(' action_definition ')' {}
    | POP node_record {}
    | PUSH node_record {}

node_record:
      SOURCE {}
    | DEST {}

/*
keyword:
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
    | WIN {}
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

assignment_expression:
      "="  ID expression {}
    | "+=" ID expression {}
    | "-=" ID expression {}
    | "*=" ID expression {}
    | "/=" ID expression {}
    | "%=" ID expression {}
    | "&=" ID expression {}
    | "|=" ID expression {}
    | "~=" ID expression {}

expression:
      arithmetic_expression
    | bitwise_expression
    | boolean_expression

arithmetic_expression:
      "+" arithmetic_expression arithmetic_expression {} 
    | "-" arithmetic_expression arithmetic_expression {}
    | "*" arithmetic_expression arithmetic_expression {}
    | "/" arithmetic_expression arithmetic_expression {}
    | "%" arithmetic_expression arithmetic_expression {}

bitwise_expression:
      "&" bitwise_expression bitwise_expression {} 
    | "|" bitwise_expression bitwise_expression {}
    | "~" bitwise_expression bitwise_expression {}
    | ">>"  bitwise_expression bitwise_expression {}
    | "<<"  bitwise_expression bitwise_expression {}
    | "^"   bitwise_expression bitwise_expression {}
*/

boolean_expression:
      '('  boolean_expression ')' {}
    | BOOL_TRUE {}
    | BOOL_FALSE {}
    | AND  boolean_expression boolean_expression {}
    | OR   boolean_expression boolean_expression {}
    | NOT  boolean_expression {}
    | "&&"   boolean_expression boolean_expression {}
    | "||" boolean_expression boolean_expression {}
    | "!"    boolean_expression boolean_expression {}
    | "=="   boolean_expression boolean_expression {}
    | "!="   boolean_expression boolean_expression {}
    | ">"    boolean_expression boolean_expression {}
    | "<"    boolean_expression boolean_expression {}
    | ">="   boolean_expression boolean_expression {}
    | "<="   boolean_expression boolean_expression {}
    | N_IN_A_ROW INT_CONST nbors_definition ID {}
    | IS_BOARD_FULL {}
    | NODE_EMPTY node_record {}

nbors_definition:
      NBORS
    | I_NBORS

%%
int main(int argc, char** argv) {
    yydebug = 1;
    if(argc < 2) {
        printf("Symbol: Leisurely: No input files present.  Please provide the path for an input file.\n");
        return 1;
    }

    FILE* leisurely_script = fopen(argv[1], "r"); 
    if(!leisurely_script) {
        printf("The input path was not a valid file.\n");
    }
    yyin = leisurely_script; 

    // parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
}

void yyerror(const char *s) {
    cout << "EEK, parse error!  Message: " << s << endl;
    // might as well halt now:
    exit(-1);
}
