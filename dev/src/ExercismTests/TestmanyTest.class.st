Class {
	#name : #TestmanyTest,
	#superclass : #ExercismTest,
	#category : #'ExercismTests-Testmany'
}

{ #category : #config }
TestmanyTest class >> exercise [
	^(ExercismExercise for: self)
		isCore: false;
		difficulty: 2;
		topics: #('testing');
		yourself
]

{ #category : #config }
TestmanyTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc111'
]

{ #category : #config }
TestmanyTest class >> version [
	^'1.0.0'
]
