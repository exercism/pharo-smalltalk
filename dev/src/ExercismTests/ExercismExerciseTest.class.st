"
An ExercismExerciseTest is a test class for testing the behavior of ExercismExercise
"
Class {
	#name : #ExercismExerciseTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismExerciseTest >> testAsJsonData [
	
	TestExerciseTest exercise asJsonData should beKindOf: Collection.
	TestExerciseTest exercise asJsonData asJSON should includeSubstring: '"slug" : "test-exercise"'.
	LeapTest exercise asJsonData asJSON should includeSubstring: '"slug" : "leap"'
]

{ #category : #tests }
ExercismExerciseTest >> testBonusExercises [
	
	self assert: ExercismExercise bonusExercises notEmpty 
	
	
]

{ #category : #tests }
ExercismExerciseTest >> testCoreExercises [
	
	self assert: ExercismExercise coreExercises notEmpty 	
	
	
]

{ #category : #tests }
ExercismExerciseTest >> testDescriptionText [
	
	self assert: (HelloWorldTest exercise descriptionText endsWith: 'real exercise')
]

{ #category : #tests }
ExercismExerciseTest >> testExerciseClass [
	
	self assert: TestExerciseTest exercise exerciseClass equals: TestExercise.	
	self assert: TestmanyTest exercise exerciseClass equals: Testmany.
	self assert: TestEmptyTest exercise exerciseClass equals: nil.
	
]

{ #category : #test }
ExercismExerciseTest >> testExerciseClassName [

	self assert: TestExerciseTest exercise exerciseClassName equals: TestExercise name.	
	self assert: TestmanyTest exercise exerciseClassName equals: Testmany name.
	self assert: TestEmptyTest exercise exerciseClassName equals: 'TestEmpty'.
]

{ #category : #tests }
ExercismExerciseTest >> testExercisePackage [
	
	self assert: TestExerciseTest exercise exercisePackage equals: TestExerciseTest package.	
	self assert: TestEmptyTest exercise exercisePackage equals: TestEmptyTest package.
	self assert: TestmanyTest exercise exercisePackage equals: TestmanyTest package.
	
]

{ #category : #tests }
ExercismExerciseTest >> testExercisePackageTag [
	
	self assert: TestExerciseTest exercise exercisePackageContainer class equals: RPackage.
	self assert: TestExerciseTest exercise exercisePackageContainer equals: TestExerciseTest package.	
	self assert: TestmanyTest exercise exercisePackageContainer equals: TestmanyTest package.
]

{ #category : #tests }
ExercismExerciseTest >> testFind [

	self assert: (ExercismExercise find: 'hello-world' ifAbsent: [nil]) equals: HelloWorldTest exercise.
	self assert: (ExercismExercise find: 'missing-exercise' ifAbsent: [ 'missing' ]) equals: 'missing'.
	self assert: (ExercismExercise find: 'missing-exercise' ifAbsent: [ :name | 'missing param' ]) equals: 'missing param' 
]

{ #category : #tests }
ExercismExerciseTest >> testFollowedBy [

	self assert: [(HelloWorldTest exercise) isFollowedBy: TwoFerTest exercise].
	self deny: [(HammingTest exercise) isFollowedBy: HelloWorldTest exercise].
]

{ #category : #tests }
ExercismExerciseTest >> testHintText [
	
	self assert: (HelloWorldTest exercise hintText beginsWith: 'If you are')
]

{ #category : #tests }
ExercismExerciseTest >> testIsDefined [
	
	self assert: TestExerciseTest exercise isDefined description: 'Should be defined'.
	self deny: TestEmptyTest exercise isDefined  description: 'Should Not be defined' 
	
]

{ #category : #tests }
ExercismExerciseTest >> testIsEmpty [
	
	self deny: TestExerciseTest exercise isEmpty description: 'Not empty with 1 solution'.
	self deny: TestmanyTest exercise isEmpty description: 'Not empty with many solucionts'.
	self assert: TestEmptyTest exercise isEmpty description: 'Should be empty' 
	
]

{ #category : #tests }
ExercismExerciseTest >> testIsFollowedBy [
	
	self assert: (HelloWorldTest exercise isFollowedBy: LeapTest exercise) description: 'Leap should follow HelloWorld'.
	
	self deny: (HelloWorldTest exercise isFollowedBy: HelloWorldTest exercise) description: 'HelloWorld should not follow itself (root)'.
	self deny: (LeapTest exercise isFollowedBy: LeapTest exercise) description: 'Leap should not follow itself (non-root)'.
	self deny: (LeapTest exercise isFollowedBy: HelloWorldTest exercise) description: 'HelloWorld should not follow Leap'.
]

{ #category : #tests }
ExercismExerciseTest >> testIsUnlockedBy [

	self assert: (TwoFerTest exercise isUnlockedBy: HelloWorldTest  exercise).
	self deny: [ TwoFerTest exercise isUnlockedBy: LeapTest exercise ]
]

{ #category : #tests }
ExercismExerciseTest >> testName [
	
	self assert: TestExerciseTest exercise name equals: 'test-exercise'.
	self assert: TestmanyTest exercise name equals: 'testmany'
]

{ #category : #tests }
ExercismExerciseTest >> testSolutionClasses [
	
	self assertCollection: TestExerciseTest exercise solutionClasses equals: {TestExercise} asSet.
	self assertCollection: TestmanyTest exercise solutionClasses equals: {Testmany. TestOtherClass. TestOtherClassTest} asSet.
	self assertCollection: TestEmptyTest exercise solutionClasses equals: {} asSet.
	
]

{ #category : #tests }
ExercismExerciseTest >> testSolutionId [
	
	TestExerciseTest solutionId: 'sId123'.
	self assert: TestExerciseTest exercise solutionId equals: 'sId123'. 
	TestmanyTest solutionId: 'sId456'.
	self assert: TestmanyTest exercise solutionId equals: 'sId456'.
	self assert: TestExerciseTest exercise solutionId equals: 'sId123'. 	
]

{ #category : #tests }
ExercismExerciseTest >> testSolutionSources [
	| sources classes classNames |
	
	sources := TestmanyTest exercise solutionSources.
	
	classes := {Testmany. TestOtherClass. TestOtherClassTest }.
	classNames := (classes collect: [ :c | ClassDescription exTonelClassFilenameFor: c name ]) copyWith: 'TestResults.txt'.
	
	self assertCollection: sources keys asSet equals: classNames asSet.
	
	(sources at: classNames last) should includeSubstring: 'Tested on:'.
	(sources at: classNames first) should includeSubstring: '#name : #', classes first name.
	(sources at: classNames allButLast last) should includeSubstring: '#name : #', classes last name.
]

{ #category : #tests }
ExercismExerciseTest >> testSolutionSourcesWithExtension [
	| sources classNames |
	
	sources := TestExExtensionTest exercise solutionSources.
	
	classNames := {
        ClassDescription exTonelClassFilenameFor: #TestExtension. 
        ClassDescription exTonelExtensionFilenameFor: #String.
        'TestResults.txt' }. 
	
	self assertCollection: sources keys asSet equals: classNames asSet.
]

{ #category : #tests }
ExercismExerciseTest >> testStoreSolutionId [
	
	TestExerciseTest exercise storeSolutionId: 'sId123'. 
	self assert: TestExerciseTest exercise solutionId equals: 'sId123'.
	
	TestmanyTest exercise storeSolutionId: 'sId789'. 
	self assert: TestmanyTest exercise solutionId equals: 'sId789'.
	 	
]

{ #category : #tests }
ExercismExerciseTest >> testUnlockReference [
	
	self assert: HelloWorldTest exercise unlockReference equals: nil.
	self assert: LeapTest exercise unlockReference equals: nil.
	self assert: SpaceAgeTest exercise unlockReference equals: TwoFerTest exercise name.
	
	
]

{ #category : #tests }
ExercismExerciseTest >> testUnlockedExercises [
	
	self assertCollection: HelloWorldTest exercise unlockedExercises asArray equals: {} .
	self assertCollection: TwoFerTest exercise unlockedExercises asArray 
				includesAll: {ResistorColorDuoTest exercise. SpaceAgeTest exercise}.
]

{ #category : #tests }
ExercismExerciseTest >> testWordifiedName [
	
	self assert: HelloWorldTest exercise wordifiedName equals: 'Hello World'.
	self assert: LeapTest exercise wordifiedName equals: 'Leap'.
]
