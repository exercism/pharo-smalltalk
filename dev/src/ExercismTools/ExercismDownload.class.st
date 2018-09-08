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
	#category : #ExercismTools
}

{ #category : #command }
ExercismDownload class >> exercise: exerciseId [
	^ self track: 'pharo' exercise: exerciseId
]

{ #category : #'instance-creation' }
ExercismDownload class >> track: trackId exercise: exerciseId [
	^ self new track: trackId exercise: exerciseId
]

{ #category : #internal }
ExercismDownload >> loadFiles: fileCacheMap [ 
	| rpo root packagesToAnnounce |
	rpo := RPackageOrganizer default.
	root := rpo packageNamed: 'Exercism'.
	packagesToAnnounce := OrderedCollection new.

	fileCacheMap keysAndValuesDo: 
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

{ #category : #internal }
ExercismDownload >> track: trackId exercise: exerciseId [
	| client solution fileCache responseString responseJSON |
	client := self class newHttpClient
		path: self path;
		queryAt: 'exercise_id' put: exerciseId;
		queryAt: 'track_id' put: trackId.
		
	responseString := client get.
	responseJSON := (STON fromString: responseString).
	
	responseJSON at: 'error' ifPresent: [ :error | self error: (error at: 'message') ].
	
	solution :=  responseJSON at: 'solution'.
	fileCache := Dictionary new.
	(solution at: 'files')
		do: [ :filename | 
			client path: (solution at: 'file_download_base_url') , filename.
			fileCache at: filename put: client get ].
	^ self loadFiles: fileCache
]
