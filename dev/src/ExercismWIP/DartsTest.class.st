"
# Darts

Write a function that returns the earned points in a single toss of a Darts game.

[Darts](https://en.wikipedia.org/wiki/Darts) is a game where players
throw darts to a [target](https://en.wikipedia.org/wiki/Darts#/media/File:Darts_in_a_dartboard.jpg).

In our particular instance of the game, the target rewards with 4 different amounts of points, depending on where the dart lands:

* If the dart lands outside the target, player earns no points (0 points).
* If the dart lands in the outer circle of the target, player earns 1 point.
* If the dart lands in the middle circle of the target, player earns 5 points.
* If the dart lands in the inner circle of the target, player earns 10 points.

The outer circle has a radius of 10 units (This is equivalent to the total radius for the entire target), the middle circle a radius of 5 units, and the inner circle a radius of 1. Of course, they are all centered to the same point (That is, the circles are [concentric](http://mathworld.wolfram.com/ConcentricCircles.html)) defined by the coordinates (0, 0).

Write a function that given a point in the target (defined by its `real` cartesian coordinates `x` and `y`), returns the correct amount earned by a dart landing in that point.
## Hint

TBD

"
Class {
	#name : #DartsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'dartsCalculator'
	],
	#category : #'ExercismWIP-Darts'
}

{ #category : #config }
DartsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'34ed17da-2b3f-0d00-a2ef-8e5709f0590c'
]

{ #category : #config }
DartsTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
DartsTest >> setUp [
	dartsCalculator := Darts new
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsInTheInnerCircle [
	| result |

	result := dartsCalculator scoreX:  -0.1 y:  -0.1 .
	self assert: result equals: 10
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsInTheMiddleCircle [
	| result |

	result := dartsCalculator scoreX: 0.8 y:  -0.8 .
	self assert: result equals: 5
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsInTheOuterCircle [
	| result |

	result := dartsCalculator scoreX: 4 y: 4 .
	self assert: result equals: 1
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsJustInTheBorderOfTheTarget [
	| result |

	result := dartsCalculator scoreX: 0 y: 10 .
	self assert: result equals: 1
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsOutsideTheTarget [
	| result |

	result := dartsCalculator scoreX:  -9 y: 9 .
	self assert: result equals: 0
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsRightInTheBorderBetweenMiddleAndInnerCircles [
	| result |

	result := dartsCalculator scoreX: 0 y:  -1 .
	self assert: result equals: 10
]

{ #category : #test }
DartsTest >> testReturnTheCorrectAmountEarnedByADartLandingInAGivenPointInTheTargetProblemADartLandsRightInTheBorderBetweenOuterAndMiddleCircles [
	| result |

	result := dartsCalculator scoreX: 5 y: 0 .
	self assert: result equals: 5
]
