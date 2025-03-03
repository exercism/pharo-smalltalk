"
I provide convenient way to WordSearch exercise result, as expected by unit tests.
"
Class {
	#name : 'WordSearchResult',
	#superclass : 'Object',
	#instVars : [
		'wordDict',
		'currentWordResult'
	],
	#category : 'Exercise@WordSearch',
	#package : 'Exercise@WordSearch'
}

{ #category : 'accessing' }
WordSearchResult >> at: aWord [ 

	currentWordResult := wordDict at: aWord ifAbsent: [^ nil]. 
	"we just set current word, if present"
	^ self
]

{ #category : 'adding' }
WordSearchResult >> at: wordFound put: startEndPointPair [

	wordDict at: wordFound put: startEndPointPair
]

{ #category : 'accessing' }
WordSearchResult >> end [ 

	^ currentWordResult last
]

{ #category : 'initialization' }
WordSearchResult >> initialize [ 

	wordDict := Dictionary new.
]

{ #category : 'accessing' }
WordSearchResult >> start [ 

	^ currentWordResult first
]
