Class {
	#name : #ExampleSyntaxErrorTest,
	#superclass : #ExercismTest,
	#category : #'Exercise@ExampleSyntaxError'
}

{ #category : #private }
ExampleSyntaxErrorTest class >> exampleSolutionSourceCode [

	^ 'Class {
	#name : #ExampleSyntaxError, ==> Syntax error here <==
	#superclass : #Object,
	#category : #ExercismTestRunnerTests
}

{ #category : #''as yet unclassified'' }
ExampleSyntaxError >> exerciseMethodA [
	^ $A
]

{ #category : #''as yet unclassified'' }
ExampleSyntaxError >> exerciseMethodB [
	^ $B
]

{ #category : #''as yet unclassified'' }
ExampleSyntaxError >> exerciseMethodC [
	^ $C
]
'
]

{ #category : #private }
ExampleSyntaxErrorTest class >> exampleTestCasesSourceCode [

	^ 'Class {
#name : #ExampleSyntaxErrorTest,
#superclass : #ExercismTest,
#category : #ExercismTestRunnerTests
}

{ #category : #''as yet unclassified'' }
ExampleSyntaxErrorTest >> testExerciseMethodA [
	self assert: ExampleSyntaxError new exerciseMethodA equals: $A
]

{ #category : #''as yet unclassified'' }
ExampleSyntaxErrorTest >> testExerciseMethodB [
	self assert: ExampleSyntaxError new exerciseMethodB equals: $B
]

{ #category : #''as yet unclassified'' }
ExampleSyntaxErrorTest >> testExerciseMethodC [
	self assert: ExampleSyntaxError new exerciseMethodC equals: $C
]
'
]

{ #category : #config }
ExampleSyntaxErrorTest class >> exercise [
	^ (self createExerciseAfter: HelloWorldTest)
		isCore: true;
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]
