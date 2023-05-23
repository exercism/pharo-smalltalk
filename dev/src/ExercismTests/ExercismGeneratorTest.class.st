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

	| file |
	file := memoryFileReference / 'two-fer' / 'TwoFerTest.class.st'.

	self assert: file exists.
	self 
		assert: (file contents withLineEndings: lineEnding) 
		equals: (self expectedTwoFerTestContents withLineEndings: lineEnding)
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

	| file |
	file := memoryFileReference / 'two-fer' / '.meta' / 'solution' / 'TwoFer.class.st'.
	
	self assert: file exists.
	self 
		assert: (file contents withLineEndings: lineEnding) 
		equals: (self expectedTwoFerSolutionContents withLineEndings: lineEnding)
]

{ #category : #private }
ExercismGeneratorTest >> expectedHintsContents [

	^ 'In Pharo, classes are objects that can have instance and class methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods. Typically class methods are used for constructing new objects (like a contructor in other languages).

While referring to methods, its useful to know that a method which has no parameters, is called a unary method, and a method taking multiple parameters, each deliniated by a word ending with a '':'', is called a keyword method.

There is also a third type of method, binary, which takes only 1 parameter and uses a symbol(s) for a name (typically a mathematical one like: +, -, & etc).'
]

{ #category : #private }
ExercismGeneratorTest >> expectedTwoFerSolutionContents [

	^ '"
This is a sample solution for Exercism students.

Of interest, in this example is that classes can define instance methods with the same name, but taking different numbers of parameters.


"
Class {
	#name : #TwoFer,
	#superclass : #Object,
	#category : #''Exercise@TwoFer''
}

{ #category : #example }
TwoFer >> who [
	^ ''One for you, one for me.''
]

{ #category : #example }
TwoFer >> who: aString [ 
	^ ''One for '', aString, '', one for me.''
]
'
]

{ #category : #private }
ExercismGeneratorTest >> expectedTwoFerTestContents [

	^ '"
# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

Given a name, return a string with the message:

```text
One for X, one for me.
```

Where X is the given name.

However, if the name is missing, return the string:

```text
One for you, one for me.
```

Here are some examples:

|Name    | String to return 
|:------:|:-----------------: 
|Alice   | One for Alice, one for me. 
|Bob     | One for Bob, one for me.
|        | One for you, one for me.
|Zaphod  | One for Zaphod, one for me.

## Hint

In Pharo, classes are objects that can have instance and class methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods. Typically class methods are used for constructing new objects (like a contructor in other languages).

While referring to methods, its useful to know that a method which has no parameters, is called a unary method, and a method taking multiple parameters, each deliniated by a word ending with a '':'', is called a keyword method.

There is also a third type of method, binary, which takes only 1 parameter and uses a symbol(s) for a name (typically a mathematical one like: +, -, & etc).
"
Class {
	#name : #TwoFerTest,
	#superclass : #ExercismTest,
	#instVars : [
		''twoFer''
	],
	#category : #''Exercise@TwoFer''
}

{ #category : #config }
TwoFerTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(self createExerciseAfter: HelloWorldTest)
		isCore: true;
		difficulty: 1;
		topics: #(''strings'' ''text-formatting'' ''refactoring'');
		yourself
	
]

{ #category : #config }
TwoFerTest class >> uuid [
	"Answer a unique id for this exercise"
	^''9806fcc0-8505-4012-bd64-3f7468014df5''
]

{ #category : #config }
TwoFerTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^''1.2.0''
]

{ #category : #running }
TwoFerTest >> setUp [
	super setUp.
	twoFer := TwoFer new.
]

{ #category : #tests }
TwoFerTest >> testANameGiven [
	self assert: (twoFer who: ''Alice'') equals: ''One for Alice, one for me.''
]

{ #category : #tests }
TwoFerTest >> testAnotherNameGiven [
	self assert: (twoFer who: ''Bob'') equals: ''One for Bob, one for me.'' 
]

{ #category : #tests }
TwoFerTest >> testNoNameGiven [
	self assert: twoFer who equals: ''One for you, one for me.'' 
	
]
'
]

{ #category : #running }
ExercismGeneratorTest >> setUp [
	
	| writer |
	super setUp.
	
	lineEnding := OSPlatform current lineEnding.
	memoryFileReference := FileSystem memory root / 'exercises'.
	writer := ExTonelWriter on: memoryFileReference.
	
	instance := ExercismGenerator new
		exercisesPath: memoryFileReference; 
		exTonelWriter: writer;
		exercismExercise: MockExercismExercise;
		yourself.
		
]

{ #category : #running }
ExercismGeneratorTest >> tearDown [ 

	instance := nil.
	super tearDown
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
ExercismGeneratorTest >> testGenerate [

	instance osSubProcess: SuccessfulTestOSProcess.
	
	instance generate.
	
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
