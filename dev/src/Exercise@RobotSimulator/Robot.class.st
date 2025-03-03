"
I am a simple ""turtle"" robot, that maintains a bearing direction and location.
"
Class {
	#name : 'Robot',
	#superclass : 'Object',
	#instVars : [
		'bearing',
		'location'
	],
	#classVars : [
		'Bearings'
	],
	#category : 'Exercise@RobotSimulator',
	#package : 'Exercise@RobotSimulator'
}

{ #category : 'instance creation' }
Robot class >> facing: directionString [

	^ self new
		bearing: (Bearing named: directionString);
		yourself
]

{ #category : 'converting' }
Robot >> asDictionary [
	^ Dictionary new
		at: 'direction' put: self bearing name;
		at: 'position'
			put:
			{('x' -> self location x).
			('y' -> self location y)} asDictionary;
		yourself
]

{ #category : 'accessing' }
Robot >> bearing [
	^ bearing
]

{ #category : 'accessing' }
Robot >> bearing: anObject [
	bearing := anObject
]

{ #category : 'action' }
Robot >> execute: instructionCharacter [

	instructionCharacter = $R
		ifTrue: [ ^ self turnRight].
	instructionCharacter = $L
		ifTrue: [ ^ self turnLeft].

	^ self moveForward
]

{ #category : 'initialization' }
Robot >> initialize [
	super initialize.
	self location: 0@0
]

{ #category : 'accessing' }
Robot >> location [
	^ location
]

{ #category : 'accessing' }
Robot >> location: aPoint [
	location := aPoint
]

{ #category : 'action' }
Robot >> moveForward [
	self location: self location + self bearing delta
]

{ #category : 'printing' }
Robot >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self bearing name;
		nextPut: $)
]

{ #category : 'action' }
Robot >> turnLeft [
	self bearing: self bearing left
]

{ #category : 'action' }
Robot >> turnRight [
	self bearing: self bearing right
]
