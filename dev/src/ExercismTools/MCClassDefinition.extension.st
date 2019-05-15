Extension { #name : #MCClassDefinition }

{ #category : #'*ExercismTools' }
MCClassDefinition >> exTonelFilename [
	^ClassDescription exTonelClassFilenameFor: self className 
]
