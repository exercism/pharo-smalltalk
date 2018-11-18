Class {
	#name : #ExercismDownloadTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #running }
ExercismDownloadTest >> setUp [
	[ ExercismCommand verifyToken ] on: ExUnauthorized do: [ :error |
	 	error configureToken 
			ifTrue: [ error retry ]
			ifFalse: [ self inform: 'Aborted'. ^false ]
		].
]

{ #category : #tests }
ExercismDownloadTest >> testExecuteDownloading [
	"Easy test for the first two steps of ExercismDownload>>execute since they don't mutate the system.
	TODO: Further test required for installing the exercise (while avoiding conflicts and cleaning up after)"
	|cmd|
	cmd := ExercismDownload new track: 'pharo' exercise: 'hello-world'.
	
   cmd getSolutionData.
	self assert: (cmd solution at: 'id' ifPresent: [true] ifAbsent: [false]).

	cmd downloadExerciseFiles.
	self assert: (cmd filesContentMap at: 'HelloWorldTest.class.st' 
		ifPresent: [:content| content includesSubstring: '#name : #HelloWorldTest'] 
		ifAbsent: [false]).
		
]
