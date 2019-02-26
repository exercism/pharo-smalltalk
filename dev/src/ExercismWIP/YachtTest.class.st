"
# Yacht

# Score a single throw of dice in *Yacht*

The dice game [Yacht](https://en.wikipedia.org/wiki/Yacht_(dice_game)) is from
the same family as Poker Dice, Generala and particularly Yahtzee, of which it
is a precursor. In the game, five dice are rolled and the result can be entered
in any of twelve categories. The score of a throw of the dice depends on
category chosen.

## Scores in Yacht

| Category | Score | Description | Example |
| -------- | ----- | ----------- | ------- |
| Ones | 1 × number of ones | Any combination	| 1 1 1 4 5 scores 3 |
| Twos | 2 × number of twos | Any combination | 2 2 3 4 5 scores 4 |
| Threes | 3 × number of threes | Any combination | 3 3 3 3 3 scores 15 |
| Fours | 4 × number of fours | Any combination | 1 2 3 3 5 scores 0 |
| Fives | 5 × number of fives| Any combination | 5 1 5 2 5 scores 15 |
| Sixes | 6 × number of sixes | Any combination | 2 3 4 5 6 scores 6 |
| Full House | Total of the dice | Three of one number and two of another | 3 3 3 5 5 scores 19 |
| Four of a Kind | Total of the four dice | At least four dice showing the same face | 4 4 4 4 6 scores 16 |
| Little Straight |  30 points | 1-2-3-4-5 | 1 2 3 4 5 scores 30 |
| Big Straight | 30 points | 2-3-4-5-6 | 2 3 4 5 6 scores 30 |
| Choice | Sum of the dice | Any combination | 2 3 3 4 6 scores 18 |
| Yacht | 50 points | All five dice showing the same face | 4 4 4 4 4 scores 50 |

If the dice do not satisfy the requirements of a category, the score is zero.
If, for example, *Four Of A Kind* is entered in the *Yacht* category, zero
points are scored. A *Yacht* scores zero if entered in the *Full House* category.

## Task
Given a list of values for five dice and a category, your solution should return
the score of the dice for that category. If the dice do not satisfy the requirements
of the category your solution should return 0. You can assume that five values
will always be presented, and the value of each will be between one and six
inclusively. You should not assume that the dice are ordered.

## Hint

TBD

"
Class {
	#name : #YachtTest,
	#superclass : #ExercismTest,
	#instVars : [
		'yachtCalculator'
	],
	#category : #'ExercismWIP-Yacht'
}

{ #category : #config }
YachtTest class >> uuid [
	"Answer a unique id for this exercise"
	^'0b6af8d9-2b3f-0d00-a2d1-298d09f0590c'
]

{ #category : #config }
YachtTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
YachtTest >> setUp [
	yachtCalculator := Yacht new
]

{ #category : #test }
YachtTest >> testBigStraight [
	| result |

	result := yachtCalculator scoreCategory: 'big straight' dice: #(4 6 2 5 3 ) .
	self assert: result equals: 30
]

{ #category : #test }
YachtTest >> testBigStraightAsLittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(6 5 4 3 2 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testChoice [
	| result |

	result := yachtCalculator scoreCategory: 'choice' dice: #(3 3 5 6 6 ) .
	self assert: result equals: 23
]

{ #category : #test }
YachtTest >> testFourInOrderButNotALittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(1 1 2 3 4 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testFourOfAKind [
	| result |

	result := yachtCalculator scoreCategory: 'four of a kind' dice: #(6 6 4 6 6 ) .
	self assert: result equals: 24
]

{ #category : #test }
YachtTest >> testFourOfAKindIsNotAFullHouse [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(1 4 4 4 4 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testFours [
	| result |

	result := yachtCalculator scoreCategory: 'fours' dice: #(1 4 1 4 1 ) .
	self assert: result equals: 8
]

{ #category : #test }
YachtTest >> testFullHouseIsNotFourOfAKind [
	| result |

	result := yachtCalculator scoreCategory: 'four of a kind' dice: #(3 3 3 5 5 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testFullHouseThreeSmallTwoBig [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(5 3 3 5 3 ) .
	self assert: result equals: 19
]

{ #category : #test }
YachtTest >> testFullHouseTwoSmallThreeBig [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(2 2 4 4 4 ) .
	self assert: result equals: 16
]

{ #category : #test }
YachtTest >> testLittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(3 5 4 1 2 ) .
	self assert: result equals: 30
]

{ #category : #test }
YachtTest >> testLittleStraightAsBigStraight [
	| result |

	result := yachtCalculator scoreCategory: 'big straight' dice: #(1 2 3 4 5 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testMinimumIs1MaximumIs5ButNotALittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(1 1 3 4 5 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testNoOnes [
	| result |

	result := yachtCalculator scoreCategory: 'ones' dice: #(4 3 6 5 5 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testNoPairsButNotALittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(1 2 3 4 6 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testNotYacht [
	| result |

	result := yachtCalculator scoreCategory: 'yacht' dice: #(1 3 3 2 5 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testOnes [
	| result |

	result := yachtCalculator scoreCategory: 'ones' dice: #(1 1 1 3 5 ) .
	self assert: result equals: 3
]

{ #category : #test }
YachtTest >> testOnesOutOfOrder [
	| result |

	result := yachtCalculator scoreCategory: 'ones' dice: #(3 1 1 5 1 ) .
	self assert: result equals: 3
]

{ #category : #test }
YachtTest >> testSixes [
	| result |

	result := yachtCalculator scoreCategory: 'sixes' dice: #(2 3 4 5 6 ) .
	self assert: result equals: 6
]

{ #category : #test }
YachtTest >> testTwoPairIsNotAFullHouse [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(2 2 4 4 5 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testTwos [
	| result |

	result := yachtCalculator scoreCategory: 'twos' dice: #(2 3 4 5 6 ) .
	self assert: result equals: 2
]

{ #category : #test }
YachtTest >> testYacht [
	| result |

	result := yachtCalculator scoreCategory: 'yacht' dice: #(5 5 5 5 5 ) .
	self assert: result equals: 50
]

{ #category : #test }
YachtTest >> testYachtAsChoice [
	| result |

	result := yachtCalculator scoreCategory: 'choice' dice: #(2 2 2 2 2 ) .
	self assert: result equals: 10
]

{ #category : #test }
YachtTest >> testYachtCanBeScoredAsFourOfAKind [
	| result |

	result := yachtCalculator scoreCategory: 'four of a kind' dice: #(3 3 3 3 3 ) .
	self assert: result equals: 12
]

{ #category : #test }
YachtTest >> testYachtCountedAsThrees [
	| result |

	result := yachtCalculator scoreCategory: 'threes' dice: #(3 3 3 3 3 ) .
	self assert: result equals: 15
]

{ #category : #test }
YachtTest >> testYachtIsNotAFullHouse [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(2 2 2 2 2 ) .
	self assert: result equals: 0
]

{ #category : #test }
YachtTest >> testYachtOf3sCountedAsFives [
	| result |

	result := yachtCalculator scoreCategory: 'fives' dice: #(3 3 3 3 3 ) .
	self assert: result equals: 0
]
