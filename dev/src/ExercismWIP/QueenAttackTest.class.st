"
# Queen Attack

Given the position of two queens on a chess board, indicate whether or not they
are positioned so that they can attack each other.

In the game of chess, a queen can attack pieces which are on the same
row, column, or diagonal.

A chessboard can be represented by an 8 by 8 array.

So if you're told the white queen is at (2, 3) and the black queen at
(5, 6), then you'd know you've got a set-up like so:

```text
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ W _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ B _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
```

You'd also be able to answer whether the queens can attack each other.
In this case, that answer would be yes, they can, because both pieces
share a diagonal.

## Hint

TBD

"
Class {
	#name : #QueenAttackTest,
	#superclass : #ExercismTest,
	#instVars : [
		'queenAttackCalculator'
	],
	#category : #'ExercismWIP-QueenAttack'
}

{ #category : #config }
QueenAttackTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a02600da-2b3f-0d00-a2da-341f09f0590c'
]

{ #category : #config }
QueenAttackTest class >> version [
	"Generated from specification: 26 February 2019"
	^'2.2.0'
]

{ #category : #setup }
QueenAttackTest >> setUp [
	queenAttackCalculator := QueenAttack new
]

{ #category : #test }
QueenAttackTest >> testTestCreationOfQueensWithValidAndInvalidPositionsQueenMustHaveColumnOnBoard [
	| result |

	result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->8); add: ('row'->4); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('error'->'column not on board'); yourself)
]

{ #category : #test }
QueenAttackTest >> testTestCreationOfQueensWithValidAndInvalidPositionsQueenMustHavePositiveColumn [
	| result |

	result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'-> -2); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('error'->'column not positive'); yourself)
]

{ #category : #test }
QueenAttackTest >> testTestCreationOfQueensWithValidAndInvalidPositionsQueenMustHavePositiveRow [
	| result |

	result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'-> -2); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('error'->'row not positive'); yourself)
]

{ #category : #test }
QueenAttackTest >> testTestCreationOfQueensWithValidAndInvalidPositionsQueenMustHaveRowOnBoard [
	| result |

	result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->8); yourself)); yourself) .
	self assert: result equals: ((Dictionary new) add: ('error'->'row not on board'); yourself)
]

{ #category : #test }
QueenAttackTest >> testTestCreationOfQueensWithValidAndInvalidPositionsQueenWithAValidPosition [
	| result |

	result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: 0
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanAttackOnFirstDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->0); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanAttackOnFourthDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->5); add: ('row'->5); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanAttackOnSameColumn [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->5); add: ('row'->4); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->5); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanAttackOnSameRow [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->6); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanAttackOnSecondDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->1); add: ('row'->3); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanAttackOnThirdDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #test }
QueenAttackTest >> testTestTheAbilityOfOneQueenToAttackAnotherCanNotAttack [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->6); add: ('row'->6); yourself)); yourself) .
	self assert: result equals: false
]
