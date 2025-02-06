"
Example data of an exercise package with just a test class (no solution)
"
Class {
	#name : #TestEmptyTest,
	#superclass : #ExercismTest,
	#category : #'ExercismTests-ExerciseEmpty'
}

{ #category : #config }
TestEmptyTest class >> exercise [
	^(ExercismExercise for: self)
		difficulty: 1;
		topics: #('testing');
		yourself
]

{ #category : #config }
TestEmptyTest class >> isActive [
	"Answer true if an exercise is active (not deprecated or for testing)"
	
	^false
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
