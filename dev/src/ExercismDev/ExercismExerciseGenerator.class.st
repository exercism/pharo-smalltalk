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
		'exerciseDirReference',
		'testJson'
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
	
	"compiles method even with undeclared globals (solution class)"
	aClass compile: src.

	"categorize compiled method to proper protocol"
	aClass 
		addAndClassifySelector: aSelector
		withMethod: (aClass compiledMethodAt: aSelector)
		inProtocol: aName
]

{ #category : #internal }
ExercismExerciseGenerator >> defaultPackageName [
	^ 'ExercismWIP'
]

{ #category : #generation }
ExercismExerciseGenerator >> ensureCreateExerciseWIPPackage [
	
	"WIP package with exercises"
	(RPackageOrganizer default
		includesPackageNamed: self defaultPackageName)
			ifFalse: [ RPackageOrganizer default createPackageNamed: self defaultPackageName ]
]

{ #category : #accessing }
ExercismExerciseGenerator >> exerciseDirReference [

	^ exerciseDirReference
]

{ #category : #accessing }
ExercismExerciseGenerator >> exerciseDirReference: anObject [

	exerciseDirReference := anObject
]

{ #category : #internal }
ExercismExerciseGenerator >> exerciseIsDeprecated [

	^ self exerciseDirReference fileNames includes: '.deprecated'
]

{ #category : #internal }
ExercismExerciseGenerator >> exerciseTestAlreadyExists [

	^ Smalltalk hasClassNamed: self testClassName 
]

{ #category : #generation }
ExercismExerciseGenerator >> generateExerciseCommentFor: testClass [
	| comment  |
	
	comment := String streamContents: [:outStream |
		outStream 
			<< '# ' << self testNameCamelCased; cr; cr;
			<< self testDescription; cr;
			<< '## Hint'; cr; cr;
			<< 'TBD'; cr
	].
	"write comment to test class"
	testClass comment: comment.
	
]

{ #category : #generation }
ExercismExerciseGenerator >> generateExerciseFrom: aFileSystemReference [
	| testClass |
	
	"this is needed, from exercise directory all artefacts will be obtained"
	self exerciseDirReference: aFileSystemReference.
	
	self exerciseIsDeprecated 
		ifTrue: [ ^self log: 'is deprecated (skipping)' for: self testClassName  ].

	self exerciseTestAlreadyExists ifTrue: [ ^self log: 'already exists (skipping)' for: self testClassName ].

	testClass := self generateTestClass.					
	self generateSetupFor: testClass.
	self generateTestMethodsFor: testClass.
	self generateMetaDataFor: testClass.
	
	self numberGenerated: self numberGenerated + 1.
	self log: 'successfully created' for: self testClassName

		
		
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateFrom: filePathReference [
	
	"create WIP package for exercises, if missing"
	self ensureCreateExerciseWIPPackage.
	
	self traceCr: 'Generating new TestCases from specification: ', filePathReference printString.
			
	self numberGenerated: 0.
	filePathReference entries
		do: [ :entry | self generateExerciseFrom: entry reference ].
		
	self 
		traceCr: ('Generation complete. Created {1} Tests!'
			format: {self numberGenerated})
]

{ #category : #generation }
ExercismExerciseGenerator >> generateMetaDataFor: testClass [
	
	"write commment with exercise info to class"
	self generateExerciseCommentFor: testClass.
	
	"compile method with uuid"
	self generateUUIDMethodFor: testClass.
	
	"complie method with version"
	self generateVersionMethodFor: testClass
]

{ #category : #generation }
ExercismExerciseGenerator >> generateSetupFor: testClass [
	|  src |
	
	src := String streamContents: [:outStream |
		outStream 
			<< 'setUp'; cr;
			tab; << 'super setUp.'; cr; 
			tab; << self testVariableName; << ' := '; << self testNameCamelCased; << ' new'.
	].

	self compile: src for: testClass selector: #setUp protocol: 'running'
		
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestClass [

	^ ExercismTest classInstaller make: [ :builder |
		  builder
			  superclass: ExercismTest;
			  name: self testClassName asSymbol;
			  slots: self testVariableName asSlotCollection;
			  sharedVariablesFromString: '';
			  sharedPools: '';
			  tag: self testNameCamelCased;
			  package: 'ExercismWIP';
			  environment: ExercismTest environment ]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateTestMethodsFor: testClass [
	| testMethodGenerator |
	
	testMethodGenerator := ExercismTestMethodGenerator uniqueInstance.
	
	"reset counter of test methods"
	testMethodGenerator resetTestCounter.
	
	"generate tests from json specification"
	(self testJson at: 'cases')
	do: [ :testCaseJson | 
		testMethodGenerator 
			testClass: testClass;
			testCaseJson: testCaseJson;
			testVariable: self testVariableName;
			testPrefix: '';
			generateTests.
	]
]

{ #category : #generation }
ExercismExerciseGenerator >> generateUUIDMethodFor: testClass [
	| source |
	
	source := String streamContents: [:outStream |
		outStream 
			<< 'uuid'; cr; tab; 
			<< '"Answer a unique id for this exercise"'; cr; tab;
			<< ('^''{1}''' format: {self nextUUID printString}) 
	].
	
	self compile: source for: testClass class selector: #uuid protocol: 'config'
]

{ #category : #generation }
ExercismExerciseGenerator >> generateVersionMethodFor: testClass [
	| source |
	
	source := String streamContents: [:outStream  |
		outStream 
			<< 'version'; cr; tab; 
			<< ('"Generated from specification: {1}"' format: {Date today}); cr; tab;
			<< ('^''{1}''' format: {self versionString})
	].
	
	self compile: source for: testClass class selector: #version protocol: 'config'
		
]

{ #category : #initialization }
ExercismExerciseGenerator >> initialize [ 
	
	super initialize.
	"reset number of generated test classes"
	self numberGenerated: 0.
]

{ #category : #internal }
ExercismExerciseGenerator >> log: stringMsg for: testNameString [

	self traceCr: testNameString, ' ', stringMsg
]

{ #category : #generation }
ExercismExerciseGenerator >> nextUUID [
	"TODO - we need version 4 UUID"
	^ UUIDGenerator next

]

{ #category : #accessing }
ExercismExerciseGenerator >> numberGenerated [
	^ numberGenerated
]

{ #category : #accessing }
ExercismExerciseGenerator >> numberGenerated: anObject [
	numberGenerated := anObject
]

{ #category : #internal }
ExercismExerciseGenerator >> testClassName [

	^ self testNameCamelCased, 'Test'

	
]

{ #category : #internal }
ExercismExerciseGenerator >> testDescription [ 
 
	^ (self exerciseDirReference / 'description.md') contents
	
]

{ #category : #internal }
ExercismExerciseGenerator >> testJson [

	^ testJson ifNil: [
		  | testSpecification |
		  testSpecification := (self exerciseDirReference
		                        / 'canonical-data.json') contents.
		  testJson := STONJSON fromString: testSpecification ]
]

{ #category : #internal }
ExercismExerciseGenerator >> testNameCamelCased [

	"E.g. FlattenArray"
	^ self exerciseDirReference basename kebabAsCamelCase 
	
]

{ #category : #internal }
ExercismExerciseGenerator >> testVariableName [

	^ (self testNameCamelCased, 'Calculator') asValidSelector asString
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

{ #category : #internal }
ExercismExerciseGenerator >> versionString [

	^ self testJson at: 'version' ifAbsent: ['Not specified']
]
