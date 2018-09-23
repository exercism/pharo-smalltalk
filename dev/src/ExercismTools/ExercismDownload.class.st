"
I download exercises from the Exercism servers

Responsibility:  
  I take the Tonel files supplied be the Exercism server  
  and parse them into Pharo classes.

Collaborators: 
  ExercismCommand - superclass providing  preconfigured http client
  STON - for parsing JSON responses from server

Public API and Key Messages (class-side)
  #exercise: - command to download Pharo track exercise
  #track:exercise: - instance creation to download any track's exercise

Examples
  ExercismDownload exercise: 'hello-world'.

Internal Representation and Key Implementation Points.
  None yet - to conform more like Command Pattern (IIUC) 
     maybe  should refactor to initialize parameters in ivars
      then call an  #execute method   
"
Class {
	#name : #ExercismDownload,
	#superclass : #ExercismCommand,
	#instVars : [
		'track',
		'exercise',
		'solution',
		'filesContentMap'
	],
	#category : #ExercismTools
}

{ #category : #command }
ExercismDownload class >> exercise: exerciseId [
	^(self new track: 'pharo' exercise: exerciseId) execute
]

{ #category : #'instance-creation' }
ExercismDownload class >> track: trackId exercise: exerciseId [
	^(self new track: trackId exercise: exerciseId) execute
]

{ #category : #internal }
ExercismDownload >> downloadExerciseFiles [
	filesContentMap := Dictionary new.
	(solution at: 'files') do: [ :filename | 
		httpclient path: (solution at: 'file_download_base_url') , filename.
		filesContentMap at: filename put: httpclient get.
		(httpclient response code = 401) ifTrue: [ (ExUnauthorized badToken: ApiToken) signal ].
 		].
	^ filesContentMap 
]

{ #category : #execution }
ExercismDownload >> execute [
	[	self verifyToken.  	
		self getSolutionData.
		self downloadExerciseFiles.
	] on: ExUnauthorized do: [ :error |
	 	error configureToken 
			ifTrue: [ error retry ]
			ifFalse: [ self inform: 'Aborted'. ^false ]
		].
	self installExercise. 
	^true
]

{ #category : #accessing }
ExercismDownload >> filesContentMap [
	^ filesContentMap
]

{ #category : #internal }
ExercismDownload >> getSolutionData [
	| responseString response |
	httpclient 
		path: self path;
		queryAt: 'track_id' put: track;
		queryAt: 'exercise_id' put: exercise.
		
	responseString := httpclient get.
	(httpclient response code = 401) ifTrue: [ (ExUnauthorized badToken: ApiToken) signal ].
	
	response := (STON fromString: responseString).
	response at: 'error' ifPresent: [ :error | self error: (error at: 'message') ].
	solution := response at: 'solution'.
]

{ #category : #internal }
ExercismDownload >> installExercise [
	| rpo exercismPackage packagesToAnnounce |
	rpo := RPackageOrganizer default.
	exercismPackage := rpo packageNamed: 'Exercism' ifAbsent: [ rpo createPackageNamed: 'Exercism' ].
	packagesToAnnounce := OrderedCollection new.

	filesContentMap keysAndValuesDo: 
	[	:filename :contents | (filename endsWith: '.st') ifTrue: 
		[	|parser|
			parser := TonelParser on: contents readStream.
         		parser document do: 
			[	:def | 
				def load.
				def isClassDefinition ifTrue: 
				[	|tag|	
					"Store solution metadata."
					tag := exercismPackage classTagNamed:  (exercismPackage toTagName:  def category).
					exercismPackage ensureProperties at: tag put: solution.
				].
			].
		].
	].
	SystemAnnouncer uniqueInstance announce: (RPackageRegistered to: exercismPackage).
]

{ #category : #accessing }
ExercismDownload >> solution [
	^ solution copy
]

{ #category : #accessing }
ExercismDownload >> track: aStringTrack exercise: aStringExercise [
	track := aStringTrack.
	exercise := aStringExercise.
]
