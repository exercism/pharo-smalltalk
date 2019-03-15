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
	^'8711c3bb-8040-0d00-8104-cce801deb008'
]

{ #category : #config }
BowlingTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.2.0'
]

{ #category : #setup }
BowlingTest >> setUp [
	bowlingCalculator := Bowling new
]

{ #category : #tests }
BowlingTest >> test01_ShouldBeAbleToScoreAGameWithAllZeros [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 0
]

{ #category : #tests }
BowlingTest >> test02_ShouldBeAbleToScoreAGameWithNoStrikesOrSpares [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 ) .
	self assert: result equals: 90
]

{ #category : #tests }
BowlingTest >> test03_ASpareFollowedByZerosIsWorthTenPoints [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 10
]

{ #category : #tests }
BowlingTest >> test04_PointsScoredInTheRollAfterASpareAreCountedTwice [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 16
]

{ #category : #tests }
BowlingTest >> test05_ConsecutiveSparesEachGetAOneRollBonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 31
]

{ #category : #tests }
BowlingTest >> test06_ASpareInTheLastFrameGetsAOneRollBonusThatIsCountedOnce [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7 ) .
	self assert: result equals: 17
]

{ #category : #tests }
BowlingTest >> test07_AStrikeEarnsTenPointsInAFrameWithASingleRoll [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 10
]

{ #category : #tests }
BowlingTest >> test08_PointsScoredInTheTwoRollsAfterAStrikeAreCountedTwiceAsABonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 26
]

{ #category : #tests }
BowlingTest >> test09_ConsecutiveStrikesEachGetTheTwoRollBonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: 81
]

{ #category : #tests }
BowlingTest >> test10_AStrikeInTheLastFrameGetsATwoRollBonusThatIsCountedOnce [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1 ) .
	self assert: result equals: 18
]

{ #category : #tests }
BowlingTest >> test11_RollingASpareWithTheTwoRollBonusDoesNotGetABonusRoll [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3 ) .
	self assert: result equals: 20
]

{ #category : #tests }
BowlingTest >> test12_StrikesWithTheTwoRollBonusDoNotGetBonusRolls [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10 ) .
	self assert: result equals: 30
]

{ #category : #tests }
BowlingTest >> test13_AStrikeWithTheOneRollBonusAfterASpareInTheLastFrameDoesNotGetABonus [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10 ) .
	self assert: result equals: 20
]

{ #category : #tests }
BowlingTest >> test14_AllStrikesIsAPerfectGame [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(10 10 10 10 10 10 10 10 10 10 10 10 ) .
	self assert: result equals: 300
]

{ #category : #tests }
BowlingTest >> test15_RollsCannotScoreNegativePoints [
	| result |

	result := bowlingCalculator roll:  -1 previousRolls: #() .
	self assert: result equals: ((Dictionary new) add: ('error'->'Negative roll is invalid'); yourself)
]

{ #category : #tests }
BowlingTest >> test16_ARollCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 11 previousRolls: #() .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #tests }
BowlingTest >> test17_TwoRollsInAFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 6 previousRolls: #(5 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #tests }
BowlingTest >> test18_BonusRollAfterAStrikeInTheLastFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 11 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #tests }
BowlingTest >> test19_TwoBonusRollsAfterAStrikeInTheLastFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 6 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #tests }
BowlingTest >> test20_TwoBonusRollsAfterAStrikeInTheLastFrameCanScoreMoreThan10PointsIfOneIsAStrike [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6 ) .
	self assert: result equals: 26
]

{ #category : #tests }
BowlingTest >> test21_TheSecondBonusRollsAfterAStrikeInTheLastFrameCannotBeAStrikeIfTheFirstOneIsNotAStrike [
	| result |

	result := bowlingCalculator roll: 10 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #tests }
BowlingTest >> test22_SecondBonusRollAfterAStrikeInTheLastFrameCannotScoreMoreThan10Points [
	| result |

	result := bowlingCalculator roll: 11 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Pin count exceeds pins on the lane'); yourself)
]

{ #category : #tests }
BowlingTest >> test23_AnUnstartedGameCannotBeScored [
	| result |

	result := bowlingCalculator scorePreviousRolls: #() .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #tests }
BowlingTest >> test24_AnIncompleteGameCannotBeScored [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #tests }
BowlingTest >> test25_CannotRollIfGameAlreadyHasTenFrames [
	| result |

	result := bowlingCalculator roll: 0 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Cannot roll after game is over'); yourself)
]

{ #category : #tests }
BowlingTest >> test26_BonusRollsForAStrikeInTheLastFrameMustBeRolledBeforeScoreCanBeCalculated [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #tests }
BowlingTest >> test27_BothBonusRollsForAStrikeInTheLastFrameMustBeRolledBeforeScoreCanBeCalculated [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #tests }
BowlingTest >> test28_BonusRollForASpareInTheLastFrameMustBeRolledBeforeScoreCanBeCalculated [
	| result |

	result := bowlingCalculator scorePreviousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Score cannot be taken until the end of the game'); yourself)
]

{ #category : #tests }
BowlingTest >> test29_CannotRollAfterBonusRollForSpare [
	| result |

	result := bowlingCalculator roll: 2 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Cannot roll after game is over'); yourself)
]

{ #category : #tests }
BowlingTest >> test30_CannotRollAfterBonusRollsForStrike [
	| result |

	result := bowlingCalculator roll: 2 previousRolls: #(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2 ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Cannot roll after game is over'); yourself)
]
