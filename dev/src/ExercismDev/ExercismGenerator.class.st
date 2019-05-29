"
I am responsible for generating kebab-cased Exercism edirectories, each containing a seperate exercise for users.

We have to do it this way as Exercism conventions differ from Tonel, and so we need to output them to a seperate directory suitable for  the Exercism command line tool.

When you have created a new exercise(s) that you are happy with, you need to run a generation.

You can either click on the #generate example method and be prompted for a file location or evaluate the following  (where the path is one that points to where you have checked out the entire pharo project using either the command line or a git tool):

ExercismGenerator generateTo: (FileLocator home / 'Dev/Exercism/pharo-git') pathString
"
Class {
	#name : #ExercismGenerator,
	#superclass : #Object,
	#classVars : [
		'DefaultPath',
		'UseConfigletGenerate'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #helper }
ExercismGenerator class >> defaultPath [
	^ DefaultPath ifNil: [ self defaultPath: FileLocator home pathString]
]

{ #category : #helper }
ExercismGenerator class >> defaultPath: pathString [
	^ DefaultPath := pathString
]

{ #category : #generation }
ExercismGenerator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
	| path |
	path := UIManager default
		chooseDirectory: 'Select the /exercises location in a fresh Exercism/Pharo git project'
		path: self defaultPath.
		
	path ifNotNil: [ self new generateTo: (self defaultPath: path) ]
]

{ #category : #helper }
ExercismGenerator >> createTagSnapshotFor: packageOrTag [
	| parentSnapshot |
	
	parentSnapshot := (MCPackage named: packageOrTag package name) snapshot.
	
	^ MCSnapshot
		fromDefinitions:
			(parentSnapshot definitions
				select:
					[ :mc | mc className isNil or: [ mc actualClass category endsWith: packageOrTag name ] ])
]

{ #category : #helper }
ExercismGenerator >> generateCustomDataFor: anExercismExercise to: destinationDirectory [
	"Generate markdown hints, that exercism configlet will pickup for readme.md files
	see: https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/readmes.md#generating-a-readme"

	(destinationDirectory / 'description.md') ensureCreateFile
		writeStreamDo: [ :stream | 
			| description |
			description := anExercismExercise descriptionText.
				
			stream nextPutAll: description ].
		
	(destinationDirectory / 'metadata.yml') ensureCreateFile
		writeStreamDo: [ :stream | 
			| data |
			data := anExercismExercise testCase customData.
				
			stream nextPutAll: '---'; lf.
			data keysAndValuesDo: [ :key :value |
				stream nextPutAll: key, ': "';
					nextPutAll: value;
					nextPut: $";
					lf ]]
]

{ #category : #helper }
ExercismGenerator >> generateReadmeHintFor: anExercismExercise to: destinationDirectory [
	"Generate markdown hints, that exercism configlet will pickup for readme.md files
	see: https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/readmes.md#generating-a-readme"

	(destinationDirectory / 'hints.md') ensureCreateFile
		writeStreamDo: [ :stream | 
			| hint |
			(hint := anExercismExercise hintText) = 'TBD'
				ifTrue: [ 
					self halt: 'Forgot to update Exercise hint for: ', anExercismExercise name ].
				
			stream nextPutAll: hint ]
]

{ #category : #helper }
ExercismGenerator >> generateSourceFilesFor: package to: filePathString [
	"Generate the Tonel source files for a package. Answer the exercise directory reference"

	| definitions exerciseDefs solutionDefs exerciseFileMap exampleDirectoryRef exerciseDirectoryRef metaDirectoryRef solutionDirectoryRef testClass  exerciseName  solutionFileMap |
	definitions := package snapshot definitions
		reject: #isOrganizationDefinition.
	exerciseDefs := definitions select: #isExerciseDefinition.
	solutionDefs := definitions select: #isSolutionDefinition.

	"The following directory structure is expected by Exercism infrastructure. 
	 Canonical reference is output of their utlitity command `configlet generate` "
	exerciseName := ExercismExercise exerciseNameFrom: package.
	exampleDirectoryRef := filePathString asFileReference.
	exerciseDirectoryRef := exampleDirectoryRef / exerciseName.
	metaDirectoryRef := exerciseDirectoryRef / '.meta'.
	solutionDirectoryRef := metaDirectoryRef / 'solution'.
	
	exerciseDirectoryRef ensureCreateDirectory.
	exerciseDirectoryRef deleteAll.
	
	exerciseFileMap := ExTonelWriter new mappedSnapshot: (MCSnapshot fromDefinitions: exerciseDefs).
	exerciseFileMap
		keysAndValuesDo: [ :file :stream | 
			(exerciseDirectoryRef / file) ensureCreateFile
				writeStreamDo: [ :fileStream | fileStream nextPutAll: stream contents ] ].
			
	solutionFileMap := ExTonelWriter new mappedSnapshot: (MCSnapshot fromDefinitions: solutionDefs).
	solutionFileMap
		keysAndValuesDo: [ :file :stream | 
			(solutionDirectoryRef / file) ensureCreateFile
				writeStreamDo: [ :fileStream | fileStream nextPutAll: stream contents ] ].
			
	testClass := exerciseDefs first actualClass instanceSide.
	self generateReadmeHintFor: testClass exercise to: metaDirectoryRef.
	
	testClass isCustom
		ifTrue:
			[ self generateCustomDataFor: testClass exercise to: metaDirectoryRef ]
]

{ #category : #generation }
ExercismGenerator >> generateTo: filePathReference [
	| basePathReference |
	
	ExercismExercise allExercises select: [:ex | ex isActive ] thenDo: [:ex | 
			self generateSourceFilesFor: ex exercisePackage to: filePathReference ].
		
	basePathReference := filePathReference parent.
	ExercismConfigGenerator generateTo: basePathReference.

]
