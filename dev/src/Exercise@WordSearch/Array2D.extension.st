Extension { #name : #Array2D }

{ #category : #'*Exercise@WordSearch' }
Array2D >> atDiagonalRow: row column: col [ 
	| result numRows numCols count |
	numRows := (self numberOfRows - row  ).
	numCols := (self numberOfColumns - col ).
	count := numRows max: numCols.
	
	result := OrderedCollection new.
	0 to: count do: [ :i |
			result add: (self at: row + i at: col + i ifInvalid: nil)
			 ].
	^result reject: [ :i | i isNil ]
]

{ #category : #'*Exercise@WordSearch' }
Array2D >> isSquare [
	^numberOfRows = numberOfColumns
]
