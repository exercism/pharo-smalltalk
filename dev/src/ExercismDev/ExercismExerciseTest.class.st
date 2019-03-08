"
An ExercismExerciseTest is a test class for testing the behavior of ExercismExercise
"
Class {
	#name : #ExercismExerciseTest,
	#superclass : #TestCase,
	#category : #'ExercismDev-Tests'
}

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
ExercismExerciseTest >> testIsUnlockedBy [

	self assert: (TwoFerTest exercise isUnlockedBy: HelloWorldTest  exercise).
	self deny: [ TwoFerTest exercise isUnlockedBy: LeapTest exercise ]
]

{ #category : #tests }
ExercismExerciseTest >> testName [
	
	self assert: HelloWorldTest exercise name equals: 'hello-world'.
	self assert: LeapTest exercise name equals: 'leap'
]

{ #category : #tests }
ExercismExerciseTest >> testPackageTag [
	
	self assert: HelloWorldTest exercise packageTag class equals: RPackageTag.
	self assert: HelloWorldTest exercise packageTag name equals: #HelloWorld.	
]

{ #category : #tests }
ExercismExerciseTest >> testSolutionClass [
	
	self assert: HelloWorldTest exercise solutionClass  equals: HelloWorld.
	
]

{ #category : #tests }
ExercismExerciseTest >> testWordifiedName [
	
	self assert: HelloWorldTest exercise wordifiedName equals: 'Hello World'.
	self assert: LeapTest exercise wordifiedName equals: 'Leap'.
]
