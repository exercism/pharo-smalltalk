Class {
	#name : 'ExampleAllPassTest',
	#superclass : 'ExercismTest',
	#category : 'Exercise@ExampleAllPass',
	#package : 'Exercise@ExampleAllPass'
}

{ #category : 'private' }
ExampleAllPassTest class >> exampleSolutionSourceCode [ 

	^ 'Class {
	#name : #ExampleAllPass,
	#superclass : #Object,
	#category : #''Exercise@ExampleAllPass''
}

{ #category : #''as yet unclassified'' }
ExampleAllPass >> exerciseMethodA [
	^ $A
]

{ #category : #''as yet unclassified'' }
ExampleAllPass >> exerciseMethodB [
	^ $B
]

{ #category : #''as yet unclassified'' }
ExampleAllPass >> exerciseMethodC [
	^ $C
]
'
]

{ #category : 'private' }
ExampleAllPassTest class >> exampleTestCasesSourceCode [ 

	^ 'Class {
#name : #ExampleAllPassTest,
#superclass : #ExercismTest,
#category : #''Exercise@ExampleAllPass''
}

{ #category : #''as yet unclassified'' }
ExampleAllPassTest >> testExampleMethodA [
	self assert: ExampleAllPass new exerciseMethodA equals: $A
]

{ #category : #''as yet unclassified'' }
ExampleAllPassTest >> testExampleMethodB [
	self assert: ExampleAllPass new exerciseMethodB equals: $B
]

{ #category : #''as yet unclassified'' }
ExampleAllPassTest >> testExampleMethodC [
	self assert: ExampleAllPass new exerciseMethodC equals: $C
]
'
]

{ #category : 'config' }
ExampleAllPassTest class >> exercise [
	^ (ExercismExercise for: self)
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]
