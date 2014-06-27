from itertools import product
import re

from sexpdata import Symbol
from termcolor import cprint

from game_graph import GameGraph, GameNode
from util import ParserError


class ASTNode(object):
    types = ['char', 'float', 'int', 'string', 'uint']

    key_words = ['action', 'all', 'board', 'board_size', 'dest', 'empty', 'end', 'game',
                 'i_nbors', 'move', 'move', 'moves', 'n_in_a_row', 'piece', 'pieces',
                 'players', 'pre', 'push', 'shape', 'square', 'tile_type', ]

    operators = ['+', '-', '*', '/', '%', '=', '+=', '-=', '*=', '/=', '%=', '&=', '|=',
                 '~=', '&', '|', '~', '^', '<<', '>>', '&&', '||', '!', '==', '!=', '>',
                 '<', '>=', '<=']

    regexps = {
        'id': re.compile(r'[a-zA-Z][a-zA-Z0-9_]*'),
        'string': re.compile(r'".*?"'),
        'integer': re.compile(r'[0-9]+'),
        'float': re.compile(r'[0-9]*\.[0-9]+'),
    }
    atoms = types + key_words + operators
    _name = None

    def get_type(self):
        return self.term_type


class Expression(ASTNode):
    def is_id(self, exp):
        return isinstance(exp, Symbol) is True \
            and exp.value() not in self.atoms \
            and self.regexps['id'].match(exp.value()) is not None

    @property
    def expressions(self):
        pass


class Game(Expression):
    def __init__(self, sexp):
        self.legal_game_components = {
            'board': Board,
            'players': Players,
            'end': End,
            'pieces': Pieces,
        }
        self._players = None
        self._equipment = None  # board
        self._pieces = None
        self._end = None
        self.parse(sexp)

    def parse(self, sexp):
        if self.is_id(sexp[0]) is True:
            self._name = sexp.pop(0).value()
        else:
            ParserError('Invalid expression: game {}'.format(str(sexp[0])))

        for arg in sexp:
            if isinstance(arg[0], Symbol) is True \
               and arg[0].value() in self.legal_game_components.keys():
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


class Board(Expression):
    def __init__(self, sexp):
        self._shape = ''
        self._size = {
            'x': 0,
            'y': 0,
        }
        self._tile_type = ''
        self.parse(sexp)
        self.generate_graph()

    def parse(self, sexp):
        if hasattr(sexp[0], 'value') and sexp[0].value() == 'board':
            sexp.pop(0)

        if self.is_id(sexp[0]) is True:
            self._name = sexp.pop(0).value()
        else:
            ParserError('Invalid expression: board {}'.format(str(sexp[0])))

        for s in sexp:
            prop_name = s[0].value()

            if prop_name == 'shape':
                if s[1].value() == 'square':
                    self._shape = 'square'
                else:
                    raise ParserError('Invalid board shape {}'.format(s[1]))
            elif prop_name == 'size':
                self._size['x'] = s[1]
                self._size['y'] = s[2]
            elif prop_name == 'tile_type':
                if s[1].value() == 'square':
                    self._tile_type = 'square'
                else:
                    raise ParserError('Invalid tile type {}'.format(s[1].value()))

    def generate_graph(self):
        self._graph = GameGraph()
        self.generate_nodes()
        self.generate_edges()

    def generate_nodes(self):
        # Generate the graphs nodes
        if self._shape == 'square':
            x = self._size['x']
            y = self._size['y']
            for i in product(range(x), range(y)):
                node = GameNode('({}, {})'.format(x, y), coords=(x, y))
                self._graph.add_node(node)

    def generate_edges(self):
        """
            Tic-Tac-Toe peices don't move around so I don't need to be declaring edges yet.
        """
        pass

    @property
    def graph(self):
        return self._graph

    def __str__(self):
        return 'Board:\n\tshape: {}\n\ttile type: {}\n\tsize:\n\t\tx: {}\n\t\ty: {}\n\t\tz: {}' \
                .format(self._shape, self._tile_type, self._size.get('x'),
                        self._size.get('y'), self._size.get('z'))


