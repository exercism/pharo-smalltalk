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
	^ {('track_id' -> self trackId).
		('language' -> 'Pharo').
		('active' -> self trackActive).
		('blurb' -> self trackDescription).
		('solution_pattern' -> '\.meta/solution/\w+\.class\.st').
		('test_pattern' -> '\w+Test\.class\.st')}
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackDescription [
	^ 'Pharo is an immersive, open source, Smalltalk programming experience. It features a pure object-oriented language and powerful user extendable environment, that focuses on simplicity and immediate feedback (think IDE and OS rolled into one). It''s elegence gives it wide reach into banking, education, web development and even robotics'

]
