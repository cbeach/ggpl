# Type System
This language is statically typed

# Built in Types
## Primitive Types
### int
### float
### narray

## Record Types
### game _name_:

```python
game NAME:
    player_definitions
    piece_definitions
    rule_definitions
    play_area
    equipment_definitions
    [support]
    [ITEMs]
```

### Players
Player objects must be defined in either the players record, or as orphaned variables in a library.
Note: This is probably an un-necessary rule, there's probably no reason for having player declarations limited to the players record.

#### Player 
Syntax:
```python
player NAME[:]
    [properties]
```

### inputs

```python
input {boolean | int | uint | float | char | string} ID:
    [PlayerType]  # defaults to all
```

* Defines a list of players for the current game.  Upto eight players can be defined in one game.

Example:
```python
game some_game:
    player alice
    player bob
    player carol
    player dungeon_master:
        label:
            "Dungeon Master"
        lives:
            1000
```
* Individual players can be referenced by index, name, or color
    * The following references are equivalent
        * "players[0]", and "players.alice" are equivalent.
* Lists of players can be referenced with the following macros
    * all|none|neutral|current|friend|enemy
        * all, neutral, current, friend, and enemy all return an array of players
        * None returns the null type (Empty List?)
        * Current's scope is based on who's turn it currently is.
            * Eg players.all would return [alice, bob, carol, dungeon_master] in the above example
            * Eg players.friend would return [alice, bob, carol] if it's alice's, bob's, or carol's turn.  Will return [dungeon\_master] if it's dungeon\_master's turn.

### Rules
```python
[start:]
[play:]
end:
    BOOLEAN
```

#### Piece
```python
piece NAME PlayerType:
    [state State]
    [flags Flags]
    move_defns

```

Example:
```python
piece knight All:
    move:
        ...
```
This is from chess.  The above example declares a piece named knight that can belong to any player.  And indeed, both players in chess own two knights.


##### Move
Defines how a piece may move on the board.  Moves must be defined inside a piece.

```python
move: 
    [dirn: Direction]
    [label: STRING]
    [mandatory: BOOLEAN]
    [owner: PlayerType]
    [post: post_conditions]
    [pre: bool_function]
    [priority: UINT] 
    action: pass | action_defns
```

Example
```python
move:
    dirn: 
        all
    pre:
        ((owner from) and ((steps f f r f) or (steps f f l f)))
    action: 
        pop 
        push 
    post: 
        capture replace
```

###### Direction
The dirn argument specifies which direction the piece is facing at the start of it's move.

###### Precondition
A boolean that specifies whether the move is permitted in a given board state.

###### Action
pop [Coordinate] [UINT | all] 
push [Coordinate] [UNIT] [Player] [trail]

###### Post Condition
capture:
   CaptureTypes [PieceRecord] [optional] [subsume] [recycle] [if fn] |
convert:
   [PlayerType] State | 
   CaptureTypes [PieceRecord] [PlayerType] State [optional] [if fn] |
rotate INT|any [optional] [if fn] |
change-dirn Direction |
displace Direction [PieceRecord] [UINT] [optional] [if fn] |
cell-state CoordType [PlayerType] State [optional] [if fn] |
piece-state [CoordType] [PlayerType] INT [optional] [if fn] |
inc-state [CoordType] [PlayerType] [amount INT] [mod UINT] [optional] [if fn] |
add-flags [CoordType] Flags [optional] [if fn] |
remove-flags [CoordType] Flags [optional] [if fn] |
score int_function [if fn] |
repeat [optional] [if fn] |
swap

// capture: If no PieceRecord, then all affected enemy pieces are captured.
   Captures are relative to to.
   recycle specifies that captured pieces go back in the hand.
   subsume is a very powerful option – the piece subsumes all
   movements and capabilities of the captured piece.
// convert: Either convert this piece to the specified owner and state, or
   convert all capturable pieces of the specified type.
   Note: Pieces to be converted to must be listed before this piece.
   This may cause circular definitions.
// rotate: rotate the piece the specified number of increments clockwise so
    that its flags point elsewhere.
// change-dirn: Change the player’s direction.
// displace: Push pieces away. Specify all for all directions.
// cell-state: Set the state (and optionally owner) of the specified cell.
// piece-state: Set the state (and optionally owner) of the top piece at coord.
// inc-state: Increment the state of the topmost piece at coord.
// add/remove-flags: Set flags of topmost piece at the specified cell/edge.
// score: Update the player’s score by a specified amount, e.g. 1 or (capture-value).
// repeat specifies that the player may repeat this move type (e.g. multiple hops).
// Postconditions are mandatory unless specified as optional.
// The if function, if given, must be satisfied for the postcondition to occur.
// swap specifies that the pieces at the from and to cells swap positions.



