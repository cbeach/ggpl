#!/usr/bin/env python

import json
from collections import defaultdict

import jinja2

with open('./test.lsr', 'r') as fp:
    src = fp.read()

symbol_table = defaultdict(dict)

src_obj = json.loads(src)
game = src_obj['game']

template_loader = jinja2.FileSystemLoader(searchpath="./templates")
template_env = jinja2.Environment(loader=template_loader)
