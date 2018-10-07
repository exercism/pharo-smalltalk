"
# Description
I am a command for submitting an exercise back to Exercism.io.

# Instance Variables
* `exercise` - a string of the exercise to be submitted.
* `exerciseMap` - a dictionary containing the source code of each exercise class in Tonel format. The keys are symbols of the class names.

# Usage
The command can be created an used instantly with `ExercismSubmit exercise: exerciseId`, where `exercisedId` is the string of an exercise name in
kebab case e.g. `'hello-world'`.

The command makes use of the `httpClient` instance variable from the `ExercismCommand` superclass.
"
Class {
	#name : #ExercismSubmit,
	#superclass : #ExercismCommand,
	#instVars : [
		'exercise',
		'exerciseMap'
	],
	#category : #ExercismTools
}

{ #category : #accessing }
ExercismSubmit class >> exercise: exerciseId [
	^ (self new exercise: exerciseId) execute
]

{ #category : #accessing }
ExercismSubmit class >> solutionDataForClass: aClass [ 
	| exercismPackage classTag |
	exercismPackage := RPackageOrganizer default 
		packageNamed: 'Exercism' 
		ifAbsent: [ self error: 'No exercises downloaded.' ].
	classTag := exercismPackage classTagForClass: aClass.  
	^ exercismPackage ensureProperties at: classTag.
	
]

{ #category : #accessing }
ExercismSubmit class >> solutionDataForExercise: exerciseString [ 
	| exercismPackage |
	exercismPackage := RPackageOrganizer default 
		packageNamed: 'Exercism' 
		ifAbsent: [ self error: 'No exercises downloaded.' ].
	exercismPackage ensureProperties 
		detect: [ :solutionData | ((solutionData at: 'exercise') at: 'id') = exerciseString ] 
		ifFound: [ :solutionData | ^ solutionData ] 
		ifNone: [ self error: 'Exercise ''' , exerciseString , ''' not downloaded.'].
	
]

{ #category : #internal }
ExercismSubmit >> buildRequest [
	| solutionEntity solutionPart multiPartFormDataEntity solutionId |
	"Assumption: There is only one entity to make which is from the class with the same name as the exercise."
	solutionEntity := ZnByteArrayEntity bytes: (exerciseMap at: exercise capitalized asSymbol).
	solutionPart := ZnMimePart exercismFieldName: 'files[]' fileName: exercise entity: solutionEntity.
	multiPartFormDataEntity := ZnMultiPartFormDataEntity new addPart: solutionPart.
	solutionId := (self class solutionDataForExercise: exercise capitalized) at: 'id'.
	
	httpclient 
		url: ApiPath , '/' , solutionId;
		entity: multiPartFormDataEntity
]

{ #category : #execution }
ExercismSubmit >> execute [
	self buildRequest.
	httpclient patch.
	
]

{ #category : #accessing }
ExercismSubmit >> exercise: aStringExercise [
	exercise := aStringExercise.
	self writeExercise
]

{ #category : #internal }
ExercismSubmit >> writeExercise [
	| packageTag |
	packageTag := (RPackageOrganizer default packageNamed: 'Exercism') classTagForClass: (Smalltalk classNamed: exercise capitalized asSymbol).
	exerciseMap := TonelWriter new mappedSnapshot: packageTag snapshot
]
