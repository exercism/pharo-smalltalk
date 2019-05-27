# Flatten Array

Take a nested list and return a single flattened list with all values except nil/null.

The challenge is to write a function that accepts an arbitrarily-deep nested list-like structure and returns a flattened structure without any nil/null values.

For Example

input: [1,[2,3,null,4],[null],5]

output: [1,2,3,4,5]


## Hint

Without using the built-in flattening method, you can easily derive your own, but you will need to differeniate between what is a collection and what is not


## Downloading

To download this exercise in Pharo, type: `flatten-array` into the `Exercism | Fetch new exercise` top menu prompt (or right click on any `Exercise@<Name>` package in the Pharo System Browser).

When you are finished writing and testing your solution, and want to submit it, you should right click on the `Exercise@FlattenArray` package and choose `Exercism | Submit exercise` in the context menu. You DON'T use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `FlattenArrayTest`, will test the functionality of `FlattenArray`.

If you are still stuck, the track documentation has detailed help for [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

Interview Question [https://reference.wolfram.com/language/ref/Flatten.html](https://reference.wolfram.com/language/ref/Flatten.html)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
