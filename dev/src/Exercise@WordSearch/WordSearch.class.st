Class {
	#name : 'WordSearch',
	#superclass : 'Object',
	#instVars : [
		'wordGrid'
	],
	#category : 'Exercise@WordSearch',
	#package : 'Exercise@WordSearch'
}

{ #category : 'internal' }
WordSearch >> directions [

	^ (0 @ 0) eightNeighbors
]

{ #category : 'internal' }
WordSearch >> find: aWord at: sourcePoint bearing: bearingPoint ifPresent: aBlock [

	| currentPoint |	
	currentPoint := sourcePoint.

	aWord
		do: [ :char | 
			(wordGrid at: currentPoint x at: currentPoint y ifInvalid: nil) = char
				ifFalse: [ ^ self ] ]
		separatedBy: [ currentPoint := currentPoint + bearingPoint ].

	aBlock value: sourcePoint value: currentPoint
]

{ #category : 'internal' }
WordSearch >> initializeWordGridFrom: arrayOfGridRows [

	wordGrid := Array2D
		rows: arrayOfGridRows size
		columns: arrayOfGridRows first size
		contents: ('' join: arrayOfGridRows)
]

{ #category : 'internal' }
WordSearch >> searchWordsToSearchFor: aWordCollection grid: aGridCollection [ 

	|  result |	
	self initializeWordGridFrom: aGridCollection.
	result := WordSearchResult new.

	aWordCollection	do: [ :word |	
			wordGrid withIndicesDo: [ :v :row :column | 
				self directions do: [ :directionPoint | 
					self
						find: word
						at: row @ column
						bearing: directionPoint
						ifPresent: [ :startPoint :endPoint | result at: word put: {startPoint. endPoint.}] ] ] 
	].

	^ result
]
