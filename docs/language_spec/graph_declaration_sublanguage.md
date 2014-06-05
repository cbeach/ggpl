### graph
The graph is represented by a simple sub-language.  The following is a short summary of the graph definition sub-language syntax.

```python
graph: 
    node [NAME]
    node node_a
    node node_b
    node node_c
    node node_d

    node_a -- node_b [NAME]:
        undirected_edge_property_1: ...,

    node_b --> node_c [NAME]: 
        directed_edge_property_1: ...,

    node_a -7- node_b [NAME]:
        weighted_undirected_edge_property_1: ...,
    
    node_c -12-> node_d [NAME]:
        weighted_directed_edge_property_1: ...,

```

#### Node declarations
The nodes in a graph are defined like so:

```python
    node <node\_name>: 
        <node\_property\_name>: <node\_property\_value>,
        ...
```
TODO: Decide where to store piece position.  Should be piece know where it is, should the graph nodes know what pieces are in it, or both?
TODO: Figure out a good syntax for defining node property types.


#### Edge Declarations

```python
    <edge_definition> NAME:
        <edge_property_name>: <edge_property_value>,
        ...
```

The edge definition has the following structure.

```
<node_1> <edge_type> <node_2> NAME
```

node_1: The name of the "from" node
edge\_type: Edge type can be either directed or undirected.  Since it is very common to have weighted edges, a syntactical shortcut has been added to facilitate them.  The following JavaScript style regular expression shows the exact syntax.
node_2: The name of the "to" node
NAME an identifier used to reference the edge.  See Edge Namespace for the rules regarding edge namespace


```
-[0-9]*->?
```

Here are a few examples of edge type declarations

```
--        //Undirected edge
-->       //Directed edge
-12-      //Undirected edge with weight 12
-8->      //Directed edge with weight 8
```

### Edge Namespace
The namespace in which an edge is contained is that it's parent node/nodes.  One of the consequences of this is that many edges can be given the same name as long as they belong to different nodes. For instance:

```python
node_a --> node_b north:
    pass
node_b --> node_c north:
    pass
```

Is perfectly legal.  The two declarations have different name spaces.  i.e. node\_a.north and node\_b.north
However, the following is not legal:

```python
node_a -- node_b north:
    pass
node_b --> node_c north:
    pass
```

In this case, the two edges are being declared in the same namespaces.  References to the first edge declaration are put in both nodes a and b since it is an undirected edge.  
The second declaration will attempt to put a reference to a second edge into node b, which is also named north.  The second declaration will cause a name collision, and is therefore not allowed.

In general, references to an edge will be inserted into the "from" nodes.  This means the left node in the case of a directed edge, and both nodes in the case of an undericted edge. 

#### Edge properties

Edges have several reserved properties.

*labels*:  A list of aliases for this edge.  
* syntax: [<string label_1>, <string label_2>, ...]

Example:
```python
// definition
graph: 
    node node_a: ,
    node node_b: ,
    node node_c: ,

    node_a --> node_b:
        labels: ["n", "north", "up"],

    node_b --> node_c: {
        labels: ["the_path"],

// usage examples
// The following six lines will resolve to the object for edge node_a-->node_b

    node_a.n
    node_a.north
    node_a.up
    
    node_a["n"]
    node_a["north"]
    node_a["up"]


// The following six lines will resolve to the node object that edge node_a-->node_b points at. I.e. node_b

    node_a.n()
    node_a.north()
    node_a.up()

    node_a["n"]()
    node_a["north"]()
    node_a["up"]()


// The following example will not work like you might want it to.

    node_b.up()   // This will not resolve to node_b, it will instead throw a compilation error.  The edge node_a-->node_b is a directional edge thus there is no reference to it in node_b.


// The following example however WILL work.

    node_b.the_path() // The edge node_b--node_c is undirected.  Undirected edges are accessible from both of the nodes that they are connected to.
    node_c.the_path()

```

TODO: Define edge scope and edge scope resolution.
TODO: Define the behavior of multiple edges with common labels that are connected to a single node.  It returns a list of nodes (node iterator) instead of a single node.  Should this even be allowed?


