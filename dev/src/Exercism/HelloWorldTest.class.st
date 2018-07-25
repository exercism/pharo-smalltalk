"
# Hello World

The classical introductory exercise. Just say ""Hello, World!"".

[""Hello, World!""](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) is
the traditional first program for beginning programming in a new language
or environment.

The objectives are simple:

- Write a function that returns the string ""Hello, World!"".
- Run the test suite and make sure that it succeeds.
- Submit your solution and check it at the website.

If everything goes well, you will be ready to fetch your first real exercise.

* * * *

For installation and learning resources, refer to the
[exercism help page](http://exercism.io/languages/pharo).

To run the tests provided, you  should use the intergrated SUnit test runner already provided in Pharo. Simply click  on the globe next to the provided unit test.

## Source

This is an exercise to introduce users to using Exercism [http://en.wikipedia.org/wiki/%22Hello,_world!%22_program](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program)

## Submitting Incomplete Solutions
Note it's entirely possible to submit an incomplete solution so you can see how others have completed the exercise and also get feedback on your progress as well

"
Class {
	#name : #HelloWorldTest,
	#superclass : #TestCase,
	#category : #'Exercism-HelloWorld'
}

{ #category : #tests }
HelloWorldTest >> testSayHello [
	self assert: HelloWorld sayHello equals: 'Hello, World!'
]
