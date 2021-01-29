# Resistor Color Duo

If you want to build something using a Raspberry Pi, you'll probably use _resistors_. For this exercise, you need to know two things about them:

* Each resistor has a resistance value.
* Resistors are small - so small in fact that if you printed the resistance value on them, it would be hard to read.
To get around this problem, manufacturers print color-coded bands onto the resistors to denote their resistance values. Each band acts as a digit of a number. For example, if they printed a brown band (value 1) followed by a green band (value 5), it would translate to the number 15.

In this exercise, you are going to create a helpful program so that you don't have to remember the values of the bands. The program will take two colors as input, and output the correct number.

The band colors are encoded as follows:

- Black: 0
- Brown: 1
- Red: 2
- Orange: 3
- Yellow: 4
- Green: 5
- Blue: 6
- Violet: 7
- Grey: 8
- White: 9


## Hint

You will need some form of lookup table of colours to calculate the value. You don't necessarily have to use a Dictionary to do this.


## Downloading

To download this exercise in Pharo, type: `resistor-color-duo` into the `Exercism | Fetch new exercise` top menu prompt (or right click on any `Exercise@<Name>` package in the Pharo System Browser).

When you are finished writing and testing your solution, and want to submit it, you should right click on the `Exercise@ResistorColorDuo` package and choose `Exercism | Submit exercise` in the context menu. You DON'T use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `ResistorColorDuoTest`, will test the functionality of `ResistorColorDuo`.

If you are still stuck, the track documentation has detailed help for [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

Maud de Vries, Erik Schierboom [https://github.com/exercism/problem-specifications/issues/1464](https://github.com/exercism/problem-specifications/issues/1464)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
