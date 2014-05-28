#include <iostream>
#include <vector>
#include <string>

#include "include/parser.h"

using namespace std;

Parser::Parser() {
    cout << "Hello, world!" << endl;
    for(int i = 4; i < 10; i++) {
        numbers.push_back(i);
    }
}

void Parser::say_goodbye() {
    cout << "Goodbye cruel world!" << endl;
}

void Parser::sound_off() {
    for(int i = 0; i < numbers.size(); i++) {
        cout << numbers[i] << endl;
    }
}
