"
# Spiral Matrix

Given the size, return a square matrix of numbers in spiral order.

The matrix should be filled with natural numbers, starting from 1
in the top-left corner, increasing in an inward, clockwise spiral order,
like these examples:

###### Spiral matrix of size 3

```text
1 2 3
8 9 4
7 6 5
```

###### Spiral matrix of size 4

```text
 1  2  3 4
12 13 14 5
11 16 15 6
10  9  8 7
```

## Hint

TBD

"
Class {
	#name : #SpiralMatrixTest,
	#superclass : #ExercismTest,
	#instVars : [
		'spiralMatrixCalculator'
	],
	#category : #'ExercismWIP-SpiralMatrix'
}

{ #category : #config }
SpiralMatrixTest class >> uuid [
	"Answer a unique id for this exercise"
	^'7182d2d9-2b3f-0d00-a2aa-176f09f0590c'
]

{ #category : #config }
SpiralMatrixTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
SpiralMatrixTest >> setUp [
	spiralMatrixCalculator := SpiralMatrix new
]

{ #category : #test }
SpiralMatrixTest >> testEmptySpiral [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 0 .
	self assert: result equals: #()
]

{ #category : #test }
SpiralMatrixTest >> testSpiralOfSize2 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 2 .
	self assert: result equals: #(#(1 2 ) #(4 3 ) )
]

{ #category : #test }
SpiralMatrixTest >> testSpiralOfSize3 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 3 .
	self assert: result equals: #(#(1 2 3 ) #(8 9 4 ) #(7 6 5 ) )
]

{ #category : #test }
SpiralMatrixTest >> testSpiralOfSize4 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 4 .
	self assert: result equals: #(#(1 2 3 4 ) #(12 13 14 5 ) #(11 16 15 6 ) #(10 9 8 7 ) )
]

{ #category : #test }
SpiralMatrixTest >> testSpiralOfSize5 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 5 .
	self assert: result equals: #(#(1 2 3 4 5 ) #(16 17 18 19 6 ) #(15 24 25 20 7 ) #(14 23 22 21 8 ) #(13 12 11 10 9 ) )
]

{ #category : #test }
SpiralMatrixTest >> testTrivialSpiral [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 1 .
	self assert: result equals: #(#(1 ) )
]
