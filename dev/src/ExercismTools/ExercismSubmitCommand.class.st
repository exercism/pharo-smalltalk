"
I am a command for submitting an exercise. 
"
Class {
	#name : #ExercismSubmitCommand,
	#superclass : #ExercismHttpCommand,
	#instVars : [
		'exercise'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismSubmitCommand class >> exercise: anExercismExercise [
	"Submit an exercism package"

	^ self from: ExercismHttpClient new exercise: anExercismExercise 
		
]

{ #category : #command }
ExercismSubmitCommand class >> from: anHttpClient exercise: exercise [
	"Submit an exercism package"

	"By default, don't submit TestCases with the solution"
	exercise verifySolutionForSubmission.
		
	^ self new
		httpClient: anHttpClient;
		exercise: exercise;
		yourself
]

{ #category : #execution }
ExercismSubmitCommand >> execute [
	[ self httpClient
		patchSolution: self exercise solutionId
		with: self exercise solutionSources 
	]
		on: ExUnauthorized
		do: [ :error | 
			error configureToken
				ifTrue: [ error retry ]
				ifFalse: [ 
					self inform: 'Submit Aborted!' ]. 
					^false ].

	^ true
]

{ #category : #accessing }
ExercismSubmitCommand >> exercise [
	^ exercise
]

{ #category : #accessing }
ExercismSubmitCommand >> exercise: anExercismExercise [
	exercise := anExercismExercise
]
