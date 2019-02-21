Class {
	#name : #ExercismExerciseGenerator,
	#superclass : #Object,
	#classVars : [
		'DefaultPath'
	],
	#category : #'ExercismDev-TestGenerator'
}

{ #category : #examples }
ExercismExerciseGenerator class >> defaultPath [
	^ DefaultPath ifNil: [ self defaultPath: FileLocator home pathString]
]

{ #category : #examples }
ExercismExerciseGenerator class >> defaultPath: pathString [
	^ DefaultPath := pathString
]

{ #category : #examples }
ExercismExerciseGenerator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
	| path |
	path := UIManager default
		chooseDirectory: 'Select the /exercises location in a full Exercism/problem-specifications git project'
		path: self defaultPath.
		
	path ifNotNil: [ self new generateFrom: (self defaultPath: path) ]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateExerciseFrom: aFileSystemReference [
	| testName testComment testDescription testJson testClass testRoot |
	
	(aFileSystemReference fileNames includes: '.deprecated')
		ifTrue: [ ^ self ].

	testRoot := '' join: ((aFileSystemReference basename splitOn: $-) collect: [ :w | w capitalized ]).
	testName := testRoot, 'Test'.
	(Smalltalk hasClassNamed: testName) ifTrue: [ ^self ].
	
	testComment := (aFileSystemReference / 'description.md') contents.
	testDescription :=  (aFileSystemReference / 'canonical-data.json') contents.
	testJson := STONJSON fromString: testDescription.
	

	testClass := TestCase  
					subclass: testName asSymbol
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					package: 'Exercism-', testRoot.
					
	self generateTestMethodsOn: testClass using: testJson
	
	
		
		
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateFrom: filePathReference [
	
	filePathReference entries do: [ :entry |
		self generateExerciseFrom: entry reference ] 

]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestMethodsOn: testClass using: testJson [

	| instance testMethod parameters testResult |
	(testJson at: 'cases') do: [ :case |
		instance := case at: 'property'.
		testMethod := 'test', (case at: 'description') asCamelCase.
		parameters := case at: 'input'.
		testResult := case at: 'expected'.
		
		self generatedTest: testMethod in: testClass calling: instance using: parameters expecting: testResult ].
	
	
		
		
		
]

{ #category : #'as yet unclassified' }
ExercismExerciseGenerator >> generatedTest: aString in: aClass calling: aSelector using: testParameters expecting: testResults [ 
	| output src |
	output := (WriteStream on: '').
	output nextPutAll: aString; crlf; tab; nextPutAll: '| result |'; crlf; crlf.
	output tab; nextPutAll: 'result := '; nextPutAll: aSelector; space.
	
	testParameters keysAndValuesDo: [  :key :value |
		output nextPutAll: key; nextPut: $:; space.
		output nextPutAll: value printString; space ].
	
	output nextPut: $.; crlf; tab; nextPutAll: 'self assert: result equals: ', testResults printString.
	src := output contents.
	aClass compile: src.
]

{ #category : #'as yet unclassified' }
ExercismExerciseGenerator >> generatedTest: aString in: aClass using: aCollection expecting: aCollection4 [ 
	self shouldBeImplemented.
]
