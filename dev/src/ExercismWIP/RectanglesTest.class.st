"
# Rectangles

Count the rectangles in an ASCII diagram like the one below.

```text
   +--+
  ++  |
+-++--+
|  |  |
+--+--+
```

The above diagram contains 6 rectangles:

```text


+-----+
|     |
+-----+
```

```text
   +--+
   |  |
   |  |
   |  |
   +--+
```

```text
   +--+
   |  |
   +--+


```

```text


   +--+
   |  |
   +--+
```

```text


+--+
|  |
+--+
```

```text

  ++
  ++


```

You may assume that the input is always a proper rectangle (i.e. the length of
every line equals the length of the first line).

## Hint

TBD

"
Class {
	#name : #RectanglesTest,
	#superclass : #ExercismTest,
	#instVars : [
		'rectanglesCalculator'
	],
	#category : #'ExercismWIP-Rectangles'
}

{ #category : #config }
RectanglesTest class >> uuid [
	"Answer a unique id for this exercise"
	^'35d811da-2b3f-0d00-a2e9-474009f0590c'
]

{ #category : #config }
RectanglesTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
RectanglesTest >> setUp [
	rectanglesCalculator := Rectangles new
]

{ #category : #test }
RectanglesTest >> test1x1SquareIsCounted [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('++' '++' ) .
	self assert: result equals: 1
]

{ #category : #test }
RectanglesTest >> testCornerIsRequiredForARectangleToBeComplete [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('+------+----+' '|      |    |' '+------+    |' '|   |       |' '+---+-------+' ) .
	self assert: result equals: 2
]

{ #category : #test }
RectanglesTest >> testFiveRectanglesWithSharedParts [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('  +-+' '  | |' '+-+-+' '| | |' '+-+-+' ) .
	self assert: result equals: 5
]

{ #category : #test }
RectanglesTest >> testLargeInputWithManyRectangles [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('+---+--+----+' '|   +--+----+' '+---+--+    |' '|   +--+----+' '+---+--+--+-+' '+---+--+--+-+' '+------+  | |' '          +-+' ) .
	self assert: result equals: 60
]

{ #category : #test }
RectanglesTest >> testNoColumns [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('' ) .
	self assert: result equals: 0
]

{ #category : #test }
RectanglesTest >> testNoRectangles [
	| result |

	result := rectanglesCalculator rectanglesStrings: #(' ' ) .
	self assert: result equals: 0
]

{ #category : #test }
RectanglesTest >> testNoRows [
	| result |

	result := rectanglesCalculator rectanglesStrings: #() .
	self assert: result equals: 0
]

{ #category : #test }
RectanglesTest >> testOneRectangle [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('+-+' '| |' '+-+' ) .
	self assert: result equals: 1
]

{ #category : #test }
RectanglesTest >> testOnlyCompleteRectanglesAreCounted [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('  +-+' '    |' '+-+-+' '| | -' '+-+-+' ) .
	self assert: result equals: 1
]

{ #category : #test }
RectanglesTest >> testRectangleOfHeight1IsCounted [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('+--+' '+--+' ) .
	self assert: result equals: 1
]

{ #category : #test }
RectanglesTest >> testRectangleOfWidth1IsCounted [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('++' '||' '++' ) .
	self assert: result equals: 1
]

{ #category : #test }
RectanglesTest >> testRectanglesCanBeOfDifferentSizes [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('+------+----+' '|      |    |' '+---+--+    |' '|   |       |' '+---+-------+' ) .
	self assert: result equals: 3
]

{ #category : #test }
RectanglesTest >> testTwoRectanglesWithoutSharedParts [
	| result |

	result := rectanglesCalculator rectanglesStrings: #('  +-+' '  | |' '+-+-+' '| |  ' '+-+  ' ) .
	self assert: result equals: 2
]
