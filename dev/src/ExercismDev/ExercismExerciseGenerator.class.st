"
I am the source code generator for creating exercism compatible source files that can be checked into the exercism/pharo project for students to download.

You need to have checked out the exercism problem-specifications to point the generator to, to get the test case definitions.

To try: self generate
"
Class {
	#name : #ExercismExerciseGenerator,
	#superclass : #Object,
	#instVars : [
		'numberGenerated',
		'testCounter'
	],
	#classVars : [
		'DefaultPath'
	],
	#category : #'ExercismDev-TestGenerator'
}

{ #category : #examples }
ExercismExerciseGenerator class >> convertLegacyTagsToPackages [
	ExercismManager legacyExercismPackage classTags
		do: [ :t | t promoteAsExercismRPackage ]
]

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

{ #category : #examples }
ExercismExerciseGenerator class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: 'Generate test exercises')
		parent: #Exercism;
		order: 150.0;
		action: [ self generate ];
		"iconName: templateCommand defaultMenuIconName;"
		help: 'Generate exercises from the canonical problem-description'.
		"withSeparatorBefore"
]

{ #category : #examples }
ExercismExerciseGenerator class >> writeLegacyPackageBaselineNames [
	(ExercismManager legacyExercismPackage classTags collect: [ :t | t name ])
		asSortedCollection
		do: [ :n | 
			Transcript
				cr;
				show: '''Exercise@' , n , '''' ]
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
ExercismExerciseGenerator >> generateCodeAssertEqualsOn: output variable: variableName prefix: aSelectorPrefix parameters: testParameters result: testResults [

	output tab; nextPutAll: 'result := '.
	
	self
		generateCodeModelCallOn: output
		variable: variableName
		prefix: aSelectorPrefix
		parameters: testParameters.
	
	output 
		nextPut: $.; 
		crlf;
		tab;
		nextPutAll: 'self assert: result equals: ' , testResults storeString
]

{ #category : #generation }
ExercismExerciseGenerator >> generateCodeModelCallOn: output variable: variableName prefix: aSelectorPrefix parameters: testParameters [

	output
		nextPutAll: variableName;
		space;
		nextPutAll: aSelectorPrefix.
		
	testParameters keys
		doWithIndex: [ :key :index | 
			output
				nextPutAll:
					(index = 1
						ifTrue: [ self keywordFor: key withPrefix: aSelectorPrefix ]
						ifFalse: [ key asValidKeyword ]).
			output
				nextPut: $:;
				space.
			output
				nextPutAll: (testParameters at: key) storeString;
				space ]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateCodeShouldRaiseOn: output variable: variableName prefix: aSelectorPrefix parameters: testParameters result: testResults [

	| errorMessage |
	output
		tab;
		nextPutAll: 'self';
		crlf; tab; tab;
		nextPutAll: 'should: [ result := '.
			
	self
		generateCodeModelCallOn: output
		variable: variableName
		prefix: aSelectorPrefix
		parameters: testParameters.
		
	errorMessage := (testResults at: 'error') printString.
	
	output
		nextPutAll: ']';
		crlf; tab; tab;
		nextPutAll: 'raise: Error';
		crlf; tab; tab;
		nextPutAll: ('whoseDescriptionIncludes: {1}' format: { errorMessage });
		cr; tab; tab;
		nextPutAll: 'description: ''Should get an error with the correct description'''.
		
	
	
]

{ #category : #generation }
ExercismExerciseGenerator >> generateExerciseFrom: aFileSystemReference [
	| testName testDescription testSpecification testJson testClass testRoot testVariable testMetaData versionString |
	

	testRoot := '' join: ((aFileSystemReference basename splitOn: $-) collect: [ :w | w capitalized ]).
	testName := testRoot, 'Test'.
	testVariable := (testRoot, 'Calculator') asValidSelector asString.
	
	(aFileSystemReference fileNames includes: '.deprecated')
		ifTrue: [ ^self log: 'is deprecated (skipping)' for: testName ].

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
	| comment uuid src exerciseInfo |
	
	"testClass package classTagForClass: testRoot"
	exerciseInfo := ExercismExercise for: testClass.
	
	comment := (WriteStream on: '') 
		nextPutAll: '# ', exerciseInfo wordifiedName; cr; cr;
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
	
	self compile: src for: testClass class selector: #uuid protocol: 'config'.
	
	src := (WriteStream on: '') nextPutAll: 'version'; cr; tab; 
		nextPutAll: ('"Generated from specification: {1}"' format: {Date today}); cr; tab;
		nextPutAll: ('^''{1}''' format: {versionString}); 
		contents.
	
	self compile: src for: testClass class selector: #version protocol: 'config'
		
		
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateSetupOn: testClass using: testVariable assigning: testRoot [
	| output src |
	
	output := (WriteStream on: '').
	output nextPutAll: 'setUp'; cr.
	output tab; nextPutAll: 'super setUp.'; cr. 
	output tab; nextPutAll: testVariable, ' := '; nextPutAll: testRoot, ' new'.
	
	src := output contents.
	self compile: src for: testClass selector: #setUp protocol: 'running'
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestClass: testName tag: tagName variable: testVariable [
	
	self resetTestCounter.
	
	^ExercismTest
		subclass: testName asSymbol
		instanceVariableNames: testVariable
		classVariableNames: ''
		poolDictionaries: ''
		package: 'ExercismWIP-', tagName
	
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestMethodsOn: testClass calling: testVariable using: testJson prefix: aPrefixString [
	| instance methodName parameters testResult testPrefix methodNameSegment |
	
	(testJson at: 'cases')
		do: [ :case | 
			methodNameSegment := (((testJson at: 'cases') size > 1 ) or: [ aPrefixString notEmpty ])
				ifTrue: [ (case at: 'description') asCamelCase asValidKeyword capitalized ]
				ifFalse: [ '' ].
			methodName :=  aPrefixString 
				ifEmpty: [ methodNameSegment withoutPrefix: 'And' ] 
				ifNotEmpty: [ aPrefixString, methodNameSegment ].
				
			(case includesKey: 'cases')
				ifTrue: [ self
						generateTestMethodsOn: testClass
						calling: testVariable
						using: case
						prefix: methodName ]
				ifFalse: [ 
					instance := case at: 'property'.
					parameters := case at: 'input'.
					testResult := case at: 'expected'.
					
					testPrefix := 'test{1}_' format: {self nextTestCounter asTwoCharacterString}.
					self
						generateTestNamed: (testPrefix, methodName) asSymbol 
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
	output << testName; crlf.
	testCounter = 1 ifTrue: [ output tab << '"Review the class [Comment] tab"' ; crlf].
	output tab << '| result |'; crlf; crlf.
	
	(self isErrorAssertion: testResults) 
		ifTrue: [ self 
			generateCodeShouldRaiseOn: output
			variable: variableName
			prefix: aSelectorPrefix
			parameters: testParameters
			result: testResults ] 
		ifFalse: [ self 
			generateCodeAssertEqualsOn: output
			variable: variableName
			prefix: aSelectorPrefix
			parameters: testParameters
			result: testResults ].
	
	src := output contents.
	
	self compile: src for: aClass selector: testName protocol: 'tests'

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

{ #category : #generation }
ExercismExerciseGenerator >> isErrorAssertion: testResults [
	testResults isDictionary ifFalse: [ ^false ].
	
	^testResults size = 1 and: [ testResults includesKey: 'error' ]
]

{ #category : #generation }
ExercismExerciseGenerator >> keywordFor: key withPrefix: aSelectorPrefix [
	^(aSelectorPrefix asLowercase endsWith: key asLowercase)
		ifTrue: [ '' ]
		ifFalse: [ key capitalized ]
]

{ #category : #internal }
ExercismExerciseGenerator >> log: stringMsg for: testNameString [

	self crLog: testNameString, ' ', stringMsg
]

{ #category : #accessing }
ExercismExerciseGenerator >> nextTestCounter [

	^testCounter := testCounter + 1
]

{ #category : #accessing }
ExercismExerciseGenerator >> numberGenerated [
	^ numberGenerated
]

{ #category : #accessing }
ExercismExerciseGenerator >> numberGenerated: anObject [
	numberGenerated := anObject
]

{ #category : #accessing }
ExercismExerciseGenerator >> resetTestCounter [

	testCounter := 0
]

{ #category : #internal }
ExercismExerciseGenerator >> updateTests [
	| cm src newSrc |
	ExercismTest
		allSubclassesDo: [ :c | 
			cm := c localMethodNamed: #setUp ifAbsent: [ nil ].
			cm
				ifNotNil: [ src := cm sourceCode lines.
					newSrc := String
						streamContents: [ :s | 
							s
								nextPutAll: src first;
								cr;
								tab;
								nextPutAll: 'super setUp.'.
							src
								allButFirstDo: [ :l | 
									s
										cr;
										nextPutAll: l ] ].
					self
						compile: newSrc
						for: c
						selector: cm selector
						protocol: 'running' ] ]
]
