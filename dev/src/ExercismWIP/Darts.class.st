Class {
	#name : #Darts,
	#superclass : #Object,
	#category : #'ExercismWIP-Darts'
}

{ #category : #scoring }
Darts >> scoreX: anInteger y: anotherInteger [ 
	| length |
	
	length := (anInteger squared + anotherInteger squared) sqrt.
	length > 10 ifTrue: [ ^ 0 ].
	length > 5 ifTrue: [ ^ 1 ].
	length > 1 ifTrue: [ ^ 5 ].
	length >= 0 ifTrue: [ ^ 10 ].
	^ 0
]
