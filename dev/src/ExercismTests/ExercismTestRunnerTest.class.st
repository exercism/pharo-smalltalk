"
An ExercismTestRunnerTest is a test class for testing the behavior of ExercismTestRunner
"
Class {
	#name : #ExercismTestRunnerTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #'test-data' }
ExercismTestRunnerTest class >> mockSnapshotRunnerSolutionSTON [
^ 'MCSnapshot {
	#definitions : OrderedCollection [
		MCOrganizationDefinition {
			#categories : [
				#''Exercise@MockRunner''
			]
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethodA \r\t^ true'',
			#category : #''as yet unclassified'',
			#selector : #mockMethodA,
			#className : #MockRunner
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethodB\r\t^ false'',
			#category : #''as yet unclassified'',
			#selector : #mockMethodB,
			#className : #MockRunner
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethodC \r\tself error: \''My domain mock error.\'' '',
			#category : #''as yet unclassified'',
			#selector : #mockMethodC,
			#className : #MockRunner
		},
		MCClassDefinition {
			#name : #MockRunner,
			#superclassName : #Object,
			#variables : OrderedCollection [ ],
			#category : #''Exercise@MockRunner'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		}
	],
	#classDefinitionCache : { #MockRunner : @8 }
}'
]

{ #category : #'test-data' }
ExercismTestRunnerTest class >> mockSnapshotRunnerTestCaseSTON [
^ 'MCSnapshot {
	#definitions : OrderedCollection [
		MCOrganizationDefinition {
			#categories : [
				#''Exercise@MockRunner''
			]
		},
		MCMethodDefinition {
			#classIsMeta : true,
			#source : ''exercise\r\t^ (self createExerciseAfter: WelcomeTest)\r\t\tisCore: true;\r\t\tdifficulty: 1;\r\t\ttopics: #(\''introduction\'');\r\t\tyourself'',
			#category : #''as yet unclassified'',
			#selector : #exercise,
			#className : #MockRunnerTest
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockTestA \r\tself assert: MockRunner new mockMethodA'',
			#category : #''as yet unclassified'',
			#selector : #mockTestA,
			#className : #MockRunnerTest
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockTestB\r\tself assert: MockRunner new mockMethodB'',
			#category : #''as yet unclassified'',
			#selector : #mockTestB,
			#className : #MockRunnerTest
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockTestC \r\tself assert: MockRunner new mockMethodC'',
			#category : #''as yet unclassified'',
			#selector : #mockTestC,
			#className : #MockRunnerTest
		},
		MCClassDefinition {
			#name : #MockRunnerTest,
			#superclassName : #ExercismTest,
			#variables : OrderedCollection [ ],
			#category : #''Exercise@MockRunner'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		}
	],
	#classDefinitionCache : { #MockRunnerTest : @9 }
}'
]

{ #category : #'test-data' }
ExercismTestRunnerTest class >> prepareMockTestCaseForTestRunner [
" this is used for generating STON representation of MCSnapshot, that can be used to be loaded from file as part of TestRunner functionality"
|aClass aPackage|

	aClass := ExercismTest subclass: #MockRunnerTest
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Exercise@MockRunner'.


	aClass compile: 'mockTestA 
	self assert: MockRunner new mockMethodA'.
	aClass compile: 'mockTestB
	self assert: MockRunner new mockMethodB'.
	aClass compile: 'mockTestC 
	self assert: MockRunner new mockMethodC'.
	aClass class compile: 'exercise
	^ (self createExerciseAfter: WelcomeTest)
		isCore: true;
		difficulty: 1;
		topics: #(''introduction'');
		yourself'.
	aPackage := RPackageOrganizer default packageNamed: 'Exercise@MockRunner'.
	^ TonelWriter new toSTON: aPackage snapshot.
]

{ #category : #'test-data' }
ExercismTestRunnerTest class >> prepareMockTestSolutionForTestRunner [
" this is used for generating STON representation of MCSnapshot, that can be used to be loaded from file as part of TestRunner functionality"
|aClass |

	aClass := Object subclass: #MockRunner
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Exercise@MockRunner'.


	aClass compile: 'mockMethodA 
	^ true'.
	aClass compile: 'mockMethodB
	^ false'.
	aClass compile: 'mockMethodC 
	self error: ''My domain mock error.'' '.

	^ TonelWriter new toSTON: aClass package snapshot.
]

{ #category : #private }
ExercismTestRunnerTest >> mockRunnerSolutionSnapshot [

	^ STON fromString: self class mockSnapshotRunnerSolutionSTON
]

{ #category : #private }
ExercismTestRunnerTest >> mockRunnerTestCaseSnapshot [

	^ STON fromString: self class mockSnapshotRunnerTestCaseSTON
]

{ #category : #private }
ExercismTestRunnerTest >> prepareMockSolutionFileIn: sourceDirectoryRef [

	(TonelWriter on: sourceDirectoryRef) writeSnapshot: self mockRunnerSolutionSnapshot.
	
	"Remove the package file as its not needed for Exercism"
	(sourceDirectoryRef / 'Exercise@MockRunner' / 'package.st') delete.
	(sourceDirectoryRef / 'Exercise@MockRunner') entries do: [:entry | entry reference moveTo: sourceDirectoryRef ].
	(sourceDirectoryRef / 'Exercise@MockRunner') delete.
	
]

{ #category : #private }
ExercismTestRunnerTest >> prepareMockTestCase [

	self mockRunnerTestCaseSnapshot install.
	
]

{ #category : #running }
ExercismTestRunnerTest >> tearDown [ 
	|aPackage|
	aPackage := RPackageOrganizer default packageNamed: 'Exercise@MockRunner' ifAbsent: [nil].
	aPackage ifNotNil: [ aPackage removeFromSystem].
	super tearDown
]

{ #category : #tests }
ExercismTestRunnerTest >> testFindExercise [

	self should: [ExercismTestRunner default findExercise: 'blurb' ] raise: ExDomainError description: 'Error occurs when trying to find non existing exercise'.
	
	self assert: (ExercismTestRunner default findExercise: 'hello-world') testCase equals: HelloWorldTest. 
]

{ #category : #tests }
ExercismTestRunnerTest >> testPrepareMockSolution [
	|memRef|
	memRef := FileSystem memory root.
	self prepareMockSolutionFileIn: memRef.
	self assert: memRef entries isNotEmpty.
]

{ #category : #tests }
ExercismTestRunnerTest >> testRunTestsFor [

	self should: [ExercismTestRunner default runTestsFor: Object] raise: ExDomainError description: 'Error occurs when trying to test non existing test case'.
	
	self assert: (ExercismTestRunner default runTestsFor: HelloWorldTest) hasPassed.
]

{ #category : #tests }
ExercismTestRunnerTest >> testSetErrorToJson [

	|result|
	result := (ExercismTestRunner default setErrorToJson: 'Some error') .
	self assert: (result includesSubstring: '"message" : "Some error"').
	self assert: (result includesSubstring: '"status" : "error"').
]

{ #category : #tests }
ExercismTestRunnerTest >> testValidateDefinitions [

	|reader|
	reader := TonelReader fromExerciseDirectory: FileSystem memory root.
	reader loadDefinitions.
	self should: [ExercismTestRunner default validateDefinitions: reader definitions] raise: ExDomainError description: 'Empty source code definitions are not valid for loading exercise'.
]
