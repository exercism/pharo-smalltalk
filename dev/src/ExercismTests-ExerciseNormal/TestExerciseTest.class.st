"
Example data of an exercise package with just a test class and solution
"
Class {
	#name : #TestExerciseTest,
	#superclass : #ExercismTest,
	#category : #'ExercismTests-ExerciseNormal'
}

{ #category : #config }
TestExerciseTest class >> exercise [
	^(ExercismExercise for: self)
		isCore: false;
		difficulty: 1;
		topics: #('testing');
		yourself
]

{ #category : #config }
TestExerciseTest class >> isActive [
	"Answer true if an exercise is active (not deprecated or for testing)"
	
	^false
]

{ #category : #config }
TestExerciseTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc000'
]

{ #category : #config }
TestExerciseTest class >> version [
	^'1.0.0'
]
