from itertools import product
import unittest
import sexpdata

from networkx import nx
from termcolor import cprint

from game_graph import GameNode
from grammar import AST
from expressions import Board


class TestTicTacToeTest(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super(TestTicTacToeTest, self).__init__(*args, **kwargs)
        with open('test_scripts/tic_tac_toe.lesr', 'r') as fp:
            self.game_rules = fp.read()

    def test_player_declarations(self):
        ast = AST(self.game_rules)
        for player, name in zip(ast.game.players._players, ('X', 'O')):
            self.assertEqual(player.name, name)


    def test_board_node_generation(self):
        board_rule = '(board (tile_type square) (shape square) (size 3 3))'
        sexp = sexpdata.loads(board_rule)
        board = Board(sexp)
        test_graph = nx.Graph()

        x = 3
        y = 3
        for i in product(range(x), range(y)):
            test_graph.add_node(GameNode('({}, {})'.format(x, y), coords=(x, y)))

        for a, b in zip(board._graph._networkx_graph.nodes(), test_graph.nodes()):
            self.assertEqual(a, b)


if __name__ == '__main__':
    unittest.main()
