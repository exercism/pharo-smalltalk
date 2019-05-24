"
Mentor notes:

- using an Array2d makes this quite simple, particularly the use of #at:at:invalid:
"
Class {
	#name : #Minesweeper,
	#superclass : #Object,
	#category : #'Exercise@Minesweeper'
}

{ #category : #exercism }
Minesweeper >> annotateMinefield: aCollection [
	| result matrix |
	
	aCollection ifEmpty: [ ^ aCollection ].

	matrix := Array2D
		rows: aCollection size
		columns: aCollection first size
		contents: (aCollection flatCollect: [ :c | c ]).

	result := matrix
		withIndicesCollect: [ :value :row :col | 
			value = $*
				ifTrue: [ value ]
				ifFalse: [ self neighbourCountIn: matrix at: row at: col ]].

	^ self rowsAsArray: result
]

{ #category : #helper }
Minesweeper >> neighbourCountIn: aMatrix at: row at: col [
	"Count the number of non-space neighbours around the position"

	^ ((row @ col) eightNeighbors
		sum: [ :point | 
			(aMatrix at: point x at: point y ifInvalid: Character space)
				asMinesweeperValue ]) asMinesweeperChar
]

{ #category : #converting }
Minesweeper >> rowsAsArray: matrix [
	^ (1 to: matrix rowCount)
		collect: [ :rowId | 
			(String streamContents: [:s | (matrix atRow: rowId) do: [:char | s << char ]]) ]
]
