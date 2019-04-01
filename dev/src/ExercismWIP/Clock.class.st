Class {
	#name : #Clock,
	#superclass : #Object,
	#category : #'ExercismWIP-Clock'
}

{ #category : #'as yet unclassified' }
Clock >> addMinute: minute hour: hour value: minutes [ 
	^ self createMinute: minute + minutes hour: hour
]

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

{ #category : #'as yet unclassified' }
Clock >> subtractMinute: minute hour: hour value: minutes [ 
	^ self createMinute: minute - minutes hour: hour
]
