"
In Pharo, classes are objects that can have methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods.
"
Class {
	#name : #TwoFerTest,
	#superclass : #TestCase,
	#instVars : [
		'twoFer'
	],
	#category : #'Exercism-TwoFer'
}

{ #category : #setup }
TwoFerTest >> setUp [
	twoFer := TwoFer new.
]

{ #category : #testing }
TwoFerTest >> testAnotherNameGiven [
	self assert: (twoFer who: 'Bob') equals: 'One for Bob, one for me.' 
]

{ #category : #testing }
TwoFerTest >> testANameGiven [
	self assert: (twoFer who: 'Alice') equals: 'One for Alice, one for me.'
]

{ #category : #testing }
TwoFerTest >> testNoNameGiven [
	self assert: twoFer who equals: 'One for you, one for me.' 
	
]
