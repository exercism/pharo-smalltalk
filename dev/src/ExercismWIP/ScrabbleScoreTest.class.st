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
	^'cacf06da-2b3f-0d00-a2e1-be2b09f0590c'
]

{ #category : #config }
ScrabbleScoreTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
ScrabbleScoreTest >> setUp [
	scrabbleScoreCalculator := ScrabbleScore new
]

{ #category : #test }
ScrabbleScoreTest >> testEmptyInput [
	| result |

	result := scrabbleScoreCalculator scoreWord: '' .
	self assert: result equals: 0
]

{ #category : #test }
ScrabbleScoreTest >> testEnglishlikeWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'pinata' .
	self assert: result equals: 8
]

{ #category : #test }
ScrabbleScoreTest >> testEntireAlphabetAvailable [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'abcdefghijklmnopqrstuvwxyz' .
	self assert: result equals: 87
]

{ #category : #test }
ScrabbleScoreTest >> testLongMixedcaseWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'OxyphenButazone' .
	self assert: result equals: 41
]

{ #category : #test }
ScrabbleScoreTest >> testLowercaseLetter [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'a' .
	self assert: result equals: 1
]

{ #category : #test }
ScrabbleScoreTest >> testMediumValuableWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'quirky' .
	self assert: result equals: 22
]

{ #category : #test }
ScrabbleScoreTest >> testMediumWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'street' .
	self assert: result equals: 6
]

{ #category : #test }
ScrabbleScoreTest >> testShortValuableWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'zoo' .
	self assert: result equals: 12
]

{ #category : #test }
ScrabbleScoreTest >> testShortWord [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'at' .
	self assert: result equals: 2
]

{ #category : #test }
ScrabbleScoreTest >> testUppercaseLetter [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'A' .
	self assert: result equals: 1
]

{ #category : #test }
ScrabbleScoreTest >> testValuableLetter [
	| result |

	result := scrabbleScoreCalculator scoreWord: 'f' .
	self assert: result equals: 4
]
