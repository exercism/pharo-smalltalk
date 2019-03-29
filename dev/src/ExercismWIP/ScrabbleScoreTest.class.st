"
# Scrabble Score

Given a word, compute the scrabble score for that word.

## Letter Values

You'll need these:

```text
Letter                           Value
A, E, I, O, U, L, N, R, S, T       1
D, G                               2
B, C, M, P                         3
F, H, V, W, Y                      4
K                                  5
J, X                               8
Q, Z                               10
```

## Examples

""cabbage"" should be scored as worth 14 points:

- 3 points for C
- 1 point for A, twice
- 3 points for B, twice
- 2 points for G
- 1 point for E

And to total:

- `3 + 2*1 + 2*3 + 2 + 1`
- = `3 + 2 + 6 + 3`
- = `5 + 9`
- = 14

## Extensions

- You can play a double or a triple letter.
- You can play a double or a triple word.

## Hint

TBD

"
Class {
	#name : #ScrabbleScoreTest,
	#superclass : #ExercismTest,
	#instVars : [
		'scrabbleScoreCalculator'
	],
	#category : #'ExercismWIP-ScrabbleScore'
}

{ #category : #config }
ScrabbleScoreTest class >> uuid [
	"Answer a unique id for this exercise"
	^'e206d516-9d41-0d00-8fef-ff4808866539'
]

{ #category : #config }
ScrabbleScoreTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : #setup }
ScrabbleScoreTest >> setUp [
	scrabbleScoreCalculator := ScrabbleScore new
]

{ #category : #tests }
ScrabbleScoreTest >> test01_LowercaseLetter [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'a' .
	self assert: result equals: 1
]

{ #category : #tests }
ScrabbleScoreTest >> test02_UppercaseLetter [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'A' .
	self assert: result equals: 1
]

{ #category : #tests }
ScrabbleScoreTest >> test03_ValuableLetter [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'f' .
	self assert: result equals: 4
]

{ #category : #tests }
ScrabbleScoreTest >> test04_ShortWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'at' .
	self assert: result equals: 2
]

{ #category : #tests }
ScrabbleScoreTest >> test05_ShortValuableWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'zoo' .
	self assert: result equals: 12
]

{ #category : #tests }
ScrabbleScoreTest >> test06_MediumWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'street' .
	self assert: result equals: 6
]

{ #category : #tests }
ScrabbleScoreTest >> test07_MediumValuableWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'quirky' .
	self assert: result equals: 22
]

{ #category : #tests }
ScrabbleScoreTest >> test08_LongMixedcaseWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'OxyphenButazone' .
	self assert: result equals: 41
]

{ #category : #tests }
ScrabbleScoreTest >> test09_EnglishlikeWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'pinata' .
	self assert: result equals: 8
]

{ #category : #tests }
ScrabbleScoreTest >> test10_EmptyInput [
	| result |

	result := scrabbleScoreCalculator scoreWord: '' .
	self assert: result equals: 0
]

{ #category : #tests }
ScrabbleScoreTest >> test11_EntireAlphabetAvailable [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'abcdefghijklmnopqrstuvwxyz' .
	self assert: result equals: 87
]
