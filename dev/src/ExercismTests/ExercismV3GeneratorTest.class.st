Class {
	#name : #ExercismV3GeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'instance',
		'memoryFileReference',
		'lineEnding'
	],
	#category : #'ExercismTests-UnitTests'
}

{ #category : #asserting }
ExercismV3GeneratorTest >> assertDocumentation [

	| introduction instructions hints after source |
	introduction := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.docs' / 'introduction.md'.
	instructions := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.docs' / 'instructions.md'.
	hints := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.docs' / 'hints.md'.
	after := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.docs' / 'after.md'.
	source := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.docs' / 'source.md'.
	
	self assert: introduction exists.
	self 
		assert: (introduction contents withLineEndings: lineEnding) 
		equals: (self expectedIntroductionContents withLineEndings: lineEnding).
		
	self assert: instructions exists.
	self 
		assert: (instructions contents withLineEndings: lineEnding) 
		equals: (self expectedInstructionsContents withLineEndings: lineEnding).
		
	self assert: hints exists.
	self 
		assert: (hints contents withLineEndings: lineEnding) 
		equals: (self expectedHintsContents withLineEndings: lineEnding).
		
	self assert: after exists.
	self 
		assert: (after contents withLineEndings: lineEnding) 
		equals: (self expectedAfterContents withLineEndings: lineEnding).
		
	self assert: source exists.
	self 
		assert: (source contents withLineEndings: lineEnding) 
		equals: (self expectedSourceContents withLineEndings: lineEnding).
]

{ #category : #asserting }
ExercismV3GeneratorTest >> assertExercise [

	| implementationStub test |
	implementationStub := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / 'RemoteControlCar.class.st'.
	test := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / 'RemoteControlCarTest.class.st'.

	self assert: implementationStub exists.
	self 
		assert: (implementationStub contents withLineEndings: lineEnding) 
		equals: (self expectedImplementationStubContents withLineEndings: lineEnding).
		
	self assert: test exists.
	self
		assert: (test contents withLineEndings: lineEnding)
		equals: (self expectedTestContents withLineEndings: lineEnding)
]

{ #category : #asserting }
ExercismV3GeneratorTest >> assertMetaDirectory [
	
	| design config example |
	design := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.meta' / 'design.md'.
	config := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.meta' / 'config.json'.
	example := memoryFileReference / 'exercises' / 'concept' / 'elons-toys' / '.meta' / 'RemoteControlCar.class.st'.
	
	self assert: design exists.
	self 
		assert: (design contents withLineEndings: lineEnding) 
		equals: (self expectedHintsContents withLineEndings: lineEnding).
	
	self assert: config exists.
	self
		assert: (config contents withLineEndings: lineEnding)
		equals: (self expectedConfigContents withLineEndings: lineEnding).
		
	self assert: example exists.
	self
		assert: (example contents withLineEndings: lineEnding)
		equals: (self expectedExampleContetns withLineEndings: lineEnding)
]

{ #category : #private }
ExercismV3GeneratorTest >> expectedHintsContents [

	^ 'In Pharo, classes are objects that can have instance and class methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods. Typically class methods are used for constructing new objects (like a contructor in other languages).

While referring to methods, its useful to know that a method which has no parameters, is called a unary method, and a method taking multiple parameters, each deliniated by a word ending with a '':'', is called a keyword method.

There is also a third type of method, binary, which takes only 1 parameter and uses a symbol(s) for a name (typically a mathematical one like: +, -, & etc).'
]

{ #category : #private }
ExercismV3GeneratorTest >> expectedImplementationStubContents [

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
ExercismV3GeneratorTest >> expectedTestContents [

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
ExercismV3GeneratorTest >> setUp [
	
	| writer |
	super setUp.
	
	lineEnding := OSPlatform current lineEnding.
	memoryFileReference := FileSystem memory root / 'exercises'.
	writer := ExTonelWriter on: memoryFileReference.
	
	instance := ExercismV3Generator new
		exercisesPath: memoryFileReference; 
		exTonelWriter: writer;
		exercismExercise: MockExercismV3Exercise;
		yourself.
		
]

{ #category : #tests }
ExercismV3GeneratorTest >> testFailedGenerateSignalsException [

	instance osProcess: FailedTestOSProcess new.
	
	self 
		should: [ instance generate ]
		raise: Error
		description: 'Did not signal an error after succesful generation'
]

{ #category : #tests }
ExercismV3GeneratorTest >> testGenerate [

	instance osProcess: SuccessfulTestOSProcess new.
	
	instance generate.
	
	self 
		assertExercise;
		assertMetaDirectory;
		assertDocumentation
]

{ #category : #tests }
ExercismV3GeneratorTest >> testGeneratorKebabCase [
	
	self assert: 'HelloWorld' asKebabCase equals: 'hello-world'.
	self assert: 'Hello' asKebabCase equals: 'hello'.
	self assert: 'HelloMyWorld' asKebabCase equals: 'hello-my-world'.
	self assert: 'X' asKebabCase equals: 'x'.
	self assert: '' asKebabCase equals: ''
]

{ #category : #tests }
ExercismV3GeneratorTest >> testSuccessfulGenerateDoesNotSignalException [

	instance osProcess: SuccessfulTestOSProcess new.
	
	self 
		shouldnt: [ instance generate ]
		raise: Error
		description: 'Signaled an error after succesful generation'
]
