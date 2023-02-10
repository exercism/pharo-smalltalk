"
I am the root of Exercism test examples but also provide a hook to specify some simple exercise metadata that can be used to generate the exercism config.json file (used by the platform to unlock exercises for users as they progress).
"
Class {
	#name : #ExercismTest,
	#superclass : #TestCase,
	#classInstVars : [
		'solutionId'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #helper }
ExercismTest class >> createExerciseAfter: anotherTestCase [
	"protocol: #helper"

	"Helper method to create an exercise meta data object"

	^ (ExercismExercise for: self)
		unlockedBy:
			((anotherTestCase notNil and: [ anotherTestCase isObsolete not ])
				ifTrue: [ [anotherTestCase exercise] on: SubclassResponsibility do: [ nil ] ]
				ifFalse: [ nil ]);
		yourself
]

{ #category : #config }
ExercismTest class >> customData [
	^{}
]

{ #category : #config }
ExercismTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise
	e.g.
	
	^(self createExerciseAfter: HelloWorldTest)
		isCore: false;
		difficulty: 1;
		topics: #('strings' 'iteration' 'parsing');
		yourself
	"
	
	self subclassResponsibility 
				
]

{ #category : #generator }
ExercismTest class >> generator [
	"Answer code generator aliases/hints"
	
	^{}
]

{ #category : #config }
ExercismTest class >> isActive [
	"Answer true if an exercise is active (not deprecated or for testing)"
	
	^true
]

{ #category : #config }
ExercismTest class >> isCustom [
	^self customData notEmpty
]

{ #category : #accessing }
ExercismTest class >> solutionId [
	^ solutionId ifNil: [ ExSolutionIdError signal: 'Missing exercise solutionId' ]
]

{ #category : #accessing }
ExercismTest class >> solutionId: anObject [
	solutionId := anObject
]

{ #category : #config }
ExercismTest class >> uuid [
	"Answer a fixed String, the unique UUID for this exercise so the Exercism platform can identify it.
	The id should be like: 'b5812b5e-2788-4ea6-b948-bfe54edeb0da' "
	
	^self subclassResponsibility 
]

{ #category : #config }
ExercismTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^self subclassResponsibility  
]

{ #category : #assertions }
ExercismTest >> assert: aNumber closeEnoughTo: aNumber2 by: decimalPlaces [
	"Assert that two numbers are the same when rounded to decimalPlaces places"

	self
		assert: (aNumber asFloat round: decimalPlaces)
		equals: (aNumber2 asFloat round: decimalPlaces)
]

{ #category : #verify }
ExercismTest >> verifySolution: aClass avoidsSelector: aSelector [
	| badSelector |
 
	badSelector := aClass methods detect: [ :m | m ast sentMessages includes: aSelector ] ifNone: [ ^self ].
	
	self fail: 'Your code in ', badSelector name, ' uses the library method #', aSelector, ' - try writing a different solution that avoids it'
]
