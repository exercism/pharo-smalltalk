"
# Transpose

Given an input text output it transposed.

Roughly explained, the transpose of a matrix:

```text
ABC
DEF
```

is given by:

```text
AD
BE
CF
```

Rows become columns and columns become rows. See <https://en.wikipedia.org/wiki/Transpose>.

If the input has rows of different lengths, this is to be solved as follows:

- Pad to the left with spaces.
- Don't pad to the right.

Therefore, transposing this matrix:

```text
ABC
DE
```

results in:

```text
AD
BE
C
```

And transposing:

```text
AB
DEF
```

results in:

```text
AD
BE
 F
```

In general, all characters from the input should also be present in the transposed output.
That means that if a column in the input text contains only spaces on its bottom-most row(s),
the corresponding output row should contain the spaces in its right-most column(s).

## Hint

TBD

"
Class {
	#name : #TransposeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'transposeCalculator'
	],
	#category : #'ExercismWIP-Transpose'
}

{ #category : #config }
TransposeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'1beafdd9-2b3f-0d00-a2d7-1d7c09f0590c'
]

{ #category : #config }
TransposeTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
TransposeTest >> setUp [
	transposeCalculator := Transpose new
]

{ #category : #test }
TransposeTest >> testEmptyString [
	| result |

	result := transposeCalculator transposeLines: #() .
	self assert: result equals: #()
]

{ #category : #test }
TransposeTest >> testFirstLineLongerThanSecondLine [
	| result |

	result := transposeCalculator transposeLines: #('The fourth line.' 'The fifth line.' ) .
	self assert: result equals: #('TT' 'hh' 'ee' '  ' 'ff' 'oi' 'uf' 'rt' 'th' 'h ' ' l' 'li' 'in' 'ne' 'e.' '.' )
]

{ #category : #test }
TransposeTest >> testMixedLineLength [
	| result |

	result := transposeCalculator transposeLines: #('The longest line.' 'A long line.' 'A longer line.' 'A line.' ) .
	self assert: result equals: #('TAAA' 'h   ' 'elll' ' ooi' 'lnnn' 'ogge' 'n e.' 'glr' 'ei ' 'snl' 'tei' ' .n' 'l e' 'i .' 'n' 'e' '.' )
]

{ #category : #test }
TransposeTest >> testRectangle [
	| result |

	result := transposeCalculator transposeLines: #('FRACTURE' 'OUTLINED' 'BLOOMING' 'SEPTETTE' ) .
	self assert: result equals: #('FOBS' 'RULE' 'ATOP' 'CLOT' 'TIME' 'UNIT' 'RENT' 'EDGE' )
]

{ #category : #test }
TransposeTest >> testSecondLineLongerThanFirstLine [
	| result |

	result := transposeCalculator transposeLines: #('The first line.' 'The second line.' ) .
	self assert: result equals: #('TT' 'hh' 'ee' '  ' 'fs' 'ie' 'rc' 'so' 'tn' ' d' 'l ' 'il' 'ni' 'en' '.e' ' .' )
]

{ #category : #test }
TransposeTest >> testSimple [
	| result |

	result := transposeCalculator transposeLines: #('ABC' '123' ) .
	self assert: result equals: #('A1' 'B2' 'C3' )
]

{ #category : #test }
TransposeTest >> testSingleLine [
	| result |

	result := transposeCalculator transposeLines: #('Single line.' ) .
	self assert: result equals: #('S' 'i' 'n' 'g' 'l' 'e' ' ' 'l' 'i' 'n' 'e' '.' )
]

{ #category : #test }
TransposeTest >> testSquare [
	| result |

	result := transposeCalculator transposeLines: #('HEART' 'EMBER' 'ABUSE' 'RESIN' 'TREND' ) .
	self assert: result equals: #('HEART' 'EMBER' 'ABUSE' 'RESIN' 'TREND' )
]

{ #category : #test }
TransposeTest >> testTriangle [
	| result |

	result := transposeCalculator transposeLines: #('T' 'EE' 'AAA' 'SSSS' 'EEEEE' 'RRRRRR' ) .
	self assert: result equals: #('TEASER' ' EASER' '  ASER' '   SER' '    ER' '     R' )
]

{ #category : #test }
TransposeTest >> testTwoCharactersInAColumn [
	| result |

	result := transposeCalculator transposeLines: #('A' '1' ) .
	self assert: result equals: #('A1' )
]

{ #category : #test }
TransposeTest >> testTwoCharactersInARow [
	| result |

	result := transposeCalculator transposeLines: #('A1' ) .
	self assert: result equals: #('A' '1' )
]
