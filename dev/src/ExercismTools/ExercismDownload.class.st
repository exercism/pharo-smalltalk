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
	(self new track: 'pharo' exercise: exerciseId) execute
]

{ #category : #'instance-creation' }
ExercismDownload class >> track: trackId exercise: exerciseId [
	(self new track: trackId exercise: exerciseId) execute
]

{ #category : #internal }
ExercismDownload >> downloadExerciseFiles [
	|client|
	filesContentMap := Dictionary new.
	(solution at: 'files')
		do: [ :filename | 
			httpclient path: (solution at: 'file_download_base_url') , filename.
			filesContentMap at: filename put: httpclient get ].
	^ filesContentMap 
]

{ #category : #execution }
ExercismDownload >> execute [
	self getSolutionData.
	self downloadExerciseFiles.
	self installExercise. 
	
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
	response := (STON fromString: responseString).
	
	response at: 'error' ifPresent: [ :error | self error: (error at: 'message') ].
	
	solution := response at: 'solution'.
]

{ #category : #internal }
ExercismDownload >> installExercise [
	| rpo root packagesToAnnounce |
	rpo := RPackageOrganizer default.
	root := rpo packageNamed: 'Exercism' ifAbsent: [ rpo createPackageNamed: 'Exercism' ].
	packagesToAnnounce := OrderedCollection new.

	filesContentMap keysAndValuesDo: 
		[:filename :contents | (filename endsWith: '.st') ifTrue: 
			[|parser|
				parser := TonelParser on: contents readStream.
         		parser document do: 
					[:def | 
						def isClassDefinition ifTrue: "Maybe not needed, see todo-discussion"
						[	rpo packageNamed: def category ifAbsent: [	packagesToAnnounce add: def ] 
						].
						def load
					].
			].
		].
	
	"TODO-DISCUSSION: Do package class-tags (which we have, i.e. not packages) need to be announced?
	 i.e. Was the system announcement previously in fetchFromExercismTo: 
	 only required for updating the System Browser to show the loaded tag?
	 And will the following suffice? "
	SystemAnnouncer uniqueInstance announce: (RPackageRegistered to: root).
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
