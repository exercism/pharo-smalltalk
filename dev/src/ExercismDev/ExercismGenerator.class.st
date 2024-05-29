"
# ExercismGenerator

I am responsible for generating kebab-cased Exercism V2 directories, each containing a seperate exercise for users.

Exercism requires plain text files that can be served to the website as exercises and then downloaded for a student 
to work on. We have to do it this way as Exercism conventions differ from Tonel, and so we need to output them to a 
seperate directory suitable for the Exercism command line tool.

## Collaborators

I need two other key objects to do my job: an `ExTonelWriter` and a `PipeableOSProcess`. `ExTonelWriter` does the
actual job of writing Tonel format files to disk. `PipeableOSProcess` is needed to make a external command line
call to the configlet tool. The configlet tool will need to be installed on the host operating system.

To grab the exercises that need to be written I use `ExercismExercise`.

## Usage

When you have created a new exercise(s) that you are happy with, you need to run a generation.

You can run the `ExercismGenerator class>>#generate` method and be prompted for a file location 
(where the path is one that points to where you have checked out the entire pharo project using either 
the command line or a git tool):

```
ExercismGenerator generate
```

In any other context I will need to have `exercisesPath` and `exTonelWriter` instance variables initialized
before `#generate` is sent to me.

```
ExercismGenerator new
	exercisesPath: (FileSystem memory root / 'exercises');
	exTonelWriter: (ExTonelWriter on: path);
	generate
```

## Instance Variables

- exercismExercise: A class handle for easily getting all the implemented exercises. Defaults to `ExercismExercise`.
- exercisesPath: The file path exercises are written to. Defaults to the class variable `DefaultPath`.
- exTonelWriter: `ExTonelWriter`; Responsible for writing objects as Tonel format source text files to the give file path.
- osProcess: A class handle of an operating system process, for sending external commands.

## Class Variables

- DefaultPath: The default file path that Tonel files will be written to.
"
Class {
	#name : #ExercismGenerator,
	#superclass : #Object,
	#instVars : [
		'codeExporter',
		'exercismExercise',
		'exercisesPath',
		'osSubProcess',
		'updateConfig'
	],
	#classVars : [
		'DefaultPath'
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
		
	path ifNotNil: [
		self new 
			exercisesPath: path;
			codeExporter: (ExercismCodeExporter on: path);
			generate
			]
]

