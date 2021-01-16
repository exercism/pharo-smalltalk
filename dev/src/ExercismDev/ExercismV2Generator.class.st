"
# ExercismV2Generator

I am responsible for generating kebab-cased Exercism V2 directories, each containing a seperate exercise for users.
Use me to create exercises for Exercism version 2.

## Collaborators

I work with `PipeableOSProcess` to make a external command line call to the configlet tool. The 
configlet tool will need to be installed on the host operating system.

To grab the exercises that need to be written I use `ExercismExercise`.

## Instance Variables

- exercismExercise: A class handle for easily getting all the implemented exercises. Defaults to `ExercismExercise`.
- osProcess: A class handle of an operating system process, for sending external commands.
"
Class {
	#name : #ExercismV2Generator,
	#superclass : #ExercismGenerator,
	#instVars : [
		'osProcess',
		'exercismExercise'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #helper }
ExercismV2Generator >> createTagSnapshotFor: packageOrTag [
	| parentSnapshot |
	
	parentSnapshot := (MCPackage named: packageOrTag package name) snapshot.
	
	^ MCSnapshot
		fromDefinitions:
			(parentSnapshot definitions
				select:
					[ :mc | mc className isNil or: [ mc actualClass category endsWith: packageOrTag name ] ])
]

{ #category : #accessing }
ExercismV2Generator >> exercismExercise [

	^ exercismExercise 
		ifNotNil: [ exercismExercise ] 
		ifNil: [ 
			exercismExercise := ExercismExercise.
			ExercismExercise  
			]
]

{ #category : #accessing }
ExercismV2Generator >> exercismExercise: anExerciseClass [

	exercismExercise := anExerciseClass 
]

{ #category : #generation }
ExercismV2Generator >> generate [
	| cmd result basePathReference |

	self exercismExercise allExercises select: [:ex | ex isActive ] thenDo: [:ex |
			self generateSourceFilesFor: ex exercisePackage to: exercisesPath ].
		
	basePathReference := exercisesPath parent.
	ExercismConfigGenerator generateTo: basePathReference.
	
	cmd := 'configlet generate ', (basePathReference pathString surroundedBySingleQuotes).		
	result := self osProcess waitForCommand: cmd.
	
	result succeeded
		ifFalse: [ 
			self error: 'failure running "configlet generate" - ' , result outputAndError printString ]
]

{ #category : #helper }
ExercismV2Generator >> generateCustomDataFor: anExercismExercise to: destinationDirectory [
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
ExercismV2Generator >> generateReadmeHintFor: anExercismExercise to: destinationDirectory [
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
ExercismV2Generator >> generateSourceFilesFor: packageOrTag to: filePathString [
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

	exTonelWriter
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

{ #category : #accessing }
ExercismV2Generator >> osProcess [

	^ osProcess 
		ifNotNil: [ osProcess ] 
		ifNil: [ 
			osProcess := PipeableOSProcess.
			osProcess  
			 ] 
]

{ #category : #accessing }
ExercismV2Generator >> osProcess: anOsProcess [ 

	osProcess := anOsProcess
]
