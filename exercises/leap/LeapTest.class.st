Class {
	#name : #LeapTest,
	#superclass : #TestCase,
	#instVars : [
		'leapYearCalculator'
	],
	#category : #'Exercism-Leap'
}

{ #category : #tests }
LeapTest >> setUp [
	leapYearCalculator := Leap new
]

{ #category : #tests }
LeapTest >> testYearIsDivisibleBy100NotDivisibleBy400 [
	self deny: (leapYearCalculator isLeapYear: 2100)
]

{ #category : #tests }
LeapTest >> testYearIsDivisibleBy400 [
	self assert: (leapYearCalculator isLeapYear: 2000)
]

{ #category : #tests }
LeapTest >> testYearIsDivisibleBy4NotDivisibleBy100 [
	self assert: (leapYearCalculator isLeapYear: 1996)
]

{ #category : #tests }
LeapTest >> testYearNotDivisibleBy4 [
	self deny: (leapYearCalculator isLeapYear: 2015)
]
