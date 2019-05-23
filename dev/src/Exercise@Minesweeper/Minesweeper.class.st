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
	| result flattenedValues matrix |
	aCollection ifEmpty: [ ^ aCollection ].

	flattenedValues := String
		streamContents: [ :s | aCollection do: [ :i | s nextPutAll: i ] ].

	matrix := Array2D
		rows: aCollection size
		columns: aCollection first size
		contents: flattenedValues.

	result := matrix
		withIndicesCollect: [ :value :row :col | 
			value = Character space
				ifTrue: [ self neighbourCountIn: matrix at: row at: col ]
				ifFalse: [ $* ] ].

	^ self rowsAsArray: result
]

{ #category : #helper }
Minesweeper >> neighbourCountIn: aMatrix at: row at: col [
	"Count the number of non-space neighbours around the position"
	
	| value |
	
	value := 0.
	
	row - 1 to: row + 1 do: [ :r | 
		col - 1 to: col + 1 do: [ :c | 
			(aMatrix at: r at: c ifInvalid: Character space) isSpaceSeparator 
				ifFalse: [ value := value + 1 ] ] ].

	^ value = 0
		ifTrue: [ Character space ]
		ifFalse: [ Character digitValue: value ]
]

{ #category : #converting }
Minesweeper >> rowsAsArray: matrix [
	^ ((1 to: matrix rowCount)
		inject: OrderedCollection new
		into: [ :answer :row | 
			answer
				add: (matrix atRow: row);
				yourself ]) asArray
]
