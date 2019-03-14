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

{ #category : #internal }
ExercismSubmitCommand >> buildSolutionData [
	| exerciseMap |
	
	exerciseMap := self createExerciseMap.
	
	^ self exercise solutionClasses
		inject: Dictionary new
		into: [ :map :solutionClass | 
			map
				add: (solutionClass name , '.st') -> (exerciseMap at: solutionClass name);
				yourself ]
]

{ #category : #internal }
ExercismSubmitCommand >> createExerciseMap [
	^ExTonelWriter new mappedSnapshot: self exercise snapshot
]

{ #category : #execution }
ExercismSubmitCommand >> execute [
	
	self httpClient
		patchSolution: self exercise solutionId
		with: self exercise solutionSources.
		
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
