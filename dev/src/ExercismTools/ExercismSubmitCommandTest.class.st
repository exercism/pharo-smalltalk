Class {
	#name : #ExercismSubmitCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
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
	submitCmd execute.
	
	mockHttpClient should verify.
	(mockHttpClient should receive patchSolution: Any with: Any) once.
	
]
