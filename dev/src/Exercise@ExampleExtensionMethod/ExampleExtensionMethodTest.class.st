Class {
	#name : 'ExampleExtensionMethodTest',
	#superclass : 'ExercismTest',
	#category : 'Exercise@ExampleExtensionMethod',
	#package : 'Exercise@ExampleExtensionMethod'
}

{ #category : 'private' }
ExampleExtensionMethodTest class >> exampleSolutionSourceCode [

	^ 'Extension { #name : #String }

{ #category : #''*Exercise@ExampleExtensionMethod'' }
String >> somethingReturned [

	^ ''something returned''
]
'
]

{ #category : 'private' }
ExampleExtensionMethodTest class >> exampleTestCasesSourceCode [

	^ 'Class {
#name : #ExampleExtensionMethodTest,
#superclass : #ExercismTest,
#category : #''Exercise@ExampleExtensionMethod''
}

{ #category : #''as yet unclassified'' }
ExampleExtensionMethodTest >> testStringExtensionSomethingReturned [
	self assert: String new somethingReturned equals: ''something returned''
]
'
]

{ #category : 'config' }
ExampleExtensionMethodTest class >> exercise [
	^ (self createExerciseAfter: HelloWorldTest)
		isCore: true;
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]
