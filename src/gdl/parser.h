#ifndef PARSER_H
#define PARSER_H

#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Parser {
    vector<int> numbers;
    public:
        Parser();
        void say_goodbye();
        void sound_off();
};

#endif
