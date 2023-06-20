Class {
	#name : #WordSearch,
	#superclass : #Object,
	#category : #'Exercise@WordSearch'
}

{ #category : #exercism }
WordSearch >> directions [
	"answer valid directional transforms where words can occur, left, right, up, down and diagonals.
	Points are encoded as Row, Col"
	
	^ {
		(-1 @ 0). "N"
		(1 @ 0). "S"
		(0 @ 1). "E"
		(0 @ -1). "W"
		(-1 @ 1). "NE"
		(-1 @ -1). "NW"
		(1 @ 1). "SE"
		(1 @ -1). "SW"
	}
]

{ #category : #internal }
WordSearch >> find: aString in: array2D at: sourcePoint bearing: bearingPoint ifPresent: aBlock [
	| currentPoint |
	
	currentPoint := sourcePoint.

	aString
		do: [ :char | 
			(array2D at: currentPoint x at: currentPoint y ifInvalid: nil) = char
				ifFalse: [ ^ self ] ]
		separatedBy: [ currentPoint := currentPoint + bearingPoint ].

	aBlock value: (self wordLocationFrom: sourcePoint to: currentPoint)
]

{ #category : #exercism }
WordSearch >> searchWordsToSearchFor: aWordCollection grid: aGridCollection [
	| wordGrid result |
	
	wordGrid := Array2D
		rows: aGridCollection size
		columns: aGridCollection first size
		contents: aGridCollection concatenation.

	result := Dictionary new.

	aWordCollection
		do: [ :word | 
			result at: word put: nil.

			wordGrid
				withIndicesDo: [ :v :r :c | 
					self directions
						do: [ :directionPoint | 
							self
								find: word
								in: wordGrid
								at: r @ c
								bearing: directionPoint
								ifPresent: [ :location | result at: word put: location ] ] ] ].

	^ result
]

{ #category : #internal }
WordSearch >> wordLocationFrom: aPointStart to: aPointEnd [
	"Answer a Dictionary of the start/end location of a found word"
	
	^ {('start'
		-->>
			{('row' -> aPointStart x).
			('column' -> aPointStart y)}).
	('end'
		-->>
			{('row' -> aPointEnd x).
			('column' -> aPointEnd y)})} asDictionary
]
