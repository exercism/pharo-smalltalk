# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

Given a name, return a string with the message:

```text
One for X, one for me.
```

Where X is the given name.

However, if the name is missing, return the string:

```text
One for you, one for me.
```

Here are some examples:

|Name    |String to return 
|:-------|:------------------
|Alice   |One for Alice, one for me. 
|Bob     |One for Bob, one for me.
|        |One for you, one for me.
|Zaphod  |One for Zaphod, one for me.


## Hint

In Pharo, classes are objects that can have instance and class methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods. Typically class methods are used for constructing new objects (like a contructor in other languages).While referring to methods, its useful to know that a method which has no parameters, is called a unary method, and a method taking multiple parameters, each deliniated by a word ending with a ':', is called a keyword method.There is also a third type of method, binary, which takes only 1 parameter and uses a symbol(s) for a name (typically a mathematical one like: +, -, & etc).


## Downloading

To download this exercise in Pharo, type: `two-fer` into the `Exercism | Fetch new exercise` top menu prompt (or right click on any `Exercise@<Name>` package in the Pharo System Browser).

When you are finished writing and testing your solution, and want to submit it, you should right click on the `Exercise@TwoFer` package and choose `Exercism | Submit exercise` in the context menu. You DON'T use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `TwoFerTest`, will test the functionality of `TwoFer`.

If you are still stuck, the track documentation has detailed help for [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

[https://github.com/exercism/problem-specifications/issues/757](https://github.com/exercism/problem-specifications/issues/757)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
