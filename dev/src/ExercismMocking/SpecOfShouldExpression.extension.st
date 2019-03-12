Extension { #name : #SpecOfShouldExpression }

{ #category : #'*ExercismMocking' }
SpecOfShouldExpression >> verify [
	"Experimental (and not working) extension to verify a mock so you don't have to repeat all the expection methods with a should be called construct"
	
	| msgs cm cmb |
	msgs := receiver currentMockBehaviour expectedMessages.
	cmb := receiver currentMockBehaviour.
	cm := receiver currentMockBehaviour createMockToValidate: receiver withNegation: withNegation.
	
	msgs do: [ :m |
		cmb send: (Message selector: m spec messageSend selector requiredValue) to: receiver ]
]
