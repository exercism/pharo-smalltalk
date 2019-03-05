"
An ExercismExerciseTest is a test class for testing the behavior of ExercismExercise
"
Class {
	#name : #ExercismExerciseTest,
	#superclass : #TestCase,
	#category : #'ExercismDev-Tests'
}

{ #category : #tests }
ExercismExerciseTest >> testFollowedBy [

	self assert: [(HelloWorldTest exercise) isFollowedBy: TwoFerTest exercise].
	self deny: [(HammingTest exercise) isFollowedBy: HelloWorldTest exercise].
]

{ #category : #tests }
ExercismExerciseTest >> testIsUnlockedBy [

	self assert: (TwoFerTest exercise isUnlockedBy: HelloWorldTest  exercise).
	self deny: [ TwoFerTest exercise isUnlockedBy: LeapTest exercise ]
]
