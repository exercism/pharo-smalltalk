Class {
	#name : #Diamond,
	#superclass : #Object,
	#category : #'ExercismWIP-Diamond'
}

{ #category : #formatting }
Diamond >> makeRow: char baseChar: baseChar [
	| maxValue letterValue halfRow |

	maxValue := baseChar asInteger - $A asInteger + 1.
	letterValue := char asInteger - $A asInteger + 1.
	halfRow := String streamContents: [ :stream |
		stream
		 << (self paddingSpaces: maxValue - 1 - (letterValue - 1))
		 << char
		 << (self paddingSpaces: letterValue - 1) ].
	^ halfRow , halfRow allButLast reversed
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
