"
Some simple unit tests to check the robot can change direction.
"
Class {
	#name : #BearingTest,
	#superclass : #TestCase,
	#category : #'Exercism-RobotSimulator'
}

{ #category : #tests }
BearingTest >> testLeftOnEast [
	self assert: (Bearing named: 'east') left equals: (Bearing named:'north') 
]

{ #category : #tests }
BearingTest >> testLeftOnNorth [
	self assert: (Bearing named: 'north') left equals: (Bearing named: 'west') 
]

{ #category : #tests }
BearingTest >> testRightOnEast [
	self assert: (Bearing named: 'east') right equals: (Bearing named: 'south')
]

{ #category : #tests }
BearingTest >> testRightOnNorth [
	self assert: (Bearing named: 'north') right equals: (Bearing named: 'east')
]

{ #category : #tests }
BearingTest >> testRobotBadDirection [
	self should: [Bearing named: 'under'] raise: DomainError 
]

{ #category : #tests }
BearingTest >> testRobotGoodDirection [
	self assert: (Bearing named: 'north') delta equals: 0@1  
]
