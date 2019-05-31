Extension { #name : #MCDefinition }

{ #category : #'*ExercismDev' }
MCDefinition >> isExercise [
	^ self actualClass instanceSide inheritsFrom: ExercismTest
]

{ #category : #'*ExercismDev' }
MCDefinition >> isSolution [
	^ self isExercise not
]
