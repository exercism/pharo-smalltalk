"
STUB CLASS TODO

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ExercismSubmit,
	#superclass : #ExercismCommand,
	#instVars : [
		'exercise',
		'exerciseContents'
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
	solutionEntity := ZnByteArrayEntity bytes: exerciseContents.
	solutionPart := ZnMimePart exercismFieldName: 'files[]' fileName: 'Acronym.class.st' entity: solutionEntity.
	multiPartFormDataEntity := ZnMultiPartFormDataEntity new addPart: solutionPart.
	solutionId := (self class solutionDataForExercise: exercise) at: 'id'.
	
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
	| path |
	exercise := aStringExercise.

	path := (Path from: (aStringExercise asKebabCase)) / '.pharo' / aStringExercise capitalized , 'class.st'.
	exerciseContents := (FileStream readOnlyFileNamed: path) contents.
]
