"
An ExercismExerciseGeneratorTest is a test class for testing the behavior of ExercismExerciseGenerator
"
Class {
	#name : #ExercismExerciseGeneratorTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismExerciseGeneratorTest >> testAsValidKeywordOnString [

	self assert: '1Direction' asValidKeyword equals: 'and1Direction'.
	self assert: '1' asValidKeyword equals: 'at1'.
]
