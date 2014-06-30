# Game Objects
Game Objects are wrappers around propnet fields.  They are simply used as an interface between the propnet and the world outside the statemachine.

# Propnet
Each subobject gets it's own bit field.  Bitfields are referenced in the boolean rules.  Optimizations can be applied later.

```C
typedef struct {
    // End conditions
    unsigned int end_condition_x_wins: 1; 
    unsigned int end_condition_y_wins: 1;
    unsigned int end_condition_draw: 1;

    // Which player's turn is it?
    unsigned int turn_x: 1;
    unsigned int turn_y: 1;

    // Specify what tiles that x's stones occupy
    // Name format is specified as tile_<tile_name>_<player_name>_<piece_name>
    // The tile occupation fields are the cartesian product [tiles] x [players] x [pieces]
    unsigned int tile_0_0_x_stone: 1; 
    unsigned int tile_0_1_x_stone: 1; 
    unsigned int tile_0_2_x_stone: 1; 
    unsigned int tile_1_0_x_stone: 1; 
    unsigned int tile_1_1_x_stone: 1; 
    unsigned int tile_1_2_x_stone: 1; 
    unsigned int tile_2_0_x_stone: 1; 
    unsigned int tile_2_1_x_stone: 1; 
    unsigned int tile_2_2_x_stone: 1; 

    // Specify what tiles that y's stones occupy
    unsigned int tile_0_0_y_stone: 1; 
    unsigned int tile_0_1_y_stone: 1; 
    unsigned int tile_0_2_y_stone: 1; 
    unsigned int tile_1_0_y_stone: 1; 
    unsigned int tile_1_1_y_stone: 1; 
    unsigned int tile_1_2_y_stone: 1; 
    unsigned int tile_2_0_y_stone: 1; 
    unsigned int tile_2_1_y_stone: 1; 
    unsigned int tile_2_2_y_stone: 1; 
} Game;

Game propnet;

// Move legality
legal = 

// End condition
game.end_condition_x_wins = (0_0_x & 0_1_x & 0_2_x) | (1_0_x & 1_1_x & 1_2_x) | (2_0_x & 2_1_x & 2_2_x) | (0_0_x & 1_0_x & 2_0_x) | (0_1_x & 1_1_x & 2_1_x) |
                            (0_2_x & 1_2_x & 2_2_x) | (0_0_x & 1_1_x & 2_2_x) | (2_0_x & 1_1_x & 0_2_x)

game.end_condition_y_wins = (0_0_y & 0_1_y & 0_2_y) | (1_0_y & 1_1_y & 1_2_y) | (2_0_y & 2_1_y & 2_2_y) | (0_0_y & 1_0_y & 2_0_y) | (0_1_y & 1_1_y & 2_1_y) |
                            (0_2_y & 1_2_y & 2_2_y) | (0_0_y & 1_1_y & 2_2_y) | (2_0_y & 1_1_y & 0_2_y)




```
