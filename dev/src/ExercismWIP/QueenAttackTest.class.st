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
	^'3d6bb52e-b043-0d00-9262-b3f002a76407'
]

{ #category : #config }
QueenAttackTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.3.0'
]

{ #category : #setup }
QueenAttackTest >> setUp [
	queenAttackCalculator := QueenAttack new
]

{ #category : #tests }
QueenAttackTest >> test01_TestCreationOfQueensWithValidAndInvalidPositionsQueenWithAValidPosition [
	| result |

	result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: 0
]

{ #category : #tests }
QueenAttackTest >> test02_TestCreationOfQueensWithValidAndInvalidPositionsQueenMustHavePositiveRow [
	| result |

	self
		should: [ result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'-> -2); yourself)); yourself) ]
		raise: Error
		whoseDescriptionIncludes: 'row not positive'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
QueenAttackTest >> test03_TestCreationOfQueensWithValidAndInvalidPositionsQueenMustHaveRowOnBoard [
	| result |

	self
		should: [ result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->8); yourself)); yourself) ]
		raise: Error
		whoseDescriptionIncludes: 'row not on board'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
QueenAttackTest >> test04_TestCreationOfQueensWithValidAndInvalidPositionsQueenMustHavePositiveColumn [
	| result |

	self
		should: [ result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'-> -2); add: ('row'->2); yourself)); yourself) ]
		raise: Error
		whoseDescriptionIncludes: 'column not positive'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
QueenAttackTest >> test05_TestCreationOfQueensWithValidAndInvalidPositionsQueenMustHaveColumnOnBoard [
	| result |

	self
		should: [ result := queenAttackCalculator createQueen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->8); add: ('row'->4); yourself)); yourself) ]
		raise: Error
		whoseDescriptionIncludes: 'column not on board'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
QueenAttackTest >> test06_TestTheAbilityOfOneQueenToAttackAnotherCanNotAttack [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->6); add: ('row'->6); yourself)); yourself) .
	self assert: result equals: false
]

{ #category : #tests }
QueenAttackTest >> test07_TestTheAbilityOfOneQueenToAttackAnotherCanAttackOnSameRow [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->6); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
QueenAttackTest >> test08_TestTheAbilityOfOneQueenToAttackAnotherCanAttackOnSameColumn [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->5); add: ('row'->4); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->5); add: ('row'->2); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
QueenAttackTest >> test09_TestTheAbilityOfOneQueenToAttackAnotherCanAttackOnFirstDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->4); add: ('row'->0); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
QueenAttackTest >> test10_TestTheAbilityOfOneQueenToAttackAnotherCanAttackOnSecondDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->1); add: ('row'->3); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
QueenAttackTest >> test11_TestTheAbilityOfOneQueenToAttackAnotherCanAttackOnThirdDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); yourself) .
	self assert: result equals: true
]

{ #category : #tests }
QueenAttackTest >> test12_TestTheAbilityOfOneQueenToAttackAnotherCanAttackOnFourthDiagonal [
	| result |

	result := queenAttackCalculator canAttackWhite_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->7); add: ('row'->1); yourself)); yourself) black_queen: ((Dictionary new) add: ('position'->((Dictionary new) add: ('column'->6); add: ('row'->0); yourself)); yourself) .
	self assert: result equals: true
]
