Class {
	#name : #ExercismSubmitCommand,
	#superclass : #ExercismCommand,
	#instVars : [
		'package'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismSubmitCommand class >> exercise: packageOrTag [
	"Submit an exercism package"

	"By default, don't submit TestCases with the solution"
	
	(packageOrTag classes reject: [ :class | class isTestCase ]) ifEmpty: [ self error: 'No classes to submit' ].
	
	^ self new
			package: packageOrTag;
			yourself
]

{ #category : #internal }
ExercismSubmitCommand >> buildExerciseMap [
	^ExTonelWriter new mappedSnapshot: self package snapshot
]

{ #category : #internal }
ExercismSubmitCommand >> buildRequest [
	| multiPartFormDataEntity solutionId exerciseMap |
	exerciseMap := self buildExerciseMap.
	multiPartFormDataEntity := ZnMultiPartFormDataEntity new.
	self solutionClasses do: [ :solutionClass | 
		|solutionPart solutionEntity|
		
		solutionEntity := ZnByteArrayEntity bytes: (exerciseMap at: solutionClass name).
		solutionPart := ZnMimePart exercismFieldName: 'files[]' 
				fileName: solutionClass name, '.st' entity: solutionEntity.
		multiPartFormDataEntity addPart: solutionPart ].
	
	solutionId := (ExercismManager solutionData at: self package name asKebabCase) id.
	
	httpclient 
		url: ApiPath , '/' , solutionId;
		entity: multiPartFormDataEntity
]

{ #category : #execution }
ExercismSubmitCommand >> execute [
	| status statusMsgs statusCode |
	
	self buildRequest.
	httpclient patch.
	
	status := httpclient response statusLine.
	statusCode := status code.
	
	statusMsgs := {201 -> 'SUCCESS'. 400 -> 'NO CHANGES'} asDictionary.
	
	(statusMsgs includesKey: statusCode)
		ifTrue: [ self inform: 'Exercism submit solution - ' , (statusMsgs at: statusCode) value. ^true ].
		
	self error:
			'Exercism submit solution - UNKNOWN ERROR (' , 
			statusCode printString, ' ' , status reason , ')'
]

{ #category : #accessing }
ExercismSubmitCommand >> package [
	^ package
]

{ #category : #accessing }
ExercismSubmitCommand >> package: anObject [
	package := anObject
]

{ #category : #execution }
ExercismSubmitCommand >> solutionClasses [ 

	^self package classes reject: [ :class | class isTestCase ]
]
