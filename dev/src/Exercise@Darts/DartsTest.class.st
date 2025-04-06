"
# Darts

# Description

Calculate the points scored in a single toss of a Darts game.

[Darts][darts] is a game where players throw darts at a [target][darts-target].

In our particular instance of the game, the target rewards 4 different amounts of points, depending on where the dart lands:

![Our dart scoreboard with values from a complete miss to a bullseye](https://assets.exercism.org/images/exercises/darts/darts-scoreboard.svg)

- If the dart lands outside the target, player earns no points (0 points).
- If the dart lands in the outer circle of the target, player earns 1 point.
- If the dart lands in the middle circle of the target, player earns 5 points.
- If the dart lands in the inner circle of the target, player earns 10 points.

The outer circle has a radius of 10 units (this is equivalent to the total radius for the entire target), the middle circle a radius of 5 units, and the inner circle a radius of 1.
Of course, they are all centered at the same point — that is, the circles are [concentric][] defined by the coordinates (0, 0).

Given a point in the target (defined by its [Cartesian coordinates][cartesian-coordinates] `x` and `y`, where `x` and `y` are [real][real-numbers]), calculate the correct score earned by a dart landing at that point.

## Credit

The scoreboard image was created by [habere-et-dispertire][habere-et-dispertire] using [Inkscape][inkscape].

[darts]: https://en.wikipedia.org/wiki/Darts
[darts-target]: https://en.wikipedia.org/wiki/Darts#/media/File:Darts_in_a_dartboard.jpg
[concentric]: https://mathworld.wolfram.com/ConcentricCircles.html
[cartesian-coordinates]: https://www.mathsisfun.com/data/cartesian-coordinates.html
[real-numbers]: https://www.mathsisfun.com/numbers/real-numbers.html
[habere-et-dispertire]: https://exercism.org/profiles/habere-et-dispertire
[inkscape]: https://en.wikipedia.org/wiki/Inkscape

## Instructions append

The Pythagorean theorem will help.

"
Class {
	#name : 'DartsTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'darts'
	],
	#category : 'Exercise@Darts',
	#package : 'Exercise@Darts'
}

{ #category : 'config' }
DartsTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"

	^ (self createExerciseAfter: LeapTest)
		difficulty: 2;
		topics: #('conditionals' 'math');
		yourself
]

{ #category : 'config' }
DartsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a0df4a77-8720-4e1a-ac52-8060f1425a2b'
]

{ #category : 'config' }
DartsTest class >> version [
	"Generated from specification: 14 April 2019"
	^'1.2.1'
]

{ #category : 'running' }
DartsTest >> setUp [
	super setUp.
	darts := Darts new
]

{ #category : 'tests' }
DartsTest >> test01_MissedTarget [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'Missed target'>
	<exeTestUUID: '9033f731-0a3a-4d9c-b1c0-34a1c8362afb'>

	| result |

	result := darts scoreX:  -9 y: 9 .
	self assert: result equals: 0
]

{ #category : 'tests' }
DartsTest >> test02_OnTheOuterCircle [
	<exeTestName: 'On the outer circle'>
	<exeTestUUID: '4c9f6ff4-c489-45fd-be8a-1fcb08b4d0ba'>

	| result |

	result := darts scoreX: 0 y: 10 .
	self assert: result equals: 1
]

{ #category : 'tests' }
DartsTest >> test03_OnTheMiddleCircle [
	<exeTestName: 'On the middle circle'>
	<exeTestUUID: '14378687-ee58-4c9b-a323-b089d5274be8'>

	| result |

	result := darts scoreX:  -5 y: 0 .
	self assert: result equals: 5
]

{ #category : 'tests' }
DartsTest >> test04_OnTheInnerCircle [
	<exeTestName: 'On the inner circle'>
	<exeTestUUID: '849e2e63-85bd-4fed-bc3b-781ae962e2c9'>

	| result |

	result := darts scoreX: 0 y:  -1 .
	self assert: result equals: 10
]

{ #category : 'tests' }
DartsTest >> test05_ExactlyOnCenter [
	<exeTestName: 'Exactly on center'>
	<exeTestUUID: '1c5ffd9f-ea66-462f-9f06-a1303de5a226'>

	| result |

	result := darts scoreX: 0 y: 0 .
	self assert: result equals: 10
]

{ #category : 'tests' }
DartsTest >> test06_NearTheCenter [
	<exeTestName: 'Near the center'>
	<exeTestUUID: 'b65abce3-a679-4550-8115-4b74bda06088'>

	| result |

	result := darts scoreX:  -0.1 y:  -0.1 .
	self assert: result equals: 10
]

{ #category : 'tests' }
DartsTest >> test07_JustWithinTheInnerCircle [
	<exeTestName: 'Just within the inner circle'>
	<exeTestUUID: '66c29c1d-44f5-40cf-9927-e09a1305b399'>

	| result |

	result := darts scoreX: 0.7 y: 0.7 .
	self assert: result equals: 10
]

{ #category : 'tests' }
DartsTest >> test08_JustOutsideTheInnerCircle [
	<exeTestName: 'Just outside the inner circle'>
	<exeTestUUID: 'd1012f63-c97c-4394-b944-7beb3d0b141a'>

	| result |

	result := darts scoreX: 0.8 y:  -0.8 .
	self assert: result equals: 5
]

{ #category : 'tests' }
DartsTest >> test09_JustWithinTheMiddleCircle [
	<exeTestName: 'Just within the middle circle'>
	<exeTestUUID: 'ab2b5666-b0b4-49c3-9b27-205e790ed945'>

	| result |

	result := darts scoreX:  -3.5 y: 3.5 .
	self assert: result equals: 5
]

{ #category : 'tests' }
DartsTest >> test10_JustOutsideTheMiddleCircle [
	<exeTestName: 'Just outside the middle circle'>
	<exeTestUUID: '70f1424e-d690-4860-8caf-9740a52c0161'>

	| result |

	result := darts scoreX:  -3.6 y:  -3.6 .
	self assert: result equals: 1
]

{ #category : 'tests' }
DartsTest >> test11_JustWithinTheOuterCircle [
	<exeTestName: 'Just within the outer circle'>
	<exeTestUUID: 'a7dbf8db-419c-4712-8a7f-67602b69b293'>

	| result |

	result := darts scoreX:  -7.0 y: 7.0 .
	self assert: result equals: 1
]

{ #category : 'tests' }
DartsTest >> test12_JustOutsideTheOuterCircle [
	<exeTestName: 'Just outside the outer circle'>
	<exeTestUUID: 'e0f39315-9f9a-4546-96e4-a9475b885aa7'>

	| result |

	result := darts scoreX: 7.1 y:  -7.1 .
	self assert: result equals: 0
]

{ #category : 'tests' }
DartsTest >> test13_AsymmetricPositionBetweenTheInnerAndMiddleCircles [
	<exeTestName: 'Asymmetric position between the inner and middle circles'>
	<exeTestUUID: '045d7d18-d863-4229-818e-b50828c75d19'>

	| result |

	result := darts scoreX: 0.5 y:  -4 .
	self assert: result equals: 5
]
