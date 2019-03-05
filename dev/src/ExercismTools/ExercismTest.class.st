Class {
	#name : #ExercismTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Core'
}

{ #category : #config }
ExercismTest class >> createExerciseAfter: anotherTestCase [
	^(ExercismExercise for: self) 
			unlockedBy: anotherTestCase exercise;
			yourself
]

{ #category : #helper }
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

{ #category : #config }
ExercismTest class >> next [
	"Answer the String id of the exercise name that follows"
	
	^''
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
	
	self fail: 'Your #', badSelector name, ' uses a library method #', aSelector, ' - try writing a solution that avoids it'
]
