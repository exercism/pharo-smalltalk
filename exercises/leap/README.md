# Leap

Given a year, report if it is a leap year.

The tricky thing here is that a leap year in the Gregorian calendar occurs:

```text
on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
    unless the year is also evenly divisible by 400
```

For example, 1997 is not a leap year, but 1996 is.  1900 is not a leap
year, but 2000 is.

If your language provides a method in the standard library that does
this look-up, pretend it doesn't exist and implement it yourself.

## Notes

Though our exercise adopts some very simple rules, there is more to
learn!

For a delightful, four minute explanation of the whole leap year
phenomenon, go watch [this youtube video][video].

[video]: http://www.youtube.com/watch?v=xX96xng7sAE

## Hint
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:For the Class part:  State a one line summary. For example, "I represent a paragraph of text".For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.For the Collaborators Part: State my main collaborators and one line about how I interact with them. Public API and Key Messages- message one   - message two - (for bonus points) how to create instances.   One simple example is simply gorgeous. Internal Representation and Key Implementation Points.    Instance Variables	leapYearCalculator:		<Object>    Implementation Points


## Running The Tests

Tests can be run directly from the Pharo IDE, by clicking on the test orb next to any test.
The SUnit convention is that the provided TestCase, `LeapTest`, is expected
to test the functionality of `Leap`.

If you are still stuck, there is more [detailed help on running tests](https://exercism.io/tracks/pharo/tests).

## Language and Environment Help

For Pharo installation and learning resources, refer to the [track help page](https://exercism.io/tracks/pharo/learning).


## Source

JavaRanch Cattle Drive, exercise 3 [http://www.javaranch.com/leap.jsp](http://www.javaranch.com/leap.jsp)


## Submitting Incomplete Solutions

Remember, it's also possible to submit an incomplete solution so you can see how others have completed the exercise
and can learn from their approach.
