"
# Saddle Points

Detect saddle points in a matrix.

So say you have a matrix like so:

```text
    1  2  3
  |---------
1 | 9  8  7
2 | 5  3  2     <--- saddle point at column 1, row 2, with value 5
3 | 6  6  7
```

It has a saddle point at column 1, row 2.

It's called a ""saddle point"" because it is greater than or equal to
every element in its row and less than or equal to every element in
its column.

A matrix may have zero or more saddle points.

Your code should be able to provide the (possibly empty) list of all the
saddle points for any given matrix.

The matrix can have a different number of rows and columns (Non square).

Note that you may find other definitions of matrix saddle points online,
but the tests for this exercise follow the above unambiguous definition.

## Hint

TBD

"
Class {
	#name : #SaddlePointsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'saddlePointsCalculator'
	],
	#category : #'ExercismWIP-SaddlePoints'
}

{ #category : #config }
SaddlePointsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'2865e616-9d41-0d00-8ffc-52fc08866539'
]

{ #category : #config }
SaddlePointsTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.5.0'
]

{ #category : #setup }
SaddlePointsTest >> setUp [
	saddlePointsCalculator := SaddlePoints new
]

{ #category : #tests }
SaddlePointsTest >> test01_CanIdentifySingleSaddlePoint [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(9 8 7 ) #(5 3 2 ) #(6 6 7 ) ) .
	self assert: result equals: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('column'->1); add: ('row'->2); yourself); yourself)
]

{ #category : #tests }
SaddlePointsTest >> test02_CanIdentifyThatEmptyMatrixHasNoSaddlePoints [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#() ) .
	self assert: result equals: #()
]

{ #category : #tests }
SaddlePointsTest >> test03_CanIdentifyLackOfSaddlePointsWhenThereAreNone [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(1 2 3 ) #(3 1 2 ) #(2 3 1 ) ) .
	self assert: result equals: #()
]

{ #category : #tests }
SaddlePointsTest >> test04_CanIdentifyMultipleSaddlePointsInAColumn [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(4 5 4 ) #(3 5 5 ) #(1 5 4 ) ) .
	self assert: result equals: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('column'->2); add: ('row'->1); yourself); at: 2 put: ((Dictionary new) add: ('column'->2); add: ('row'->2); yourself); at: 3 put: ((Dictionary new) add: ('column'->2); add: ('row'->3); yourself); yourself)
]

{ #category : #tests }
SaddlePointsTest >> test05_CanIdentifyMultipleSaddlePointsInARow [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(6 7 8 ) #(5 5 5 ) #(7 5 6 ) ) .
	self assert: result equals: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('column'->1); add: ('row'->2); yourself); at: 2 put: ((Dictionary new) add: ('column'->2); add: ('row'->2); yourself); at: 3 put: ((Dictionary new) add: ('column'->3); add: ('row'->2); yourself); yourself)
]

{ #category : #tests }
SaddlePointsTest >> test06_CanIdentifySaddlePointInBottomRightCorner [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(8 7 9 ) #(6 7 6 ) #(3 2 5 ) ) .
	self assert: result equals: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('column'->3); add: ('row'->3); yourself); yourself)
]

{ #category : #tests }
SaddlePointsTest >> test07_CanIdentifySaddlePointsInANonSquareMatrix [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(3 1 3 ) #(3 2 4 ) ) .
	self assert: result equals: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('column'->3); add: ('row'->1); yourself); at: 2 put: ((Dictionary new) add: ('column'->1); add: ('row'->1); yourself); yourself)
]

{ #category : #tests }
SaddlePointsTest >> test08_CanIdentifyThatSaddlePointsInASingleColumnMatrixAreThoseWithTheMinimumValue [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(2 ) #(1 ) #(4 ) #(1 ) ) .
	self assert: result equals: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('column'->1); add: ('row'->2); yourself); at: 2 put: ((Dictionary new) add: ('column'->1); add: ('row'->4); yourself); yourself)
]

{ #category : #tests }
SaddlePointsTest >> test09_CanIdentifyThatSaddlePointsInASingleRowMatrixAreThoseWithTheMaximumValue [
	| result |

	result := saddlePointsCalculator saddlePointsMatrix: #(#(2 5 3 5 ) ) .
	self assert: result equals: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('column'->2); add: ('row'->1); yourself); at: 2 put: ((Dictionary new) add: ('column'->4); add: ('row'->1); yourself); yourself)
]
