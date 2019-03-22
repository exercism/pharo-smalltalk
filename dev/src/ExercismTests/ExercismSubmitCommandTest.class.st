Class {
	#name : #ExercismSubmitCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismSubmitCommandTest >> testSubmitHelloWorldPackageWithMock [
	| submitCmd mockHttpClient mockExercise |
	
	Any strictMocks: true.
	mockHttpClient := ExercismHttpClient asMock.
	mockExercise := ExercismExercise asMock.
	
	(mockExercise expect verifySolutionForSubmission) atLeastOnce.
	(mockExercise expect solutionId) atLeastOnce willReturn: 'submission12'.
	(mockExercise expect solutionSources) willReturn: 
		{ 'HelloWorld.st'->'HelloWorld content'. 'TwoFer.st'->'twofer content'} asDictionary.
	
	mockHttpClient expect verifyToken atLeastOnce.
	(mockHttpClient expect patchSolution: Any with: Any)
		specifying: [:solnId :formData | 
			formData keys should equal: {'HelloWorld.st'. 'TwoFer.st' } asSet.
			(formData at: 'HelloWorld.st') should includeSubstring: 'HelloWorld content'.
			(formData at: 'TwoFer.st') should includeSubstring: 'TwoFer content' ].
	
	submitCmd := ExercismSubmitCommand from: mockHttpClient exercise: mockExercise.
	
	submitCmd execute.
	
	Any verify.

	
]
