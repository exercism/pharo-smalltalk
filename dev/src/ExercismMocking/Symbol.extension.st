Extension { #name : #Symbol }

{ #category : #'*ExercismMocking' }
Symbol >> asMock [
	"Answer a new mocketry mock, named after a yet to be defing class (for clarity, but also allowing for easy refactoring of class names)"
	
	^Mock named: self asString
]

{ #category : #'*ExercismMocking' }
Symbol >> asStrictMock [
	"Answer a new strict mock, named after a yet to be defined class (for clarity, but also allowing for easy refactoring of class names)"
	
	^Mock named: self asString strict: true
]
