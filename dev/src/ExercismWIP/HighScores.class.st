Class {
	#name : #HighScores,
	#superclass : #Object,
	#category : #'ExercismWIP-HighScores'
}

{ #category : #exercism }
HighScores >> latestScore: scoreCollection [ 
	^scoreCollection last
]

{ #category : #exercism }
HighScores >> personalBestScores: scoreCollection [ 
	^scoreCollection max
]

{ #category : #exercism }
HighScores >> personalTopThreeScores: aCollection [ 
	^(aCollection asSortedCollection: [ :a :b | a > b ]) asArray first: (3 min: aCollection size)
]

{ #category : #exercism }
HighScores >> scores: aCollection [ 
	^aCollection 
]
