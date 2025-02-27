"
I'm responsible for generating (compiling) test case methods from testJson specification. If json case contains other cases, I call myself with test method prefix gained from parent case description. I'm part of ExercismExerciseGenerator. I recieve testCaseJson, testClass (compilation target), testPrefix and testVariable as input parameters in order to generate test methods successfully. 



Public API and Key Messages
- generateTests

Example:
ExercismTestMethodGenerator uniqueInstance 
			testClass: HelloWorldTest;
			testCaseJson: testCaseJson;
			testVariable: 'helloWorldCalculator;
			testPrefix: '';
			generateTests.
"
Class {
	#name : 'ExercismTestMethodGenerator',
	#superclass : 'Object',
	#instVars : [
		'testCounter',
		'testCaseJson',
		'testClass',
		'testVariable',
		'testPrefix'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'ExercismDev-TestGenerator',
	#package : 'ExercismDev',
	#tag : 'TestGenerator'
}

{ #category : 'accessing' }
ExercismTestMethodGenerator class >> uniqueInstance [
	
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'private' }
ExercismTestMethodGenerator >> caseContainsOtherCases [

	^ self testCaseJson includesKey: 'cases'
]

{ #category : 'private' }
ExercismTestMethodGenerator >> generateCodeAssertEqualsOn: outStream [

	outStream
		tab;
		nextPutAll: 'result := '.

	self generateCodeModelCallOn: outStream.

	outStream
		nextPut: $.;
		cr;
		tab;
		nextPutAll: 'self assert: result equals: ';
		nextPutAll: self testResults storeString
]

{ #category : 'private' }
ExercismTestMethodGenerator >> generateCodeModelCallOn: outStream [

	outStream
		nextPutAll: self testVariable;
		space;
		nextPutAll: self testSelector.

	self testInputParameters keys doWithIndex: [ :key :index |
		outStream nextPutAll: (index = 1
				 ifTrue: [ self keywordFor: key ]
				 ifFalse: [ key asValidKeyword ]).
		outStream
			nextPut: $:;
			space.
		outStream
			nextPutAll: (self testInputParameters at: key) storeString;
			space ]
]

{ #category : 'private' }
ExercismTestMethodGenerator >> generateCodeShouldRaiseOn: outStream [

	| errorMessage |
	outStream 
		tab;
		nextPutAll: 'self';
		crlf; tab; tab;
		nextPutAll: 'should: [ result := '.
			
	self generateCodeModelCallOn: outStream.
		
	errorMessage := (self testResults at: 'error') printString.
	
	outStream
		nextPutAll: ']';
		cr; tab; tab;
		nextPutAll: 'raise: Error';
		cr; tab; tab;
		nextPutAll: ('whoseDescriptionIncludes: {1}' format: { errorMessage });
		cr; tab; tab;
		nextPutAll: 'description: ''Should get an error with the correct description'''.	
	
]

{ #category : 'private' }
ExercismTestMethodGenerator >> generateDescriptionAndUUIDPragmasOn: outStream [

		outStream 
			tab; << ('<exeTestName: ''{1}''>' format: {self testCaseJson at: 'description'}); cr; 
			tab; << ('<exeTestUUID: ''{1}''>' format: {self testCaseJson at: 'uuid'}); cr;
			cr
]

{ #category : 'API - actions' }
ExercismTestMethodGenerator >> generateTest [

	|  sourceCode testNameSelector|
	testNameSelector := self testNameWithCounterPrefix.
	sourceCode := String streamContents: [:outStream | 
		outStream << testNameSelector; cr.
		self generateTipCommentForFirstCaseOn: outStream.
		self generateDescriptionAndUUIDPragmasOn: outStream.
		outStream tab << '| result |'; cr; cr.
		
		self isErrorAssertion ifTrue: [self generateCodeShouldRaiseOn: outStream ]
		ifFalse: [ self generateCodeAssertEqualsOn: outStream  ].
		
	].
	
	ExercismExerciseGenerator new compile: sourceCode for: self testClass selector: testNameSelector protocol: 'tests'
]

{ #category : 'API - actions' }
ExercismTestMethodGenerator >> generateTests [

	self caseContainsOtherCases
		ifTrue: [
			|aPrefix|
			"materialize prefix first, before caseJson is changed in ongoing generation"
			aPrefix := self methodName.
			(self testCaseJson at: 'cases') do: [ :aCaseJson |
				self class uniqueInstance
					testCaseJson: aCaseJson;
					testPrefix: aPrefix;
					generateTests ] ]
		ifFalse: [ self generateTest ]
]

{ #category : 'private' }
ExercismTestMethodGenerator >> generateTipCommentForFirstCaseOn: outStream [
		
	testCounter = 1 ifTrue: [ outStream tab << '"Tip: Remember to review the class [Comment] tab"' ; cr].
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> isErrorAssertion [

	| testResults |
	testResults := self testResults.
	testResults isDictionary ifFalse: [ ^ false ].

	^ testResults size = 1 and: [ testResults includesKey: 'error' ]
]

{ #category : 'private' }
ExercismTestMethodGenerator >> keywordFor: key [
	
	^(self testSelector asLowercase endsWith: key asLowercase)
		ifTrue: [ '' ]
		ifFalse: [ key capitalized ]
]

{ #category : 'private' }
ExercismTestMethodGenerator >> methodName [

	| methodNameSegment |
	methodNameSegment := (self testCaseJson at: 'description') asCamelCase asValidKeyword capitalized.
	^ self testPrefix
		  ifEmpty: [ methodNameSegment withoutPrefix: 'And' ]
		  ifNotEmpty: [ self testPrefix , methodNameSegment ]
]

{ #category : 'private' }
ExercismTestMethodGenerator >> nextTestCounter [

	^ testCounter := testCounter + 1
]

{ #category : 'initialization' }
ExercismTestMethodGenerator >> resetTestCounter [ 

	self testCounter: 0.
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testCaseJson [

	^ testCaseJson
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testCaseJson: anObject [

	testCaseJson := anObject
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testClass [

	^ testClass
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testClass: anObject [

	testClass := anObject
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testCounter [

	^ testCounter
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testCounter: anObject [

	testCounter := anObject
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testInputParameters [

	^ self testCaseJson at: 'input'
]

{ #category : 'private' }
ExercismTestMethodGenerator >> testNameWithCounterPrefix [

	| counterPrefix |
	counterPrefix := 'test{1}_' format: { self nextTestCounter asTwoCharacterString }.
	^ (counterPrefix , self methodName) asSymbol
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testPrefix [

	^ testPrefix
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testPrefix: anObject [

	testPrefix := anObject
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testResults [

	^ self testCaseJson at: 'expected'
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testSelector [
			
	^ self testCaseJson at: 'property'
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testVariable [

	^ testVariable
]

{ #category : 'accessing' }
ExercismTestMethodGenerator >> testVariable: anObject [

	testVariable := anObject
]
