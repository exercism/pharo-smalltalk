Extension { #name : #ClassDescription }

{ #category : #'*ExercismTools' }
ClassDescription class >> exTonelClassFilenameFor: aName [
	^aName, '.class.st'
]

{ #category : #'*ExercismTools' }
ClassDescription class >> exTonelExtensionFilenameFor: aName [
	^aName, '.extension.st'
]
