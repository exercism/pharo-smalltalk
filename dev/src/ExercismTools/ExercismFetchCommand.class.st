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
		ifPresent: [ :error | DomainError signal: (error at: 'message') ].
		
	^ExercismSubmission data: response
]

{ #category : #accessing }
ExercismFetchCommand >> initialize [
	super initialize.
	self parser: TonelParser new.
]

{ #category : #accessing }
ExercismFetchCommand >> parser [
	^ parser
]

{ #category : #accessing }
ExercismFetchCommand >> parser: aTonelParser [
	parser := aTonelParser
]
