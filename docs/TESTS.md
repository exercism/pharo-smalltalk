## Running Tests

At the most basic level, Exercism is all about the tests and 
[testing](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/test-suites.md).

In Pharo, you can run tests for a single exercise by clicking on the test orb next to any TestCase class or method.
The orb will then be colored according to the result of the last test run: 
green for pass, yellow for an assertion failure, and red for a runtime error/exception.

Larger groups of tests can also be run using the Test Runner tool from the world menu or typing `<meta> + OU`.
 
Alternatively you can use the playground and evaluate:
```
AllExercismTests suite run.
```

**Did you know:** *[TDD](https://en.wikipedia.org/wiki/Test-driven_development) was invented in Smalltalk via the introduction of the [SUnit](https://en.wikipedia.org/wiki/SUnit) test library*

