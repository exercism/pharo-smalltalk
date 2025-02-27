Extension { #name : 'ExercismTest' }

{ #category : '*ExercismTestRunnerTests' }
ExercismTest class >> exTonelSourceFilename [

	^ ClassDescription exTonelClassFilenameFor: self exercise exerciseClassName 
]

{ #category : '*ExercismTestRunnerTests' }
ExercismTest class >> exTonelTestFilename [

	^ ClassDescription exTonelClassFilenameFor: self name 
]

{ #category : '*ExercismTestRunnerTests' }
ExercismTest class >> exampleDirName [

	^ self exercise exerciseClassName asKebabCase
]

{ #category : '*ExercismTestRunnerTests' }
ExercismTest class >> prepareExampleSolutionSourceCode [

" this is used for generating STON representation of MCSnapshot, that can be used to generate solution of example (golden test)"
| solutionClass|

	solutionClass  := Object subclass: (self exercise exerciseClassName)
	instanceVariableNames: ''
	classVariableNames: ''
	package: self package name asString.

	solutionClass compile: ('exerciseMethodA
	^ $A').
	solutionClass compile: ('exerciseMethodB
	^ $B').	
	solutionClass compile: ('exerciseMethodC
	^ $C').

	^ TonelWriter sourceCodeOf: solutionClass.
]

{ #category : '*ExercismTestRunnerTests' }
ExercismTest class >> prepareExampleTestCasesSourceCode [

" this is used for generating STON representation of MCSnapshot, that can be used to generate solution of example (golden test)"
|testClass solutionClassName|

	testClass := self.
	solutionClassName := self exercise exerciseClassName.

	testClass compile: ('testExerciseMethodA
	self assert: {1} new exerciseMethodA equals: $A' format: {solutionClassName}).
	testClass compile: ('testExerciseMethodB
	self assert: {1} new exerciseMethodB equals: $B' format: {solutionClassName}).	
	testClass compile: ('testExerciseMethodC
	self assert: {1} new exerciseMethodC equals: $C' format: {solutionClassName}).

	^ TonelWriter sourceCodeOf: testClass.
]
