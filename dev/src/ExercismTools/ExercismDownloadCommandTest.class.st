Class {
	#name : #ExercismDownloadCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #running }
ExercismDownloadCommandTest >> setUp [
	[ ExercismCommand verifyToken ] on: ExUnauthorized do: [ :error |
	 	error configureToken 
			ifTrue: [ error retry ]
			ifFalse: [ self inform: 'Aborted'. ^false ]
		].
]

{ #category : #tests }
ExercismDownloadCommandTest >> testExecuteDownloading [
	"Easy test for the first two steps of ExercismDownload>>execute since they don't mutate the system.
	TODO: Further test required for installing the exercise (while avoiding conflicts and cleaning up after)"

	| cmd client downloadResult sourceCode |
	cmd := ExercismDownloadCommand
		from: client
		track: 'pharo'
		exercise: 'hello-world'.
		
	downloadResult := cmd execute.
	
	self assert: downloadResult notNil description: 'Get a result'.
	self assert: (downloadResult id notNil).
	
	self assert: (downloadResult includes: 'HelloWorldTest.class.st').
	sourceCode := downloadResult contentsFor: 'HelloWorldTest.class.st'.
	self assert: sourceCode notEmpty.
	self assert: (sourceCode includesSubstring: '#name : #HelloWorldTest').
		
]
