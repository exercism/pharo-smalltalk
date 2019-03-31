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
		
	^(self client: anHttpClient)
		exercise: exercise;
		yourself
]

{ #category : #execution }
ExercismSubmitCommand >> execute [
	^ [ self
		executeCheckingToken: [ self httpClient
				patchSolution: self exercise solutionId
				with: self exercise solutionSources ] ]
		on: ExSolutionIdError
		do: [ :error | 
			| submission |

			submission := (ExercismDownloadCommand
				track: self exercise trackId
				exercise: self exercise name) fetchLatestSubmission.
			submission storeSolutionId.
			error retry ]
]

{ #category : #accessing }
ExercismSubmitCommand >> exercise [
	^ exercise
]

{ #category : #accessing }
ExercismSubmitCommand >> exercise: anExercismExercise [
	exercise := anExercismExercise
]
