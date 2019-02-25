Class {
	#name : #ExercismExerciseGenerator,
	#superclass : #Object,
	#instVars : [
		'numberGenerated'
	],
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

{ #category : #internal }
ExercismExerciseGenerator >> compile: src for: aClass selector: aSelector protocol: aName [
	| cm aContext |
	
	"aClass compile: src classified: (Protocol name: 'setup') notifying: self."
	
	aContext := CompilationContext new 
		interactive: false; 
		"forSyntaxHighlighting: true;"
		"logged: false;"
		yourself.
	
	cm := OpalCompiler new 
					compilationContext: aContext;
					options: #( + #optionEmbeddSources );				
					class: aClass;
					compile: src.
			
	aClass 
		addAndClassifySelector: aSelector
		withMethod: cm
		inProtocol: aName
]

{ #category : #accessing }
ExercismExerciseGenerator >> defaultPackageName [
	^ 'ExercismWIP'
]

{ #category : #generation }
ExercismExerciseGenerator >> generateExerciseFrom: aFileSystemReference [
	| testName testDescription testSpecification testJson testClass testRoot testVariable testMetaData versionString |
	

	testRoot := '' join: ((aFileSystemReference basename splitOn: $-) collect: [ :w | w capitalized ]).
	testName := testRoot, 'Test'.
	testVariable := (testRoot, 'Calculator') asValidSelector asString.
	
	(aFileSystemReference fileNames includes: '.deprecated')
		ifTrue: [ self log: 'is deprecated (skipping)' for: testName ].

	(Smalltalk hasClassNamed: testName) ifTrue: [ ^self log: 'already exists (skipping)' for: testName ].
	
	testDescription := (aFileSystemReference / 'description.md') contents.
	testMetaData := (aFileSystemReference / 'metadata.yml') contents.
	testSpecification := [ (aFileSystemReference / 'canonical-data.json') contents] 
		on: FileDoesNotExistException do: [ ^self log:'has no specification (skipping)' for: testName ].
		
	testJson := STONJSON fromString: testSpecification.
	versionString := testJson at: 'version'.
	
	testMetaData := (WriteStream on: '') nextPutAll: testMetaData;
		nextPutAll: ('exercise: "{1}"' format: {testRoot}); cr;
		nextPutAll: ('version: "{1}"' format: {versionString}); cr; contents.

	testClass := self generateTestClass: testName tag: testRoot variable: testVariable.						
	"self generateTestVariableAccessors: testVariable in: testClass."
	self generateSetupOn: testClass using: testVariable assigning: testRoot.
	self generateTestMethodsOn: testClass calling: testVariable using: testJson prefix: ''.
	self generateMetaDataFor: testClass description: testDescription version: versionString metaData: testMetaData.
	
	self numberGenerated: self numberGenerated + 1.
	self log: 'successfully created' for: testName
	
	
		
		
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateFrom: filePathReference [
	(RPackageOrganizer default
		includesPackageNamed: self defaultPackageName)
			ifFalse: [ RPackageOrganizer default createPackageNamed: self defaultPackageName ].
		
	self crLog: 'Generating new TestCases from specification: ', filePathReference printString.
			
	self numberGenerated: 0.
	filePathReference entries
		do: [ :entry | self generateExerciseFrom: entry reference ].
		
	self 
		crLog: ('Generation complete. Created {1} Tests!'
			format: {self numberGenerated})
]

{ #category : #generation }
ExercismExerciseGenerator >> generateMetaDataFor: testClass description: testDescription version: versionString metaData: testMetaData [
	| comment uuid src |
	
	"testClass package classTagForClass: testRoot"
	
	comment := (WriteStream on: '') 
		nextPutAll: '# ', testClass  wordifiedName; cr; cr;
		nextPutAll: testDescription; cr;
		nextPutAll: '## Hint'; cr; cr;
		nextPutAll: 'TBD'; cr;
		contents.
	
	testClass comment: comment.
	
	uuid := UUIDGenerator next.
	src := (WriteStream on: '') nextPutAll: 'uuid'; cr; tab; 
		nextPutAll: '"Answer a unique id for this exercise"'; cr; tab;
		nextPutAll: ('^''{1}''' format: {uuid printString}); 
		contents.
	
	self compile: src for: testClass class selector: #uuid protocol: 'meta'.
	
	src := (WriteStream on: '') nextPutAll: 'version'; cr; tab; 
		nextPutAll: ('"Generated from specification: {1}"' format: {Date today}); cr; tab;
		nextPutAll: ('^''{1}''' format: {versionString}); 
		contents.
	
	self compile: src for: testClass class selector: #version protocol: 'meta'
		
		
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateSetupOn: testClass using: testVariable assigning: testRoot [
	| output src |
	
	output := (WriteStream on: '').
	output nextPutAll: 'setUp'; crlf.
	output tab; nextPutAll: testVariable, ' := '; nextPutAll: testRoot, ' new'.
	
	src := output contents.
	self compile: src for: testClass selector: #setUp protocol: 'setup'
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestClass: testName tag: tagName variable: testVariable [
	
	^ExercismTest
		subclass: testName asSymbol
		instanceVariableNames: testVariable
		classVariableNames: ''
		poolDictionaries: ''
		package: 'ExercismWIP-', tagName
	
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestMethodsOn: testClass calling: testVariable using: testJson prefix: aPrefixString [
	| instance methodName parameters testResult |
	
	(testJson at: 'cases')
		do: [ :case | 
			methodName := ((aPrefixString
				ifEmpty: [ 'test' ]) , (case at: 'description') asCamelCase capitalized)
				asValidSelector.
				
			(case includesKey: 'cases')
				ifTrue: [ 
					self
						generateTestMethodsOn: testClass
						calling: testVariable
						using: case
						prefix: methodName ]
				ifFalse: [ 
					instance := case at: 'property'.
					parameters := case at: 'input'.
					testResult := case at: 'expected'.
					self
						generateTestNamed: methodName
						in: testClass
						variable: testVariable
						selector: instance
						parameters: parameters
						expecting: testResult ] ]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestNamed: testName in: aClass variable: variableName selector: aSelectorPrefix parameters: testParameters expecting: testResults [ 
	| output src |
	output := (WriteStream on: '').
	output nextPutAll: testName; crlf; tab; nextPutAll: '| result |'; crlf; crlf.
	output tab; nextPutAll: 'result := '; nextPutAll: variableName; space; nextPutAll: aSelectorPrefix.
	
	testParameters keys doWithIndex: [ :key :index |
		output nextPutAll: (index = 1 ifTrue: [ key capitalized ] ifFalse: [key asValidKeywordName]).
		output nextPut: $:; space.
		output nextPutAll: (testParameters at: key) storeString; space ].
	
	output nextPut: $.; crlf; tab; nextPutAll: 'self assert: result equals: ', testResults storeString.
	src := output contents.
	
	self compile: src for: aClass selector: testName protocol: 'test'

]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestVariableAccessors: testVariable in: aClass [
	| aRefactoring |
	
	aRefactoring := RBCreateAccessorsForVariableRefactoring
		variable: testVariable 
		class: aClass
		classVariable: false.
	aRefactoring execute.
	
]

{ #category : #internal }
ExercismExerciseGenerator >> log: stringMsg for: testNameString [

	self crLog: testNameString, ' ', stringMsg
]

{ #category : #accessing }
ExercismExerciseGenerator >> numberGenerated [
	^ numberGenerated
]

{ #category : #accessing }
ExercismExerciseGenerator >> numberGenerated: anObject [
	numberGenerated := anObject
]
