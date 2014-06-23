import re

from sexpdata import Symbol
from termcolor import cprint


class Node(object):
    def __init__(self):
        self.types = ['char', 'float', 'int', 'string', 'uint']

        self.key_words = ['action', 'all', 'board', 'board_size', 'dest', 'empty', 'end', 'game',
                          'i_nbors', 'move', 'move', 'moves', 'n_in_a_row', 'piece', 'pieces',
                          'players', 'pre', 'push', 'shape', 'square', 'tile_type', ]

        self.operators = ['+', '-', '*', '/', '%', '=', '+=', '-=', '*=', '/=', '%=', '&=', '|=',
                          '~=', '&', '|', '~', '^', '<<', '>>', '&&', '||', '!', '==', '!=', '>',
                          '<', '>=', '<=']

        self.regexps = {
            'id': re.compile(r'[a-zA-Z][a-zA-Z0-9_]*'),
            'string': re.compile(r'".*?"'),
            'integer': re.compile(r'[0-9]+'),
            'float': re.compile(r'[0-9]*\.[0-9]+'),
        }
        self.atoms = self.types + self.key_words + self.operators

    def get_type(self):
        return self.term_type


class Expression(Node):
    def __init__(self, *args):
        super(Expression, self).__init__()
        if len(args) is not 0:
            self._expressions = []

    @property
    def expressions(self):
        pass


class Game(Expression):
    def __init__(self, sexp):
        super(Game, self).__init__()
        self.legal_game_components = {
            'board': Board,
            'players': Players,
            'end': End,
            'pieces': Pieces,
        }
        self.parse_game_object(sexp)
        self._name = None
        self._players = None
        self._equipment = None  # board
        self._pieces = None
        self._end = None

    def parse_game_object(self, sexp):
        if self.regexps['id'].match(sexp[0].value()) is not None:
            self._name = sexp.pop(0)

        for arg in sexp:
            if isinstance(arg[0], Symbol) is True and arg[0].value() in self.legal_game_components.keys():
                comp_name = arg.pop(0).value()
                comp = self.legal_game_components[comp_name](arg)
                setattr(self, '_{}'.format(comp_name), comp)

    @property
    def players(self):
        return self._players

    @property
    def equipment(self):
        return self._equipment

    @property
    def pieces(self):
        return self._pieces

    @property
    def end(self):
        return self._end


class Board(Node):
    def __init__(self, args):
        cprint('Creating a board node.', 'green')


class Players(Node):
    def __init__(self, args):
        cprint('Creating a players node.', 'green')


class End(Node):
    def __init__(self, args):
        cprint('Creating an end node.', 'green')


class Pieces(Node):
    def __init__(self, args):
        cprint('Creating a pieces node.', 'green')
