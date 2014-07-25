#include "action.hpp"
#include "move.hpp"
#include "precondition.hpp"

Move::Move() {
    for(int i = 0; i < 1024; i++) {
        preconditions[i] = 0;
        actions[i] = 0;
    }
    preconditions_index = 0;
    actions_index = 0;
}

void Move::add_precondition(MovePrecondition* pre) {
    preconditions[preconditions_index] = pre;
    preconditions_index++; 
}

void Move::add_action(Action* action) {
    actions[actions_index] = action;
    actions_index++; 
}

void Move::add_property(MoveProperty* prop) { }

void Move::add_property(MovePrecondition* pre) {
    add_precondition(pre);
}

void Move::add_property_list(MovePropertyList* prop_list) {}
