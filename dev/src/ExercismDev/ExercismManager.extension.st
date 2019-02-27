Extension { #name : #ExercismManager }

{ #category : #'*ExercismDev' }
ExercismManager >> dependencyGraph [
	
	| result |
	result := ExercismExercise  allExercises select: [:e | e isCore ].
	
	^result asSortedCollection: [ :a :b | b isFollowedBy: a ]
]
