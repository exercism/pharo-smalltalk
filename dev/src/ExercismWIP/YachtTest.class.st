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
	^'af6fc316-9d41-0d00-8fe0-bca408866539'
]

{ #category : #config }
YachtTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #setup }
YachtTest >> setUp [
	yachtCalculator := Yacht new
]

{ #category : #tests }
YachtTest >> test01_Yacht [
	| result |

	result := yachtCalculator scoreCategory: 'yacht' dice: #(5 5 5 5 5 ) .
	self assert: result equals: 50
]

{ #category : #tests }
YachtTest >> test02_NotYacht [
	| result |

	result := yachtCalculator scoreCategory: 'yacht' dice: #(1 3 3 2 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test03_Ones [
	| result |

	result := yachtCalculator scoreCategory: 'ones' dice: #(1 1 1 3 5 ) .
	self assert: result equals: 3
]

{ #category : #tests }
YachtTest >> test04_OnesOutOfOrder [
	| result |

	result := yachtCalculator scoreCategory: 'ones' dice: #(3 1 1 5 1 ) .
	self assert: result equals: 3
]

{ #category : #tests }
YachtTest >> test05_NoOnes [
	| result |

	result := yachtCalculator scoreCategory: 'ones' dice: #(4 3 6 5 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test06_Twos [
	| result |

	result := yachtCalculator scoreCategory: 'twos' dice: #(2 3 4 5 6 ) .
	self assert: result equals: 2
]

{ #category : #tests }
YachtTest >> test07_Fours [
	| result |

	result := yachtCalculator scoreCategory: 'fours' dice: #(1 4 1 4 1 ) .
	self assert: result equals: 8
]

{ #category : #tests }
YachtTest >> test08_YachtCountedAsThrees [
	| result |

	result := yachtCalculator scoreCategory: 'threes' dice: #(3 3 3 3 3 ) .
	self assert: result equals: 15
]

{ #category : #tests }
YachtTest >> test09_YachtOf3sCountedAsFives [
	| result |

	result := yachtCalculator scoreCategory: 'fives' dice: #(3 3 3 3 3 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test10_Sixes [
	| result |

	result := yachtCalculator scoreCategory: 'sixes' dice: #(2 3 4 5 6 ) .
	self assert: result equals: 6
]

{ #category : #tests }
YachtTest >> test11_FullHouseTwoSmallThreeBig [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(2 2 4 4 4 ) .
	self assert: result equals: 16
]

{ #category : #tests }
YachtTest >> test12_FullHouseThreeSmallTwoBig [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(5 3 3 5 3 ) .
	self assert: result equals: 19
]

{ #category : #tests }
YachtTest >> test13_TwoPairIsNotAFullHouse [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(2 2 4 4 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test14_FourOfAKindIsNotAFullHouse [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(1 4 4 4 4 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test15_YachtIsNotAFullHouse [
	| result |

	result := yachtCalculator scoreCategory: 'full house' dice: #(2 2 2 2 2 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test16_FourOfAKind [
	| result |

	result := yachtCalculator scoreCategory: 'four of a kind' dice: #(6 6 4 6 6 ) .
	self assert: result equals: 24
]

{ #category : #tests }
YachtTest >> test17_YachtCanBeScoredAsFourOfAKind [
	| result |

	result := yachtCalculator scoreCategory: 'four of a kind' dice: #(3 3 3 3 3 ) .
	self assert: result equals: 12
]

{ #category : #tests }
YachtTest >> test18_FullHouseIsNotFourOfAKind [
	| result |

	result := yachtCalculator scoreCategory: 'four of a kind' dice: #(3 3 3 5 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test19_LittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(3 5 4 1 2 ) .
	self assert: result equals: 30
]

{ #category : #tests }
YachtTest >> test20_LittleStraightAsBigStraight [
	| result |

	result := yachtCalculator scoreCategory: 'big straight' dice: #(1 2 3 4 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test21_FourInOrderButNotALittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(1 1 2 3 4 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test22_NoPairsButNotALittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(1 2 3 4 6 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test23_MinimumIs1MaximumIs5ButNotALittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(1 1 3 4 5 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test24_BigStraight [
	| result |

	result := yachtCalculator scoreCategory: 'big straight' dice: #(4 6 2 5 3 ) .
	self assert: result equals: 30
]

{ #category : #tests }
YachtTest >> test25_BigStraightAsLittleStraight [
	| result |

	result := yachtCalculator scoreCategory: 'little straight' dice: #(6 5 4 3 2 ) .
	self assert: result equals: 0
]

{ #category : #tests }
YachtTest >> test26_Choice [
	| result |

	result := yachtCalculator scoreCategory: 'choice' dice: #(3 3 5 6 6 ) .
	self assert: result equals: 23
]

{ #category : #tests }
YachtTest >> test27_YachtAsChoice [
	| result |

	result := yachtCalculator scoreCategory: 'choice' dice: #(2 2 2 2 2 ) .
	self assert: result equals: 10
]
