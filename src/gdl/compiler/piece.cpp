#include <iostream>

#include "piece.hpp"

using namespace std;

void Piece::set_player(Player* new_player) {
    owner = new_player; 
}

void Piece::set_move_list(MoveList* moves) {
    move_list = moves;
}
