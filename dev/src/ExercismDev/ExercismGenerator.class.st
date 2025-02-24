"
# ExercismGenerator

I am responsible for generating kebab-cased Exercism V3 directories, each containing a seperate exercise for users (right now only practice).

Exercism requires plain text files that can be served to the website as exercises and then downloaded for a student 
to work on. We have to do it this way as Exercism conventions differ from Tonel, and so we need to output them to a 
seperate directory suitable for the Exercism command line tool.

## Collaborators

I need two other key objects to do my job: an `ExercismCodeExporter` and a `OSSUnixSubprocess` (or `OSWinSubprocess` depending on Platform being used). `ExercismCodeExporter` does the
actual job of writing Tonel format files to disk. `OSSUnix/WinSubprocess` is needed to make a external command line
call to the configlet tool. The configlet tool will be fetched automatically on the host operating system, if not present.

To grab the exercises that need to be written I use `ExercismExercise`.

## Usage

### Generating sources to output directories for all exercises 
When you have created a new exercises that you are happy with, you need to run a generation.

You can run the `ExercismGenerator class>>#generate` method and be prompted for a file location 
(where the path is one that points to where you have checked out the entire pharo project using either 
the command line or a git tool):

```
ExercismGenerator generate
```

In any other context (e.g. for testing purposes) I will need to have `exercisesDirReference` variable initialized
before `#generate` is sent to me. Following example will generate output sources to directory of memory filesystem.

```
ExercismGenerator new
	exercisesDirReference: (FileSystem memory root / 'exercises');
	generate
```

### Generating sources to output directory for given exercise (update of exercise)
When you've created just specific exercise or exercise that needs just update, you can run:

#### For using default directory - repository-root/exercises/practice path
`ExercismGenerator new generateForExercise: 'slug-name'`

#### When needed to export to specific exercise directory
```
ExercismGenerator new 
	exercisesDirReference: 'path-to-exercises/practice' asFileReference;
	generateForExercise: 'slug-name'

```

## Instance Variables

- exercismExercise: A class handle for easily getting all the implemented exercises. Defaults to `ExercismExercise`.
- exerciseDirReference: The directory reference where exercises are written to. Defaults from the class variable `DefaultPath`.
- codeExporter: `ExercismCodeExporter`; Responsible for writing objects as Tonel format source text files to the give file path.
- osSubProcess: A class handle of an operating system process, for sending external commands.

## Class Variables

- DefaultPath: The default file path that Tonel files will be written to.
"
Class {
	#name : #ExercismGenerator,
	#superclass : #Object,
	#instVars : [
		'codeExporter',
		'exercismExercise',
		'osSubProcess',
		'updateConfig',
		'exercisesDirReference'
	],
	#classVars : [
		'DefaultPath'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #helper }
ExercismGenerator class >> defaultPath [
	
	^ DefaultPath ifNil: [ 
		self defaultPath: (
			self exercismRepositoryPath 
				ifNil: [FileLocator home pathString]
				ifNotNil: [self exercismRepositoryPath, '/exercises/practice']
		)
	]
]

