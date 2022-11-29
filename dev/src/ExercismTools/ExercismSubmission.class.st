"
I am a wrapper over the exercism json submission data. Crucially I have a solutionId that is needed when submitting exercises that have been downloaded.
"
Class {
	#name : #ExercismSubmission,
	#superclass : #Object,
	#instVars : [
		'exercismData',
		'contentData'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #accessing }
ExercismSubmission class >> baseUrlKey [
	^ 'file_download_base_url'
]

{ #category : #accessing }
ExercismSubmission class >> data: exercismDataDictionary [
	^ self new
		exercismData:
			(exercismDataDictionary
				at: 'solution'
				ifAbsent: [ exercismDataDictionary ]);
		yourself
]

{ #category : #accessing }
ExercismSubmission class >> error: aString [
	^self new 
		exercismData: { 'exercise' ->> {'id' -> '' }} asDictionary;
		errorMessage: aString;
		yourself
]

{ #category : #accessing }
ExercismSubmission >> baseUrl [ 
	^(self exercismData at: self class baseUrlKey) exPathString.
]

{ #category : #accessing }
ExercismSubmission >> contentData [
	^ contentData
]

{ #category : #accessing }
ExercismSubmission >> contentData: anObject [
	contentData := anObject
]

{ #category : #accessing }
ExercismSubmission >> contentsFor: aString ifAbsent: anObject [ 
	^self contentData at: aString
]

{ #category : #internal }
ExercismSubmission >> createSnapshotFromDefinitions [

	"return MC snapshot from definitions that can be loaded or submitted"
	^ MCSnapshot fromDefinitions: self definitionsToLoadFromDirectory

]

{ #category : #internal }
ExercismSubmission >> definitionsToLoadFromDirectory [
	
	"reader will return definitions to be loaded from directory containing package directory and .st files with classes"
	| tonelReader | 
	tonelReader := TonelReader on: self latestExercisePackageSourceDir fileName: self exercisePackageName.
	tonelReader loadDefinitions.
	^ tonelReader definitions.

]

{ #category : #accessing }
ExercismSubmission >> errorMessage [ 

	^self exercismData at: 'error' ifAbsent: [ '' ]

]

{ #category : #accessing }
ExercismSubmission >> errorMessage: aString [ 

	self exercismData at: 'error' put: aString

]

{ #category : #storing }
ExercismSubmission >> exercise [
	"Answer the ExercismExercise associated with this submission"
	
	^ExercismExercise find: self exerciseId ifAbsent: [nil]
]

{ #category : #accessing }
ExercismSubmission >> exerciseClassName [ 
	^self exerciseId kebabAsCamelCase 
]

{ #category : #accessing }
ExercismSubmission >> exerciseId [
	^(self exercismData at: 'exercise') at: 'id'
]

{ #category : #internal }
ExercismSubmission >> exercisePackageName [

	^ ExercismManager exercisePrefix, '@', self exerciseClassName 
]

{ #category : #accessing }
ExercismSubmission >> exercismData [
	^ exercismData
]

{ #category : #accessing }
ExercismSubmission >> exercismData: anObject [
	exercismData := anObject
]

{ #category : #accessing }
ExercismSubmission >> filenames [
	^self exercismData at: 'files'
]

{ #category : #accessing }
ExercismSubmission >> initialize [ 

	super initialize.
	self contentData: Dictionary new.
]

{ #category : #internal }
ExercismSubmission >> installDefinitionsFromSnapshot [

	"tonel reader will load definitions from directory containing package directory and .st files with classes, creates MC snapshot and install package with exercise to default package organizer"
	
	self createSnapshotFromDefinitions install
]

{ #category : #storing }
ExercismSubmission >> isValid [
	"Answer true if the submission resulted in a valid exercise"
	
	^(self exercismData includesKey: 'error') not and: [ self exercise notNil ]
]

{ #category : #internal }
ExercismSubmission >> latestExercisePackageSourceDir [

	"return memory file reference with retreived latest exercise souuces - needed for tonel reader"
	|memFileRef packageDir|
	memFileRef := FileSystem memory root.
	packageDir := (memFileRef / self exercisePackageName) ensureCreateDirectory.
	self sourceFilenamesWithContentsDo: [:fileName :sourceString |
		"do write files here"
		|sourceFile|
		sourceFile := packageDir / fileName.
		sourceFile writeStreamDo: [:aStream | aStream nextPutAll: sourceString ]
	].
	^ memFileRef 
]

{ #category : #retrieving }
ExercismSubmission >> populateFileContentsWith: aBlockClosure [
	self sourceFilenames
		do: [ :filename | 
			| fileContent |
			fileContent := aBlockClosure value:
				self baseUrl , filename.
			fileContent
				ifNotNil: [ self contentData at: filename put: fileContent ] ]
]

{ #category : #accessing }
ExercismSubmission >> solutionId [
	^self exercismData at: 'id'
]

{ #category : #accessing }
ExercismSubmission >> sourceFilenames [
	
	^self filenames select: [:filename | filename endsWith: '.st' ]
]

{ #category : #retrieving }
ExercismSubmission >> sourceFilenamesWithContentsDo: aBlockClosure [
	self contentData
		keysAndValuesDo:
			[ :filename :contents | aBlockClosure value: filename value: contents ]
]

{ #category : #storing }
ExercismSubmission >> storeSolutionId [
	self exercise ifNotNil: [:exercise | exercise storeSolutionId: self solutionId]
]

{ #category : #accessing }
ExercismSubmission >> user [
	^(self exercismData at: 'user') at: 'handle'
]
