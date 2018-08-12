"
While there is an #isLeapYear method for Dates, can you figure out how to do this yourself using simple math? 

You may also need to explore Boolean #and: and #or: conditions which are interestingly implemented as methods on the classes True and False. Try using Spotter (shift-enter) to see how they work. 


"
Class {
	#name : #LeapTest,
	#superclass : #TestCase,
	#instVars : [
		'leapYearCalculator'
	],
	#category : #'Exercism-Leap'
}

{ #category : #setup }
LeapTest >> setUp [
	leapYearCalculator := Leap new
]

{ #category : #testing }
LeapTest >> testYearIsDivisibleBy100NotDivisibleBy400 [
	self deny: (leapYearCalculator isLeapYear: 2100)
]

{ #category : #testing }
LeapTest >> testYearIsDivisibleBy400 [
	self assert: (leapYearCalculator isLeapYear: 2000)
]

{ #category : #testing }
LeapTest >> testYearIsDivisibleBy4NotDivisibleBy100 [
	self assert: (leapYearCalculator isLeapYear: 1996)
]

{ #category : #testing }
LeapTest >> testYearNotDivisibleBy4 [
	self deny: (leapYearCalculator isLeapYear: 2015)
]
