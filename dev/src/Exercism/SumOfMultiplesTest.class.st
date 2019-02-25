"
# Sum Of Multiples

Given a number, find the sum of all the unique multiples of particular numbers up to
but not including that number.

If we list all the natural numbers below 20 that are multiples of 3 or 5,
we get 3, 5, 6, 9, 10, 12, 15, and 18.

The sum of these multiples is 78.

## Hint

The trick to this exercise is to understand how to iterate accross an Interval as well as check a Collection for any multiples that are divisible by a number. Try using the Spotter to look up potential classes and browse the categories of methods in those classes. 

Also remember that the Pharo environment is extensively cross referenced. You can right click on any class or method and browse ""references"" to a class (to see how it might be created), as well as ""senders"" of a method (to see how it might be used). 

"
Class {
	#name : #SumOfMultiplesTest,
	#superclass : #ExercismTest,
	#category : #'Exercism-SumOfMultiples'
}

{ #category : #meta }
SumOfMultiplesTest class >> difficulty [
	^3
]

{ #category : #meta }
SumOfMultiplesTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('iteration' 'filtering' 'math')
]

{ #category : #meta }
SumOfMultiplesTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^LeapTest 
]

{ #category : #meta }
SumOfMultiplesTest class >> uuid [
	"Answer a unique id for this exercise"
	^'34b0900f-de21-4fef-b24b-f125b608e65e'
]

{ #category : #config }
SumOfMultiplesTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^'1.5.0'
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf1to100 [
	self assert: ((SumOfMultiples with: 1) upTo: 100) equals: 4950
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf3or5upto1 [
	self assert: ((SumOfMultiples with: 3 or: 5) upTo: 1) equals: 0
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf3or5upto10 [
	self assert: ((SumOfMultiples with: 3 or: 5) upTo: 10) equals: 23
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf3or5upto100 [
	self assert: ((SumOfMultiples with: 3 or: 5) upTo: 100) equals: 2318
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf3or5upto1000 [
	self assert: ((SumOfMultiples with: 3 or: 5) upTo: 1000) equals: 233168
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf3or5upto4 [
	self assert: ((SumOfMultiples with: 3 or: 5) upTo: 4) equals: 3
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf3upto7 [
	self assert: ((SumOfMultiples with: 3) upTo: 7) equals: 9
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf43or47upto10000 [
	self assert: ((SumOfMultiples with: 43 or: 47) upTo: 10000) equals: 2203160
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf4or6upto15 [
	self assert: ((SumOfMultiples with: 4 or: 6) upTo: 15) equals: 30
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf5or25upto51 [
	self assert: ((SumOfMultiples with: 5 or: 25) upTo: 51) equals: 275
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf5or6or8upto150 [
	self assert: ((SumOfMultiples withAny: #(5 6 8)) upTo: 150) equals: 4419
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOf7or13or17upto20 [
	self assert: ((SumOfMultiples withAny: #(7 13 17)) upTo: 20) equals: 51
]

{ #category : #testing }
SumOfMultiplesTest >> testMultiplesOfEmptyListUpTo10000 [
	self assert: (SumOfMultiples new upTo: 10000) equals: 0
]
