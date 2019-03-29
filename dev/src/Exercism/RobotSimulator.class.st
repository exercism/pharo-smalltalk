"
A simple solution that seperates the Robot into a new class
"
Class {
	#name : #RobotSimulator,
	#superclass : #Object,
	#instVars : [
		'robot'
	],
	#category : #'Exercism-RobotSimulator'
}

{ #category : #internal }
RobotSimulator >> currentPosition [
	^self robot asDictionary
]

{ #category : #accessing }
RobotSimulator >> robot [
	^ robot
]

{ #category : #accessing }
RobotSimulator >> robot: anObject [
	robot := anObject
]

{ #category : #exercism }
RobotSimulator >> sendInstructions: instructionsString [
	
	instructionsString
		do: [ :instruction | self robot execute: instruction ].

	^ self currentPosition
]

{ #category : #exercism }
RobotSimulator >> startFacing: aString atPosition: aDictionary [
	self robot:
		((Robot facing: aString)
			location: (aDictionary at: 'x') @ (aDictionary at: 'y');
			yourself).

	^ self currentPosition
]
