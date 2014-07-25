#include <iostream>

#include "base_node.hpp"

using namespace std;

BaseNode::BaseNode() {
    name = "";
}

void BaseNode::add_name(char* new_name) {
    name = new_name;
}
