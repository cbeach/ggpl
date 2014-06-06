# Memory Management
The following features of this language should be sufficient to negate the need of a garbage 
collector for user defined games.


* Leisurely has the following properties:
    * It is declarative: It does not allow the creation of new variables outside the finite 
    * It is functional: Functions are first class.
    * User defined games do not have access to the heep.

# Recursion Depth
The game should throw an error (completely crash and burn) if the recursion depth is exceded.  Recursion depth can be set as a command line argument to the compiler.

# Boolean evaluation
## Version 1
Just reduce the booleans to a bit field and perform the necessary operations on them.

## Version 2
Reduce boolean expressions to conjunctive normal form CNF.  Each disjunction is contained in its own bitfield.  A hash map is used to keep track of all of the disjunctions that each variable is contained within.
Negative and positive disjunctions are kept in separate bags.  When a variable is updated, each disjunction that contains that variable is updated.  If the value of the disjunction changes, then it is moved to the appropriate bag.
If there are no more disjunctions in the negative bag, then the CNF evaluates to true.
Only updating the variables that have changed will prevent redundant computation from being performed.

## Version 3
Further optimize the boolean expression.
