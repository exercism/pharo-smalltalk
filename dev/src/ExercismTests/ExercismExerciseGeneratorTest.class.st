"
An ExercismExerciseGeneratorTest is a test class for testing the behavior of ExercismExerciseGenerator
"
Class {
	#name : 'ExercismExerciseGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ExercismTests-UnitTests',
	#package : 'ExercismTests',
	#tag : 'UnitTests'
}

{ #category : 'setup' }
ExercismExerciseGeneratorTest >> canonicalTestSampleJson [
^ 
'{
    "exercise": "mock-exercise",
    "comments": [],
    "cases": [
      {
        "description": "parsing and numbers",
        "cases": [
          {
            "uuid": "9962203f-f00a-4a85-b404-8a8ecbcec09d",
            "description": "numbers just get pushed onto the stack",
            "property": "evaluate",
            "input": {
              "instructions": ["1 2 3 4 5"]
            },
            "expected": [1, 2, 3, 4, 5]
          }
        ]
      },
      {
        "description": "addition",
        "cases": [
          {
            "uuid": "9e69588e-a3d8-41a3-a371-ea02206c1e6e",
            "description": "can add two numbers",
            "property": "evaluate",
            "input": {
              "instructions": ["1 2 +"]
            },
            "expected": [3]
          },
          {
            "uuid": "52336dd3-30da-4e5c-8523-bdf9a3427657",
            "description": "errors if there is nothing on the stack",
            "property": "evaluate",
            "input": {
              "instructions": ["+"]
            },
            "expected": {
              "error": "empty stack"
            }
          }
        ]
      }
    ]
}
'
]

{ #category : 'setup' }
ExercismExerciseGeneratorTest >> createMockExerciseDirectory [
	|memFileRef exerciseDir |
	memFileRef := FileSystem memory root.
	exerciseDir := (memFileRef / 'mock-exercise') ensureCreateDirectory.
	
	"exercise description"
	(exerciseDir / 'description.md')
		ensureCreateFile;
		writeStreamDo: [:aStream |
			aStream << (String loremIpsum: 100).
			aStream cr.
		].
	"canonical test cases"
	(exerciseDir / 'canonical-data.json')
		ensureCreateFile;
		writeStreamDo: [:aStream |
			aStream << self canonicalTestSampleJson 
		].
	^ exerciseDir  
]

{ #category : 'setup' }
ExercismExerciseGeneratorTest >> mockClassName [

	^ ('mock-exercise' kebabAsCamelCase, 'Test') asSymbol
]

{ #category : 'running' }
ExercismExerciseGeneratorTest >> tearDown [
	"remove mock class if exists"
 	(self class environment hasClassNamed: self mockClassName) ifTrue: [ 
			(self class environment at: self mockClassName) removeFromSystem 
	].
	super tearDown
]

{ #category : 'tests' }
ExercismExerciseGeneratorTest >> testAsValidKeywordOnString [

	self assert: '1Direction' asValidKeyword equals: 'and1Direction'.
	self assert: '1' asValidKeyword equals: 'at1'.
	self assert: 'is < 5' asValidKeyword equals: 'isLessThan5'.
	self assert: 'is > 15' asValidKeyword equals: 'isGreaterThan15'.
	self assert: 'is = 5' asValidKeyword equals: 'isEquals5'.
	self assert: 'is <= 5' asValidKeyword equals: 'isLessThanOrEqualTo5'
]

{ #category : 'tests' }
ExercismExerciseGeneratorTest >> testExerciseVariableName [
	|generator|
	"set directory reference with canonical description with tests of given exercise"
	generator := ExercismExerciseGenerator new exerciseDirReference: 
		self createMockExerciseDirectory.
	
	self assert: generator exerciseVariableName equals: 'mockExercise'.
]

{ #category : 'tests' }
ExercismExerciseGeneratorTest >> testGenerateExerciseFrom [
	|aPackage aClass testSelectors classSelectors|
	"run generator"
	ExercismExerciseGenerator new generateExerciseFrom: self createMockExerciseDirectory.
	
	"verify if mock test class exists with all test cases, methods and comment"
	
	aPackage := (RPackageOrganizer default
		packageNamed: 'ExercismWIP').
	"test mock class should exist in package"
	self assert: (aPackage includesClassNamed: self mockClassName).
	
	aClass := aPackage classes detect: [:definedClass | definedClass name = self mockClassName ].
	self assert: aClass comment isNotEmpty.
	
	"3 test cases should be defined"
	testSelectors := aClass selectors select: [:selector | selector beginsWith: 'test'].
	self assert: testSelectors size equals: 3.
	self assert: (aClass includesSelector: #setUp).
	
	testSelectors do: [:aSelector |
		|method| 
		method := aClass compiledMethodAt: aSelector.
		"verify pragmas"
		self assert: (method hasPragmaNamed: #exeTestName:).
		self assert: (method hasPragmaNamed: #exeTestUUID:).
		"verify assertion or exception handle is included"
		self assert: (#('assert:' 'should:') anySatisfy: [:assertSelector | method sourceCode includesSubstring: assertSelector ] ).
	].
	classSelectors := aClass class selectors.
	self assert: (classSelectors includes: #version).
	self assert: (classSelectors includes: #uuid).
	

	
]

{ #category : 'tests' }
ExercismExerciseGeneratorTest >> testHasValidTestDecriptions [
	|generator|
	"set directory reference with canonical description with tests of given exercise"
	generator := ExercismExerciseGenerator new exerciseDirReference: 
		self createMockExerciseDirectory.
	
	self assert: generator hasValidTestDecriptions.
	
	"now remove test descriptions"
	(generator exerciseDirReference / 'canonical-data.json') ensureDelete.
	self deny: generator hasValidTestDecriptions.
]

{ #category : 'tests' }
ExercismExerciseGeneratorTest >> testPackageNameForTestClass [
	|generator|
	"set directory reference with canonical description with tests of given exercise"
	generator := ExercismExerciseGenerator new exerciseDirReference: 
		self createMockExerciseDirectory.
	
	"for new exercises, package should be set to work-in-progress"
	generator regenerateExisting: false.
	self assert: generator packageNameForTestClass  equals: 'ExercismWIP'.
	
	"for existing exercises with solution already, it should be exercise package"
	generator regenerateExisting: true.
	self assert: generator packageNameForTestClass  equals: 'Exercise@MockExercise'.
]

{ #category : 'tests' }
ExercismExerciseGeneratorTest >> testSetupAppendInfoFromExistingTestClass [

	|generator|
	generator := ExercismExerciseGenerator new exerciseDirReference: 'two-fer' asFileReference.
	generator setupAppendInfoFromExistingTestClass.
	self deny: generator existingAppendInfo equals: 'TBD'.
	
	generator exerciseDirReference: 'mock-exercise' asFileReference.
	generator setupAppendInfoFromExistingTestClass.
	self assert: generator existingAppendInfo equals: 'TBD'.
]
