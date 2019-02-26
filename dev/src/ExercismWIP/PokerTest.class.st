"
# Poker

Pick the best hand(s) from a list of poker hands.

See [wikipedia](https://en.wikipedia.org/wiki/List_of_poker_hands) for an
overview of poker hands.

## Hint

TBD

"
Class {
	#name : #PokerTest,
	#superclass : #ExercismTest,
	#instVars : [
		'pokerCalculator'
	],
	#category : #'ExercismWIP-Poker'
}

{ #category : #config }
PokerTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d474ebd9-2b3f-0d00-a2c4-5c6709f0590c'
]

{ #category : #config }
PokerTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
PokerTest >> setUp [
	pokerCalculator := Poker new
]

{ #category : #test }
PokerTest >> testAStraightBeatsThreeOfAKind [
	| result |

	result := pokerCalculator bestHands: #('4S 5H 4C 8D 4H' '3S 4D 2S 6D 5C' ) .
	self assert: result equals: #('3S 4D 2S 6D 5C' )
]

{ #category : #test }
PokerTest >> testATieHasMultipleWinners [
	| result |

	result := pokerCalculator bestHands: #('4D 5S 6S 8D 3C' '2S 4C 7S 9H 10H' '3S 4S 5D 6H JH' '3H 4H 5C 6C JD' ) .
	self assert: result equals: #('3S 4S 5D 6H JH' '3H 4H 5C 6C JD' )
]

{ #category : #test }
PokerTest >> testAcesCanEndAStraight10JQKA [
	| result |

	result := pokerCalculator bestHands: #('4S 5H 4C 8D 4H' '10D JH QS KD AC' ) .
	self assert: result equals: #('10D JH QS KD AC' )
]

{ #category : #test }
PokerTest >> testAcesCanStartAStraightA2345 [
	| result |

	result := pokerCalculator bestHands: #('4S 5H 4C 8D 4H' '4D AH 3S 2D 5C' ) .
	self assert: result equals: #('4D AH 3S 2D 5C' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveAFlushTieGoesToHighCardDownToTheLastOneIfNecessary [
	| result |

	result := pokerCalculator bestHands: #('4H 7H 8H 9H 6H' '2S 4S 5S 6S 7S' ) .
	self assert: result equals: #('4H 7H 8H 9H 6H' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveAFullHouseTieGoesToHighestrankedTriplet [
	| result |

	result := pokerCalculator bestHands: #('4H 4S 4D 9S 9D' '5H 5S 5D 8S 8D' ) .
	self assert: result equals: #('5H 5S 5D 8S 8D' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveFourOfAKindTieGoesToHighQuad [
	| result |

	result := pokerCalculator bestHands: #('2S 2H 2C 8D 2D' '4S 5H 5S 5D 5C' ) .
	self assert: result equals: #('4S 5H 5S 5D 5C' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveStraightFlushTieGoesToHighestrankedCard [
	| result |

	result := pokerCalculator bestHands: #('4H 6H 7H 8H 5H' '5S 7S 8S 9S 6S' ) .
	self assert: result equals: #('5S 7S 8S 9S 6S' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveThreeOfAKindTieGoesToHighestRankedTriplet [
	| result |

	result := pokerCalculator bestHands: #('2S 2H 2C 8D JH' '4S AH AS 8C AD' ) .
	self assert: result equals: #('4S AH AS 8C AD' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveTwoIdenticallyRankedPairsTieGoesToRemainingCardkicker [
	| result |

	result := pokerCalculator bestHands: #('JD QH JS 8D QC' 'JS QS JC 2D QD' ) .
	self assert: result equals: #('JD QH JS 8D QC' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveTwoPairsHighestRankedPairWins [
	| result |

	result := pokerCalculator bestHands: #('2S 8H 2D 8D 3H' '4S 5H 4C 8S 5D' ) .
	self assert: result equals: #('2S 8H 2D 8D 3H' )
]

{ #category : #test }
PokerTest >> testBothHandsHaveTwoPairsWithTheSameHighestRankedPairTieGoesToLowPair [
	| result |

	result := pokerCalculator bestHands: #('2S QS 2C QD JH' 'JD QH JS 8D QC' ) .
	self assert: result equals: #('JD QH JS 8D QC' )
]

{ #category : #test }
PokerTest >> testBothHandsWithAStraightTieGoesToHighestRankedCard [
	| result |

	result := pokerCalculator bestHands: #('4S 6C 7S 8D 5H' '5S 7H 8S 9D 6H' ) .
	self assert: result equals: #('5S 7H 8S 9D 6H' )
]

{ #category : #test }
PokerTest >> testEvenThoughAnAceIsUsuallyHighA5highStraightIsTheLowestscoringStraight [
	| result |

	result := pokerCalculator bestHands: #('2H 3C 4D 5D 6H' '4S AH 3S 2D 5H' ) .
	self assert: result equals: #('2H 3C 4D 5D 6H' )
]

{ #category : #test }
PokerTest >> testFlushBeatsAStraight [
	| result |

	result := pokerCalculator bestHands: #('4C 6H 7D 8D 5H' '2S 4S 5S 6S 7S' ) .
	self assert: result equals: #('2S 4S 5S 6S 7S' )
]

{ #category : #test }
PokerTest >> testFourOfAKindBeatsAFullHouse [
	| result |

	result := pokerCalculator bestHands: #('4S 5H 4D 5D 4H' '3S 3H 2S 3D 3C' ) .
	self assert: result equals: #('3S 3H 2S 3D 3C' )
]

{ #category : #test }
PokerTest >> testFullHouseBeatsAFlush [
	| result |

	result := pokerCalculator bestHands: #('3H 6H 7H 8H 5H' '4S 5H 4C 5D 4H' ) .
	self assert: result equals: #('4S 5H 4C 5D 4H' )
]

{ #category : #test }
PokerTest >> testHighestCardOutOfAllHandsWins [
	| result |

	result := pokerCalculator bestHands: #('4D 5S 6S 8D 3C' '2S 4C 7S 9H 10H' '3S 4S 5D 6H JH' ) .
	self assert: result equals: #('3S 4S 5D 6H JH' )
]

{ #category : #test }
PokerTest >> testHighestPairWins [
	| result |

	result := pokerCalculator bestHands: #('4S 2H 6S 2D JH' '2S 4H 6C 4D JD' ) .
	self assert: result equals: #('2S 4H 6C 4D JD' )
]

{ #category : #test }
PokerTest >> testMultipleHandsWithTheSameHighCardsTieComparesNextHighestRankedDownToLastCard [
	| result |

	result := pokerCalculator bestHands: #('3S 5H 6S 8D 7H' '2S 5D 6D 8C 7S' ) .
	self assert: result equals: #('3S 5H 6S 8D 7H' )
]

{ #category : #test }
PokerTest >> testOnePairBeatsHighCard [
	| result |

	result := pokerCalculator bestHands: #('4S 5H 6C 8D KH' '2S 4H 6S 4D JH' ) .
	self assert: result equals: #('2S 4H 6S 4D JH' )
]

{ #category : #test }
PokerTest >> testSingleHandAlwaysWins [
	| result |

	result := pokerCalculator bestHands: #('4S 5S 7H 8D JC' ) .
	self assert: result equals: #('4S 5S 7H 8D JC' )
]

{ #category : #test }
PokerTest >> testStraightFlushBeatsFourOfAKind [
	| result |

	result := pokerCalculator bestHands: #('4S 5H 5S 5D 5C' '7S 8S 9S 6S 10S' ) .
	self assert: result equals: #('7S 8S 9S 6S 10S' )
]

{ #category : #test }
PokerTest >> testThreeOfAKindBeatsTwoPair [
	| result |

	result := pokerCalculator bestHands: #('2S 8H 2H 8D JH' '4S 5H 4C 8S 4H' ) .
	self assert: result equals: #('4S 5H 4C 8S 4H' )
]

{ #category : #test }
PokerTest >> testTwoPairsBeatsOnePair [
	| result |

	result := pokerCalculator bestHands: #('2S 8H 6S 8D JH' '4S 5H 4C 8C 5C' ) .
	self assert: result equals: #('4S 5H 4C 8C 5C' )
]

{ #category : #test }
PokerTest >> testWithMultipleDecksBothHandsHaveAFullHouseWithTheSameTripletTieGoesToThePair [
	| result |

	result := pokerCalculator bestHands: #('5H 5S 5D 9S 9D' '5H 5S 5D 8S 8D' ) .
	self assert: result equals: #('5H 5S 5D 9S 9D' )
]

{ #category : #test }
PokerTest >> testWithMultipleDecksBothHandsWithIdenticalFourOfAKindTieDeterminedByKicker [
	| result |

	result := pokerCalculator bestHands: #('3S 3H 2S 3D 3C' '3S 3H 4S 3D 3C' ) .
	self assert: result equals: #('3S 3H 4S 3D 3C' )
]

{ #category : #test }
PokerTest >> testWithMultipleDecksTwoPlayersCanHaveSameThreeOfAKindTiesGoToHighestRemainingCards [
	| result |

	result := pokerCalculator bestHands: #('4S AH AS 7C AD' '4S AH AS 8C AD' ) .
	self assert: result equals: #('4S AH AS 8C AD' )
]
