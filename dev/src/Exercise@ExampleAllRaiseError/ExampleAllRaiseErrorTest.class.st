Class {
	#name : #ExampleAllRaiseErrorTest,
	#superclass : #ExercismTest,
	#category : #'Exercise@ExampleAllRaiseError'
}

{ #category : #private }
ExampleAllRaiseErrorTest class >> exampleSolutionSourceCode [

	^ 'Class {
	#name : #ExampleAllRaiseError,
	#superclass : #Object,
	#category : #ExercismTestRunnerTests
}

{ #category : #''as yet unclassified'' }
ExampleAllRaiseError >> exerciseMethodA [
		self error: ''some domain error''
]

{ #category : #''as yet unclassified'' }
ExampleAllRaiseError >> exerciseMethodB [
		self error: ''another error''
]

{ #category : #''as yet unclassified'' }
ExampleAllRaiseError >> exerciseMethodC [
		self error: ''yet another error''
]
'
]

{ #category : #private }
ExampleAllRaiseErrorTest class >> exampleTestCasesSourceCode [

	^ 'Class {
#name : #ExampleAllRaiseErrorTest,
#superclass : #ExercismTest,
#category : #ExercismTestRunnerTests
}

{ #category : #''as yet unclassified'' }
ExampleAllRaiseErrorTest >> testExerciseMethodA [
	self assert: ExampleAllRaiseError new exerciseMethodA
]

{ #category : #''as yet unclassified'' }
ExampleAllRaiseErrorTest >> testExerciseMethodB [
	self assert: ExampleAllRaiseError new exerciseMethodB
]

{ #category : #''as yet unclassified'' }
ExampleAllRaiseErrorTest >> testExerciseMethodC [
	self assert: ExampleAllRaiseError new exerciseMethodC
]
'
]

{ #category : #config }
ExampleAllRaiseErrorTest class >> exercise [
	^ (self createExerciseAfter: HelloWorldTest)
		isCore: true;
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]

{ #category : #private }
ExampleAllRaiseErrorTest class >> prepareExampleSolutionSourceCode [

" this is used for generating STON representation of MCSnapshot, that can be used to generate solution of example (golden test)"
| solutionClass|

	solutionClass  := Object subclass: (self exercise exerciseClassName)
	instanceVariableNames: ''
	classVariableNames: ''
	package: self package name asString.

	solutionClass compile: ('exerciseMethodA
		self error: ''some domain error''').
	solutionClass compile: ('exerciseMethodB
		self error: ''another error''').
	solutionClass compile: ('exerciseMethodC
		self error: ''yet another error''').

	^ TonelWriter sourceCodeOf: solutionClass.
]
