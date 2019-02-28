"
# Difference Of Squares

Find the difference between the square of the sum and the sum of the squares of the first N natural numbers.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)² = 55² = 3025.

The sum of the squares of the first ten natural numbers is
1² + 2² + ... + 10² = 385.

Hence the difference between the square of the sum of the first
ten natural numbers and the sum of the squares of the first ten
natural numbers is 3025 - 385 = 2640.

You are not expected to discover an efficient solution to this yourself from
first principles; research is allowed, indeed, encouraged. Finding the best
algorithm for the problem is a key skill in software engineering.

## Hint

TBD

"
Class {
	#name : #DifferenceOfSquaresTest,
	#superclass : #ExercismTest,
	#instVars : [
		'differenceOfSquaresCalculator'
	],
	#category : #'ExercismWIP-DifferenceOfSquares'
}

{ #category : #config }
DifferenceOfSquaresTest class >> uuid [
	"Answer a unique id for this exercise"
	^'05a22bbe-4a3f-0d00-bb1b-1ea8071d6982'
]

{ #category : #config }
DifferenceOfSquaresTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.2.0'
]

{ #category : #setup }
DifferenceOfSquaresTest >> setUp [
	differenceOfSquaresCalculator := DifferenceOfSquares new
]

{ #category : #tests }
DifferenceOfSquaresTest >> test01_SquareTheSumOfTheNumbersUpToTheGivenNumberSquareOfSum1 [
	| result |

	result := differenceOfSquaresCalculator squareOfSumNumber: 1 .
	self assert: result equals: 1
]

{ #category : #tests }
DifferenceOfSquaresTest >> test01_SubtractSumOfSquaresFromSquareOfSumsDifferenceOfSquares1 [
	| result |

	result := differenceOfSquaresCalculator differenceOfSquaresNumber: 1 .
	self assert: result equals: 0
]

{ #category : #tests }
DifferenceOfSquaresTest >> test01_SumTheSquaresOfTheNumbersUpToTheGivenNumberSumOfSquares1 [
	| result |

	result := differenceOfSquaresCalculator sumOfSquaresNumber: 1 .
	self assert: result equals: 1
]

{ #category : #tests }
DifferenceOfSquaresTest >> test02_SquareTheSumOfTheNumbersUpToTheGivenNumberSquareOfSum5 [
	| result |

	result := differenceOfSquaresCalculator squareOfSumNumber: 5 .
	self assert: result equals: 225
]

{ #category : #tests }
DifferenceOfSquaresTest >> test02_SubtractSumOfSquaresFromSquareOfSumsDifferenceOfSquares5 [
	| result |

	result := differenceOfSquaresCalculator differenceOfSquaresNumber: 5 .
	self assert: result equals: 170
]

{ #category : #tests }
DifferenceOfSquaresTest >> test02_SumTheSquaresOfTheNumbersUpToTheGivenNumberSumOfSquares5 [
	| result |

	result := differenceOfSquaresCalculator sumOfSquaresNumber: 5 .
	self assert: result equals: 55
]

{ #category : #tests }
DifferenceOfSquaresTest >> test03_SquareTheSumOfTheNumbersUpToTheGivenNumberSquareOfSum100 [
	| result |

	result := differenceOfSquaresCalculator squareOfSumNumber: 100 .
	self assert: result equals: 25502500
]

{ #category : #tests }
DifferenceOfSquaresTest >> test03_SubtractSumOfSquaresFromSquareOfSumsDifferenceOfSquares100 [
	| result |

	result := differenceOfSquaresCalculator differenceOfSquaresNumber: 100 .
	self assert: result equals: 25164150
]

{ #category : #tests }
DifferenceOfSquaresTest >> test03_SumTheSquaresOfTheNumbersUpToTheGivenNumberSumOfSquares100 [
	| result |

	result := differenceOfSquaresCalculator sumOfSquaresNumber: 100 .
	self assert: result equals: 338350
]
