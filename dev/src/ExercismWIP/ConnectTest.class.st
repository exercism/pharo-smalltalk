"
# Connect

Compute the result for a game of Hex / Polygon.

The abstract boardgame known as
[Hex](https://en.wikipedia.org/wiki/Hex_%28board_game%29) / Polygon /
CON-TAC-TIX is quite simple in rules, though complex in practice. Two players
place stones on a rhombus with hexagonal fields. The player to connect his/her
stones to the opposite side first wins. The four sides of the rhombus are
divided between the two players (i.e. one player gets assigned a side and the
side directly opposite it and the other player gets assigned the two other
sides).

Your goal is to build a program that given a simple representation of a board
computes the winner (or lack thereof). Note that all games need not be ""fair"".
(For example, players may have mismatched piece counts.)

The boards look like this (with spaces added for readability, which won't be in
the representation passed to your code):

```text
. O . X .
 . X X O .
  O O O X .
   . X O X O
    X O O O X
```

""Player `O`"" plays from top to bottom, ""Player `X`"" plays from left to right. In
the above example `O` has made a connection from left to right but nobody has
won since `O` didn't connect top and bottom.

## Hint

TBD

"
Class {
	#name : #ConnectTest,
	#superclass : #ExercismTest,
	#instVars : [
		'connectCalculator'
	],
	#category : #'ExercismWIP-Connect'
}

{ #category : #config }
ConnectTest class >> uuid [
	"Answer a unique id for this exercise"
	^'9178f616-9d41-0d00-9005-8cc608866539'
]

{ #category : #config }
ConnectTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #running }
ConnectTest >> setUp [
	super setUp.
	connectCalculator := Connect new
]

{ #category : #tests }
ConnectTest >> test01_AnEmptyBoardHasNoWinner [
	| result |

	result := connectCalculator winnerBoard: #('. . . . .' ' . . . . .' '  . . . . .' '   . . . . .' '    . . . . .' ) .
	self assert: result equals: ''
]

{ #category : #tests }
ConnectTest >> test02_XCanWinOnA1x1Board [
	| result |

	result := connectCalculator winnerBoard: #('X' ) .
	self assert: result equals: 'X'
]

{ #category : #tests }
ConnectTest >> test03_OCanWinOnA1x1Board [
	| result |

	result := connectCalculator winnerBoard: #('O' ) .
	self assert: result equals: 'O'
]

{ #category : #tests }
ConnectTest >> test04_OnlyEdgesDoesNotMakeAWinner [
	| result |

	result := connectCalculator winnerBoard: #('O O O X' ' X . . X' '  X . . X' '   X O O O' ) .
	self assert: result equals: ''
]

{ #category : #tests }
ConnectTest >> test05_IllegalDiagonalDoesNotMakeAWinner [
	| result |

	result := connectCalculator winnerBoard: #('X O . .' ' O X X X' '  O X O .' '   . O X .' '    X X O O' ) .
	self assert: result equals: ''
]

{ #category : #tests }
ConnectTest >> test06_NobodyWinsCrossingAdjacentAngles [
	| result |

	result := connectCalculator winnerBoard: #('X . . .' ' . X O .' '  O . X O' '   . O . X' '    . . O .' ) .
	self assert: result equals: ''
]

{ #category : #tests }
ConnectTest >> test07_XWinsCrossingFromLeftToRight [
	| result |

	result := connectCalculator winnerBoard: #('. O . .' ' O X X X' '  O X O .' '   X X O X' '    . O X .' ) .
	self assert: result equals: 'X'
]

{ #category : #tests }
ConnectTest >> test08_OWinsCrossingFromTopToBottom [
	| result |

	result := connectCalculator winnerBoard: #('. O . .' ' O X X X' '  O O O .' '   X X O X' '    . O X .' ) .
	self assert: result equals: 'O'
]

{ #category : #tests }
ConnectTest >> test09_XWinsUsingAConvolutedPath [
	| result |

	result := connectCalculator winnerBoard: #('. X X . .' ' X . X . X' '  . X . X .' '   . X X . .' '    O O O O O' ) .
	self assert: result equals: 'X'
]

{ #category : #tests }
ConnectTest >> test10_XWinsUsingASpiralPath [
	| result |

	result := connectCalculator winnerBoard: #('O X X X X X X X X' ' O X O O O O O O O' '  O X O X X X X X O' '   O X O X O O O X O' '    O X O X X X O X O' '     O X O O O X O X O' '      O X X X X X O X O' '       O O O O O O O X O' '        X X X X X X X X O' ) .
	self assert: result equals: 'X'
]
