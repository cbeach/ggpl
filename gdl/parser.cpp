#include <iostream>
using namespace std;

class Parser {
    public:
        void say_hello() {
            cout << "No" << endl;
        }
};

int main(int argc, char** argv) {
    Parser parse;
    parse.say_hello();
}
