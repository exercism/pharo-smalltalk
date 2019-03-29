"
I am a simple ""turtle"" robot, that maintains a direction and location.
"
Class {
	#name : #Robot,
	#superclass : #Object,
	#instVars : [
		'name',
		'location'
	],
	#classVars : [
		'Bearings'
	],
	#category : #'Exercism-RobotSimulator'
}

{ #category : #config }
Robot class >> bearingData [
	^ {
	('north' -> (0 @ 1)).
	('east' -> (1 @ 0)).
	('south' -> (0 @ -1)).
	('west' -> (-1 @ 0))}
]

{ #category : #'instance creation' }
Robot class >> facing: directionString [

	self bearingData
		detect: [ :data | data key = directionString ]
		ifNone: [ DomainError signal: 'invalid direction, ' , directionString ].

	^ self new
		name: directionString;
		yourself
]

{ #category : #converting }
Robot >> asDictionary [
	^ Dictionary new
		at: 'direction' put: self name;
		at: 'position'
			put:
			{('x' -> self location x).
			('y' -> self location y)} asDictionary;
		yourself
]

{ #category : #internal }
Robot >> bearingDelta [
	^ (self class bearingData detect: [ :b | b key = self name ]) value
]

{ #category : #internal }
Robot >> bearingLeft [
	| directions |
	directions := self bearingNames.
	^directions before: self name ifAbsent: [directions last].
	
]

{ #category : #accessing }
Robot >> bearingNames [
	^ self class bearingData collect: [ :b | b key ]
]

{ #category : #internal }
Robot >> bearingRight [
	| directions |
	directions := self bearingNames.
	^directions after: self name ifAbsent: [directions first].
	
]

{ #category : #action }
Robot >> execute: instructionCharacter [

	instructionCharacter = $R
		ifTrue: [ ^ self turnRight].
	instructionCharacter = $L
		ifTrue: [ ^ self turnLeft].

	^ self moveForward
]

{ #category : #initialization }
Robot >> initialize [
	super initialize.
	self location: 0@0
]

{ #category : #accessing }
Robot >> location [
	^ location
]

{ #category : #accessing }
Robot >> location: aPoint [
	location := aPoint
]

{ #category : #action }
Robot >> moveForward [
	self location: self location + self bearingDelta
]

{ #category : #accessing }
Robot >> name [
	^ name
]

{ #category : #accessing }
Robot >> name: nameString [
	name := nameString
]

{ #category : #printing }
Robot >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #action }
Robot >> turnLeft [
	self name: self bearingLeft
]

{ #category : #action }
Robot >> turnRight [
	self name: self bearingRight
]
