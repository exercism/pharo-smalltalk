Class {
	#name : #ExercismSubmitTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #running }
ExercismSubmitTest >> setUp [
	ExercismCommand verifyToken 
]

{ #category : #tests }
ExercismSubmitTest >> testSubmitHelloWorldClass [
	|exercise downloadCmd|
	exercise := 'hello-world'.
	downloadCmd := ExercismDownload new track: 'pharo' exercise: exercise.
	downloadCmd getSolutionData.
	self assert: (ExercismSubmit class: HelloWorld) isOkay.
	
]

{ #category : #tests }
ExercismSubmitTest >> testSubmitHelloWorldPackage [
	|exercise downloadCmd|
	exercise := 'hello-world'.
	downloadCmd := ExercismDownload new track: 'pharo' exercise: exercise.
	downloadCmd getSolutionData.
	self assert: (ExercismSubmit exercise: exercise) isOkay.
	
]