### Play Area
The play area is the structure in which the game will be played.  This is the abstract representation of the space in which the game is going to take place.

```python
play_area: 
    number_set: 
        integer|real
    coordinates: 
        coordinate_system: Cartesian|Polar|Cylindrical|Spherical
        axes: 
            x_axis: 
                type: 
                    discrete|continuous
                range:
                    max: 
                        NUMBER
                    min:
                        NUMBER
            y_axis: 
                // same properties as x
            z_axis:    
                // same properties as x
    area_structure: 
        Graph|Plane|Volume:
}
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
    * graph: A graph data structure.  Each node will coorispond to a place for a piece on the game board.  Edges will be paths that are available for pieces to take.  See below for a definition of the graph description language
        * number_set must be integers
    * plane: A simple 2D plane
        * number_set must be real
        * The Z axis may not be defined
    * volume: A simple 3D volume
        * number_set must be real
        * The X, Y, and Z axes must all be defined
* board: defines the type and layout of tiles that the board uses.

### Equipment

#### board
The physical representation of the area in which the game will take place.  Tiles, or regions on this board can be linked with nodes in the game's graph.

```python
board: 
    tiling: 
        hex|square|triangle|truncated_square [ i_nbors | no_d_nbors ]
    shape: 
        ShapeType
    size: 
        NUMBER
    regions: 
        RegionRecords
```
* i_nbors: Indirect neighbors (diagonals) are included if specified
* no_d_nbors: Direct neighbors (left, right, up, down) are removed if specified

#### Dice
Implement later

### End
A Result coupled with a boolean expression.

```python

end:
    if BOOLEAN end_condition:
        mover_wins | mover_loses | draw [opp_turn]

# mover_wins: The player who just moved wins (default).
# mover_loses: The next player wins.
# tie: The game is tied.
# If opp_turn is specified, then a player wins only if their end_clause is met on the opponent’s turn.
```

#### End Conditions
connect:
    [PieceRecord] [d_nbors | i_nbors | all_nbors] [flagged]
    RegionSet [stack]
|
cycle [PieceRecord] [UINT] [full] [d_nbors | i_nbors | all_nbors] |
group [PieceRecord] [UINT] [d_nbors | i_nbors | all_nbors] [stack] |
n_in_a\_row [PieceRecord] UINT [d_nbors | i_nbors | all_nbors] |
pattern [PieceRecord] Steps |
reach [PieceRecord] [UINT| all| fill] [stacks]:
    away | away UINT | CompassDirn | CompassDirn UINT |
    region UINT | site UINT | CoordLabel |
    all\_sides | all\_sides UINT |
capture [PieceRecord] [UINT | all] |
    eliminate PlayerTypes
score { UINT | best } |
stack [PieceRecord] UINT [owner] |
state  CoordRecord | PieceRecord  |
no_move

* connect: Connect all specified regions (must be at least two).
    * If a PieceRecord is given, then only connect that piece type.
    * If i\_nbors or d_nbors are specified, only those neighbours connect.
    * If flagged is specified, only currently flagged directions are allowed.
    * If stack is specified then all pieces in stacks are counted, else only the
    * topmost piece of each stack is examined.
* cycle: Form a cycle, or a full cycle if full is specified.
    * If a PieceRecord is given, then the cycle must consist of that piece.
    * The UINT value, if given, specifies area that the cycle must enclose.
* group: Gather pieces together into a single connected group.
    * If a PieceRecord is given, then that piece type must be gathered.
    * If stack is specified then all pieces in stacks are counted, else only the topmost piece of each stack is examined.
    * The UINT value, if given, specifies the number of pieces to be gathered (default all).
    * The STRING value, if given, specifies type of piece to be gathered.
* n_in_a_row: Form a line of n pieces (of PieceRecord, if given).
* pattern: Form a pattern of pieces defined by the Steps.
* reach: The optional UINT value specifies the number of pieces that must reach the target regions (default 1).
    * If all, then all pieces must reach the target region(s).
    * If fill, then all target region(s) must be filled.
    * If stacks, then only stacks are counted (buried pieces are ignored).
    * If a PieceRecord is given, then only that type of piece is counted.
* capture: Capture piece(s) of the specified type and state.
    * If no piece is specified, then all enemy captures are counted.
    * If all, then all specified pieces must be captured.
    * If all and no piece is specified, all enemy pieces must be eliminated.
    * The optional UINT value specifies the number of pieces (default 1).
* eliminate: Eliminate the specified player(s).
* end_score: Achieve a specified score.
    * If UINT is specified then end as soon as that score is reached, else
    * if best is specified then best score wins/loses.
* stack: Achieve a stack of the specified height.
    * If owner is specified, then only the owner’s pieces in the stack are counted.
* state: Achieve the specified cell/edge or piece state.
* no_move: Current player has no legal moves.
