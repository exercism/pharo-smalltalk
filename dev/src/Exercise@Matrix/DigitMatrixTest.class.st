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

Try using the Finder - Examples searcher, to see if there is a useful method for parsing.

"
Class {
	#name : #DigitMatrixTest,
	#superclass : #ExercismTest,
	#instVars : [
		'matrixCalculator'
	],
	#category : #'Exercise@Matrix'
}

{ #category : #config }
DigitMatrixTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(self createExerciseAfter: AllergiesTest)
		isCore: true;
		difficulty: 4;
		topics: #('matrices' 'parsing');
		yourself
	
]

{ #category : #config }
DigitMatrixTest class >> generator [
	"Potential generator hints"
	
	^ {('Matrix' -> 'DigitMatrix')}
]

{ #category : #config }
DigitMatrixTest class >> uuid [
	"Answer a unique id for this exercise"
	^'bea80017-9d41-0d00-900d-a13308866539'
]

{ #category : #config }
DigitMatrixTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #running }
DigitMatrixTest >> setUp [
	super setUp.
	matrixCalculator := DigitMatrix new
]

{ #category : #tests }
DigitMatrixTest >> test01_ExtractRowFromOneNumberMatrix [
	| result |

	result := matrixCalculator rowString: '1' index: 1 .
	self assert: result equals: #(1 )
]

{ #category : #tests }
DigitMatrixTest >> test02_CanExtractRow [
	| result |

	result := matrixCalculator rowString: '1 2
3 4' index: 2 .
	self assert: result equals: #(3 4 )
]

{ #category : #tests }
DigitMatrixTest >> test03_ExtractRowWhereNumbersHaveDifferentWidths [
	| result |

	result := matrixCalculator rowString: '1 2
10 20' index: 2 .
	self assert: result equals: #(10 20 )
]

{ #category : #tests }
DigitMatrixTest >> test04_CanExtractRowFromNonsquareMatrix [
	| result |

	result := matrixCalculator rowString: '1 2 3
4 5 6
7 8 9
8 7 6' index: 3 .
	self assert: result equals: #(7 8 9 )
]

{ #category : #tests }
DigitMatrixTest >> test05_ExtractColumnFromOneNumberMatrix [
	| result |

	result := matrixCalculator columnString: '1' index: 1 .
	self assert: result equals: #(1 )
]

{ #category : #tests }
DigitMatrixTest >> test06_CanExtractColumn [
	| result |

	result := matrixCalculator columnString: '1 2 3
4 5 6
7 8 9' index: 3 .
	self assert: result equals: #(3 6 9 )
]

{ #category : #tests }
DigitMatrixTest >> test07_CanExtractColumnFromNonsquareMatrix [
	| result |

	result := matrixCalculator columnString: '1 2 3
4 5 6
7 8 9
8 7 6' index: 3 .
	self assert: result equals: #(3 6 9 6 )
]

{ #category : #tests }
DigitMatrixTest >> test08_ExtractColumnWhereNumbersHaveDifferentWidths [
	| result |

	result := matrixCalculator columnString: '89 1903 3
18 3 1
9 4 800' index: 2 .
	self assert: result equals: #(1903 3 4 )
]
