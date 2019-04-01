Class {
	#name : #Clock,
	#superclass : #Object,
	#category : #'ExercismWIP-Clock'
}

{ #category : #creation }
Clock >> createMinute: anInteger hour: anInteger2 [ 
	^ '{1}{2}:{3}{4}' format: {
		(anInteger2 < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		anInteger2.
		(anInteger < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		anInteger }
]
