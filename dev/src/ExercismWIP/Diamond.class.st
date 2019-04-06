Class {
	#name : #Diamond,
	#superclass : #Object,
	#category : #'ExercismWIP-Diamond'
}

{ #category : #formatting }
Diamond >> makeTipBaseChar: baseChar [
	| totalRows paddingSpaces |

	totalRows := (baseChar asInteger - $A asInteger + 1) * 2 - 1.
	paddingSpaces := totalRows // 2.
	^ '{1}A{2}'
		format: {
			self paddingSpaces: paddingSpaces.
			self paddingSpaces: paddingSpaces }
]

{ #category : #formatting }
Diamond >> paddingSpaces: anInteger [
	^ anInteger isZero
		ifTrue: [ '' ]
		ifFalse: [ String new: anInteger withAll: Character space ]
]

{ #category : #formatting }
Diamond >> rowsLetter: aString [
	| number result |
	
	aString size isZero ifTrue: [ ^ #() ].
	number := aString first digitValue - 9.
	number = 1 ifTrue: [ ^ { aString } ].
	^ result
]
