"
An ExercismHttpCommandTest is a test class for testing the behavior of ExercismHttpCommand
"
Class {
	#name : #ExercismHttpCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismHttpCommandTest >> testExecuteCheckingToken [
	| mockClient cmd result |
	mockClient := ExercismHttpClient asStrictMock.
	
	mockClient expect verifyToken atLeastOnce.
	
	cmd := ExercismHttpCommand client: mockClient.
	result := cmd executeCheckingToken: [ #resultOk ].
	
	Any verify.
	result should equal: #resultOk.
]

{ #category : #tests }
ExercismHttpCommandTest >> testExecuteCheckingTokenOnFailurePrompts [
	| mockClient cmd result |
	mockClient := ExercismHttpClient asStrictMock.
	
	mockClient stub verifyToken willReturn: true.
	(mockClient stub verifyToken willRaise: ExUnauthorized new) useOnce.
	
	mockClient expect promptForToken atLeastOnce willReturn: true.
	
	cmd := ExercismHttpCommand client: mockClient.
	result := cmd executeCheckingToken: [ #resultOk ].
	
	Any verify.
	result should equal: #resultOk.
]

{ #category : #tests }
ExercismHttpCommandTest >> testExecuteCheckingTokenOnFailurePromptsAndAborts [
	| mockClient cmd result |
	mockClient := ExercismHttpClient asStrictMock.
	
	mockClient stub verifyToken willRaise: ExUnauthorized new.
	
	mockClient expect promptForToken atLeastOnce willReturn: false.
	(mockClient expect promptForToken atLeastOnce willReturn: true) useOnce.
	
	cmd := ExercismHttpCommand client: mockClient.
	result := cmd executeCheckingToken: [ #resultOk ].
	
	Any verify.
	result should equal: nil.
]