class Players(Expression):
    def __init__(self, sexp):
        self._players = []
        self.parse(sexp)

    def parse(self, sexp):
        for s in sexp:
            self._players.append(Player(s))

    def __str__(self):
        return 'Players:\n' + '\t'.join([str(p) for p in self._players])


class End(Expression):
    def __init__(self, sexp):
        self._end_conditions = []
        self.parse(sexp)

    def parse(self, sexp):
        if self.is_id(sexp[0]) is True:
            self._name = sexp.pop(0).value()
        else:
            ParserError('Invalid expression: End {}'.format(str(sexp[0])))

        for s in sexp:
            prop_name = s[0].value()
            if prop_name == 'n_in_a_row':
                self._end_conditions.append({
                    'condition': prop_name,
                    'n': s[1],
                    'neighbors': s[2].value(),
                    'piece_type': s[3].value(),
                })

    def __str__(self):
        end_str = ['End Condition:']
        for s in self._end_conditions:
            if s['condition'] == 'n_in_a_row':
                end_str.append(('n_in_a_row:\n'
                                '\tn: {}\n'
                                '\tneighbors: {}\n'
                                '\tpiece type: {}').format(s['n'],
                                                            s['neighbors'],
                                                            s['piece_type']))
        return '\n\t'.join(end_str)


class Pieces(Expression):
    def __init__(self, sexp):
        self._pieces = []
        self.parse(sexp)

    def parse(self, sexp):
        for s in sexp:
            s.pop(0)
            self._pieces.append(Piece(s))

    def __str__(self):
        return 'Pieces:\n' + '\n'.join([str(p) for p in self._pieces])


class Piece(Expression):
    def __init__(self, sexp):
        self._name = ''
        self._moves = None
        self._owners = ''
        self.parse(sexp)

    def parse(self, sexp):
        if self.is_id(sexp[0]) is True:
            self._name = sexp.pop(0).value()
        else:
            ParserError('Invalid expression: piece {}'.format(str(sexp[0])))

        if sexp[0] == 'All':
            self._owners = 'All'

        for s in sexp:
            if isinstance(s, list) is True:
                if s[0].value() == 'moves':
                    s.pop(0)
                    self._moves = Moves(s)

    def __str__(self):
        return 'Piece:\n\t' + self._name


class Moves(Expression):
    def __init__(self, sexp):
        self._moves = []
        self.parse(sexp)

    def parse(self, sexp):
        if self.is_id(sexp[0]) is True:
            self._name = sexp.pop(0).value()
        else:
            ParserError('Invalid expression: moves {}'.format(str(sexp[0])))

        for s in sexp:
            s.pop(0)
            self._moves.append(Move(s))

    def __str__(self):
        return 'Moves:\n' + '\n'.join([str(m) for m in self._moves])


class Move(Expression):
    def __init__(self, sexp):
        self._pre = []
        self._action = []
        self.parse(sexp)

    def parse(self, sexp):
        if self.is_id(sexp[0]) is True:
            self._name = sexp.pop(0).value()
        else:
            ParserError('Invalid expression: move {}'.format(str(sexp[0])))

        for s in sexp:
            if s[0].value() == 'action':
                self._action = [i.value() for i in s[1:]]
            elif s[0].value() == 'pre':
                self._pre = [i.value() for i in s[1:]]

    def __str__(self):
        return 'Move:\n\tactions: {}\n\tpreconditions: {}'.format(self._action, self._pre)


class Player(Expression):
    def __init__(self, sexp):
        self._name = ''
        self.parse(sexp)

    def parse(self, sexp):
        if self.is_id(sexp) is True:
            self._name = sexp.value()
        else:
            ParserError('Invalid expression: player {}'.format(str(sexp[0])))

    @property
    def name(self):
        return self._name

    def __str__(self):
        return 'Move:\n\t' + self._name
