"
An ExercismManagerTest is a test class for testing the behavior of ExercismManager
"
Class {
	#name : 'ExercismManagerTest',
	#superclass : 'TestCase',
	#category : 'ExercismTests-UnitTests',
	#package : 'ExercismTests',
	#tag : 'UnitTests'
}

{ #category : 'tests' }
ExercismManagerTest >> testParseExerciseProposal [
	"Ensure we can parse the proposed exercism download command, and extract the exercise id"

	self
		assert: (ExercismManager default parseTokenNamed: 'exercise' from: 'hello-world')
		equals: 'hello-world'.
	self
		assert:
			(ExercismManager default
				parseTokenNamed: 'exercise'
				from: 'exercism download --exercise=two-fer --track=pharo')
		equals: 'two-fer'.
	self
		assert:
			(ExercismManager default
				parseTokenNamed: 'exercise'
				from: 'exercism download --randome')
		equals: nil.
	self
		assert: (ExercismManager default parseTokenNamed: 'exercise' from: '')
		equals: nil
]
