Class {
	#name : #ExampleTypoInMethodNameTest,
	#superclass : #ExercismTest,
	#category : #'Exercise@ExampleTypoInMethodName'
}

{ #category : #private }
ExampleTypoInMethodNameTest class >> exampleSolutionSourceCode [ 

	^ 'Class {
	#name : #ExampleTypoInMethodName,
	#superclass : #Object,
	#category : #ExercismTestRunnerTests
}

{ #category : #''as yet unclassified'' }
ExampleTypoInMethodNameATYPO >> exerciseMethodA [
	^ $A
]

'
]

{ #category : #private }
ExampleTypoInMethodNameTest class >> exampleTestCasesSourceCode [ 

	^ 'Class {
#name : #ExampleTypoInMethodNameTest,
#superclass : #ExercismTest,
#category : #ExercismTestRunnerTests
}

{ #category : #''as yet unclassified'' }
ExampleAllPassTest >> testExampleMethodA [
	self assert: ExampleTypoInMethodName new exerciseMethodA equals: $A
]
'
]

{ #category : #config }
ExampleTypoInMethodNameTest class >> exercise [
	^ (self createExerciseAfter: HelloWorldTest)
		isCore: true;
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]
