#ifndef GAME_HPP
#define GAME_HPP
#include <cstddef>
#include "player_list.hpp"
#include "input_list.hpp"
#include "board.hpp"
#include "end.hpp"
#include "piece_list.hpp"

class Game {
    private:
        PlayerList players;
        InputList inputs;
        Board board;
        End end;
        PieceList pieces;

    public:
        //Game(GameDefinitionList def_list);
        void add_property(PlayerList players);
        void add_property(InputList input);
        void add_property(Board players);
        void add_property(End end);
        void add_property(PieceList players);
        bool accept();
};

#endif
