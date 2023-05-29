Class {
	#name : #ExampleEmptySolutionFileTest,
	#superclass : #ExercismTest,
	#category : #'Exercise@ExampleEmptySolutionFile'
}

{ #category : #private }
ExampleEmptySolutionFileTest class >> exampleSolutionSourceCode [

	^ ''
]

{ #category : #private }
ExampleEmptySolutionFileTest class >> exampleTestCasesSourceCode [

	^ 'Class {
#name : #ExampleEmptySolutionFileTest,
#superclass : #ExercismTest,
#category : #''Exercise@ExampleEmptySolutionFile''
}

{ #category : #''as yet unclassified'' }
ExampleEmptySolutionFileTest >> testExerciseMethodA [
	self assert: ExampleSyntaxError new exerciseMethodA equals: $A
]

{ #category : #''as yet unclassified'' }
ExampleEmptySolutionFileTest >> testExerciseMethodB [
	self assert: ExampleSyntaxError new exerciseMethodB equals: $B
]

{ #category : #''as yet unclassified'' }
ExampleEmptySolutionFileTest >> testExerciseMethodC [
	self assert: ExampleSyntaxError new exerciseMethodC equals: $C
]
'
]

{ #category : #config }
ExampleEmptySolutionFileTest class >> exercise [
	^ (self createExerciseAfter: HelloWorldTest)
		isCore: true;
		difficulty: 1;
		topics: #(''introduction'');
		yourself.
]
