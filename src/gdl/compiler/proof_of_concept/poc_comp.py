#!/usr/bin/env python

import argparse

import sexpdata
from grammar import AST

from termcolor import cprint

#arg_parser = argparse.ArgumentParser(description="LeisurelyScript compiler")
#arg_parser.add_argument('-f', help='A leisurely script to compile.')

def parse_file(path):
    with open(path, 'r') as fp:
        s = sexpdata.loads(fp.read())

    #for i in s:
    #    print i

    ast = AST(s)
    return ast

s = parse_file('test1.lesr')
