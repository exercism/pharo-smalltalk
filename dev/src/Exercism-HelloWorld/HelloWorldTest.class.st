"
# Hello World

The classical introductory exercise. Just say ""Hello, World!"".

[""Hello, World!""](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) is the traditional first program for beginning programming in a new language or environment.

The objectives are simple:

Write a function that returns the string ""Hello, World!"".
Run the test suite and make sure that it succeeds.
Submit your solution and check it at the website.
If everything goes well, you will be ready to fetch your first real exercise.

* * * *

For installation and learning resources, refer to the
[exercism help page](http://exercism.io/languages/pharo).

The provided tests can be run directly from the test class or the Test 
Runner tool from the World menu `ctrl + OU` (MacOS `cmd + OU`).

## Source

This is an exercise to introduce users to using Exercism [Hello World at Wikipedia](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.

## Running Tests

Tests can be run directly from the test class. The test class is normally named after the class under test e.g.
`HelloWorld` is the class tested by `HelloWorldTest`. To run a test click the button next to any method
prefixed with `test`. The button will be colored according to the result of the last test: green for pass,
yellow for fail, and red for error.

All the tests in a class can be run by clicking the button next to the test class name. Larger groups of tests
can be run using the Test Runner tool from the world menu. `ctrl + OU` opens the Test Runner 
(`cmd + OU` for MacOS).

### Problem Specification

Tests adapted from **problem-specifications//canoncial-data.json** @ v1.1.0.
"
Class {
	#name : #HelloWorldTest,
	#superclass : #TestCase,
	#category : #'Exercism-HelloWorld'
}

{ #category : #tests }
HelloWorldTest >> testHello [
	self assert: HelloWorld sayHello equals: 'Hello, World!'
]
