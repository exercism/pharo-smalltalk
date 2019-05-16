# Grains

Calculate the number of grains of wheat on a chessboard given that the number
on each square doubles.

There once was a wise servant who saved the life of a prince. The king
promised to pay whatever the servant could dream up. Knowing that the
king loved chess, the servant told the king he would like to have grains
of wheat. One grain on the first square of a chess board, with the number
of grains doubling on each successive square.

There are 64 squares on a chessboard (where square 1 has one grain, square 2 has two grains, and so on).

Write code that shows:
- how many grains were on a given square, and
- the total number of grains on the chessboard

## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- Optimize for speed.
- Optimize for readability.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?


## Hint

These kinds of problems (where an answer is dependent on a previous) one are often called recursion. There are different ways to code for recursion, it might be worth reasearching if you are not familiar with this. Pharo is well optimised for recursion, and it is a commonly used pattern.Note: in the original problem specification, the grainsCalculator is called via #square, however we have renamed this method #atSquare: which is a more Smalltalk like name, that better describes that you are asking for an answer "at a square".


## Downloading

To download this exercise in Pharo, type: `grains` into the `Exercism | Fetch new exercise` top menu prompt (or right click on any `Exercise@<Name>` package in the Pharo System Browser).

When you are finished writing and testing your solution, and want to submit it, you should right click on the `Exercise@Grains` package and choose `Exercism | Submit exercise` in the context menu. You DON'T use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `GrainsTest`, will test the functionality of `Grains`.

If you are still stuck, the track documentation has detailed help for [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

JavaRanch Cattle Drive, exercise 6 [http://www.javaranch.com/grains.jsp](http://www.javaranch.com/grains.jsp)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
