Extension { #name : #Mock }

{ #category : #'*ExercismMocking' }
Mock >> expect [
	"An alias for stub, but the idea is to make it more intention revealing when paired with MockExpectedMessage>>#matching: for pre-setting expectations"
	
	^self stub
]
