# Leisurely (tentative name) GDL Language Specification v0.1 

This game description language (GDL) is designed to be easy read and write.
It attempts to address features of other GDL's that are considered (by the author) to be flaws.
There are very few of these languages, and they are almost exclusively used by researchers 
interested in general game playing.  They have not had much (if any) time in the wild, and do 
not benefit from a wide variety of viewpoints in their development.  This will be an attempt to 
improve the GDL ecosystem.

This specification is concerned with the implementation game rules _only_.  This GDL will have
no features for defining the "look and feel" of the game.  That will be defined elsewhere

# Open Questions
* Should I rename ludeme to game?
* Should I use RPN?
    * It's easier to parse, but harder to write.
* What operators should be available for scope resolution?
* Should the user be able to define functions?
* What are the data types of your language?
* Should I switch to significant white space?
* Should I add syntax for templating to the language?
    * Pros:
        * It _might_ make algorithms easier to implement.
    * Cons:
        * It would most likely spiral into something truely hideous. 
        * Might require the addition of an operator overloading system.

# Answered:
* Are you going to allow direct pointer access or not?
    * No
* Is it a static or dynamic language?
    * It is a strongly typed, static language 
* What is your memory model? Are you going to use a garbage collector or manual memory management? (If you use a garbage collector, prepare to write one or adapt an existing one to your language.)
    * No garbage collector needed.  This is a representation of a staticly defined state machine.
* How are going to handle concurrency? Are you going to use a simple threading/locking model or something more complex like Linda or the actor model? (Since nowadays computers have multiple cores.)
    * No concurancy is needed in the language.  Any concurancy will be handled in the implementation.
* Are there primitive functions embedded in the language or will everything come from a library?
    * There will be a small set of built-in functions, records, and variables.
* What is the paradigm or paradigms of you language? Functional? Object-oriented? Prototype (like JavaScript)? Aspect-oriented? Template oriented? Or something entirely new?
    * This is an Automata-based programming language
* How is your language going to interface with existing libraries and languages (mainly C)? This point is important if you're building a domain-specific language.
    * It doesn't have to.
* Allow "Naked" variable declarations.
    * Named pieces, boards, graphs, play_areas, rules, etc. can be declared outside of the scope of a game.
    * Not allowing this would make the import keyword useless

UPPERCASE:           Symbol types.                                                         
lowercase:           Rule clause (ludeme) defined by the language.
Capitalised:         Data type.
italicised:          Keyword, operator, function or built-in clause identifier.
Italicised Capital:  Player identifier or name.
[item]:              Optional item.
|:                   Choice (disjunction).
{a | b | c ...}:     Exactly one of the listed items.
(clause):            Rule clause (ludeme) bracketed for scoping purposes.
%n:                  Variable item to be instantiated as the nth argument.

INT:    Signed integer.
UINT:   Unsigned integer.
FLOAT:  Floating point number.
NUMBER: INT | UINT | FLOAT
BOOL:   0|1
CHAR:   Unicode character encoded in UTF-8 
STRING: CHARs
NAME:   STRING // Unique name
ITEM:   NUMBER | BOOL | FLAGS | STRING


# The Game Object
The game rules will be represented by a _ludeme_<sup>1</sup> object with syntax similar to that of 
JavaScript.  The properties game, players, play_area, and rules are all required.  The support 
property is optional and is automatically generated for the most part.  Only one top level ludeme 
object is allowed per file

```python
ludeme NAME:
    game_properties: //chage name to meta?
        // game property definitions go here
        sha1: "";
    players:
        // player definitions go here
    play_area:
        // play_area property definitions go here
    rules:
        // rule definitions go here
        [piece:]
        [start:]
        [play:]
        end:
        piece [owner] [name]:
            // owner is a reference of type Player
            moves:
                move: 
                    direction: 
                        all 
                    pre
                        BOOLEAN
                    action: 
                        pop(source)
                        push(dest)
                    post:
                        capture() 
                move:
                    ...
            [label STRING]
            [state State]
            [flags Flags]
            [value NUMBER]
    [support]:
        // This section contains data relating analyses
}
```

## game
Define game properties that are global over the entire game's scope.  For the most part these properties are planned for future versions.  They will define properties of the game's physics engines (gravity, collisions, mass, innertia, etc.), etc.

```python
game_properties: {
    sha-1: "...",   //40 character long hex string
}
```
* sha-1:  Identifies the game in the database.

#Example rule sets from "Automatic Generation and Evaluation" by Cameron Browne
##1: 004 – Gomoku (hexhex board, connected move, capture)
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


##6: 061 – Form a Group (knight moves, capture)
Game #6 involves pieces that make knight moves that capture by replacement. The rule set contains a
phase ludeme in the start section even though cell phase plays no real part in the game; this
superfluous ludeme is included purely to trigger the board display to show cell phases in the default
checkerboard pattern, in order to visually aid the player in planning knight moves.

```lisp
(ludeme 061
    (players (White n) (Black s) )
    (board
        (tiling square)
        (shape square)
        (size 5)
    )
    (pieces
        (Knight All
            (moves
                (move
                    (dirn all)
                    (pre
                        (and
                            (owner from)
                            (or
                                (steps f f r f)
                                (steps f f l f)
                            )
                        )
                    )
                    (action (pop) (push) )
                    (post (capture replace) )
                )
            )
        )
    )
    (start
        (place
            (Knight White) home (home 1) (home 2) (home 3) (home 4) (home 5) (phase 0)
        )
        (place
            (Knight Black) home (home 1) (home 2) (home 3) (home 4) (home 5) (phase 1)
        )
    )
    (end (All win (group) ) )
)

```

1. The word "ludeme" was coined by David Parlett, and means "an element of play".  It's use a language element for a GDL was taken from Cameron Brown, 
   "Automatic Generation and Evaluation"

# Reference

Browne, Cameron (2008, February) Automatic Generation and Evaluation of Recombination Games
    http://dev.pubs.doc.ic.ac.uk/phd-game-design/phd-game-design.pdf 
