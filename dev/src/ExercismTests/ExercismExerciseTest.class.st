"
An ExercismExerciseTest is a test class for testing the behavior of ExercismExercise
"
Class {
	#name : 'ExercismExerciseTest',
	#superclass : 'TestCase',
	#category : 'ExercismTests-UnitTests',
	#package : 'ExercismTests',
	#tag : 'UnitTests'
}

{ #category : 'tests' }
ExercismExerciseTest >> testAppendInfoText [
	
	self assert: (HelloWorldTest exercise appendText beginsWith: 'If you are')
]

{ #category : 'tests' }
ExercismExerciseTest >> testAsJsonData [
	|testExerciseDict jsonString |
	
	testExerciseDict := TestExerciseTest exercise asJsonData.
	
	"test if can be converted to JSON string"
	jsonString := testExerciseDict asJSON.
	
	jsonString should includeSubstring: '"slug" : "test-exercise"'.
	jsonString should includeSubstring: '"name" : "Test Exercise"'.
	jsonString should includeSubstring: '"uuid"'.
	
	"test collections - if practices and prerequisites are included as part of exercice"
	self assert: ((testExerciseDict at: 'practices') includesAll: #('if-statements' 'numbers' 'operator-precedence')).
	self assert: ((testExerciseDict at: 'prerequisites') includesAll: #('if-statements' 'numbers')).   
	
	jsonString should includeSubstring: '"difficulty" : 1'.
	LeapTest exercise asJsonData asJSON should includeSubstring: '"slug" : "leap"'
]

{ #category : 'tests' }
ExercismExerciseTest >> testDefinedSolutionClasses [
	
	self assertCollection: TestExerciseTest exercise definedSolutionClasses equals: {TestExercise} asSet.
	self assertCollection: TestmanyTest exercise definedSolutionClasses equals: {Testmany. TestOtherClass. TestOtherClassTest} asSet.
	self assertCollection: TestEmptyTest exercise definedSolutionClasses equals: {} asSet.
	self assertCollection: TestExExtensionTest exercise definedSolutionClasses  equals: { TestExtension  } asSet.
]

{ #category : 'tests' }
ExercismExerciseTest >> testDescriptionText [
	
	self assert: (HelloWorldTest exercise descriptionText endsWith: 'real exercise')
]

{ #category : 'tests' }
ExercismExerciseTest >> testExerciseClass [
	
	self assert: TestExerciseTest exercise exerciseClass equals: TestExercise.	
	self assert: TestmanyTest exercise exerciseClass equals: Testmany.
	self assert: TestEmptyTest exercise exerciseClass equals: nil.
	
]

{ #category : 'test' }
ExercismExerciseTest >> testExerciseClassName [

	self assert: TestExerciseTest exercise exerciseClassName equals: TestExercise name.	
	self assert: TestmanyTest exercise exerciseClassName equals: Testmany name.
	self assert: TestEmptyTest exercise exerciseClassName equals: 'TestEmpty'.
]

{ #category : 'tests' }
ExercismExerciseTest >> testExercisePackage [
	
	self assert: TestExerciseTest exercise exercisePackage equals: TestExerciseTest package.	
	self assert: TestEmptyTest exercise exercisePackage equals: TestEmptyTest package.
	self assert: TestmanyTest exercise exercisePackage equals: TestmanyTest package.
	
]

{ #category : 'tests' }
ExercismExerciseTest >> testExercisePackageTag [
	
	self assert: TestExerciseTest exercise exercisePackageContainer class equals: RPackage.
	self assert: TestExerciseTest exercise exercisePackageContainer equals: TestExerciseTest package.	
	self assert: TestmanyTest exercise exercisePackageContainer equals: TestmanyTest package.
]

{ #category : 'tests' }
ExercismExerciseTest >> testFind [

	self assert: (ExercismExercise find: 'hello-world' ifAbsent: [nil]) equals: HelloWorldTest exercise.
	self assert: (ExercismExercise find: 'missing-exercise' ifAbsent: [ 'missing' ]) equals: 'missing'.
	self assert: (ExercismExercise find: 'missing-exercise' ifAbsent: [ :name | 'missing param' ]) equals: 'missing param' 
]

{ #category : 'tests' }
ExercismExerciseTest >> testIsDefined [
	
	self assert: TestExerciseTest exercise isDefined description: 'Should be defined'.
	self deny: TestEmptyTest exercise isDefined  description: 'Should Not be defined' 
	
]

{ #category : 'tests' }
ExercismExerciseTest >> testIsEmpty [
	
	self deny: TestExerciseTest exercise isEmpty description: 'Not empty with 1 solution'.
	self deny: TestmanyTest exercise isEmpty description: 'Not empty with many solucionts'.
	self assert: TestEmptyTest exercise isEmpty description: 'Should be empty' 
	
]

{ #category : 'tests' }
ExercismExerciseTest >> testName [
	
	self assert: TestExerciseTest exercise name equals: 'test-exercise'.
	self assert: TestmanyTest exercise name equals: 'testmany'
]

{ #category : 'tests' }
ExercismExerciseTest >> testPractiseExercisesNotEmpty [
	
	self assert: ExercismExercise practiceExercises notEmpty
]

{ #category : 'tests' }
ExercismExerciseTest >> testPractiseExercisesSorted [
	|exercises |
	exercises := ExercismExercise practiceExercises.
	
	"test if practise exercises are ordered by difficulty and then by name (within same difficulty"
	self assert: exercises first difficulty < exercises last difficulty.
	self assert: exercises first name < exercises second name.
]

{ #category : 'tests' }
ExercismExerciseTest >> testSolutionClasses [
	
	self assertCollection: TestExerciseTest exercise solutionClasses equals: {TestExercise} asSet.
	self assertCollection: TestmanyTest exercise solutionClasses equals: {Testmany. TestOtherClass. TestOtherClassTest} asSet.
	self assertCollection: TestEmptyTest exercise solutionClasses equals: {} asSet.
	
]

{ #category : 'tests' }
ExercismExerciseTest >> testSolutionId [
	
	TestExerciseTest solutionId: 'sId123'.
	self assert: TestExerciseTest exercise solutionId equals: 'sId123'. 
	TestmanyTest solutionId: 'sId456'.
	self assert: TestmanyTest exercise solutionId equals: 'sId456'.
	self assert: TestExerciseTest exercise solutionId equals: 'sId123'. 	
]

{ #category : 'tests' }
ExercismExerciseTest >> testSolutionSources [
	| sources classes classNames |
	
	sources := TestmanyTest exercise solutionSources.
	
	classes := {Testmany. TestOtherClass. TestOtherClassTest }.
	classNames := (classes collect: [ :c | ClassDescription exTonelClassFilenameFor: c name ]) copyWith: 'TestResults.txt'.
	
	self assertCollection: sources keys asSet equals: classNames asSet.
	
	(sources at: classNames last) includesSubstring: 'Tested on:'.
	(sources at: classNames first) includesSubstring: '#name : #', classes first name.
	(sources at: classNames allButLast last) includesSubstring: '#name : #', classes last name.
]

{ #category : 'tests' }
ExercismExerciseTest >> testSolutionSourcesWithExtension [
	| sources classNames |
	
	sources := TestExExtensionTest exercise solutionSources.
	
	classNames := {
        ClassDescription exTonelClassFilenameFor: #TestExtension. 
        ClassDescription exTonelExtensionFilenameFor: #String.
        'TestResults.txt' }. 
	
	self assertCollection: sources keys asSet equals: classNames asSet.
]

{ #category : 'tests' }
ExercismExerciseTest >> testStoreSolutionId [
	
	TestExerciseTest exercise storeSolutionId: 'sId123'. 
	self assert: TestExerciseTest exercise solutionId equals: 'sId123'.
	
	TestmanyTest exercise storeSolutionId: 'sId789'. 
	self assert: TestmanyTest exercise solutionId equals: 'sId789'.
	 	
]

{ #category : 'tests' }
ExercismExerciseTest >> testWordifiedName [
	
	self assert: HelloWorldTest exercise wordifiedName equals: 'Hello World'.
	self assert: LeapTest exercise wordifiedName equals: 'Leap'.
]
