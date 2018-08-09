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
