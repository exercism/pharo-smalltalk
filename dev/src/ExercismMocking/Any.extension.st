Extension { #name : #Any }

{ #category : #'*ExercismMocking' }
Any class >> strictMocks [
	"Make all mocks be strict, and fail if called without a stub/expectation"
	
	self strictMocks: true
]

{ #category : #'*ExercismMocking' }
Any class >> strictMocks: aBoolean [
	"Make all mocks strict/loose, and if strict, cause them to fail when called without a stub/expectation"
	
	 aBoolean ifTrue: [
		Any stub anyMessage specifying: [ 
			SpecOfFailed signal: 'Strict mock received an un-mocked call!' ]]
]

{ #category : #'*ExercismMocking' }
Any class >> verify [
	"Verify all current mocks and ensure their expectations have been met. This eases the burdon on having to make a series of 'should receive' calls, however some may still be needed (in addition) for more complicated assertions."
	
	| mocks |
	mocks := MockCurrentBehaviour value interactionHistory involvedObjects.
	mocks do: [ :mock | mock should verify ]
]
