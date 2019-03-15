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
	^'bc00c7bb-8040-0d00-810a-c50f01deb008'
]

{ #category : #config }
MinesweeperTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.1.0'
]

{ #category : #setup }
MinesweeperTest >> setUp [
	minesweeperCalculator := Minesweeper new
]

{ #category : #tests }
MinesweeperTest >> test01_NoRows [
	| result |

	result := minesweeperCalculator annotateMinefield: #() .
	self assert: result equals: #()
]

{ #category : #tests }
MinesweeperTest >> test02_NoColumns [
	| result |

	result := minesweeperCalculator annotateMinefield: #('' ) .
	self assert: result equals: #('' )
]

{ #category : #tests }
MinesweeperTest >> test03_NoMines [
	| result |

	result := minesweeperCalculator annotateMinefield: #('   ' '   ' '   ' ) .
	self assert: result equals: #('   ' '   ' '   ' )
]

{ #category : #tests }
MinesweeperTest >> test04_MinefieldWithOnlyMines [
	| result |

	result := minesweeperCalculator annotateMinefield: #('***' '***' '***' ) .
	self assert: result equals: #('***' '***' '***' )
]

{ #category : #tests }
MinesweeperTest >> test05_MineSurroundedBySpaces [
	| result |

	result := minesweeperCalculator annotateMinefield: #('   ' ' * ' '   ' ) .
	self assert: result equals: #('111' '1*1' '111' )
]

{ #category : #tests }
MinesweeperTest >> test06_SpaceSurroundedByMines [
	| result |

	result := minesweeperCalculator annotateMinefield: #('***' '* *' '***' ) .
	self assert: result equals: #('***' '*8*' '***' )
]

{ #category : #tests }
MinesweeperTest >> test07_HorizontalLine [
	| result |

	result := minesweeperCalculator annotateMinefield: #(' * * ' ) .
	self assert: result equals: #('1*2*1' )
]

{ #category : #tests }
MinesweeperTest >> test08_HorizontalLineMinesAtEdges [
	| result |

	result := minesweeperCalculator annotateMinefield: #('*   *' ) .
	self assert: result equals: #('*1 1*' )
]

{ #category : #tests }
MinesweeperTest >> test09_VerticalLine [
	| result |

	result := minesweeperCalculator annotateMinefield: #(' ' '*' ' ' '*' ' ' ) .
	self assert: result equals: #('1' '*' '2' '*' '1' )
]

{ #category : #tests }
MinesweeperTest >> test10_VerticalLineMinesAtEdges [
	| result |

	result := minesweeperCalculator annotateMinefield: #('*' ' ' ' ' ' ' '*' ) .
	self assert: result equals: #('*' '1' ' ' '1' '*' )
]

{ #category : #tests }
MinesweeperTest >> test11_Cross [
	| result |

	result := minesweeperCalculator annotateMinefield: #('  *  ' '  *  ' '*****' '  *  ' '  *  ' ) .
	self assert: result equals: #(' 2*2 ' '25*52' '*****' '25*52' ' 2*2 ' )
]

{ #category : #tests }
MinesweeperTest >> test12_LargeMinefield [
	| result |

	result := minesweeperCalculator annotateMinefield: #(' *  * ' '  *   ' '    * ' '   * *' ' *  * ' '      ' ) .
	self assert: result equals: #('1*22*1' '12*322' ' 123*2' '112*4*' '1*22*2' '111111' )
]
