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
		'LastPath',
		'UseConfigletGenerate'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #'as yet unclassified' }
ExercismGenerator class >> defaultGenerationPath [
	|exercismRepo|
	exercismRepo := LGitRepository allInstances detect: [ :repo |
		repo workingDirectory pathSegments last = 'pharo-smalltalk'].
	^ exercismRepo ifNotNil: [(exercismRepo workingDirectory / 'exercises') pathString ]

]

{ #category : #generation }
ExercismGenerator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
	| generationPath defaultGenerationPath |
	defaultGenerationPath := self defaultGenerationPath.
	generationPath := defaultGenerationPath ifNotNil: [ 
		(self confirm: 'Generate to default location?' , String cr, defaultGenerationPath)
			ifTrue:  [ defaultGenerationPath ]
	].
	
	generationPath ifNil: [ generationPath := 
		UIManager default
			chooseDirectory: 'Select the "pharo-smalltalk/exercises" folder to generate into'
			path: self lastPath.
		].
		
	generationPath ifNotNil: [ self new generateTo: (self lastPath: generationPath) asFileReference ]
]

{ #category : #helper }
ExercismGenerator class >> lastPath [
	^ LastPath ifNil: [ self defaultPath: FileLocator home pathString]
]

{ #category : #helper }
ExercismGenerator class >> lastPath: pathString [
	^ LastPath := pathString
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

{ #category : #'as yet unclassified' }
ExercismGenerator >> generateDefinitions: definitions to: aFileReference [ 
	| tonelFileMap |
	tonelFileMap := ExTonelWriter new mappedSnapshot: (MCSnapshot fromDefinitions: definitions).
	tonelFileMap
		keysAndValuesDo: [ :file :stream | 
			(aFileReference / file) ensureCreateFile
				writeStreamDo: [ :fileStream | fileStream nextPutAll: stream contents ] ].
]

{ #category : #helper }
ExercismGenerator >> generateExercise: exercise to: exerciseRootDirRef [
	"Generate the Tonel source files for a package. Answer the exercise directory reference"

	| exerciseName exerciseDirRef metaDirRef solutionDirRef exerciseDefs solutionDefs |

	"The following directory structure is expected by Exercism infrastructure. 
	 Canonical reference is output of their utlitity command `configlet generate` "
	exerciseName := ExercismExercise exerciseNameFrom: exercise exercisePackage.
	exerciseDirRef := exerciseRootDirRef / exerciseName.
	metaDirRef     := exerciseRootDirRef / exerciseName / '.meta'.
	solutionDirRef := exerciseRootDirRef / exerciseName / '.meta' / 'solution'.		
			
	exerciseDirRef ensureCreateDirectory.
	exerciseDirRef deleteAll.
	
	exerciseDefs := exercise definitions select: #isExercise.
	self generateDefinitions: exerciseDefs to: exerciseDirRef.
	
	solutionDefs := exercise definitions select: #isSolution.
	self generateDefinitions: solutionDefs to: solutionDirRef.

	self generateReadmeFor: exercise to: exerciseDirRef.
	self generateReadmeHintFor: exercise to: metaDirRef.
	
	exercise isCustom ifTrue: [ self generateCustomDataFor: exercise to: metaDirRef ]
]

{ #category : #helper }
ExercismGenerator >> generateReadmeFor: exercise to: destinationDirectory [
	(destinationDirectory / 'README.md') ensureCreateFile
		writeStreamDo: [ :stream | stream nextPutAll: exercise readme withUnixLineEndings ]
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
ExercismGenerator >> generateSourceFilesFor: packageOrTag to: filePathString [
	"Generate the Tonel source files for a package (normally a tag). Answer the exercise directory reference"

	| exampleDirectoryRef exerciseDirectoryRef metaDirectoryRef  solutionDirectoryRef testClass testClassFilename exerciseName testClasses |
	
	"Note: could create the writer on a memory stream to then pick what should be stored on disk
	e.g.
		mem := FileSystem memory root.
		writer := ExTonelWriter on: mem."

	exerciseName := ExercismExercise exerciseNameFrom: packageOrTag.
	exampleDirectoryRef := filePathString asFileReference.
	exerciseDirectoryRef := exampleDirectoryRef / exerciseName.
	metaDirectoryRef :=  exerciseDirectoryRef / '.meta'.
	solutionDirectoryRef := metaDirectoryRef / 'solution'.
	
	exerciseDirectoryRef ensureCreateDirectory.
	exerciseDirectoryRef deleteAll.
	
	(ExTonelWriter on: exampleDirectoryRef)
		sourceDirectory: (solutionDirectoryRef relativeTo: exampleDirectoryRef) pathString;
		writeSnapshot: (self createTagSnapshotFor: packageOrTag).

	"Remove the package file as its not needed for Exercism"
	(solutionDirectoryRef / 'package.st') delete.
	
	"Move the test file down to the exerciseDirectory"
	testClasses := packageOrTag classes select: [ :cls | cls superclass = ExercismTest ].	
	testClasses do: [ :tc |
		testClassFilename := tc name, '.class.st'.
		(solutionDirectoryRef / testClassFilename) moveTo: exerciseDirectoryRef / testClassFilename ].
	
	testClass := testClasses detect: [ :tc | tc class includesSelector: #exercise  ].
	self generateReadmeHintFor: testClass exercise to: metaDirectoryRef.
	
	testClass isCustom ifTrue: [ self generateCustomDataFor: testClass exercise to: metaDirectoryRef  ].
	
	^exerciseDirectoryRef 

]

{ #category : #generation }
ExercismGenerator >> generateTo: exerciseRootDirectoryReference [
	| repoFileReference |
	
	ExercismExercise allExercises 
		select: [:exercise | exercise isActive ] 
		thenDo: [:exercise | self generateExercise: exercise to: exerciseRootDirectoryReference ].
		
	repoFileReference := exerciseRootDirectoryReference parent.
	ExercismConfigGenerator generateTo: repoFileReference.

]
