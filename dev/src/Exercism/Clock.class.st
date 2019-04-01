Class {
	#name : #Clock,
	#superclass : #Object,
	#category : #'Exercism-Clock'
}

{ #category : #computing }
Clock >> addMinute: minute hour: hour value: minutes [ 
	^ self createMinute: minute + minutes hour: hour
]

{ #category : #creating }
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

{ #category : #comparing }
Clock >> equalClock1: aCollection clock2: aCollection2 [
	| clock1 clock2 |
	
	clock1 := self createMinute: (aCollection at: #minute) hour: (aCollection at: #hour).
	clock2 := self createMinute: (aCollection2 at: #minute) hour: (aCollection2 at: #hour).
	^ clock1 = clock2
]

{ #category : #computing }
Clock >> subtractMinute: minute hour: hour value: minutes [ 
	^ self createMinute: minute - minutes hour: hour
]
