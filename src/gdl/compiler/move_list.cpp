// move_list.cpp
#include "move_list.hpp"

MoveList::MoveList() {
    for(int i = 0; i < 1024; i++) {
        moves[i] = 0;
    }
    moves_index = 0;
}

void MoveList::add_move(Move* new_move) {
    moves[moves_index] = new_move;
    moves_index++; 
}
