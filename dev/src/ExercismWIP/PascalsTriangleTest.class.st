"
# Pascals Triangle

Compute Pascal's triangle up to a given number of rows.

In Pascal's Triangle each number is computed by adding the numbers to
the right and left of the current position in the previous row.

```text
    1
   1 1
  1 2 1
 1 3 3 1
1 4 6 4 1
# ... etc
```

## Hint

TBD

"
Class {
	#name : #PascalsTriangleTest,
	#superclass : #ExercismTest,
	#instVars : [
		'pascalsTriangleCalculator'
	],
	#category : #'ExercismWIP-PascalsTriangle'
}

{ #category : #config }
PascalsTriangleTest class >> uuid [
	"Answer a unique id for this exercise"
	^'47074dbe-4a3f-0d00-bb34-0b99071d6982'
]

{ #category : #config }
PascalsTriangleTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.5.0'
]

{ #category : #setup }
PascalsTriangleTest >> setUp [
	pascalsTriangleCalculator := PascalsTriangle new
]

{ #category : #tests }
PascalsTriangleTest >> test01_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleZeroRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 0 .
	self assert: result equals: #()
]

{ #category : #tests }
PascalsTriangleTest >> test02_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleSingleRow [
	| result |

	result := pascalsTriangleCalculator rowsCount: 1 .
	self assert: result equals: #(#(1 ) )
]

{ #category : #tests }
PascalsTriangleTest >> test03_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleTwoRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 2 .
	self assert: result equals: #(#(1 ) #(1 1 ) )
]

{ #category : #tests }
PascalsTriangleTest >> test04_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleThreeRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 3 .
	self assert: result equals: #(#(1 ) #(1 1 ) #(1 2 1 ) )
]

{ #category : #tests }
PascalsTriangleTest >> test05_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleFourRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 4 .
	self assert: result equals: #(#(1 ) #(1 1 ) #(1 2 1 ) #(1 3 3 1 ) )
]

{ #category : #tests }
PascalsTriangleTest >> test06_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleFiveRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 5 .
	self assert: result equals: #(#(1 ) #(1 1 ) #(1 2 1 ) #(1 3 3 1 ) #(1 4 6 4 1 ) )
]

{ #category : #tests }
PascalsTriangleTest >> test07_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleSixRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 6 .
	self assert: result equals: #(#(1 ) #(1 1 ) #(1 2 1 ) #(1 3 3 1 ) #(1 4 6 4 1 ) #(1 5 10 10 5 1 ) )
]

{ #category : #tests }
PascalsTriangleTest >> test08_GivenACountReturnACollectionOfThatManyRowsOfPascalsTriangleTenRows [
	| result |

	result := pascalsTriangleCalculator rowsCount: 10 .
	self assert: result equals: #(#(1 ) #(1 1 ) #(1 2 1 ) #(1 3 3 1 ) #(1 4 6 4 1 ) #(1 5 10 10 5 1 ) #(1 6 15 20 15 6 1 ) #(1 7 21 35 35 21 7 1 ) #(1 8 28 56 70 56 28 8 1 ) #(1 9 36 84 126 126 84 36 9 1 ) )
]
