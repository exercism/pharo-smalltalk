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

{ #category : #'instance creation' }
SumOfMultiples class >> with: aNumber [ 
	^self withAny: { aNumber }
]

{ #category : #'instance creation' }
SumOfMultiples class >> with: aNumber or: anotherNumber [
	^ self
		withAny:
			{aNumber.
			anotherNumber}
]

{ #category : #'instance creation' }
SumOfMultiples class >> withAny: numberCollection [
	| result |
	result := self new.
	numberCollection do: [ :number | result addMultiple: number ].
	^ result
]

{ #category : #public }
SumOfMultiples >> addMultiple: aNumber [ 
	self multiples add: aNumber
]

{ #category : #helper }
SumOfMultiples >> anyMultiplesOf: aNumber [
	^ self multiples anySatisfy: [ :multiple | aNumber isDivisibleBy: multiple ]
]

{ #category : #accessing }
SumOfMultiples >> multiples [
	^ multiples ifNil: [ multiples := Set new ]
]

{ #category : #public }
SumOfMultiples >> upTo: maxNumber [
	^ (1 to: maxNumber - 1)
		inject: 0
		into: [ :runningSum :aNumber | 
			(self anyMultiplesOf: aNumber)
				ifTrue: [ runningSum + aNumber ]
				ifFalse: [ runningSum ] ]
]
