Class {
	#name : #Trinary,
	#superclass : #Object,
	#category : #'Exercism-Trinary'
}

{ #category : #'private validating' }
Trinary >> isValidTrinaryValue: anIntegerOrString [
	^ '0123' includesAll: anIntegerOrString asString
]

{ #category : #private }
Trinary >> parseTrinaryValue: anIntegerOrString [
	| trinaryValue |
	trinaryValue := 0.
	anIntegerOrString asString reverse
		withIndexDo: [ :element :index | 
			trinaryValue := trinaryValue
				+ (element digitValue * (3 raisedTo: index - 1)) ].
	^ trinaryValue
]

{ #category : #converting }
Trinary >> toDecimalTrinary: anIntegerOrString [
	^ (self isValidTrinaryValue: anIntegerOrString)
		ifTrue: [ self parseTrinaryValue: anIntegerOrString ]
		ifFalse: [ 0 ]
]
