Extension { #name : #MCDefinition }

{ #category : #'*ExercismTools' }
MCDefinition >> isExerciseDefinition [
	^ self actualClass instanceSide inheritsFrom: TestCase
]

{ #category : #'*ExercismTools' }
MCDefinition >> isSolutionDefinition [
	^ self isExerciseDefinition not
]
