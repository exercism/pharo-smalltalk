"
An ExercismManagerTest is a test class for testing the behavior of ExercismManager
"
Class {
	#name : #ExercismManagerTest,
	#superclass : #TestCase,
	#category : #ExercismTests
}

{ #category : #tests }
ExercismManagerTest >> testParseExerciseProposal [

	self assert: (ExercismManager default parseExerciseName: 'hello-world') equals: 'hello-world'.
	self assert: (ExercismManager default parseExerciseName: 'exercism download --exercise=two-fer --track=pharo') equals: 'two-fer'.
	self assert: (ExercismManager default parseExerciseName: 'exercism download --randome') equals: nil.
	self assert: (ExercismManager default parseExerciseName: '') equals: nil.
]
