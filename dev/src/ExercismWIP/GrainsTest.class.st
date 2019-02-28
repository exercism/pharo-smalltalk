"
# Grains

Calculate the number of grains of wheat on a chessboard given that the number
on each square doubles.

There once was a wise servant who saved the life of a prince. The king
promised to pay whatever the servant could dream up. Knowing that the
king loved chess, the servant told the king he would like to have grains
of wheat. One grain on the first square of a chess board, with the number
of grains doubling on each successive square.

There are 64 squares on a chessboard (where square 1 has one grain, square 2 has two grains, and so on).

Write code that shows:
- how many grains were on a given square, and
- the total number of grains on the chessboard

## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- Optimize for speed.
- Optimize for readability.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?

## Hint

TBD

"
Class {
	#name : #GrainsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'grainsCalculator'
	],
	#category : #'ExercismWIP-Grains'
}

{ #category : #config }
GrainsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'f7f07fbe-4a3f-0d00-bb57-b1cf071d6982'
]

{ #category : #config }
GrainsTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.2.0'
]

{ #category : #setup }
GrainsTest >> setUp [
	grainsCalculator := Grains new
]

{ #category : #tests }
GrainsTest >> test01_ReturnsTheNumberOfGrainsOnTheSquareand1 [
	| result |

	result := grainsCalculator square: 1 .
	self assert: result equals: 1
]

{ #category : #tests }
GrainsTest >> test02_ReturnsTheNumberOfGrainsOnTheSquareand2 [
	| result |

	result := grainsCalculator square: 2 .
	self assert: result equals: 2
]

{ #category : #tests }
GrainsTest >> test02_ReturnsTheTotalNumberOfGrainsOnTheBoard [
	| result |

	result := grainsCalculator total.
	self assert: result equals: 18446744073709551615
]

{ #category : #tests }
GrainsTest >> test03_ReturnsTheNumberOfGrainsOnTheSquareand3 [
	| result |

	result := grainsCalculator square: 3 .
	self assert: result equals: 4
]

{ #category : #tests }
GrainsTest >> test04_ReturnsTheNumberOfGrainsOnTheSquareand4 [
	| result |

	result := grainsCalculator square: 4 .
	self assert: result equals: 8
]

{ #category : #tests }
GrainsTest >> test05_ReturnsTheNumberOfGrainsOnTheSquareand16 [
	| result |

	result := grainsCalculator square: 16 .
	self assert: result equals: 32768
]

{ #category : #tests }
GrainsTest >> test06_ReturnsTheNumberOfGrainsOnTheSquareand32 [
	| result |

	result := grainsCalculator square: 32 .
	self assert: result equals: 2147483648
]

{ #category : #tests }
GrainsTest >> test07_ReturnsTheNumberOfGrainsOnTheSquareand64 [
	| result |

	result := grainsCalculator square: 64 .
	self assert: result equals: 9223372036854775808
]

{ #category : #tests }
GrainsTest >> test08_ReturnsTheNumberOfGrainsOnTheSquareSquare0RaisesAnException [
	| result |

	result := grainsCalculator square: 0 .
	self assert: result equals: ((Dictionary new) add: ('error'->'square must be between 1 and 64'); yourself)
]

{ #category : #tests }
GrainsTest >> test09_ReturnsTheNumberOfGrainsOnTheSquareNegativeSquareRaisesAnException [
	| result |

	result := grainsCalculator square:  -1 .
	self assert: result equals: ((Dictionary new) add: ('error'->'square must be between 1 and 64'); yourself)
]

{ #category : #tests }
GrainsTest >> test10_ReturnsTheNumberOfGrainsOnTheSquareSquareGreaterThan64RaisesAnException [
	| result |

	result := grainsCalculator square: 65 .
	self assert: result equals: ((Dictionary new) add: ('error'->'square must be between 1 and 64'); yourself)
]
