"
Mentor notes:

- using the method #eightNeighbors inspires many simplifications, as well as the use of some extension methods
- it also possible to do something more matrix like using an Array2D and its row/column manipulations
"
Class {
	#name : #Minesweeper,
	#superclass : #Object,
	#category : #'Exercise@Minesweeper'
}

{ #category : #exercism }
Minesweeper >> annotateMinefield: aCollection [
	aCollection ifEmpty: [ ^ aCollection ].

	^ aCollection
		withIndexCollect: [ :row :y | 
			row withIndexCollect: [ :cell :x | 
					cell = $*
						ifTrue: [ cell ]
						ifFalse: [ self neighbourValueIn: aCollection at: (x@y) ] ] ]
]

{ #category : #exercism }
Minesweeper >> neighbourValueIn: aCollection at: aPoint [
	^ (aPoint eightNeighbors sum: [ :p | aCollection mineAt: p ])
		asMinesweeperChar
]