{ #category : #'accessing - platform' }
ExercismGenerator class >> subProcessClass [

	OSPlatform current isWindows ifTrue: [ 
		^ self class environment at: #OSWSWinProcess ].
	^ self class environment at: #OSSUnixSubprocess 
]

{ #category : #accessing }
ExercismGenerator >> basePathReference [

	^ self exercisesPath parent
]

{ #category : #accessing }
ExercismGenerator >> codeExporter: anObject [

	codeExporter := anObject
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
ExercismGenerator >> exerciseDirReferenceFrom: exerciseName [
	"returns dir reference to exercise dir - e.g. /exercises/two-fer/"
	
	^ self exercisesPath asFileReference / exerciseName
]

{ #category : #accessing }
ExercismGenerator >> exercisesPath [

	^ exercisesPath
]

{ #category : #accessing }
ExercismGenerator >> exercisesPath: aFileReference [
 
	exercisesPath := aFileReference
]

{ #category : #accessing }
ExercismGenerator >> exercismExercise [

	^ exercismExercise 
		ifNotNil: [ exercismExercise ] 
		ifNil: [ 
			exercismExercise := ExercismExercise.
			ExercismExercise  
			]
]

{ #category : #accessing }
ExercismGenerator >> exercismExercise: anExerciseClass [

	exercismExercise := anExerciseClass 
]

{ #category : #generation }
ExercismGenerator >> generate [

	"generate source files for active exercises"
	self generateSourceFilesForActiveExercises.
	
	"generate configuration config.json file"
	ExercismConfigGenerator generateTo: self basePathReference.
	
	"run configlet generation"
	self runConfigletCommand.
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

{ #category : #generation }
ExercismGenerator >> generateForExercise: slugName [

	| exerciseToGenerate |
	exerciseToGenerate := self exercismExercise	
		find: slugName
		ifAbsent: [ self error: ('Exercise {1} not found.' format: { slugName }) ].

	"generate source files for given exercise"
	self generateSourceFilesFor: exerciseToGenerate exercisePackage.

	"generate configuration config.json file"
	ExercismConfigGenerator generateTo: self basePathReference.

	"run configlet generation"
	self runConfigletCommand
]

{ #category : #helper }
ExercismGenerator >> generateReadmeHintAndCustomDataOf: testClass to: metaDirectoryRef [
	
	self generateReadmeHintFor: testClass exercise to: metaDirectoryRef.
	testClass isCustom ifTrue: [ self generateCustomDataFor: testClass exercise to: metaDirectoryRef ]
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
					self error: 'Forgot to update Exercise hint for: ', anExercismExercise name ].
				
			stream nextPutAll: hint ]
]

{ #category : #helper }
ExercismGenerator >> generateSourceFilesFor: packageOrTag [
	"Generate the Tonel source files for a package (normally a tag). Answer the exercise directory reference"

	| exerciseDirectoryRef metaDirectoryRef  solutionDirectoryRef testClass exerciseName testClasses |

	exerciseName := ExercismExercise exerciseNameFrom: packageOrTag.
	exerciseDirectoryRef := self exerciseDirReferenceFrom: exerciseName.
	metaDirectoryRef :=  exerciseDirectoryRef / '.meta'.
	solutionDirectoryRef := metaDirectoryRef / 'solution'.
	
	self prepareExerciseDirectory: exerciseDirectoryRef.

	codeExporter 
		directoryReference: solutionDirectoryRef;
		writeSnapshot: (self createTagSnapshotFor: packageOrTag).
	
	"move files to root solution directory and remove unnecessary package dir"
	self moveSolutionFilesOfPackage: packageOrTag to: solutionDirectoryRef. 

	"Move the test file down to the exerciseDirectory"
	testClasses := self testClassesOfPackage: packageOrTag.	
	self moveTestClasses: testClasses from: solutionDirectoryRef to: exerciseDirectoryRef.
	
	"Generate readme hint and custom metadata"
	testClass := testClasses detect: [ :tc | tc class includesSelector: #exercise ].
	self generateReadmeHintAndCustomDataOf: testClass to: metaDirectoryRef.
	
	^exerciseDirectoryRef
	
]

{ #category : #generation }
ExercismGenerator >> generateSourceFilesForActiveExercises [

	self exercismExercise allExercises
		select: [ :ex | ex isActive ]
		thenDo: [ :ex | 
			self generateSourceFilesFor: ex exercisePackage
		]
]

{ #category : #helper }
ExercismGenerator >> moveSolutionFilesOfPackage: packageOrTag to: solutionDirectoryRef [

	"move files to root solution directory and remove unnecessary package dir"
	((solutionDirectoryRef / packageOrTag name) allChildrenMatching: '*.st') do: [:aFile |
		aFile moveTo: solutionDirectoryRef 
	].
	(solutionDirectoryRef / packageOrTag name) delete.
	
	"Remove the package file as its not needed for Exercism"
	(solutionDirectoryRef / 'package.st') delete
]

{ #category : #helper }
ExercismGenerator >> moveTestClasses: aClasses from: solutionDirectoryRef to: exerciseDirectoryRef [ 

	aClasses do: [ :tc |
		|testClassFilename|
		testClassFilename := '{1}.class.st' format: {tc name}.
		(solutionDirectoryRef / testClassFilename) moveTo: exerciseDirectoryRef / testClassFilename
	]
]

{ #category : #accessing }
ExercismGenerator >> osSubProcess [

	^ osSubProcess 
		ifNotNil: [ osSubProcess ] 
		ifNil: [ 
		  osSubProcess := self class subProcessClass.
		  osSubProcess ]
]

{ #category : #accessing }
ExercismGenerator >> osSubProcess: anOsSubProcess [ 

	osSubProcess := anOsSubProcess
]

{ #category : #helper }
ExercismGenerator >> prepareExerciseDirectory: exerciseDirReference [
	
	exerciseDirReference ensureCreateDirectory.
	exerciseDirReference deleteAll.
]

{ #category : #generation }
ExercismGenerator >> runConfigletCommand [
	|result |		
	result := self osSubProcess new
		command: 'configlet generate';
		arguments: (Array with: self basePathReference pathString surroundedBySingleQuotes);
		redirectStdout;
		runAndWait.
	
	result isSuccess ifFalse: [ 
			self error: 'failure running "configlet generate" - ' , result lastError printString ]
]

{ #category : #helper }
ExercismGenerator >> testClassesOfPackage: packageOrTag [

	^ packageOrTag classes select: [ :cls | cls superclass = ExercismTest ]
]

{ #category : #accessing }
ExercismGenerator >> updateConfig [

	^ updateConfig
]

{ #category : #accessing }
ExercismGenerator >> updateConfig: aBool [

	updateConfig := aBool
]
