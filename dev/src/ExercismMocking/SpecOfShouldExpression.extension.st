Extension { #name : #SpecOfShouldExpression }

{ #category : #'*ExercismMocking' }
SpecOfShouldExpression >> verify [
	"Verify the current mock, and ensure all of its expectations have been met. This eases the burdon on having to make a series of 'should receive' calls, however some may still be needed (in addition) for more complicated assertions."
	
	| expectedMessages occurredMessages missingMessages errorMsg selectors |
	
	<todo: 'need to handle occured msgs and ensure they occurred properly'>
	
	expectedMessages := (receiver currentMockBehaviour expectedMessages) 
			select: [:m | m asExpectedMessageSpec messageSend receiver basicMatches: receiver].
	occurredMessages := receiver currentMockBehaviour occurredMessages.
	
	missingMessages := expectedMessages
		collect: [ :m | m asExpectedMessageSpec ]
		thenReject: [ :m | m basicMatches: occurredMessages ].
		
	missingMessages ifEmpty: [ ^self ].
		
	selectors := missingMessages
		collect: [ :msg | msg messageSend selector asSimpleValue asSymbol ].
		
	errorMsg := String
		streamContents: [ :stream | 
			stream << receiver ghostPrintString
				<< ' failed to satisfy expectations on: '.
			selectors
				allButLastDo: [ :s | 
					stream
						print: s;
						nextPutAll: ', ' ].
			stream print: selectors last ].
		
	MockExpectationFailure signal: errorMsg
]
