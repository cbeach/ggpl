# Compilation
The product of compilation will either be a binary library that contains a state machine 
with a standardized API, or a source file that contains a reduction of the same code to a 
different language.

Players (binaries of game playing algorithms) will use the binary library to play games quickly 
will minimal effort.

The files that contain code for other languages will be used for different forms of evaluation.
    
    Eg. Prolog can be generated to allow for validation of the game's representation in 
        predicate logic

* Language Properties:
    * Statically typed
    * Declarative

* Files:
    * Extensions: 
        * Source Code: .gdl

* Lexical Properties:
    * Case Sensitive
    * White Space is significant

* Compilation Steps
    1. Lexical Analysis
    2. Parse tokens and generate AST
    3. Reduce the AST to the target language
        * C/C++ for machine code generation due to widely used tools and bindings for Node and Python
        * Prolog for running the game rules through logical validation
    4. Generate bindings for Node and Python
