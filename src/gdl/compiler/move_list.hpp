#ifndef MOVE_LIST_HPP
#define MOVE_LIST_HPP
#include "base_node.hpp"
#include "move.hpp"

class MoveList {
    private:
        Move* moves[1024];
        int moves_index;
    public:
        MoveList();
        void add_move(Move* new_move);
};
#endif
