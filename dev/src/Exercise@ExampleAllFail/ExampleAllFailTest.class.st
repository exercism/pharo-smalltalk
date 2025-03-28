Class {
	#name : 'ExampleAllFailTest',
	#superclass : 'ExercismTest',
	#category : 'Exercise@ExampleAllFail',
	#package : 'Exercise@ExampleAllFail'
}

{ #category : 'private' }
ExampleAllFailTest class >> exampleSolutionSourceCode [ 

	^ 'Class {
	#name : #ExampleAllFail,
	#superclass : #Object,
	#category : #''Exercise@ExampleAllFail''
}

{ #category : #''as yet unclassified'' }
ExampleAllFail >> exerciseMethodA [
	^ ''not $A''
]

{ #category : #''as yet unclassified'' }
ExampleAllFail >> exerciseMethodB [
	^ ''not $B''
]

{ #category : #''as yet unclassified'' }
ExampleAllFail >> exerciseMethodC [
	^ ''not $C''
]
'
]

{ #category : 'private' }
ExampleAllFailTest class >> exampleTestCasesSourceCode [ 
	
	^ 'Class {
	#name : #ExampleAllFailTest,
	#superclass : #ExercismTest,
	#category : #''Exercise@ExampleAllFail''
}

{ #category : #''as yet unclassified'' }
ExampleAllFailTest >> testExerciseMethodA [
	self assert: ExampleAllFail new exerciseMethodA equals: $A
]

{ #category : #''as yet unclassified'' }
ExampleAllFailTest >> testExerciseMethodB [
	self assert: ExampleAllFail new exerciseMethodB equals: $B
]

{ #category : #''as yet unclassified'' }
ExampleAllFailTest >> testExerciseMethodC [
	self assert: ExampleAllFail new exerciseMethodC equals: $C
]
'
]

{ #category : 'config' }
ExampleAllFailTest class >> exercise [
	^ (ExercismExercise for: self)
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]

{ #category : 'config' }
ExampleAllFailTest class >> prepareExampleSolutionSourceCode [

" this is used for generating STON representation of MCSnapshot, that can be used to generate solution of example (golden test)"
| solutionClass|

	solutionClass  := Object subclass: (self exercise exerciseClassName)
	instanceVariableNames: ''
	classVariableNames: ''
	package: self package name asString.

	solutionClass compile: ('exerciseMethodA
	^ ''not $A''').
	solutionClass compile: ('exerciseMethodB
	^ ''not $B''').	
	solutionClass compile: ('exerciseMethodC
	^ ''not $C''').

	^ TonelWriter sourceCodeOf: solutionClass.
]
