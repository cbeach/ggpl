#ifndef ACTION_HPP
#define ACTION_HPP
#include "move_property.hpp"

#define PUSH_PIECE 1
#define POP_PIECE 2

#define SOURCE_NODE 1
#define DEST_NODE 2

struct action_struct {
    int action;
    int node;
};

class Action: public MoveProperty {
    public:
        void add_action(int action, int node);
};

#endif
