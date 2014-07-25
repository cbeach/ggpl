#include "game.hpp"

void Game::add_property(PlayerList p) {
    this->players = p;
}

void Game::add_property(InputList i) {
    this->inputs = i;
}

void Game::add_property(Board b) {
    this->board = b;
}

void Game::add_property(End e) {
    this->end = e;
}

void Game::add_property(PieceList p) {
    this->pieces = p;
}

bool Game::accept() {
    players.accept();
    inputs.accept();
    board.accept();
    end.accept();
    pieces.accept();
    return true;
}
