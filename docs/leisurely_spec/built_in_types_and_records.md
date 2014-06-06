# Type System
This language is statically typed

# Built in Types
## Primitive Types
### int
### float
### array

## Record Types
### Ludeme _name_:
* The word "ludeme" was coined by David Parlett, and means "an element of play".  It's use as a language element in a GDL was taken from Cameron Brown's, "Automatic Generation and Evaluation".
* TODO: Settle on a more specific and precise definition of ludeme as it pertains to this GDL.


### Players
Player objects must be defined in either the players record, or as orphaned variables in a library.
Note: This is probably an un-necessary rule, there's probably no reason for having player declarations limited to the players record.j

#### Player 
Syntax:
```python
player NAME[:]
    [properties]
```

* Defines a list of players for the current game.  Upto eight players can be defined in one game.

Example:
```python
ludeme some_game:
    player alice
    player bob
    player carol
    player dungeon_master:
        label:
            "Dungeon Master"
        lives:
            1000
```

* Individual players can be referenced referenced by index, or name
    * The following references are equivalent
        * "players[0]", and "players.alice" are equivalent.
* Lists of players can be referenced with the following macros
    * all|none|neutral|current|friend|enemy
        * all, neutral, current, friend, and enemy all return an array of players
        * None returns the null type (Empty List?)
        * Current's scope is based on who's turn it currently is.
            * Eg players.all would return [alice, bob, carol, dungeon_master] in the above example
            * Eg players.friend would return [alice, bob, carol] if it's alice's, bob's, or carol's turn.  Will return [dungeon\_master] if it's dungeon\_master's turn.

### Piece


* Defines a generic piece.
* Eg Piece Knight ...
```python
piece knight All:
    moves:
        move
            dirn: 
                all
            pre:
                ((owner from) and ((steps f f r f) or (steps f f l f)))
            action: 
                pop 
                push 
            post: 
                capture replace
        )
    )

```

### Move


### Moves

### Rules

```python
rules: 
    [pieces:]
    [start:]
    [play:]
    end:
        BOOLEAN
```

### Play Area
The play area is the structure in which the game will be played.

```python
play_area: 
    number_set: 
        integer|real
    coordinates: 
        coordinate_system: Cartesian|Polar|Cylindrical|Spherical
        axes: 
            x: 
                type: 
                    discrete|continuous
                range:
                    max: 
                        NUMBER
                    min:
                        NUMBER
            y: 
                // same properties as x
            z:    
                // same properties as x
    area_structure: 
        Graph|Plane|Volume:

    board:
}
```

#### board
```python
board: 
    tiling: 
        TilingType [i-nbors]
    shape: 
        ShapeType
    size: 
        NUMBER
    regions: 
        RegionRecords
```

How the play area is defined is partly determined by:
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
### TilingType:


# Instantiation
## Piece
* NAME|any|current|captured

## PlayerState:
* active|resigned

## CompassDirection:
* n|s|e|w|ne|se|nw|sw

## TurtleDirection:
* f|b|l|r|fl|fr|bl|br
    
## PieceRecord:
* PieceType [PlayerType] [(state UINT)] [(flags UINT)] [(value INT)]
