Class {
	#name : #ExercismReview,
	#superclass : #Object,
	#instVars : [
		'codeSnapshot',
		'submission'
	],
	#classVars : [
		'DefaultPath'
	],
	#category : #'ExercismDev-Core'
}

{ #category : #'instance creation' }
ExercismReview class >> for: anExercismSubmission with: anMCSnapshot [
	^self new
		submission: anExercismSubmission;
		codeSnapshot: anMCSnapshot;
		yourself 
]

{ #category : #accessing }
ExercismReview >> codeSnapshot [
	^ codeSnapshot
]

{ #category : #accessing }
ExercismReview >> codeSnapshot: anObject [
	codeSnapshot := anObject
]

{ #category : #accessing }
ExercismReview >> reviewName [
	^self submission user, ' : ', self submission exerciseId
]

{ #category : #accessing }
ExercismReview >> submission [
	^ submission
]

{ #category : #accessing }
ExercismReview >> submission: anObject [
	submission := anObject
]
