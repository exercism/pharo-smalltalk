"
A simple exercise, of note is how to handle the top three scores - ideally you can sort and then take the min of 3 and the score list size, but there are equally other options.
"
Class {
	#name : #HighScores,
	#superclass : #Object,
	#category : #'Exercise@HighScores'
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
	^ (aCollection asSortedCollection: [ :a :b | a > b ]) asArray
			first: (3 min: aCollection size)
]

{ #category : #exercism }
HighScores >> scores: aCollection [ 
	^aCollection 
]