{ #category : #helper }
ExercismGenerator class >> defaultPath: pathString [
	^ DefaultPath := pathString
]

{ #category : #helper }
ExercismGenerator class >> exercismRepositoryPath [
	
	|repository|
	repository := (IceRepository repositoryNamed: 'pharo-smalltalk') ifNil: [ self traceCr: 'Could not determine location of local Pharo Exercism repository.'. ^ nil ].
	^ repository location pathString
]

{ #category : #generation }
ExercismGenerator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
	| dirReference |
	dirReference := UIManager default
		chooseDirectory: 'Select the /exercises/practise location in a fresh Exercism/Pharo git project'
		path: self defaultPath.
		
	dirReference ifNotNil: [
		self new 
			exercisesDirReference: dirReference;
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
	
	"root directory of Pharo track where config.json is located, 
	 if cannot determine repository path, use parent of actually selected directory for export"
	| basePath |
	
	basePath := self class exercismRepositoryPath.
	basePath ifNil:[
		basePath := self exercisesDirReference parent
	].
	^ basePath asFileReference
]

{ #category : #helper }
ExercismGenerator >> checkOrUpdateConfiglet [

	(self configletRootReference / 'configlet') isFile
		ifTrue: [ ^ self ].
	self traceCr: 'Could not find configlet. Fetching configlet...'.
	self fetchConfiglet
]

{ #category : #accessing }
ExercismGenerator >> codeExporter: anObject [

	codeExporter := anObject
]

{ #category : #accessing }
ExercismGenerator >> configletRootReference [
	
	|configletPath|
	"use default bin directory where configlet is locatated (out from git repository). If not present, use parent of exercises dir."
	configletPath := self class exercismRepositoryPath.
	configletPath ifNil: [ ^ self basePathReference / 'bin' ].
	^ configletPath asFileReference / 'bin'
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
	
	^ self exercisesDirReference asFileReference / exerciseName
]

{ #category : #accessing }
ExercismGenerator >> exercisesDirReference [

	^ exercisesDirReference
]

{ #category : #accessing }
ExercismGenerator >> exercisesDirReference: aFileReference [
 
	exercisesDirReference := aFileReference.

	"whenever new directory for exercices export is changed, setup code exporter as well"
	self setupCodeExporterFromDirReference.
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

{ #category : #helper }
ExercismGenerator >> fetchConfiglet [
	
	|result |		
	result := self osSubProcess new
		workingDirectory: self configletRootReference fullName;
		command: 'fetch-configlet';
		arguments: #();
		redirectStdout;
		runAndWait.
	
	result isSuccess ifFalse: [ 
			self error: 'Cannot fetch configlet - ' , result lastError printString ].
	self traceCr: 'Configlet fetching - done!'
]

{ #category : #generation }
ExercismGenerator >> generate [
	"this will regenerate all active exercises"
	
	"generate source files for active exercises"
	self generateSourceFilesForActiveExercises.
	
	"generate configuration config.json file"
	ExercismConfigGenerator generateTo: self basePathReference.
	
	"run configlet generation"
	self runConfigletCommandsForActiveExercices.
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

	"update configuration config.json file with exercise"
	self updateOrCreateConfigJsonFor: slugName.

	"run configlet commands for given exercise"
	self runTestSpecificationsUpdateForExercise: slugName.
	self runDocsAndMetadataUpdateForExercise: slugName.
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

	exerciseName := self exercismExercise exerciseNameFrom: packageOrTag.
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

{ #category : #initialize }
ExercismGenerator >> initialize [ 
	
	super initialize.
	self exercisesDirReference: self class defaultPath asFileReference.

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
ExercismGenerator >> runConfigletCommandsForActiveExercices [
	
		self exercismExercise allExercises
		select: [ :ex | ex isActive ]
		thenDo: [ :ex |
			self runTestSpecificationsUpdateForExercise: ex name.
			self runDocsAndMetadataUpdateForExercise: ex name.
		]
]

{ #category : #generation }
ExercismGenerator >> runDocsAndMetadataUpdateForExercise: slugName [
	| result |	
		
	result := self osSubProcess new
		command: 'configlet';
		workingDirectory: self configletRootReference fullName;
		arguments: {'sync'. '--docs'. '--filepaths'. '--metadata'. '-uy'. '-e'. slugName.} asArray;
		redirectStdout;
		runAndWait.
	
	result isSuccess ifFalse: [ 
			self error: ('Failed running "configlet sync --docs --filepaths --metadata -uy -e {1}" with result: {2}' format: { slugName. result lastError printString.})]
]

{ #category : #generation }
ExercismGenerator >> runTestSpecificationsUpdateForExercise: slugName [
	| result |	
		
	result := self osSubProcess new
		command: 'configlet';
		workingDirectory: self configletRootReference fullName;
		arguments: {'sync'. '-u'. '--tests'. 'include'. '-e'. slugName.} asArray;
		redirectStdout;
		runAndWait.
	
	result isSuccess ifFalse: [ 
			self error: ('Failed running "configlet sync -u --tests include -e {1}" with result: {2}' format: { slugName. result lastError printString.})]
]

{ #category : #initialize }
ExercismGenerator >> setupCodeExporterFromDirReference [

	"this will set code exporter when directory for exercise export is changed"
	self codeExporter: (ExercismCodeExporter on: self exercisesDirReference)
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

{ #category : #helper }
ExercismGenerator >> updateOrCreateConfigJsonFor: slugName [

	"create new config file, if config.json completely missing"
	(self basePathReference filesMatching: 'config.json') ifEmpty: [
		 ^ ExercismConfigGenerator generateTo: self basePathReference
	].

	"otherwise update configuration config.json file with exercise"
	ExercismConfigGenerator new
		updateConfigFrom: self basePathReference
		for: slugName
]
