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
"
Class {
	#name : #HelloWorld,
	#superclass : #Object,
	#category : #'ExercismDev-HelloWorld'
}

{ #category : #exercism }
HelloWorld class >> sayHello [
	^ 'Hello, World!'
]
