"
# Change

Correctly determine the fewest number of coins to be given to a customer such
that the sum of the coins' value would equal the correct amount of change.

## For example

- An input of 15 with [1, 5, 10, 25, 100] should return one nickel (5)
  and one dime (10) or [5, 10]
- An input of 40 with [1, 5, 10, 25, 100] should return one nickel (5)
  and one dime (10) and one quarter (25) or [5, 10, 25]

## Edge cases

- Does your algorithm work for any given set of coins?
- Can you ask for negative change?
- Can you ask for a change value smaller than the smallest coin value?

## Hint

TBD

"
Class {
	#name : #ChangeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'changeCalculator'
	],
	#category : #'ExercismWIP-Change'
}

{ #category : #config }
ChangeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'fb0ae0d9-2b3f-0d00-a2b8-70b309f0590c'
]

{ #category : #config }
ChangeTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
ChangeTest >> setUp [
	changeCalculator := Change new
]

{ #category : #test }
ChangeTest >> testAnotherPossibleChangeWithoutUnitCoinsAvailable [
	| result |

	result := changeCalculator findFewestCoins: #(4 5 ) target: 27 .
	self assert: result equals: #(4 4 4 5 5 5 )
]

{ #category : #test }
ChangeTest >> testCannotFindNegativeChangeValues [
	| result |

	result := changeCalculator findFewestCoins: #(1 2 5 ) target:  -5 .
	self assert: result equals: ((Dictionary new) add: ('error'->'target can''t be negative'); yourself)
]

{ #category : #test }
ChangeTest >> testChangeWithLilliputianCoins [
	| result |

	result := changeCalculator findFewestCoins: #(1 4 15 20 50 ) target: 23 .
	self assert: result equals: #(4 4 15 )
]

{ #category : #test }
ChangeTest >> testChangeWithLowerElboniaCoins [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 21 25 ) target: 63 .
	self assert: result equals: #(21 21 21 )
]

{ #category : #test }
ChangeTest >> testErrorIfNoCombinationCanAddUpToTarget [
	| result |

	result := changeCalculator findFewestCoins: #(5 10 ) target: 94 .
	self assert: result equals: ((Dictionary new) add: ('error'->'can''t make target with given coins'); yourself)
]

{ #category : #test }
ChangeTest >> testErrorTestingForChangeSmallerThanTheSmallestOfCoins [
	| result |

	result := changeCalculator findFewestCoins: #(5 10 ) target: 3 .
	self assert: result equals: ((Dictionary new) add: ('error'->'can''t make target with given coins'); yourself)
]

{ #category : #test }
ChangeTest >> testLargeTargetValues [
	| result |

	result := changeCalculator findFewestCoins: #(1 2 5 10 20 50 100 ) target: 999 .
	self assert: result equals: #(2 2 5 20 20 50 100 100 100 100 100 100 100 100 100 )
]

{ #category : #test }
ChangeTest >> testMultipleCoinChange [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 25 100 ) target: 15 .
	self assert: result equals: #(5 10 )
]

{ #category : #test }
ChangeTest >> testNoCoinsMake0Change [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 21 25 ) target: 0 .
	self assert: result equals: #()
]

{ #category : #test }
ChangeTest >> testPossibleChangeWithoutUnitCoinsAvailable [
	| result |

	result := changeCalculator findFewestCoins: #(2 5 10 20 50 ) target: 21 .
	self assert: result equals: #(2 2 2 5 10 )
]

{ #category : #test }
ChangeTest >> testSingleCoinChange [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 25 100 ) target: 25 .
	self assert: result equals: #(25 )
]
