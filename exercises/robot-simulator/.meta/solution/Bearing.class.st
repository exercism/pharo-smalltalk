"
I am a bearing direction, that knows its immediate left and right bearing
"
Class {
	#name : #Bearing,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classVars : [
		'Bearings'
	],
	#category : #'Exercism-RobotSimulator'
}

{ #category : #config }
Bearing class >> bearingData [
	"Answer bearing names in clockwise order, along with the corresponding delta that would move a point location forward in the correct x/y axis for that bearing"
	
	^ {
	('north' -> (0 @ 1)).
	('east' -> (1 @ 0)).
	('south' -> (0 @ -1)).
	('west' -> (-1 @ 0))}
]

{ #category : #'instance creation' }
Bearing class >> named: directionString [
	self bearingData
		detect: [ :data | data key = directionString ]
		ifNone: [ DomainError signal: 'invalid direction, ' , directionString ].

	^ self new
		name: directionString;
		yourself
]

{ #category : #comparing }
Bearing >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #query }
Bearing >> delta [
	^ (self class bearingData detect: [ :b | b key = self name ]) value
]

{ #category : #comparing }
Bearing >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #query }
Bearing >> left [
	| directions |
	directions := self names.
	^Bearing named: (directions before: self name ifAbsent: [directions last]).
	
]

{ #category : #accessing }
Bearing >> name [
	^ name
]

{ #category : #accessing }
Bearing >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Bearing >> names [
	^ self class bearingData collect: [ :b | b key ]
]

{ #category : #printing }
Bearing >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #query }
Bearing >> right [
	| directions |
	directions := self names.
	^Bearing named: (directions after: self name ifAbsent: [directions first])
	
]
