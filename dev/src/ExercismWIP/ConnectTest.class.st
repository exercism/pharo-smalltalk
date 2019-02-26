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
	^'0d1d29da-2b3f-0d00-a2fe-d11109f0590c'
]

{ #category : #config }
ConnectTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
ConnectTest >> setUp [
	connectCalculator := Connect new
]

{ #category : #test }
ConnectTest >> testAnEmptyBoardHasNoWinner [
	| result |

	result := connectCalculator winnerBoard: #('. . . . .' ' . . . . .' '  . . . . .' '   . . . . .' '    . . . . .' ) .
	self assert: result equals: ''
]

{ #category : #test }
ConnectTest >> testIllegalDiagonalDoesNotMakeAWinner [
	| result |

	result := connectCalculator winnerBoard: #('X O . .' ' O X X X' '  O X O .' '   . O X .' '    X X O O' ) .
	self assert: result equals: ''
]

{ #category : #test }
ConnectTest >> testNobodyWinsCrossingAdjacentAngles [
	| result |

	result := connectCalculator winnerBoard: #('X . . .' ' . X O .' '  O . X O' '   . O . X' '    . . O .' ) .
	self assert: result equals: ''
]

{ #category : #test }
ConnectTest >> testOCanWinOnA1x1Board [
	| result |

	result := connectCalculator winnerBoard: #('O' ) .
	self assert: result equals: 'O'
]

{ #category : #test }
ConnectTest >> testOWinsCrossingFromTopToBottom [
	| result |

	result := connectCalculator winnerBoard: #('. O . .' ' O X X X' '  O O O .' '   X X O X' '    . O X .' ) .
	self assert: result equals: 'O'
]

{ #category : #test }
ConnectTest >> testOnlyEdgesDoesNotMakeAWinner [
	| result |

	result := connectCalculator winnerBoard: #('O O O X' ' X . . X' '  X . . X' '   X O O O' ) .
	self assert: result equals: ''
]

{ #category : #test }
ConnectTest >> testXCanWinOnA1x1Board [
	| result |

	result := connectCalculator winnerBoard: #('X' ) .
	self assert: result equals: 'X'
]

{ #category : #test }
ConnectTest >> testXWinsCrossingFromLeftToRight [
	| result |

	result := connectCalculator winnerBoard: #('. O . .' ' O X X X' '  O X O .' '   X X O X' '    . O X .' ) .
	self assert: result equals: 'X'
]

{ #category : #test }
ConnectTest >> testXWinsUsingAConvolutedPath [
	| result |

	result := connectCalculator winnerBoard: #('. X X . .' ' X . X . X' '  . X . X .' '   . X X . .' '    O O O O O' ) .
	self assert: result equals: 'X'
]

{ #category : #test }
ConnectTest >> testXWinsUsingASpiralPath [
	| result |

	result := connectCalculator winnerBoard: #('O X X X X X X X X' ' O X O O O O O O O' '  O X O X X X X X O' '   O X O X O O O X O' '    O X O X X X O X O' '     O X O O O X O X O' '      O X X X X X O X O' '       O O O O O O O X O' '        X X X X X X X X O' ) .
	self assert: result equals: 'X'
]
