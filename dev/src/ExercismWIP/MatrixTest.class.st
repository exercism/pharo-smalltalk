"
# Matrix

Given a string representing a matrix of numbers, return the rows and columns of
that matrix.

So given a string with embedded newlines like:

```text
9 8 7
5 3 2
6 6 7
```

representing this matrix:

```text
    1  2  3
  |---------
1 | 9  8  7
2 | 5  3  2
3 | 6  6  7
```

your code should be able to spit out:

- A list of the rows, reading each row left-to-right while moving
  top-to-bottom across the rows,
- A list of the columns, reading each column top-to-bottom while moving
  from left-to-right.

The rows for our example matrix:

- 9, 8, 7
- 5, 3, 2
- 6, 6, 7

And its columns:

- 9, 5, 6
- 8, 3, 6
- 7, 2, 7

## Hint

TBD

"
Class {
	#name : #MatrixTest,
	#superclass : #ExercismTest,
	#instVars : [
		'matrixCalculator'
	],
	#category : #'ExercismWIP-Matrix'
}

{ #category : #config }
MatrixTest class >> uuid [
	"Answer a unique id for this exercise"
	^'3c5c32da-2b3f-0d00-a307-fd2809f0590c'
]

{ #category : #config }
MatrixTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
MatrixTest >> setUp [
	matrixCalculator := Matrix new
]

{ #category : #test }
MatrixTest >> testCanExtractColumn [
	| result |

	result := matrixCalculator columnString: '1 2 3
4 5 6
7 8 9' index: 3 .
	self assert: result equals: #(3 6 9 )
]

{ #category : #test }
MatrixTest >> testCanExtractColumnFromNonsquareMatrix [
	| result |

	result := matrixCalculator columnString: '1 2 3
4 5 6
7 8 9
8 7 6' index: 3 .
	self assert: result equals: #(3 6 9 6 )
]

{ #category : #test }
MatrixTest >> testCanExtractRow [
	| result |

	result := matrixCalculator rowString: '1 2
3 4' index: 2 .
	self assert: result equals: #(3 4 )
]

{ #category : #test }
MatrixTest >> testCanExtractRowFromNonsquareMatrix [
	| result |

	result := matrixCalculator rowString: '1 2 3
4 5 6
7 8 9
8 7 6' index: 3 .
	self assert: result equals: #(7 8 9 )
]

{ #category : #test }
MatrixTest >> testExtractColumnFromOneNumberMatrix [
	| result |

	result := matrixCalculator columnString: '1' index: 1 .
	self assert: result equals: #(1 )
]

{ #category : #test }
MatrixTest >> testExtractColumnWhereNumbersHaveDifferentWidths [
	| result |

	result := matrixCalculator columnString: '89 1903 3
18 3 1
9 4 800' index: 2 .
	self assert: result equals: #(1903 3 4 )
]

{ #category : #test }
MatrixTest >> testExtractRowFromOneNumberMatrix [
	| result |

	result := matrixCalculator rowString: '1' index: 1 .
	self assert: result equals: #(1 )
]

{ #category : #test }
MatrixTest >> testExtractRowWhereNumbersHaveDifferentWidths [
	| result |

	result := matrixCalculator rowString: '1 2
10 20' index: 2 .
	self assert: result equals: #(10 20 )
]
