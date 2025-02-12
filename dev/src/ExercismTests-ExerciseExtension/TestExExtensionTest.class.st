Class {
	#name : #TestExExtensionTest,
	#superclass : #ExercismTest,
	#category : #'ExercismTests-ExerciseExtension'
}

{ #category : #config }
TestExExtensionTest class >> exercise [
	^(ExercismExercise for: self)
		difficulty: 2;
		topics: #('testing');
		yourself
]

{ #category : #config }
TestExExtensionTest class >> isActive [
	"Answer true if an exercise is active (not deprecated or for testing)"
	
	^false
]

{ #category : #config }
TestExExtensionTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc111'
]

{ #category : #config }
TestExExtensionTest class >> version [
	^'1.0.0'
]
