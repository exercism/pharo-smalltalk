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
	^'65019b16-9d41-0d00-8fbe-dc9808866539'
]

{ #category : #config }
SpiralMatrixTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #running }
SpiralMatrixTest >> setUp [
	super setUp.
	spiralMatrixCalculator := SpiralMatrix new
]

{ #category : #tests }
SpiralMatrixTest >> test01_EmptySpiral [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 0 .
	self assert: result equals: #()
]

{ #category : #tests }
SpiralMatrixTest >> test02_TrivialSpiral [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 1 .
	self assert: result equals: #(#(1 ) )
]

{ #category : #tests }
SpiralMatrixTest >> test03_SpiralOfSize2 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 2 .
	self assert: result equals: #(#(1 2 ) #(4 3 ) )
]

{ #category : #tests }
SpiralMatrixTest >> test04_SpiralOfSize3 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 3 .
	self assert: result equals: #(#(1 2 3 ) #(8 9 4 ) #(7 6 5 ) )
]

{ #category : #tests }
SpiralMatrixTest >> test05_SpiralOfSize4 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 4 .
	self assert: result equals: #(#(1 2 3 4 ) #(12 13 14 5 ) #(11 16 15 6 ) #(10 9 8 7 ) )
]

{ #category : #tests }
SpiralMatrixTest >> test06_SpiralOfSize5 [
	| result |

	result := spiralMatrixCalculator spiralMatrixSize: 5 .
	self assert: result equals: #(#(1 2 3 4 5 ) #(16 17 18 19 6 ) #(15 24 25 20 7 ) #(14 23 22 21 8 ) #(13 12 11 10 9 ) )
]
