#Syntax Specification
TODO: Syntax for scope resolution and referencing properies/variables in different parts of the 
      game declaration
TODO: Define type system

## White Space
Leisurely uses roughly the same rules for whitespace as Python.  
An increase in indentation denotes a codeblock belonging to the previous statement.
A newline specifies the end of a line of code with the following exceptions:

1. The newline character is inside a set parentheses or brackets (square or curly)
2. The line ends with a sequence describe by '\\\s*\n'

In those cases the newline character is treated like all other whitespace.  This is done for the sake of readibility.

## Parentheses
Parenteses are used for order of precedence in expressions.

## Strings
Python and JavaScript rules are used for string declarations.  I.e. ' <==> "

## Statements
Colon is placed at the end to denote the code block belonging to the statement

## Reserved Words

### import [library_name|library_sha]
The import command will import the desired file into the current game's namespace.
A repository of game libraries will be kept in a remote database that the compiler will have access to. 
Cached copies of commonly used libraries will be kept on disk.  Cache misses will require the compiler
to download and cache the specified library.

### self
Refers to the ludeme in the current scope.
Eg.
    1. In this example, self refers to one of the instantiations of the piece knight.
        piece knight:
            moves:
                move:
                    pre:
                        self.state == <something>

### pass
Equivalent to noop.  Allows for variable declarations with empty properties.  For instance, declaring empty nodes and edges in a graph.
```python
    node node_a:
        pass
    node node_b:
        int some_value
    node_a --> node_b northern_edge:
        pass
```

# Operators

| Operator   | Description                                         |
|:----------:|----------------------------------------------------:|
| -[int]-    | Undirected edge declarator                          |
| -[int]->   | Directed edge declarator                            |   
| .          | Object reference                                    |   
| ()         |                                                     |   
| :          | Placed after a statement, defines a block of code   |   
|            |                                                     |   
