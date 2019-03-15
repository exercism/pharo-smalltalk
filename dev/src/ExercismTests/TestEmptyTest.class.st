Class {
	#name : #TestEmptyTest,
	#superclass : #ExercismTest,
	#category : #'ExercismTests-TestEmpty'
}

{ #category : #config }
TestEmptyTest class >> exercise [
	^(ExercismExercise for: self)
		isCore: false;
		difficulty: 1;
		topics: #('testing');
		yourself
]

{ #category : #config }
TestEmptyTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2accaaa'
]

{ #category : #config }
TestEmptyTest class >> version [
	^'1.0.0'
]
