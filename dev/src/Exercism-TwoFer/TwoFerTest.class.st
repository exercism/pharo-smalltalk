"
# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

```text
""One for X, one for me.""
```

When X is a name or ""you"".

If the given name is ""Alice"", the result should be ""One for Alice, one for me.""
If no name is given, the result should be ""One for you, one for me.""


* * * *

For installation and learning resources, refer to the
[exercism help page](http://exercism.io/languages/pharo).

The provided tests can be run directly from the test class or the Test 
Runner tool from the World menu `ctrl + OU` (MacOS `cmd + OU`).

## Source

This is an exercise to introduce users to basic programming constructs, just after Hello World. [https://en.wikipedia.org/wiki/Two-fer](https://en.wikipedia.org/wiki/Two-fer)

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

Tests adapted from **problem-specifications//canoncial-data.json** @ v1.2.0.
"
Class {
	#name : #TwoFerTest,
	#superclass : #TestCase,
	#instVars : [
		'twoFer'
	],
	#category : #'Exercism-TwoFer'
}

{ #category : #running }
TwoFerTest >> setUp [
	twoFer := TwoFer new.
]

{ #category : #tests }
TwoFerTest >> testWithAnotherName [
	self assert: (twoFer who: 'Bob') equals: 'One for Bob, one for me.' 
]

{ #category : #tests }
TwoFerTest >> testWithName [
	self assert: (twoFer who: 'Alice') equals: 'One for Alice, one for me.'
]

{ #category : #tests }
TwoFerTest >> testWithNoName [
	self assert: twoFer who equals: 'One for you, one for me.' 
	
]
