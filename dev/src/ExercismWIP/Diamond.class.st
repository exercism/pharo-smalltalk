Class {
	#name : #Diamond,
	#superclass : #Object,
	#category : #'ExercismWIP-Diamond'
}

{ #category : #formatting }
Diamond >> rowsLetter: aString [
	| number result |
	
	aString size isZero ifTrue: [ ^ #() ].
	number := aString first digitValue - 9.
	number = 1 ifTrue: [ ^ { aString } ].
	^ result
]
