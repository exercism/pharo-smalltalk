"
# Running Tests

Tests can be run directly from the test class. The test class is normally named after the class under test e.g.
`HelloWorld` is the class tested by `HelloWorldTest`. To run a test click the button next to any method
prefixed with `test`. The button will be colored according to the result of the last test: green for pass,
yellow for fail, and red for error.

All the tests in a class can be run by clicking the button next to the test class name. Larger groups of tests
can be run using the Test Runner tool from the world menu. `ctrl + OU` opens the Test Runner 
(`cmd + OU` for MacOS).
"
Class {
	#name : #TwoFerTest,
	#superclass : #TestCase,
	#instVars : [
		'twoFer'
	],
	#category : #'ExercismDev-TwoFer'
}

{ #category : #running }
TwoFerTest >> setUp [
	twoFer := TwoFer new.
]

{ #category : #tests }
TwoFerTest >> testANameGive [
	self assert: (twoFer who: 'Alice') equals: 'One for Alice, one for me.'. 
]

{ #category : #tests }
TwoFerTest >> testAnotherNameGiven [
	self assert: (twoFer who: 'Bob') equals: 'One for Bob, one for me.' 
]

{ #category : #tests }
TwoFerTest >> testNoNameGiven [
	self assert: twoFer who equals: 'One for you, one for me.' 
	
]
