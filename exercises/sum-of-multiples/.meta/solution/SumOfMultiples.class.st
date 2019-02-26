"
This solution uses inject:into: to sum the runnning interval, as well as extracting the multiples test to a seperate method for clarity
"
Class {
	#name : #SumOfMultiples,
	#superclass : #Object,
	#instVars : [
		'multiples'
	],
	#category : #'Exercism-SumOfMultiples'
}

{ #category : #internal }
SumOfMultiples >> anyMultiplesOf: aNumber [
	^ self multiples anySatisfy: [ :multiple | aNumber isDivisibleBy: multiple ]
]

{ #category : #accessing }
SumOfMultiples >> multiples [
	^ multiples ifNil: [ multiples := Set new ]
]

{ #category : #exercism }
SumOfMultiples >> sumFactors: aCollection limit: anInteger [
	self multiples addAll: aCollection.
	
	^ (1 to: anInteger - 1)
		inject: 0
		into: [ :runningSum :aNumber | 
			(self anyMultiplesOf: aNumber)
				ifTrue: [ runningSum + aNumber ]
				ifFalse: [ runningSum ] ]
]
