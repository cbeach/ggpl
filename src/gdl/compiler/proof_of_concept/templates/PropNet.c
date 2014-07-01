/* 
 * This is a Jinja2 template for generating the C source file for a propnet game implementation.
 */

//The Python header includes <errno.h>, <stdio.h>, <stdlib.h>, and <string.h>.
#include <Python.h>


typedef struct {
    {% for field in bitfields %}
        unsigned int {{ field }}: 1;
    {% endfor %}
} {{ game.name }};

//TODO: Get legal moves
char** get_legal_moves() {
    //1. Use the template to generate moves as strings that are acceptable inputs.
    //2. Determine which moves are acceptable
    //  2a. For non-stacking pieces that are placed (go, tic-tak-toe, etc.) this is just a list of 
    //      open nodes
    //  2b. For stacking pieces, 
    //3. Return a list of encoded strings to the player
}

//TODO: Determine terminal state
//TODO: Take inputs and return game state

