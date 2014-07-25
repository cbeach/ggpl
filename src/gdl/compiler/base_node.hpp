#ifndef BASE_NODE_HPP
#define BASE_NODE_HPP

#include <string>

using namespace std;

class BaseNode {
    protected:
        char* name;
    public:
        BaseNode();
        void add_name(char* new_name);
};
#endif
