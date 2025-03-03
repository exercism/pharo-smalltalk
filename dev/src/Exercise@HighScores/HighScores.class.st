"
A simple exercise, of note is how to handle the top three scores - ideally you can sort and then take the min of 3 and the score list size, but there are equally other options.
"
Class {
	#name : 'HighScores',
	#superclass : 'Object',
	#instVars : [
		'scores'
	],
	#category : 'Exercise@HighScores',
	#package : 'Exercise@HighScores'
}

{ #category : 'exercism' }
HighScores >> addScores: aCollection [

	scores addAll: aCollection
]

{ #category : 'initialization' }
HighScores >> initialize [ 
	
	super initialize.
	scores := OrderedCollection new.
]

{ #category : 'exercism' }
HighScores >> latestScore [
	
	^ scores last
]

{ #category : 'exercism' }
HighScores >> personalBestScores [
	
	^ scores max
]

{ #category : 'exercism' }
HighScores >> personalTopThreeScores [
	^ (scores asSortedCollection: [ :a :b | a > b ]) asArray
			first: (3 min: scores size)
]

{ #category : 'exercism' }
HighScores >> scores [
	
	^ scores asArray
]
