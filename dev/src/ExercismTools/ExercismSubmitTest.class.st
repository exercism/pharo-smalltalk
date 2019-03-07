Class {
	#name : #ExercismSubmitTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #running }
ExercismSubmitTest >> setUp [
	[ ExercismCommand verifyToken ] on: ExUnauthorized do: [ :error |
	 	error configureToken 
			ifTrue: [ error retry ]
			ifFalse: [ self inform: 'Aborted'. ^false ]
		].
]

{ #category : #tests }
ExercismSubmitTest >> testSubmitHelloWorldClass [
	|exercise downloadCmd|
	exercise := 'hello-world'.
	downloadCmd := ExercismDownloadCommand track: ExercismManager trackId exercise: exercise.
	downloadCmd execute.
	self assert: (ExercismSubmit class: HelloWorld) isOkay.
	
]

{ #category : #tests }
ExercismSubmitTest >> testSubmitHelloWorldPackage [
	|exercise downloadCmd|
	exercise := 'hello-world'.
	downloadCmd := ExercismDownloadCommand track: ExercismManager trackId exercise: exercise.
	downloadCmd execute.
	self assert: (ExercismSubmit exercise: exercise) isOkay.
	
]
