#ifndef PIECE_HPP
#define PIECE_HPP

#include <iostream>
#include "base_node.hpp"
#include "move_list.hpp"
#include "player.hpp"

class Piece: public BaseNode {
    private:
        Player* owner;
        MoveList* move_list;
    public:
        Piece();
        void set_player(Player* new_player);
        void set_move_list(MoveList* moves);
};

#endif
