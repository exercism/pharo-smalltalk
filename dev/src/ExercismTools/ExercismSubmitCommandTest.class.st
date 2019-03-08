Class {
	#name : #ExercismSubmitCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #running }
ExercismSubmitCommandTest >> setUp [
	[ ExercismCommand verifyToken ] on: ExUnauthorized do: [ :error |
	 	error configureToken 
			ifTrue: [ error retry ]
			ifFalse: [ self inform: 'Aborted'. ^false ]
		].
]

{ #category : #tests }
ExercismSubmitCommandTest >> testSubmitHelloWorldPackage [
	| exercise downloadCmd submitCmd |
	
	exercise := HelloWorldTest exercise.
	downloadCmd := ExercismDownloadCommand
		track: ExercismManager trackId
		exercise: exercise id.
		
	downloadCmd execute.
	
	submitCmd := ExercismSubmitCommand exercise: exercise packageTag.
	self assert: submitCmd execute.
	
]
