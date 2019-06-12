Class {
	#name : #WordSearch,
	#superclass : #Object,
	#category : #'Exercise@WordSearch'
}

{ #category : #exercism }
WordSearch >> find: word in: wordGrid at: i specifying: aBlock [
	| loc |
	
	(loc := self locationOf: word in: (wordGrid atRow: i)) > 0
			ifTrue: [ aBlock value: loc ]
]

{ #category : #exercism }
WordSearch >> locationOf: word in: row [
	^ (String fromByteArrayOfCharacters: row) findString: word
]

{ #category : #exercism }
WordSearch >> searchWordsToSearchFor: aWordCollection grid: aGridCollection [
	| wordGrid result loc |
	
	wordGrid := Array2D
		rows: aGridCollection size
		columns: aGridCollection first size
		contents: aGridCollection concatenation.

	result := Dictionary new.

	aWordCollection
		do: [ :word | 
			result at: word put: nil.

			1 to: wordGrid numberOfRows do: [ :i | 
				(loc := self locationOf: word in: (wordGrid atRow: i)) > 0
					ifTrue: [ result
							at: word
							put: (self wordLocationsFrom: i @ loc to: i @ (loc + word size - 1)) ].

				(loc := self locationOf: word reversed in: (wordGrid atRow: i)) > 0
					ifTrue: [ result
							at: word
							put: (self wordLocationsFrom: i @ (loc + word size - 1) to: i @ loc) ] ].

			1 to: wordGrid numberOfColumns do: [ :i | 
				(loc := self locationOf: word in: (wordGrid atColumn: i)) > 0
					ifTrue: [ result
							at: word
							put: (self wordLocationsFrom: loc @ i to: (loc + word size - 1) @ i) ].

				(loc := self locationOf: word reversed in: (wordGrid atColumn: i))
					> 0
					ifTrue: [ result
							at: word
							put: (self wordLocationsFrom: (loc + word size - 1) @ i to: loc @ i) ] ].

			1 to: wordGrid numberOfColumns do: [ :i | 
				(loc := self
					locationOf: word
					in: (wordGrid atDiagonalRow: 1 column: i)) > 0
					ifTrue: [ result
							at: word
							put:
								(self
									wordLocationsFrom: loc @ i
									to: (loc + word size - 1) @ (i + word size - 1)) ] ].

			2 to: wordGrid numberOfRows do: [ :i | 
				(loc := self
					locationOf: word
					in: (wordGrid atDiagonalRow: i column: 1)) > 0
					ifTrue: [ result
							at: word
							put:
								(self
									wordLocationsFrom: loc @ i
									to: (loc + word size - 1) @ (i + word size - 1)) ] ].

			1 to: wordGrid numberOfColumns do: [ :i | 
				(loc := self
					locationOf: word reversed
					in: (wordGrid atDiagonalRow: 1 column: i)) > 0
					ifTrue: [ result
							at: word
							put:
								(self
									wordLocationsFrom: (loc + word size - 1) @ (i + word size - 1)
									to: loc @ i) ] ].
			2 to: wordGrid numberOfRows do: [ :i | 
				(loc := self
					locationOf: word reversed
					in: (wordGrid atDiagonalRow: i column: 1)) > 0
					ifTrue: [ result
							at: word
							put:
								(self
									wordLocationsFrom: (loc + word size - i + 2) @ (loc + word size - 1)
									to: (loc - i + 3) @ loc) ] ] ].


	^ result
]

{ #category : #internal }
WordSearch >> wordLocationsFrom: aPoint to: aPoint2 [
	^ {('start'
		-->>
			{('row' -> aPoint x).
			('column' -> aPoint y)}).
	('end'
		-->>
			{('row' -> aPoint2 x).
			('column' -> aPoint2 y)})} asDictionary
]
