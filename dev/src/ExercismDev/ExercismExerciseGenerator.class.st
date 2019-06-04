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
		'testCounter',
		'problems'
	],
	#category : #'ExercismDev-TestGenerator'
}

{ #category : #examples }
ExercismExerciseGenerator class >> convertLegacyTagsToPackages [
	ExercismManager legacyExercismPackage classTags
		do: [ :t | t promoteAsExercismRPackage ]
]

{ #category : #examples }
ExercismExerciseGenerator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
		
	self new generateFrom: ExercismProblemSpecification all "or allNeedingGeneration ?? ask user ??"
]

{ #category : #examples }
ExercismExerciseGenerator class >> problemSpecificationsFrom: filePathReference [
	^ filePathReference entries
		collect: [ :entry | ExercismProblemSpecification newFromFileRef: entry reference ].

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
ExercismExerciseGenerator >> generateExerciseFrom: spec [
	| testMetaData testClass |
	
"	ExercismProblemSpecification newFromFileRef: aFileSystemReference.
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
"
	Transcript crShow: 'Generating ', spec classNameForTest.	
	spec hasCanonicalData ifFalse: [ ^self ].
	testClass := self generateTestClassUsing: spec.					
	"self generateTestVariableAccessors: testVariable in: testClass."
	self generateSetupOn: testClass using: spec.
	self halt. "Work in progress. Step through next method to validate."
	self generateTestMethodsOn: testClass using: spec.

	testMetaData := ''. "spec metaDataString".
	testMetaData := (WriteStream on: '') nextPutAll: testMetaData;
		nextPutAll: ('exercise: "{1}"' format: {spec mixedCaseName}); cr;
		nextPutAll: ('version: "{1}"' format: {spec version}); cr; contents.	
	self generateMetaDataFor: testClass description: spec description version: spec version metaData: testMetaData.
	
	self numberGenerated: self numberGenerated + 1.
	self log: 'successfully created' for: spec classNameForTest
	
	
		
		
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateFrom: problemSpecifications [
	(RPackageOrganizer default
		includesPackageNamed: self defaultPackageName)
			ifFalse: [ RPackageOrganizer default createPackageNamed: self defaultPackageName ].
		
	self numberGenerated: 0.
	(problemSpecifications select: #hasCanonicalData)
		do: [ :spec | self generateExerciseFrom: spec ].
		
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
ExercismExerciseGenerator >> generateSetupOn: testClass using: spec [
	| methodSource |
	
	methodSource := (WriteStream on: '').
	methodSource  
		nextPutAll: 'setUp'; cr;
		tab; nextPutAll: 'super setUp.'; cr;
		tab; nextPutAll: spec testVariable, ' := '; nextPutAll: spec classNameForSolution, ' new'.
	
	self 
		compile: methodSource contents 
		for: testClass 
		selector: #setUp 
		protocol: 'running'
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestClassUsing: spec [
	
	self resetTestCounter.
	
	^ExercismTest
		subclass: spec classNameForTest asSymbol
		instanceVariableNames: spec testVariable
		classVariableNames: ''
		poolDictionaries: ''
		package: 'ExercismWIP-', spec mixedCaseName
	
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestMethodsOn: testClass calling: testVariable using: spec prefix: aPrefixString [
	"Processes... https://github.com/exercism/problem-specifications/blob/master/canonical-schema.json"
	| groups instance methodName parameters testResult testPrefix methodNameSegment |
	
	groups := (spec tests collect: [ :test | test groupCount ]) max.
	spec tests 
		do: [ :test |
				testPrefix := 'test{1}_' format: {self nextTestCounter asTwoCharacterString}.
				self
					generateTestNamed: (testPrefix, test methodNameSegment) asSymbol 
					in: testClass
					variable: spec testVariable
					selector: test property
					parameters: test input
					expecting: test expected ]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestMethodsOn: testClass using: spec [ 
	"Processes... https://github.com/exercism/problem-specifications/blob/master/canonical-schema.json"
	| testPrefix |
	
	spec tests 
		do: [ :test |
				testPrefix := 'test{1}_' format: {self nextTestCounter asTwoCharacterString}.
				self
					generateTestNamed: (testPrefix, test methodNameSegment) asSymbol 
					in: testClass
					variable: spec testVariable
					selector: test property
					parameters: test input
					expecting: test expected ]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestNamed: testName in: aClass variable: variableName selector: aSelectorPrefix parameters: testParameters expecting: testResults [ 
	| output src |

	output := (WriteStream on: '').
	output << testName; crlf.
	testCounter = 1 ifTrue: [ output tab << '"Tip: Remember to review the class [Comment] tab"' ; crlf].
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
ExercismExerciseGenerator >> updateCategorisation [
	"utility script to fix categorisations"
	| cm |
	ExercismTest
		allSubclassesDo: [ :c | 
			cm := c class localMethodNamed: #exercise ifAbsent: [ nil ].
			cm ifNotNil: [ cm protocol: 'config']]
]

{ #category : #internal }
ExercismExerciseGenerator >> updateTests [
	"utility script to fix previously generated test methods"
	
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
