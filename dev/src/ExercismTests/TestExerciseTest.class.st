Class {
	#name : #TestexerciseTest,
	#superclass : #ExercismTest,
	#category : #'ExercismTests-Testexercise'
}

{ #category : #config }
TestexerciseTest class >> exercise [
	^(ExercismExercise for: self)
		isCore: false;
		difficulty: 2;
		topics: #('testing');
		yourself
]

{ #category : #config }
TestexerciseTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc111'
]

{ #category : #config }
TestexerciseTest class >> version [
	^'1.0.0'
]
