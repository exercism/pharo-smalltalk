Class {
	#name : #Clock,
	#superclass : #Object,
	#category : #'ExercismWIP-Clock'
}

{ #category : #creation }
Clock >> createMinute: anInteger hour: anInteger2 [ 
	| hour minute |
	
	hour := anInteger2 = 24 ifTrue: [ 0 ] ifFalse: anInteger2.
	minute := anInteger.
	
	^ '{1}{2}:{3}{4}' format: {
		(hour < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		hour.
		(minute < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		minute }
]
