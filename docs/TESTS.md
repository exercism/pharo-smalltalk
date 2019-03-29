## Running Tests

At the most basic level, Exercism is all about the tests and 
[testing](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/test-suites.md).

In Pharo, you can run tests for a single exercise by clicking on the coloured test orb next to any TestCase class or method.
The orb will then be coloured according to the result of the last test run: 
- green for pass 
- yellow for an assertion failure 
- red for a runtime error/exception.

The tests in Exercism exercises have been purposely numbered to give a defined order of execution (test01_verifySomeProperty, test02_verifyAnotherProperty etc.). When working on an exercise it is recommended that you click on the orb of the first test, understand the failure and what is required to make it pass and then add the code to your solution to make the test pass. In Pharo it is quite normal to make these changes in the debugger where you have access to both the code editor as well as a view of all the variables and parameters that can help you understand the problem. 

_NOTE: It is not a regular practice to label tests with an ordering prefix, and you should NOT do this when writing tests for your own code._

Pharo is also happy to run with code that is broken, and the debugger will simply re-open when code is encountered that is in error (either a syntax error, bad value or even a missing class or method). This technique was a primary influencer for test driven development, and you can get a taste of this approach when you run the first test of any exercise. The debugger will immediately report that your solution class is not found (as you haven't tried to solve it yet). Conveniently, their is a "Create" button that helps you add the missing class and it then continues running the test until it either finishes, or another error is encountered. With your first test, you normally then encounter a second error for a missing method in your new class. Again, the "Create" button in the debugger lets you define it, and continue running. At this point, you can then click further down the stack trace and review the requirements of the failing test and modify your freshly created method to make that test pass. 

Later in your development cycle you might also find it useful to click further back in the stack and use the "Restart" button to resume program execution at an earlier point, so that you can then step through/into your program to see what is going on. This is an important and useful way to understand why your program isn't working.  

As well as seeing variables in the debugger, you can also highlight any statement and click on inspect/print to see the result of evaluating it. This can be useful when testing results from a method, or for examining the internal state of an object. 

In Summary, don't be afraid of using the debugger in Pharo, we view it as a valuable tool that aids in understanding and experimenting with a problem.

_Side note:_ If you want to run larger groups of tests, you can also run tests from the Package menu as well as use the Test Runner tool (accessed from the World menu or type `<meta> + OU`).
 
You can also use run tests programmatically from the playground by print evaluating:
```
AllExercismTests suite run.
```

<br/>

**Did you know:** *[TDD](https://en.wikipedia.org/wiki/Test-driven_development) was invented in Smalltalk via the introduction of the [SUnit](https://en.wikipedia.org/wiki/SUnit) test library*

