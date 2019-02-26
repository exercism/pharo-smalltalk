"
# Minesweeper

Add the numbers to a minesweeper board.

Minesweeper is a popular game where the user has to find the mines using
numeric hints that indicate how many mines are directly adjacent
(horizontally, vertically, diagonally) to a square.

In this exercise you have to create some code that counts the number of
mines adjacent to a square and transforms boards like this (where `*`
indicates a mine):

    +-----+
    | * * |
    |  *  |
    |  *  |
    |     |
    +-----+

into this:

    +-----+
    |1*3*1|
    |13*31|
    | 2*2 |
    | 111 |
    +-----+

## Hint

TBD

"
Class {
	#name : #MinesweeperTest,
	#superclass : #ExercismTest,
	#instVars : [
		'minesweeperCalculator'
	],
	#category : #'ExercismWIP-Minesweeper'
}

{ #category : #config }
MinesweeperTest class >> uuid [
	"Answer a unique id for this exercise"
	^'3aabfad9-2b3f-0d00-a2d4-c4d009f0590c'
]

{ #category : #config }
MinesweeperTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
MinesweeperTest >> setUp [
	minesweeperCalculator := Minesweeper new
]

{ #category : #test }
MinesweeperTest >> testCross [
	| result |

	result := minesweeperCalculator annotateMinefield: #('  *  ' '  *  ' '*****' '  *  ' '  *  ' ) .
	self assert: result equals: #(' 2*2 ' '25*52' '*****' '25*52' ' 2*2 ' )
]

{ #category : #test }
MinesweeperTest >> testHorizontalLine [
	| result |

	result := minesweeperCalculator annotateMinefield: #(' * * ' ) .
	self assert: result equals: #('1*2*1' )
]

{ #category : #test }
MinesweeperTest >> testHorizontalLineMinesAtEdges [
	| result |

	result := minesweeperCalculator annotateMinefield: #('*   *' ) .
	self assert: result equals: #('*1 1*' )
]

{ #category : #test }
MinesweeperTest >> testLargeMinefield [
	| result |

	result := minesweeperCalculator annotateMinefield: #(' *  * ' '  *   ' '    * ' '   * *' ' *  * ' '      ' ) .
	self assert: result equals: #('1*22*1' '12*322' ' 123*2' '112*4*' '1*22*2' '111111' )
]

{ #category : #test }
MinesweeperTest >> testMineSurroundedBySpaces [
	| result |

	result := minesweeperCalculator annotateMinefield: #('   ' ' * ' '   ' ) .
	self assert: result equals: #('111' '1*1' '111' )
]

{ #category : #test }
MinesweeperTest >> testMinefieldWithOnlyMines [
	| result |

	result := minesweeperCalculator annotateMinefield: #('***' '***' '***' ) .
	self assert: result equals: #('***' '***' '***' )
]

{ #category : #test }
MinesweeperTest >> testNoColumns [
	| result |

	result := minesweeperCalculator annotateMinefield: #('' ) .
	self assert: result equals: #('' )
]

{ #category : #test }
MinesweeperTest >> testNoMines [
	| result |

	result := minesweeperCalculator annotateMinefield: #('   ' '   ' '   ' ) .
	self assert: result equals: #('   ' '   ' '   ' )
]

{ #category : #test }
MinesweeperTest >> testNoRows [
	| result |

	result := minesweeperCalculator annotateMinefield: #() .
	self assert: result equals: #()
]

{ #category : #test }
MinesweeperTest >> testSpaceSurroundedByMines [
	| result |

	result := minesweeperCalculator annotateMinefield: #('***' '* *' '***' ) .
	self assert: result equals: #('***' '*8*' '***' )
]

{ #category : #test }
MinesweeperTest >> testVerticalLine [
	| result |

	result := minesweeperCalculator annotateMinefield: #(' ' '*' ' ' '*' ' ' ) .
	self assert: result equals: #('1' '*' '2' '*' '1' )
]

{ #category : #test }
MinesweeperTest >> testVerticalLineMinesAtEdges [
	| result |

	result := minesweeperCalculator annotateMinefield: #('*' ' ' ' ' ' ' '*' ) .
	self assert: result equals: #('*' '1' ' ' '1' '*' )
]
