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
	#name : 'DifferenceOfSquaresTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'differenceOfSquaresCalculator'
	],
	#category : 'ExercismWIP-DifferenceOfSquares',
	#package : 'ExercismWIP',
	#tag : 'DifferenceOfSquares'
}

{ #category : 'config' }
DifferenceOfSquaresTest class >> uuid [
	"Answer a unique id for this exercise"
	^'0ce1a816-9d41-0d00-8fca-ed6108866539'
]

{ #category : 'config' }
DifferenceOfSquaresTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.2.0'
]

{ #category : 'running' }
DifferenceOfSquaresTest >> setUp [
	super setUp.
	differenceOfSquaresCalculator := DifferenceOfSquares new
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test01_SquareTheSumOfTheNumbersUpToTheGivenNumberSquareOfSum1 [
	| result |

	result := differenceOfSquaresCalculator squareOfSumNumber: 1 .
	self assert: result equals: 1
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test02_SquareTheSumOfTheNumbersUpToTheGivenNumberSquareOfSum5 [
	| result |

	result := differenceOfSquaresCalculator squareOfSumNumber: 5 .
	self assert: result equals: 225
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test03_SquareTheSumOfTheNumbersUpToTheGivenNumberSquareOfSum100 [
	| result |

	result := differenceOfSquaresCalculator squareOfSumNumber: 100 .
	self assert: result equals: 25502500
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test04_SumTheSquaresOfTheNumbersUpToTheGivenNumberSumOfSquares1 [
	| result |

	result := differenceOfSquaresCalculator sumOfSquaresNumber: 1 .
	self assert: result equals: 1
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test05_SumTheSquaresOfTheNumbersUpToTheGivenNumberSumOfSquares5 [
	| result |

	result := differenceOfSquaresCalculator sumOfSquaresNumber: 5 .
	self assert: result equals: 55
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test06_SumTheSquaresOfTheNumbersUpToTheGivenNumberSumOfSquares100 [
	| result |

	result := differenceOfSquaresCalculator sumOfSquaresNumber: 100 .
	self assert: result equals: 338350
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test07_SubtractSumOfSquaresFromSquareOfSumsDifferenceOfSquares1 [
	| result |

	result := differenceOfSquaresCalculator differenceOfSquaresNumber: 1 .
	self assert: result equals: 0
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test08_SubtractSumOfSquaresFromSquareOfSumsDifferenceOfSquares5 [
	| result |

	result := differenceOfSquaresCalculator differenceOfSquaresNumber: 5 .
	self assert: result equals: 170
]

{ #category : 'tests' }
DifferenceOfSquaresTest >> test09_SubtractSumOfSquaresFromSquareOfSumsDifferenceOfSquares100 [
	| result |

	result := differenceOfSquaresCalculator differenceOfSquaresNumber: 100 .
	self assert: result equals: 25164150
]
