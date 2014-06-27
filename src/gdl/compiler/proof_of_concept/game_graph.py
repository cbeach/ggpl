import networkx as nx
from termcolor import cprint


class GameNodeError(Exception):
    pass


class EdgeError(Exception):
    pass


class GameGraph:
    def __init__(self):
        self._networkx_graph = nx.Graph()

    def add_node(self, node):
        self._networkx_graph.add_node(node)

    def __eq__(self, other):
        # This equality method does not try to handle graph isomorphism
        if isinstance(other, GameGraph):
            other = other._graph

        for a, b in zip(self._networkx_graph.nodes(), other):
            if a != b:
                return False
        return True


class GameNode:
    __node_id_dont_use_this = 1

    def __init__(self, name=None, edges=[], coords=None):
        self._node_id = self.get_node_id()
        self._edges = edges
        self._name = name
        self._coord = {
            'x': coords[0],
        }
        if len(coords) > 1:
            self._coord['y'] = coords[1]
        if len(coords) > 2:
            self._coord['z'] = coords[2]

    @classmethod
    def get_node_id(cls):
        temp = cls.__node_id_dont_use_this
        cls.__node_id_dont_use_this += 1
        return temp

    def add_edge(self, edge):
        self._edges.append()

    def create_edge(self, node_2, **kwargs):
        self._edges.append(Edge(**kwargs))

    @property
    def x(self):
        return self._coord['x']

    @property
    def y(self):
        return self._coord.get('y')

    @property
    def z(self):
        return self._coord.get('z')

    @property
    def name(self):
        return self._name

    def __hash__(self):
        return self._node_id

    def __unicode__(self):
        return str(self)

    def __str__(self):
        return self._name

    def __eq__(self, other):
        if isinstance(other, GameNode) is not True:
            return False

        return (other.name == self.name
                and other.x == self.x
                and other.y == self.y
                and other.z == self.z)


class Edge:
    def __init__(self, node_1=None, node_2=None, weight=0, name='', directed=False):
        if node_1 is None or node_2 is None:
            raise EdgeError('Edges must have a source node and destination node (they can be the same node)')
        else:
            self._src_node = node_1
            self._dest_node = node_2

        self._directed = directed
        self._name = name
        self._weight = weight

    @property
    def weight(self):
        return self._weight

    @weight.setter
    def weight(self, value):
        return self._weight

    def __str__(self):
        weight = self._weight if self._weight > 0 else ''
        direction = '>' if self._directed is True else ''
        return '{} -{}-{} {}'.format(self._src_node, weight, direction, self._dest_node)
