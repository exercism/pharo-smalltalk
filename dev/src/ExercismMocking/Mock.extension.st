Extension { #name : #Mock }

{ #category : #'*ExercismMocking' }
Mock >> expect [
	"An alias for stub, but the idea is to make it more intention revealing when paired with MockExpectedMessage>>#matching: for pre-setting expectations"
	
	^self stub
]

{ #category : #'*ExercismMocking' }
Mock class >> named: aName strict: aBoolean [
	"Answer a new 'strict' mock, and named (normally after the class it represents)"
	
	^(self strict: aBoolean) mockName: aName
]

{ #category : #'*ExercismMocking' }
Mock class >> strict: aBoolean [
	"Answer a new strict/loose mock, and if strict (aBoolean =true) cause it to fail when called without a previously specified stub/expectation"
	
	| result |
	
	result := self new.
	aBoolean
		ifTrue: [ result stub anyMessage
						specifying: [ 
							"|spec| spec := SpecOfBooleanProperty fromMessage: 'Strict mock received un-mocked call'.
							(SpecOfValidationFailure spec: spec for: result) raise."
							SpecOfFailed signal: 'Strict mock received an un-mocked call!' ]].
					
	^ result
]
