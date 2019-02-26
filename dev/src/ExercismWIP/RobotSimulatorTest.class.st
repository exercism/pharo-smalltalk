"
# Robot Simulator

Write a robot simulator.

A robot factory's test facility needs a program to verify robot movements.

The robots have three possible movements:

- turn right
- turn left
- advance

Robots are placed on a hypothetical infinite grid, facing a particular
direction (north, east, south, or west) at a set of {x,y} coordinates,
e.g., {3,8}, with coordinates increasing to the north and east.

The robot then receives a number of instructions, at which point the
testing facility verifies the robot's new position, and in which
direction it is pointing.

- The letter-string ""RAALAL"" means:
  - Turn right
  - Advance twice
  - Turn left
  - Advance once
  - Turn left yet again
- Say a robot starts at {7, 3} facing north. Then running this stream
  of instructions should leave it at {9, 4} facing west.

## Hint

TBD

"
Class {
	#name : #RobotSimulatorTest,
	#superclass : #ExercismTest,
	#instVars : [
		'robotSimulatorCalculator'
	],
	#category : #'ExercismWIP-RobotSimulator'
}

{ #category : #config }
RobotSimulatorTest class >> uuid [
	"Answer a unique id for this exercise"
	^'fbac3eda-2b3f-0d00-a312-0dd009f0590c'
]

{ #category : #config }
RobotSimulatorTest class >> version [
	"Generated from specification: 26 February 2019"
	^'3.1.0'
]

{ #category : #setup }
RobotSimulatorTest >> setUp [
	robotSimulatorCalculator := RobotSimulator new
]

{ #category : #test }
RobotSimulatorTest >> testARobotIsCreatedWithAPositionAndADirectionNegativePositionsAreAllowed [
	| result |

	result := robotSimulatorCalculator createDirection: 'south' position: ((Dictionary new) add: ('x'-> -1); add: ('y'-> -1); yourself) .
	self assert: result equals: ((Dictionary new) add: ('direction'->'south'); add: ('position'->((Dictionary new) add: ('x'-> -1); add: ('y'-> -1); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testARobotIsCreatedWithAPositionAndADirectionRobotsAreCreatedWithAPositionAndDirection [
	| result |

	result := robotSimulatorCalculator createDirection: 'north' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) .
	self assert: result equals: ((Dictionary new) add: ('direction'->'north'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testMovesTheRobotForward1SpaceInTheDirectionItIsPointingDecreasesTheXCoordinateByOneWhenFacingWest [
	| result |

	result := robotSimulatorCalculator moveDirection: 'west' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'A' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'west'); add: ('position'->((Dictionary new) add: ('x'-> -1); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testMovesTheRobotForward1SpaceInTheDirectionItIsPointingDecreasesTheYCoordinateByOneWhenFacingSouth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'south' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'A' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'south'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'-> -1); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testMovesTheRobotForward1SpaceInTheDirectionItIsPointingIncreasesTheXCoordinateByOneWhenFacingEast [
	| result |

	result := robotSimulatorCalculator moveDirection: 'east' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'A' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'east'); add: ('position'->((Dictionary new) add: ('x'->1); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testMovesTheRobotForward1SpaceInTheDirectionItIsPointingIncreasesTheYCoordinateOneWhenFacingNorth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'north' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'A' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'north'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->1); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesClockwiseChangesTheDirectionFromEastToSouth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'east' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'R' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'south'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesClockwiseChangesTheDirectionFromNorthToEast [
	| result |

	result := robotSimulatorCalculator moveDirection: 'north' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'R' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'east'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesClockwiseChangesTheDirectionFromSouthToWest [
	| result |

	result := robotSimulatorCalculator moveDirection: 'south' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'R' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'west'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesClockwiseChangesTheDirectionFromWestToNorth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'west' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'R' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'north'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesCounterclockwiseChangesTheDirectionFromEastToNorth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'east' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'L' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'north'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesCounterclockwiseChangesTheDirectionFromNorthToWest [
	| result |

	result := robotSimulatorCalculator moveDirection: 'north' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'L' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'west'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesCounterclockwiseChangesTheDirectionFromSouthToEast [
	| result |

	result := robotSimulatorCalculator moveDirection: 'south' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'L' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'east'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testRotatesTheRobotsDirection90DegreesCounterclockwiseChangesTheDirectionFromWestToSouth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'west' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'L' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'south'); add: ('position'->((Dictionary new) add: ('x'->0); add: ('y'->0); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testWhereRTurnRightLTurnLeftAndAAdvanceTheRobotCanFollowASeriesOfInstructionsAndEndUpWithTheCorrectPositionAndDirectionInstructionsToMoveEastAndNorth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'south' position: ((Dictionary new) add: ('x'->8); add: ('y'->4); yourself) instructions: 'LAAARRRALLLL' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'north'); add: ('position'->((Dictionary new) add: ('x'->11); add: ('y'->5); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testWhereRTurnRightLTurnLeftAndAAdvanceTheRobotCanFollowASeriesOfInstructionsAndEndUpWithTheCorrectPositionAndDirectionInstructionsToMoveEastAndNorthFromREADME [
	| result |

	result := robotSimulatorCalculator moveDirection: 'north' position: ((Dictionary new) add: ('x'->7); add: ('y'->3); yourself) instructions: 'RAALAL' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'west'); add: ('position'->((Dictionary new) add: ('x'->9); add: ('y'->4); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testWhereRTurnRightLTurnLeftAndAAdvanceTheRobotCanFollowASeriesOfInstructionsAndEndUpWithTheCorrectPositionAndDirectionInstructionsToMoveWestAndNorth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'north' position: ((Dictionary new) add: ('x'->0); add: ('y'->0); yourself) instructions: 'LAAARALA' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'west'); add: ('position'->((Dictionary new) add: ('x'-> -4); add: ('y'->1); yourself)); yourself)
]

{ #category : #test }
RobotSimulatorTest >> testWhereRTurnRightLTurnLeftAndAAdvanceTheRobotCanFollowASeriesOfInstructionsAndEndUpWithTheCorrectPositionAndDirectionInstructionsToMoveWestAndSouth [
	| result |

	result := robotSimulatorCalculator moveDirection: 'east' position: ((Dictionary new) add: ('x'->2); add: ('y'-> -7); yourself) instructions: 'RRAAAAALA' .
	self assert: result equals: ((Dictionary new) add: ('direction'->'south'); add: ('position'->((Dictionary new) add: ('x'-> -3); add: ('y'-> -8); yourself)); yourself)
]
