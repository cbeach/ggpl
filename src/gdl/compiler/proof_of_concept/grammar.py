import re

import sexpdata
from termcolor import cprint

from expressions import Board, End, Game,  Pieces, Players
from util import ParserError


class AST:
    def __init__(self, sexp):
        if isinstance(sexp, str):
            self.generate_AST(sexpdata.loads(sexp))
        else:
            self.generate_AST(sexp)

    def generate_AST(self, sexp):
        if isinstance(sexp[0], sexpdata.Symbol) is True and sexp[0].value() == 'game':
            self._game = Game(sexp[1:])
        else:
            cprint(sexp[0], 'red')
            raise ParserError('Leisurely files may contain one game declaration, '
                              'and nothing more.')

    @property
    def game(self):
        return self._game


