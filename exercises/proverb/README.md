# Proverb

For want of a horseshoe nail, a kingdom was lost, or so the saying goes.

Given a list of inputs, generate the relevant proverb. For example, given the list `["nail", "shoe", "horse", "rider", "message", "battle", "kingdom"]`, you will output the full text of this proverbial rhyme:

```text
For want of a nail the shoe was lost.
For want of a shoe the horse was lost.
For want of a horse the rider was lost.
For want of a rider the message was lost.
For want of a message the battle was lost.
For want of a battle the kingdom was lost.
And all for the want of a nail.
```

Note that the list of inputs may vary; your solution should be able to handle lists of arbitrary length and content. No line of the output text should be a static, unchanging string; all should vary according to the input given.

## Hint

This one can be quite simple if you look at ways to iterate over the list of inputs.


## Downloading

To download this exercise in Pharo, type: `proverb` into the `Exercism | Fetch Exercise` package menu prompt (right click on the Exercism package in the Pharo System Browser). You can also submit your solution from the same menu for any selected package. You don't normally need to use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `ProverbTest`, will test the functionality of `Proverb`.

If you are still stuck, the track documentation has more detailed help on [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

Wikipedia [http://en.wikipedia.org/wiki/For_Want_of_a_Nail](http://en.wikipedia.org/wiki/For_Want_of_a_Nail)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
