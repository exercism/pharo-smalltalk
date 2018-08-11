Extension { #name : #PreDebugDoesNotUnderstandAction }

{ #category : #'*ExercismTools' }
PreDebugDoesNotUnderstandAction >> closeWindow [
	"Safely close the pre-debugger window without destroying the debugger context and stack"

	self preDebugWindow
		debugger: nil;
		close
]
