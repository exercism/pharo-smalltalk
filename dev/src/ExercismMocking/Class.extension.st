Extension { #name : #Class }

{ #category : #'*ExercismMocking' }
Class >> asMock [
	"Answer a new mocketry mock, named after the class (for clarity, but also allowing for easy refactoring of class names)"
	
	^Mock named: self name
]

{ #category : #'*ExercismMocking' }
Class >> asStrictMock [
	"Answer a new mocketry mock, named after the class and also set into strict mode"
	
	^Mock named: self name strict: true
]
