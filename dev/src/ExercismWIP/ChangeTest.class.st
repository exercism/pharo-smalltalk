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
	#name : 'ChangeTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'changeCalculator'
	],
	#category : 'ExercismWIP-Change',
	#package : 'ExercismWIP',
	#tag : 'Change'
}

{ #category : 'config' }
ChangeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'eb88a52e-b043-0d00-924a-1dc202a76407'
]

{ #category : 'config' }
ChangeTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.3.0'
]

{ #category : 'running' }
ChangeTest >> setUp [
	super setUp.
	changeCalculator := Change new
]

{ #category : 'tests' }
ChangeTest >> test01_SingleCoinChange [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 25 100 ) target: 25 .
	self assert: result equals: #(25 )
]

{ #category : 'tests' }
ChangeTest >> test02_MultipleCoinChange [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 25 100 ) target: 15 .
	self assert: result equals: #(5 10 )
]

{ #category : 'tests' }
ChangeTest >> test03_ChangeWithLilliputianCoins [
	| result |

	result := changeCalculator findFewestCoins: #(1 4 15 20 50 ) target: 23 .
	self assert: result equals: #(4 4 15 )
]

{ #category : 'tests' }
ChangeTest >> test04_ChangeWithLowerElboniaCoins [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 21 25 ) target: 63 .
	self assert: result equals: #(21 21 21 )
]

{ #category : 'tests' }
ChangeTest >> test05_LargeTargetValues [
	| result |

	result := changeCalculator findFewestCoins: #(1 2 5 10 20 50 100 ) target: 999 .
	self assert: result equals: #(2 2 5 20 20 50 100 100 100 100 100 100 100 100 100 )
]

{ #category : 'tests' }
ChangeTest >> test06_PossibleChangeWithoutUnitCoinsAvailable [
	| result |

	result := changeCalculator findFewestCoins: #(2 5 10 20 50 ) target: 21 .
	self assert: result equals: #(2 2 2 5 10 )
]

{ #category : 'tests' }
ChangeTest >> test07_AnotherPossibleChangeWithoutUnitCoinsAvailable [
	| result |

	result := changeCalculator findFewestCoins: #(4 5 ) target: 27 .
	self assert: result equals: #(4 4 4 5 5 5 )
]

{ #category : 'tests' }
ChangeTest >> test08_NoCoinsMake0Change [
	| result |

	result := changeCalculator findFewestCoins: #(1 5 10 21 25 ) target: 0 .
	self assert: result equals: #()
]

{ #category : 'tests' }
ChangeTest >> test09_ErrorTestingForChangeSmallerThanTheSmallestOfCoins [
	| result |

	self
		should: [ result := changeCalculator findFewestCoins: #(5 10 ) target: 3 ]
		raise: Error
		whoseDescriptionIncludes: 'can''t make target with given coins'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
ChangeTest >> test10_ErrorIfNoCombinationCanAddUpToTarget [
	| result |

	self
		should: [ result := changeCalculator findFewestCoins: #(5 10 ) target: 94 ]
		raise: Error
		whoseDescriptionIncludes: 'can''t make target with given coins'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
ChangeTest >> test11_CannotFindNegativeChangeValues [
	| result |

	self
		should: [ result := changeCalculator findFewestCoins: #(1 2 5 ) target:  -5 ]
		raise: Error
		whoseDescriptionIncludes: 'target can''t be negative'
		description: 'Should get an error with the correct description'
]
