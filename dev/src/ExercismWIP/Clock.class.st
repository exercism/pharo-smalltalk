Class {
	#name : #Clock,
	#superclass : #Object,
	#category : #'ExercismWIP-Clock'
}

{ #category : #creation }
Clock >> createMinute: anInteger hour: anInteger2 [ 
	| hour minute |
	
	hour := anInteger // 60 + anInteger2 % 24.
	minute := anInteger % 60.
	
	^ '{1}{2}:{3}{4}' format: {
		(hour < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		hour.
		(minute < 10 ifTrue: [ '0' ] ifFalse: [ '' ]).
		minute }
]
