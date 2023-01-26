"
An ExercismTestRunnerTest is a test class for testing the behavior of ExercismTestRunner
"
Class {
	#name : #ExercismTestRunnerTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismTestRunnerTest >> testFindExercise [

	self should: [ExercismTestRunner default findExercise: 'blurb' ] raise: ExDomainError description: 'Error occurs when trying to find non existing exercise'.
	
	self assert: (ExercismTestRunner default findExercise: 'hello-world') testCase equals: HelloWorldTest. 
]

{ #category : #tests }
ExercismTestRunnerTest >> testRunTestsFor [

	self should: [ExercismTestRunner default runTestsFor: Object] raise: ExDomainError description: 'Error occurs when trying to test non existing test case'.
	
	self assert: (ExercismTestRunner default runTestsFor: HelloWorldTest) hasPassed.
]

{ #category : #tests }
ExercismTestRunnerTest >> testSetErrorToJson [

	|result|
	result := (ExercismTestRunner default setErrorToJson: 'Some error') .
	self assert: (result includesSubstring: '"message" : "Some error"').
	self assert: (result includesSubstring: '"status" : "error"').
]

{ #category : #tests }
ExercismTestRunnerTest >> testValidateDefinitions [

	|reader|
	reader := TonelReader fromExerciseDirectory: FileSystem memory root.
	reader loadDefinitions.
	self should: [ExercismTestRunner default validateDefinitions: reader definitions] raise: ExDomainError description: 'Empty source code definitions are not valid for loading exercise'.
]
