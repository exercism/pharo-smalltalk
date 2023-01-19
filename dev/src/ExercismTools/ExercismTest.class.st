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

{ #category : #export }
ExercismTest >> exercismTestResultInfo [

	|testResultDict|
	testResultDict := OrderedDictionary new.
	testResultDict 
		add: 'name' -> self humanReadableName;
		add: 'status' -> self statusString.
	self resultMessage ifNotEmpty: 
	[:aString | 
			testResultDict add:  'message' -> aString.
			testResultDict add: 'output' -> self resultDebugInfo.
	].
	testResultDict add: 'test_code' -> self sourceCodeString.
	^ testResultDict 
]

{ #category : #export }
ExercismTest >> humanReadableName [

	| readName |
	readName := (self selector includes: $_)
		            ifTrue: [ self selector copyAfterLast: $_ ]
		            ifFalse: [ self selector withoutPrefix: 'test' ].
	^ readName asSentenceCase trim capitalized
]

{ #category : #export }
ExercismTest >> resultDebugInfo [

	| writeStream |
	writeStream := WriteStream on: ''.
	[ self runCase ]
		on: Error , TestFailure , TestTookTooMuchTime
		do: [ :anException | 
			| aContext |
			aContext := anException signalerContext.
			[ 
			aContext isNil or: [ 
				aContext receiver == self and: [ 
					aContext methodSelector == #runCase ] ] ] whileFalse: [ 
				[ 
				writeStream
					nextPutAll: aContext printString;
					lf ] onErrorDo: [ 
					writeStream
						nextPutAll:
							('Error during printing of stacktrace: {1}>>{2}.' format: { 
										 self class name.
										 self selector });
						lf ].
				aContext := aContext sender ]].
		^ writeStream contents withUnixLineEndings
]

{ #category : #export }
ExercismTest >> resultMessage [
	|errorMessage|
	errorMessage := ''.
	[self runCase] on: 
			Error, 
			TestFailure, 
			TestTookTooMuchTime  
		do: [:ex |errorMessage := ex messageText].
	^ errorMessage 
]

{ #category : #export }
ExercismTest >> sourceCodeString [
	"using LF lineending since it will be bumped to json format"
	^ (self class compiledMethodAt: self selector) sourceCode withUnixLineEndings
]

{ #category : #export }
ExercismTest >> statusString [ 

	(self class methodPassed: self selector) ifTrue: [^ 'pass'].
	(self class methodFailed: self selector) ifTrue: [^ 'fail'].
	(self class methodRaisedError: self selector) ifTrue: [^ 'error'].
]

{ #category : #verify }
ExercismTest >> verifySolution: aClass avoidsSelector: aSelector [
	| badSelector |
 
	badSelector := aClass methods detect: [ :m | m ast sentMessages includes: aSelector ] ifNone: [ ^self ].
	
	self fail: 'Your code in ', badSelector name, ' uses the library method #', aSelector, ' - try writing a different solution that avoids it'
]
