Class {
	#name : #ExercismFetchCommand,
	#superclass : #ExercismHttpCommand,
	#instVars : [
		'parser'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #internal }
ExercismFetchCommand >> fetchExerciseFilesFor: submission [

	submission
		populateFileContentsWith: [ :filename | self httpClient getResource: filename ]
]

{ #category : #internal }
ExercismFetchCommand >> fetchLatestSubmission [
	| response |
	
	response := self retrieveLatestData.
	
	response
		at: 'error'
		ifPresent: [ :error | ExDomainError signal: (error at: 'message'), (' ({1})' format: {self httpClient parameterString} ) ].
		
	^ExercismSubmission data: response
]

{ #category : #internal }
ExercismFetchCommand >> retrieveLatestData [
	^self subclassResponsibility 
]
