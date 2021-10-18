# List of concept exercises
Following concepts are organized in Pharo language specific manner. They don't use conventional approach of describing language aspects used from mainstream languages, it's more focused on specific and unique language properties. However, most of exercises can be somehow "mapped" to the conventional terms or explanation topics (e.g. iterating through collections can be mapped to "for", "do-while" terms or concepts).  
Concepts are described just from very high level, so every concept exercise would need separate comperhensive content with sample code examples/exercises.

## Foreword - key aspects of Pharo
- introduce key aspects of Pharo: not just language but also dev environment
- not file based but image based, program and data together
- JIT compiled and VM based
- Live, immersive and dynamic system (everything is inspectable)
- Simple but powerful model (only few syntax elements, everything else part of standard library)
- No primitive types
- Strongly typed but dynamic
- Multiplatform
- Some history
- MIT licence

## Pharo Object model in nutshell
- explain there are just objects and messages sent to the objects
- messages vs methods (understanding difference)
- everything is and object (even classes)
- Mention single inheritance
- Mention what is missing (less is more)

## Pharo syntax on one postcard
- explain all syntactic elements on postcard
- only 6 reserved words
- everything else is done via objects and messages

## It's all about sending messages
- kind of messages
- message precedence,flow of evaluation
- how to read from conventional languages
- message sequencing and cascading

## Assignment and local variables
- explain local variable declaration
- how to assign to an variable
- mention there can be another kinds of variables

## Defining classes and methods
- how to define class (by sending a message)
- how to define a method within a class
- mention the convention for implemented method vs syntactic element 
- how to define class method
- explain selectors, senders, implementors

## Blocks - first class citizens
- explain blocks are anonymous functions implemented as first class objects
- operations on blocks
- how blocks can be useful (defferring evaluation)
- mention blocks are used everywhere in Pharo

## Control flow by sending a message
- explain how booleans are implemented
- explain how if statemements are implemented (sending a message to a boolean instance)
- summarize that if is not syntactic element but method implemented on boolean classes

## Parentheses, brackets, square brackets
## Returning
## Variables can be special
## Undefined values are objects
## Understanding class methods
## SUnit - mother of all unit tests
## Iterating, looping by sending a message
## Strings, characters, streams, symbols as objects
## Files are objects too
## Dynamic vs literal arrays
## Numbers are another objects
## Manipulating with bits
## Inheritance is simple
## Exceptions are powerful
## Debugging and halting (breakpoints)
## Reflection and introspection
## Advanced of advanced Pharo object model
## Common mistakes
## Pharo Development environment - one of first one of best
## Version control system using Git and others
## Pharo specific language elements (traits, metalinks, variables as slot objects)
