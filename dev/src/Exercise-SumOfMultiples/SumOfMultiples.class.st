"
This solution uses inject:into: to sum the runnning interval, as well as extracting the multiples test to a seperate method for clarity
"
Class {
	#name : #SumOfMultiples,
	#superclass : #Object,
	#category : #'Exercism-SumOfMultiples'
}

{ #category : #internal }
SumOfMultiples >> anyMultiplesOf: aNumber in: aCollection [
	^ aCollection anySatisfy: [ :multiple | aNumber isDivisibleBy: multiple ]
]

{ #category : #exercism }
SumOfMultiples >> sumFactors: aCollection limit: anInteger [
	
	^ (1 to: anInteger - 1)
		sumNumbers: [ :factor | 
			(self anyMultiplesOf: factor in: aCollection)
				ifTrue: [ factor ]
				ifFalse: [ 0 ] ]
]
