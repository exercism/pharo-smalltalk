# Secret Handshake

> There are 10 types of people in the world: Those who understand
> binary, and those who don't.

You and your fellow cohort of those in the "know" when it comes to
binary decide to come up with a secret "handshake".

```text
1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.
```

Given a decimal number, convert it to the appropriate sequence of events for a secret handshake.

Here's a couple of examples:

Given the input 3, the function would return the array
["wink", "double blink"] because 3 is 11 in binary.

Given the input 19, the function would return the array
["double blink", "wink"] because 19 is 10011 in binary.
Notice that the addition of 16 (10000 in binary)
has caused the array to be reversed.

## Hint

The Integer class has a bit manipulation protocol which may be useful.


## Downloading

To download this exercise in Pharo, type: `secret-handshake` into the `Exercism | Fetch Exercise` package menu prompt (right click on the Exercism package in the Pharo System Browser). You can also submit your solution from the same menu for any selected package. You don't normally need to use the exercism cli (as indicated on the right hand panel).

## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided `SecretHandshakeTest`, will test the functionality of `SecretHandshake`.

If you are still stuck, the track documentation has more detailed help on [running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

Bert, in Mary Poppins [http://www.imdb.com/title/tt0058331/quotes/qt0437047](http://www.imdb.com/title/tt0058331/quotes/qt0437047)


## Submitting Incomplete Solutions

Remember, it is also possible to submit an incomplete solution so you can see how others have completed this exercise and can learn from their approach.
