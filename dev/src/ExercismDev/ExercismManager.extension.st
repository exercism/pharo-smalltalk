Extension { #name : #ExercismManager }

{ #category : #'*ExercismDev' }
ExercismManager >> dependencyGraph [
	
	^ExercismExercise coreExercises
	
	
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackActive [
	^true
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
	^ 'Pharo is a fun and immersive Smalltalk programming experience. Featuring a clean object-oriented language and a powerful user extendable environment, it focuses on simplicity and immediate feedback (think IDE and OS rolled into one). Its elegance and productivity give it wide reach into banking, education, web development and even robotics.'
]

{ #category : #'*ExercismDev' }
ExercismManager >> viewMenteeSolution [
	| reviewId result |

	reviewId := (UIManager default
		request: 'Enter a valid mentor exercism uuid:')
		ifNil: [ ^ nil ]
		ifNotNil: [ :value | self parseTokenNamed: 'uuid' from: value ].

	UIManager default inform: 'Retrieving: ' , reviewId.
	result := (ExercismReviewCommand reviewId: reviewId) execute.

	(MCSnapshotBrowser forSnapshot: (result codeSnapshot))
		showLabelled: ('Exercism Solution ({1})' format: { result reviewName })
]
