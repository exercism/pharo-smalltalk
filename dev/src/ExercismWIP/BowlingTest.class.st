"
# Bowling

Score a bowling game.

Bowling is a game where players roll a heavy ball to knock down pins
arranged in a triangle. Write code to keep track of the score
of a game of bowling.

## Scoring Bowling

The game consists of 10 frames. A frame is composed of one or two ball
throws with 10 pins standing at frame initialization. There are three
cases for the tabulation of a frame.

* An open frame is where a score of less than 10 is recorded for the
  frame. In this case the score for the frame is the number of pins
  knocked down.

* A spare is where all ten pins are knocked down by the second
  throw. The total value of a spare is 10 plus the number of pins
  knocked down in their next throw.

* A strike is where all ten pins are knocked down by the first
  throw. The total value of a strike is 10 plus the number of pins
  knocked down in the next two throws. If a strike is immediately
  followed by a second strike, then the value of the first strike
  cannot be determined until the ball is thrown one more time.

Here is a three frame example:

| Frame 1         | Frame 2       | Frame 3                |
| :-------------: |:-------------:| :---------------------:|
| X (strike)      | 5/ (spare)    | 9 0 (open frame)       |

Frame 1 is (10 + 5 + 5) = 20

Frame 2 is (5 + 5 + 9) = 19

Frame 3 is (9 + 0) = 9

This means the current running total is 48.

The tenth frame in the game is a special case. If someone throws a
strike or a spare then they get a fill ball. Fill balls exist to
calculate the total of the 10th frame. Scoring a strike or spare on
the fill ball does not give the player more fill balls. The total
value of the 10th frame is the total number of pins knocked down.

For a tenth frame of X1/ (strike and a spare), the total value is 20.

For a tenth frame of XXX (three strikes), the total value is 30.

## Requirements

Write code to keep track of the score of a game of bowling. It should
support two operations:

* `roll(pins : int)` is called each time the player rolls a ball.  The
  argument is the number of pins knocked down.
* `score() : int` is called only at the very end of the game.  It
  returns the total score for that game.

## Hint

TBD

"
Class {
	#name : #BowlingTest,
	#superclass : #ExercismTest,
	#instVars : [
		'bowlingCalculator'
	],
	#category : #'ExercismWIP-Bowling'
}

{ #category : #config }
BowlingTest class >> uuid [
	"Answer a unique id for this exercise"
	^'7875f5d9-2b3f-0d00-a2ce-4ad409f0590c'
]

{ #category : #config }
BowlingTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
BowlingTest >> setUp [
	bowlingCalculator := Bowling new
]

{ #category : #test }
BowlingTest >> testARollCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 11 previousRolls: #() .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #test }
BowlingTest >> testASpareFollowedByZerosIsWorthTenPoints [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 10
]

{ #category : #test }
BowlingTest >> testASpareInTheLastFrameGetsAOneRollBonusThatIsCountedOnce [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7 ) .
	self assert: result equals: 17
]

{ #category : #test }
BowlingTest >> testAStrikeEarnsTenPointsInAFrameWithASingleRoll [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 10
]

{ #category : #test }
BowlingTest >> testAStrikeInTheLastFrameGetsATwoRollBonusThatIsCountedOnce [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1 ) .
	self assert: result equals: 18
]

{ #category : #test }
BowlingTest >> testAStrikeWithTheOneRollBonusAfterASpareInTheLastFrameDoesNotGetABonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10 ) .
	self assert: result equals: 20
]

{ #category : #test }
BowlingTest >> testAllStrikesIsAPerfectGame [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 10 10 10 10 10 10 10 10 10 10 10 ) .
	self assert: result equals: 300
]

{ #category : #test }
BowlingTest >> testAnIncompleteGameCannotBeScored [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #test }
BowlingTest >> testAnUnstartedGameCannotBeScored [
	| result |

	result := bowlingCalculator scorePreviousRolls: #() .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #test }
BowlingTest >> testBonusRollAfterAStrikeInTheLastFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 11 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #test }
BowlingTest >> testBonusRollForASpareInTheLastFrameMustBeRolledBeforeScoreCanBeCalculated [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #test }
BowlingTest >> testBonusRollsForAStrikeInTheLastFrameMustBeRolledBeforeScoreCanBeCalculated [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #test }
BowlingTest >> testBothBonusRollsForAStrikeInTheLastFrameMustBeRolledBeforeScoreCanBeCalculated [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #test }
BowlingTest >> testCannotRollAfterBonusRollForSpare [
	| result |

	result := bowlingCalculator roll: 2 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Cannot roll after game is over'); yourself)
]

{ #category : #test }
BowlingTest >> testCannotRollAfterBonusRollsForStrike [
	| result |

	result := bowlingCalculator roll: 2 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Cannot roll after game is over'); yourself)
]

{ #category : #test }
BowlingTest >> testCannotRollIfGameAlreadyHasTenFrames [
	| result |

	result := bowlingCalculator roll: 0 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Cannot roll after game is over'); yourself)
]

{ #category : #test }
BowlingTest >> testConsecutiveSparesEachGetAOneRollBonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 31
]

{ #category : #test }
BowlingTest >> testConsecutiveStrikesEachGetTheTwoRollBonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 81
]

{ #category : #test }
BowlingTest >> testPointsScoredInTheRollAfterASpareAreCountedTwice [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 16
]

{ #category : #test }
BowlingTest >> testPointsScoredInTheTwoRollsAfterAStrikeAreCountedTwiceAsABonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 26
]

{ #category : #test }
BowlingTest >> testRollingASpareWithTheTwoRollBonusDoesNotGetABonusRoll [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3 ) .
	self assert: result equals: 20
]

{ #category : #test }
BowlingTest >> testRollsCannotScoreNegativePoints [
	| result |

	result := bowlingCalculator roll:  -1 previousRolls: #() .
	self assert: result equals: ((Dictionary new) add: ('error'->'Negative roll is invalid'); yourself)
]

{ #category : #test }
BowlingTest >> testSecondBonusRollAfterAStrikeInTheLastFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 11 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #test }
BowlingTest >> testShouldBeAbleToScoreAGameWithAllZeros [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 0
]

{ #category : #test }
BowlingTest >> testShouldBeAbleToScoreAGameWithNoStrikesOrSpares [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 ) .
	self assert: result equals: 90
]

{ #category : #test }
BowlingTest >> testStrikesWithTheTwoRollBonusDoNotGetBonusRolls [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10 ) .
	self assert: result equals: 30
]

{ #category : #test }
BowlingTest >> testTheSecondBonusRollsAfterAStrikeInTheLastFrameCannotBeAStrikeIfTheFirstOneIsNotAStrike [
	| result |

	result := bowlingCalculator roll: 10 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #test }
BowlingTest >> testTwoBonusRollsAfterAStrikeInTheLastFrameCanScoreMoreThan10PointsIfOneIsAStrike [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6 ) .
	self assert: result equals: 26
]

{ #category : #test }
BowlingTest >> testTwoBonusRollsAfterAStrikeInTheLastFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 6 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #test }
BowlingTest >> testTwoRollsInAFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 6 previousRolls: #(5 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]
