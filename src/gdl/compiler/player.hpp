#ifndef PLAYER_HPP
#define PLAYER_HPP
#include "base_node.hpp"

class Player: public BaseNode {
    private:
        char* name;
    public:
        Player(char* player_name);
};
#endif
