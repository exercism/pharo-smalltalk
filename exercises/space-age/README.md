# Space Age

Given an age in seconds, calculate how old someone would be on:

   - Earth: orbital period 365.25 Earth days, or 31557600 seconds
   - Mercury: orbital period 0.2408467 Earth years
   - Venus: orbital period 0.61519726 Earth years
   - Mars: orbital period 1.8808158 Earth years
   - Jupiter: orbital period 11.862615 Earth years
   - Saturn: orbital period 29.447498 Earth years
   - Uranus: orbital period 84.016846 Earth years
   - Neptune: orbital period 164.79132 Earth years

So if you were told someone were 1,000,000,000 seconds old, you should
be able to say that they're 31.69 Earth-years old.

If you're wondering why Pluto didn't make the cut, go watch [this
youtube video](http://www.youtube.com/watch?v=Z_2gbGXzFbs).


## Hint

You might find Pharo dictionaries useful in completing this exercise.Pharo has several ways to construct dictionaries, including `Dictionary new: at:put:`and a literal syntax using `Association`s. An `Association` looks like `key -> value`and can be turned into a dictionary like this: `{ 'key' -> 'value' } asDictionary`.Remember that in Smalltalk, all infix operators are right-associative and that youcan browse any of the classes mentioned above live.


## Downloading

To download this exercise in Pharo, type: `space-age` into the `Exercism | Fetch new exercise` top menu prompt (or right click on any `Exercise@<Name>` package in the Pharo System Browser).

When you are finished writing and testing your solution, and want to submit it, you should right click on the `Exercise@SpaceAge` package and choose `Exercism | Submit exercise` in the context menu. You DON'T use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `SpaceAgeTest`, will test the functionality of `SpaceAge`.

If you are still stuck, the track documentation has detailed help for [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

Partially inspired by Chapter 1 in Chris Pine's online Learn to Program tutorial. [http://pine.fm/LearnToProgram/?Chapter=01](http://pine.fm/LearnToProgram/?Chapter=01)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
