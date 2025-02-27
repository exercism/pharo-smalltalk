Extension { #name : 'BlockClosure' }

{ #category : '*ExercismMocking' }
BlockClosure >> runWithMockSetup: preEvaluationBlock [
	"Evaluate the preEvaluationBlock (which normally contains mocks with expectations) before evaluating the reciever. Useful for mock testing so you can see/read the object under test code first"
	
	preEvaluationBlock value.
	self value.
	Any verify.
]
