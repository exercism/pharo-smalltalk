Class {
	#name : #ExercismSubmitCommandTest,
	#superclass : #TestCase,
	#category : #ExercismTests
}

{ #category : #tests }
ExercismSubmitCommandTest >> testSubmitHelloWorldPackageWithMock [
	| exercise submitCmd mockHttpClient |
	
	mockHttpClient := Mock new.
	exercise := HelloWorldTest exercise.

	(mockHttpClient expect patchSolution: Any with: Any)
		specifying: [:solnId :formData | 
			formData keys should include: 'HelloWorld.st'.
			(formData at: 'HelloWorld.st') should includeSubstring: 'sample solution' ].
	
	submitCmd := ExercismSubmitCommand from: mockHttpClient exercise: exercise packageTag.
	
	ExercismManager submissionIdFor: exercise id ifAbsent: [ 'fakeId' ].
	submitCmd execute.
	
	mockHttpClient should verify.
	(mockHttpClient should receive patchSolution: Any with: Any) once.
	
]
