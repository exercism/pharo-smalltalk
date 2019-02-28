Extension { #name : #ExercismManager }

{ #category : #'*ExercismDev' }
ExercismManager >> dependencyGraph [
	
	^ExercismExercise coreExercises
	
	
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackActive [
	^false
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackConfigHeader [
	^ { 'track_id' -> self trackId.
		'language' -> 'Pharo'.
		'active' -> self trackActive.
		'blurb' -> 'The immersive and modern, Smalltalk programming experience'.
		'solution_pattern' -> '\.meta/solution/\w+\.class\.st'.
  	 	'test_pattern' -> '\w+Test\.class\.st' }
]
