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

{ #category : #exercism }
RobotSimulator >> createDirection: aString position: aDictionary [
	self robot:
		((Robot facing: aString)
			location: (aDictionary at: 'x') @ (aDictionary at: 'y');
			yourself).

	^ self currentPosition
]

{ #category : #internal }
RobotSimulator >> currentPosition [
	^self robot asDictionary
]

{ #category : #exercism }
RobotSimulator >> moveDirection: bearingString position: pointDictionary instructions: instructionsString [
	self createDirection: bearingString position: pointDictionary.
	
	instructionsString
		do: [ :instruction | self robot execute: instruction ].

	^ self currentPosition
]

{ #category : #accessing }
RobotSimulator >> robot [
	^ robot
]

{ #category : #accessing }
RobotSimulator >> robot: anObject [
	robot := anObject
]
