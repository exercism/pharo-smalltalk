Extension { #name : #TAssertable }

{ #category : #'*ExercismTools' }
TAssertable >> deny: actual equals: expected [
	^ self
		deny: expected = actual
		description: ['Expected a value other than ', expected fullPrintString]
]
