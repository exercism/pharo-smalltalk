"
Some simple unit tests to check the robot can change direction.
"
Class {
	#name : #RobotTest,
	#superclass : #TestCase,
	#category : #'Exercism-RobotSimulator'
}

{ #category : #tests }
RobotTest >> testLeftOnEast [
	self assert: (Robot facing: 'east') bearingLeft equals: 'north' 
]

{ #category : #tests }
RobotTest >> testLeftOnNorth [
	self assert: (Robot facing: 'north') bearingLeft equals: 'west' 
]

{ #category : #tests }
RobotTest >> testRightOnEast [
	self assert: (Robot facing: 'east') bearingRight equals: 'south' 
]

{ #category : #tests }
RobotTest >> testRightOnNorth [
	self assert: (Robot facing: 'north') bearingRight equals: 'east' 
]

{ #category : #tests }
RobotTest >> testRobotBadDirection [
	self should: [Robot facing: 'under'] raise: DomainError 
]

{ #category : #tests }
RobotTest >> testRobotGoodDirection [
	self assert: (Robot facing: 'north') bearingDelta equals: 0@1  
]
