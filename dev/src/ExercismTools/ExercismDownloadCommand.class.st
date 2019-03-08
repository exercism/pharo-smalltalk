Class {
	#name : #ExercismDownloadCommand,
	#superclass : #ExercismCommand,
	#instVars : [
		'solution',
		'client',
		'exerciseId',
		'trackName'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismDownloadCommand class >> from: aClient track: trackId exercise: exerciseId [
	^self new 
		client: aClient;
		track: trackId exercise: exerciseId;
		yourself
]

{ #category : #command }
ExercismDownloadCommand class >> track: trackId exercise: exerciseId [
	^ self from: nil track: trackId exercise: exerciseId
]

{ #category : #accessing }
ExercismDownloadCommand >> client [
	^ client
]

{ #category : #accessing }
ExercismDownloadCommand >> client: anObject [
	client := anObject
]

{ #category : #internal }
ExercismDownloadCommand >> downloadExerciseFiles [
	| filesContentMap |
	
	filesContentMap := Dictionary new.
	
	solution filenames
		do: [ :filename | 
			httpclient path: solution baseURL , filename.
			filesContentMap at: filename put: httpclient get.
			httpclient response code = 401
				ifTrue: [ (ExUnauthorized badToken: ApiToken) signal ] ].
			
	^ filesContentMap
]

{ #category : #execution }
ExercismDownloadCommand >> execute [
	[ 
		httpclient := self class newHttpClient.
		self verifyToken.
		self getSolutionData.
		solution files: self downloadExerciseFiles.
		^ solution 
	]
		on: ExUnauthorized
		do: [ :error | 
			error configureToken
				ifTrue: [ error retry ]
				ifFalse: [ self inform: 'Aborted' ] ].
	^ nil
]

{ #category : #internal }
ExercismDownloadCommand >> getSolutionData [
	| response |
	
	response := self retrieveLatestSubmission.
	
	response
		at: 'error'
		ifPresent: [ :error | self error: (error at: 'message') ].
		
	solution := ExercismSubmission data: (response at: 'solution').
	
	"cache the id for later (needs improving)"
	ExercismManager solutionData at: exerciseId put: solution
]

{ #category : #internal }
ExercismDownloadCommand >> installExercise [
	|  exercismPackage  |
	
	exercismPackage := ExercismManager exercismPackage.
	
	solution sourceFilesDo:  
	 [ :filename :contents | |parser|
			parser := TonelParser on: contents readStream.
         	parser document do: [:def | def load].
	].
	
	SystemAnnouncer uniqueInstance announce: (RPackageRegistered to: exercismPackage).
	^true
]

{ #category : #internal }
ExercismDownloadCommand >> retrieveLatestSubmission [
	| responseString |
	
	httpclient
		path: self path , '/latest';
		queryAt: 'track_id' put: trackName;
		queryAt: 'exercise_id' put: exerciseId.
		
	responseString := httpclient get.
	
	httpclient response code = 401
		ifTrue: [ (ExUnauthorized badToken: ApiToken) signal ].
	
	^ STON fromString: responseString
]

{ #category : #accessing }
ExercismDownloadCommand >> solution [
	^ solution copy
]

{ #category : #accessing }
ExercismDownloadCommand >> track: aStringTrackName exercise: aStringExerciseId [
	trackName := aStringTrackName.
	exerciseId := aStringExerciseId asKebabCase.
]
