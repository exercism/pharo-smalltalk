Class {
	#name : #ExercismDownloadCommand,
	#superclass : #ExercismHttpCommand,
	#instVars : [
		'parser',
		'exerciseId',
		'trackName'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismDownloadCommand class >> from: aClient track: trackId exercise: exerciseId [
	^self new 
		httpClient: aClient;
		track: trackId exercise: exerciseId;
		yourself
]

{ #category : #command }
ExercismDownloadCommand class >> track: trackId exercise: exerciseId [
	^ self from: ExercismHttpClient new track: trackId exercise: exerciseId
]

{ #category : #execution }
ExercismDownloadCommand >> execute [
	[ | submission |
	
	self httpClient verifyToken.
	submission := self fetchLatestSubmission.
	
	self fetchExerciseFilesFor: submission.
	self installExerciseFor: submission.

	"cache the id for later (could be improved)"
	ExercismManager storeSubmissionData: submission.
	^ submission 
	]
		on: ExUnauthorized
		do: [ :error | 
			error configureToken
				ifTrue: [ error retry ]
				ifFalse: [ self inform: 'Aborted' ] ].
	^ nil
]

{ #category : #internal }
ExercismDownloadCommand >> fetchExerciseFilesFor: submission [

	submission
		populateFileContentWith: [ :filename | self httpClient getResource: filename ]
]

{ #category : #internal }
ExercismDownloadCommand >> fetchLatestSubmission [
	| response |
	
	response := self retrieveLatestData.
	
	response
		at: 'error'
		ifPresent: [ :error | self error: (error at: 'message') ].
		
	^ExercismSubmission data: (response at: 'solution')
]

{ #category : #accessing }
ExercismDownloadCommand >> initialize [
	super initialize.
	self parser: TonelParser new.
]

{ #category : #internal }
ExercismDownloadCommand >> installExerciseFor: submission [

	submission
		sourceFilesDo:
			[ :filename :contents | (self parser documentFrom: contents) do: [ :def | def load ] ].
		
	SystemAnnouncer uniqueInstance
		announce: (RPackageRegistered to: ExercismManager exercismPackage).
	
]

{ #category : #accessing }
ExercismDownloadCommand >> parser [
	^ parser
]

{ #category : #accessing }
ExercismDownloadCommand >> parser: aTonelParser [
	parser := aTonelParser
]

{ #category : #internal }
ExercismDownloadCommand >> retrieveLatestData [
	| responseString |
		
	responseString := self httpClient getLatestExercise: exerciseId for: trackName.
	^ STON fromString: responseString
]

{ #category : #accessing }
ExercismDownloadCommand >> track: aStringTrackName exercise: aStringExerciseId [
	trackName := aStringTrackName.
	exerciseId := aStringExerciseId asKebabCase.
]
