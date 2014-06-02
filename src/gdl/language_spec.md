# GDL Language Specification v0.1

This game description language (GDL) is designed to be easy read and write.
It attempts to address features of other GDL's that are considered (by the author) to be flaws.
There are very few of these languages, and they are almost exclusively used by researchers 
interested in general game playing.  They have not had much (if any) time in the wild, and do 
not benefit from a wide variety of viewpoints in their development.  This will be an attempt to 
improve the GDL ecosystem.

This specification is concerned with the implementation game rules _only_.  This GDL will have
no features for defining the "look and feel" of the game.  That will be defined elsewhere


## Compilation
The product of compilation will be a machine code state machine housed in a library. 
Players will use this library to play games quickly will minimal effort.

* Language Properties:
    * Declarative

* Files:
    * Extensions: 
        * Source Code: .gdl

* Lexical Properties:
    * Case Sensitive
    * White Space is significant

* Compilation Steps
    1. Lexical Analysis
    2. Parse tokens and generate AST
    3. Reduce the AST to the target language
        * C/C++ for machine code generation due to widely used tools and bindings for Node and Python
        * Prolog for running the game rules through logical validation
    4. Generate bindings for Node and Python


## Syntax Specification

### Keywords
#### import [library_name|library_sha]
The import command will import the desired file into the current game's namespace.
A repository of game libraries will be kept in a remote database that the compiler will have access to. 
Cached copies of commonly used libraries will be kept on disk.  Cache misses will require the compiler
to download and cahce the specified library.

### Operators

### Game Objects
The game rules will be represented by a _ludeme_<sup>1</sup> object with syntax similar to that of 
JavaScript.  The properties game, players, play_area, and rules are all required.  The support 
property is optional and is automatically generated for the most part.  Only one top level ludeme 
object is allowed per file

```js
ludeme NAME = {
    game: {},
    players: [],
    play_area: {},
    rules: [{}, {}, ...],
    [support]
}
```

#### Ludeme properties

##### game
```js
game: {
    sha-1: "...",   //40 character long hex string
}
```
* sha-1:  Identifies the game in the database.


##### play_area
The play area is the structure in which the game will be played.

```js
play_area: {
    number_set: "[integer|real]", 
    coordinates: {
        coordinate_system: "[cartesian|polar|cylindrical|spherical]",
        axes: {
            x: {
                type: [discrete|continuous]
                range: {
                    max: "[int|float]",
                    min: "[int|float]",
                }
            },
            y: {},  // same as x
            z: {}   // same as x
        }
    }
    area_structure: {
        "[graph|plane|volume]": {

        }
    }
    board: {}
}
```
How the play area is defined is partly determined 
* number_set: "[integer|real]"
    * Examples of games from each type
        * Integer: Chess, checkers, tic-tac-toe, battle ship, etc.
        * Real: Super Mario, Soccer, Water Polo, The Legend of Zelda, etc.
* coordinates: Specifies the properties of the coordinate system.
    * coordinate_system: "[cartesian|polar|cylindrical|spherical]"
    * axes: List which axes should be defined by the game at compilation.  X is mandatory, Y and Z are optional.
        * Race games are an example of 1D games
* area\_structure: This will contain precisely one of the following properties.  The property that is used is dependent on the number of axes defined and the number\_set that is used.
    * graph: A graph data structure.  Each node will coorispond to a place for a piece on the game board.  Edges will be paths that are agailable for pieces to take.  See below for a definition of the graph description language
        * number_set must be integers
    * plane: A simple 2D plane
        * number_set must be real
        * The Z axis may not be defined
    * volume: A simple 3D volume
        * number_set must be real
        * The X, Y, and Z axes must all be defined
* board: defines the type and layout of tiles that the board uses.

###### graph

```js
graph: {
    node_a: {
        node_a_property_1: ...,
    },
    node_b: {
        node_b_property_1: ...,
    },
    node_c: {
        node_c_property_1: ...,
    },
    node_d: {
        node_d_property_1: ...,
    },
    node_a -- node_b: {
        undirected_edge_property_1: ...,
    }
    node_b --> node_c: {
        directed_edge_property_1: ...,
    }
    node_a -- node_b: {
        weighted_undirected_edge_property_1: ...,
    }
    node_c -12-> node_d: {
        weighted_directed_edge_property_1: ...,
    }
}
```

##### board
```js
board: {
    tiling: TilingType [i-nbors],
    shape: ShapeType,
    size: units,
    regions: RegionRecords,
}
```

##### rules
```js
rules: [
    {  
        pieces:  // optional
    }, {
        start:  // optional
    }, {
        play:  // optional
    }, {
        end:  // optional
    }
]
```

Example rule set from "Automatic Generation and Evaluation" by Cameron Browne
#1: 004 – Gomoku (hexhex board, connected move, capture)
```lisp
(ludeme 004
    (players White Black)
    (board
        (tiling hex)
        (shape hex)
        (size 5)
    )
    (pieces
        (Stone All
            (moves
                (move
                    (pre (empty to) )
                    (action (push) )
                )
                (move
                    (pre (and (owner from) (connected) (<= (height from) (height to) ) )
                    (action (pop) (push) )
                )
                (move
                    (pre (and (owner from) (connected) (> (height from) (height to) ) )
                    (action (pop) (push) )
                    (post (capture) )
                )
            )
        )
    )
    (end (All win (in-a-row 5) ) )
)
```

1. The word "ludeme" was coined by David Parlett, and means "an element of play".  It's use a language element for a GDL was taken from Cameron Brown, 
   "Automatic Generation and Evaluation"
