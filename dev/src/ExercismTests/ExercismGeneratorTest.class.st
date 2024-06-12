"
# ExercismGeneratorTest

To avoid side effects during testing I make use of `FailedTestOSProcess` and `SuccessfulTestOSProcess`
to simulate calls to external processes. Generated exercises are written to an in memory file system.

## Instance Variables

- instance: An instance of `ExercismGenerator`.
- memoryFileReference: An in memory filesystem that exercises will be written to.
- lineEnding: An OS specific line ending character i.e. carrage-return and/or line-feed depeding on the OS.
"
Class {
	#name : #ExercismGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'instance',
		'memoryFileReference',
		'lineEnding'
	],
	#category : #'ExercismTests-UnitTests'
}

{ #category : #asserting }
ExercismGeneratorTest >> activeExercisesWithPackageDo: aBlock [


	instance exercismExercise allExercises
		select: [ :ex | ex isActive ]
		thenDo: [ :ex | 
			aBlock value: ex exercisePackage.
	]
]

{ #category : #asserting }
ExercismGeneratorTest >> assertAllActiveExerciseClassesWithSolutionsExists [

self	activeExercisesWithPackageDo: [:exPackage | 
			|exerciseName exerciseFile|
			exerciseName := ExercismExercise exerciseNameFrom: exPackage.
			exerciseFile := memoryFileReference / exerciseName / '.meta' / 'solution' / (exerciseName kebabAsCamelCase, '.class.st' ).
			self assert: exerciseFile exists.
			self assert: exerciseFile contents isNotEmpty.			
	]
]

{ #category : #asserting }
ExercismGeneratorTest >> assertAllActiveExerciseTestClassesExists [

self	activeExercisesWithPackageDo: [:exPackage | 
			| exerciseName |
			exerciseName := ExercismExercise exerciseNameFrom: exPackage.
			exPackage classes select: [ :cls | cls superclass = ExercismTest ]	
			thenDo: [ :tc |
				| testFile |  
				testFile := memoryFileReference / exerciseName / (tc name, '.class.st').
				self assert: testFile exists.
				self assert: testFile contents isNotEmpty.	
			]
		]
]

{ #category : #asserting }
ExercismGeneratorTest >> assertExerciseTests [

	| file exerciseSourceCode|
	file := memoryFileReference / 'two-fer' / 'TwoFerTest.class.st'.

	self assert: file exists.
	exerciseSourceCode := file contents withLineEndings: lineEnding.
	"test just for important substrings - entire file is Tonel version dependent."
	self expectedTwoFerTestContentsSubstrings do: [:testedString  |
		self assert: (exerciseSourceCode includesSubstring: testedString) 
		].

	self 
		shouldnt: [ TonelParser parseString: exerciseSourceCode ]  
		raise: TonelParseError  
		description: 'Parsing of souce code of Exercism test should not raise parsing exception and definition can be loaded.'.
]

{ #category : #asserting }
ExercismGeneratorTest >> assertHints [
	
	| file |
	file := memoryFileReference / 'two-fer' / '.meta' / 'hints.md'.
	
	self assert: file exists.
	self 
		assert: (file contents withLineEndings: lineEnding) 
		equals: (self expectedHintsContents withLineEndings: lineEnding)
]

{ #category : #asserting }
ExercismGeneratorTest >> assertSolution [

	| file exerciseSourceCode|
	file := memoryFileReference / 'two-fer' / '.meta' / 'solution' / 'TwoFer.class.st'.
	
	self assert: file exists.
	exerciseSourceCode := file contents withLineEndings: lineEnding.
	"test just for important substrings - entire file is Tonel version dependent."
	self expectedTwoFerSolutionContentsSubstrings do: [:testedString  |
		self assert: (exerciseSourceCode includesSubstring: testedString) 
		].

	self 
		shouldnt: [ TonelParser parseString: exerciseSourceCode ]  
		raise: TonelParseError  
		description: 'Parsing of souce code of Exercism solution should not raise parsing exception and definition can be loaded.'.
]

{ #category : #private }
ExercismGeneratorTest >> expectedHintsContents [

	^ 'In Pharo, classes are objects that can have instance and class methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods. Typically class methods are used for constructing new objects (like a contructor in other languages).

While referring to methods, its useful to know that a method which has no parameters, is called a unary method, and a method taking multiple parameters, each deliniated by a word ending with a '':'', is called a keyword method.

There is also a third type of method, binary, which takes only 1 parameter and uses a symbol(s) for a name (typically a mathematical one like: +, -, & etc).'
]

{ #category : #private }
ExercismGeneratorTest >> expectedTwoFerSolutionContentsSubstrings [

	^ Array 
		with: ('TwoFer >> who [
	^ ''One for you, one for me.''
]' withLineEndings: lineEnding)
		with: ('TwoFer >> who: aString [ 
	^ ''One for '', aString, '', one for me.''
]' withLineEndings: lineEnding)

]

{ #category : #private }
ExercismGeneratorTest >> expectedTwoFerTestContentsSubstrings [

	^ Array 
		with: 'Two Fer'
		with: 'Class'
		with: 'TwoFerTest'
		with: 'ExercismTest'
]

{ #category : #running }
ExercismGeneratorTest >> setUp [
	
	| writer |
	super setUp.
	
	lineEnding := OSPlatform current lineEnding.
	memoryFileReference := FileSystem memory root / 'exercises'.
	writer := ExercismCodeExporter on: memoryFileReference.
	
	instance := ExercismGenerator new
		exercisesPath: memoryFileReference; 
		codeExporter: writer;
		exercismExercise: MockExercismExercise;
		yourself.
		
]

{ #category : #running }
ExercismGeneratorTest >> tearDown [ 

	instance := nil.
	super tearDown
]

{ #category : #tests }
ExercismGeneratorTest >> testCheckOrUpdateConfiglet [
	|memFileSystem|
	instance osSubProcess: FailedTestOSProcess.
	
	"memory file system should be used instead of system for testing purposes"
	memFileSystem := instance exercisesPath fileSystem.
	DiskStore 
	currentFileSystem: memFileSystem 
	during: [
	"when configlet not present - should proceed to fetching and should fail"  
	self should: [instance checkOrUpdateConfiglet] 
			raise: Error 
			whoseDescriptionIncludes: 'Cannot fetch configlet' 
			description: 'Checking should proceed to fetching of configlet and should fail as exepected result of FailedTestOSProcess.'.
  ].

	DiskStore 
	currentFileSystem: memFileSystem 
	during: [
	(instance class exercismRepositoryPath asFileReference / 'bin' / 'configlet') ensureCreateFile.  
	"when configlet is present (fake file above) - it should not proceed to fetching"
	self shouldnt: [instance checkOrUpdateConfiglet]
			raise: Error 
			whoseDescriptionIncludes: 'Cannot fetch configlet' 
			description: 'Checking of configlet should pass and not proceed to fetching.'.
	]
]

{ #category : #tests }
ExercismGeneratorTest >> testFailedGenerateSignalsException [

	instance osSubProcess: FailedTestOSProcess.
	self 
		should: [ instance generate ]
		raise: Error
		description: 'Did not signal an error after succesful generation'
]

{ #category : #tests }
ExercismGeneratorTest >> testFetchConfiglet [

	instance osSubProcess: SuccessfulTestOSProcess.
	
	self shouldnt: [instance fetchConfiglet] 
			raise: Error 
			whoseDescriptionIncludes: 'Cannot fetch configlet' 
			description: 'Fetching of configlet should success.'.
	
	instance osSubProcess: FailedTestOSProcess.
	
	self should: [instance fetchConfiglet]
			raise: Error 
			whoseDescriptionIncludes: 'Cannot fetch configlet' 
			description: 'Fetching of configlet should fail.'.

]

{ #category : #tests }
ExercismGeneratorTest >> testGenerate [

	instance osSubProcess: SuccessfulTestOSProcess.
	
	instance generate.
	
	self assertExerciseTests.
	self assertHints.
	self assertSolution
]

{ #category : #tests }
ExercismGeneratorTest >> testGenerateForExercise [

	instance osSubProcess: SuccessfulTestOSProcess.
	
	instance generateForExercise: 'two-fer'.
	
	self assertExerciseTests.
	self assertHints.
	self assertSolution
]

{ #category : #tests }
ExercismGeneratorTest >> testGenerateSourceFilesForActiveExercises [

	instance osSubProcess: SuccessfulTestOSProcess.
	
	"test for all active exercises not just Two-fer mock"
	instance exercismExercise: ExercismExercise.
	
	instance generateSourceFilesForActiveExercises.
	self assertAllActiveExerciseClassesWithSolutionsExists.
	self assertAllActiveExerciseTestClassesExists.
]

{ #category : #tests }
ExercismGeneratorTest >> testGeneratorKebabCase [
	
	self assert: 'HelloWorld' asKebabCase equals: 'hello-world'.
	self assert: 'Hello' asKebabCase equals: 'hello'.
	self assert: 'HelloMyWorld' asKebabCase equals: 'hello-my-world'.
	self assert: 'X' asKebabCase equals: 'x'.
	self assert: '' asKebabCase equals: ''
]

{ #category : #tests }
ExercismGeneratorTest >> testSuccessfulGenerateDoesNotSignalException [

	instance osSubProcess: SuccessfulTestOSProcess.
	
	self 
		shouldnt: [ instance generate ]
		raise: Error
		description: 'Signaled an error after succesful generation'
]
