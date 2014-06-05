# Memory Management
The following features of this language should be sufficient to negate the need of a garbage 
collector for user defined games.


* LeisurelyScript has the following properties:
    * It is declarative: It does not allow the creation of new variables outside the finite 
    * It is functional: Functions are first class.
    * User defined games do not have access to the heep.

# Recursion Depth
The game should throw an error (completely crash and burn) if the recursion depth is exceded.
