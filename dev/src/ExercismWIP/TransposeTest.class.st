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
	^'74e3c916-9d41-0d00-8fe6-f8c308866539'
]

{ #category : #config }
TransposeTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #running }
TransposeTest >> setUp [
	super setUp.
	transposeCalculator := Transpose new
]

{ #category : #tests }
TransposeTest >> test01_EmptyString [
	| result |

	result := transposeCalculator transposeLines: #() .
	self assert: result equals: #()
]

{ #category : #tests }
TransposeTest >> test02_TwoCharactersInARow [
	| result |

	result := transposeCalculator transposeLines: #('A1' ) .
	self assert: result equals: #('A' '1' )
]

{ #category : #tests }
TransposeTest >> test03_TwoCharactersInAColumn [
	| result |

	result := transposeCalculator transposeLines: #('A' '1' ) .
	self assert: result equals: #('A1' )
]

{ #category : #tests }
TransposeTest >> test04_Simple [
	| result |

	result := transposeCalculator transposeLines: #('ABC' '123' ) .
	self assert: result equals: #('A1' 'B2' 'C3' )
]

{ #category : #tests }
TransposeTest >> test05_SingleLine [
	| result |

	result := transposeCalculator transposeLines: #('Single line.' ) .
	self assert: result equals: #('S' 'i' 'n' 'g' 'l' 'e' ' ' 'l' 'i' 'n' 'e' '.' )
]

{ #category : #tests }
TransposeTest >> test06_FirstLineLongerThanSecondLine [
	| result |

	result := transposeCalculator transposeLines: #('The fourth line.' 'The fifth line.' ) .
	self assert: result equals: #('TT' 'hh' 'ee' '  ' 'ff' 'oi' 'uf' 'rt' 'th' 'h ' ' l' 'li' 'in' 'ne' 'e.' '.' )
]

{ #category : #tests }
TransposeTest >> test07_SecondLineLongerThanFirstLine [
	| result |

	result := transposeCalculator transposeLines: #('The first line.' 'The second line.' ) .
	self assert: result equals: #('TT' 'hh' 'ee' '  ' 'fs' 'ie' 'rc' 'so' 'tn' ' d' 'l ' 'il' 'ni' 'en' '.e' ' .' )
]

{ #category : #tests }
TransposeTest >> test08_MixedLineLength [
	| result |

	result := transposeCalculator transposeLines: #('The longest line.' 'A long line.' 'A longer line.' 'A line.' ) .
	self assert: result equals: #('TAAA' 'h   ' 'elll' ' ooi' 'lnnn' 'ogge' 'n e.' 'glr' 'ei ' 'snl' 'tei' ' .n' 'l e' 'i .' 'n' 'e' '.' )
]

{ #category : #tests }
TransposeTest >> test09_Square [
	| result |

	result := transposeCalculator transposeLines: #('HEART' 'EMBER' 'ABUSE' 'RESIN' 'TREND' ) .
	self assert: result equals: #('HEART' 'EMBER' 'ABUSE' 'RESIN' 'TREND' )
]

{ #category : #tests }
TransposeTest >> test10_Rectangle [
	| result |

	result := transposeCalculator transposeLines: #('FRACTURE' 'OUTLINED' 'BLOOMING' 'SEPTETTE' ) .
	self assert: result equals: #('FOBS' 'RULE' 'ATOP' 'CLOT' 'TIME' 'UNIT' 'RENT' 'EDGE' )
]

{ #category : #tests }
TransposeTest >> test11_Triangle [
	| result |

	result := transposeCalculator transposeLines: #('T' 'EE' 'AAA' 'SSSS' 'EEEEE' 'RRRRRR' ) .
	self assert: result equals: #('TEASER' ' EASER' '  ASER' '   SER' '    ER' '     R' )
]
