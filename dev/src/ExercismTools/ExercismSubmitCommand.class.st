Class {
	#name : #ExercismSubmitCommand,
	#superclass : #ExercismHttpCommand,
	#instVars : [
		'package'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismSubmitCommand class >> exercise: packageOrTag [
	"Submit an exercism package"

	^ self from: ExercismHttpClient new exercise: packageOrTag 
		
]

{ #category : #command }
ExercismSubmitCommand class >> from: anHttpClient exercise: packageOrTag [
	"Submit an exercism package"

	"By default, don't submit TestCases with the solution"
	(packageOrTag classes reject: [ :class | class isTestCase ])
		ifEmpty: [ self error: 'No classes to submit' ].
		
	^ self new
		httpClient: anHttpClient;
		package: packageOrTag;
		yourself
]

{ #category : #internal }
ExercismSubmitCommand >> buildSolutionData [
	| exerciseMap |
	
	exerciseMap := self createExerciseMap.
	
	^ self solutionClasses
		inject: Dictionary new
		into: [ :map :solutionClass | 
			map
				add: (solutionClass name , '.st') -> (exerciseMap at: solutionClass name);
				yourself ]
]

{ #category : #internal }
ExercismSubmitCommand >> createExerciseMap [
	^ExTonelWriter new mappedSnapshot: self package snapshot
]

{ #category : #execution }
ExercismSubmitCommand >> execute [
	| solutionId exerciseName |
	
	exerciseName := self package name asKebabCase.
	
	solutionId := ExercismManager 
		submissionIdFor: self package name asKebabCase 
		ifAbsent: [ self error: 
			('Unable to submit exercise {1p}, submission id not found!' format: exerciseName) ].
			
	self httpClient
		patchSolution: solutionId
		with: self buildSolutionData.
		
	^ true
]

{ #category : #accessing }
ExercismSubmitCommand >> package [
	^ package
]

{ #category : #accessing }
ExercismSubmitCommand >> package: anObject [
	package := anObject
]

{ #category : #accessing }
ExercismSubmitCommand >> solutionClasses [ 

	^self package classes reject: [ :class | class isTestCase ]
]
