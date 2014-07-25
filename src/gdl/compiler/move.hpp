#ifndef MOVE_HPP
#define MOVE_HPP
#include "action.hpp"
#include "base_node.hpp"
#include "precondition.hpp"
#include "move_property_list.hpp"

class Move: public BaseNode {
    private:
        MovePrecondition* preconditions[1024]; 
        Action* actions[1024];
        int preconditions_index;
        int actions_index;
    public:
        Move();
        void add_action(Action* action);
        void add_precondition(MovePrecondition* pre);
        void add_property(MoveProperty* prop);
        void add_property(MovePrecondition* pre);
        void add_property_list(MovePropertyList* prop_list);
};
#endif
