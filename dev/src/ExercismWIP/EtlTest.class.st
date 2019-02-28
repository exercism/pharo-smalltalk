"
# Etl

We are going to do the `Transform` step of an Extract-Transform-Load.

### ETL

Extract-Transform-Load (ETL) is a fancy way of saying, ""We have some crufty, legacy data over in this system, and now we need it in this shiny new system over here, so
we're going to migrate this.""

(Typically, this is followed by, ""We're only going to need to run this
once."" That's then typically followed by much forehead slapping and
moaning about how stupid we could possibly be.)

### The goal

We're going to extract some scrabble scores from a legacy system.

The old system stored a list of letters per score:

- 1 point: ""A"", ""E"", ""I"", ""O"", ""U"", ""L"", ""N"", ""R"", ""S"", ""T"",
- 2 points: ""D"", ""G"",
- 3 points: ""B"", ""C"", ""M"", ""P"",
- 4 points: ""F"", ""H"", ""V"", ""W"", ""Y"",
- 5 points: ""K"",
- 8 points: ""J"", ""X"",
- 10 points: ""Q"", ""Z"",

The shiny new scrabble system instead stores the score per letter, which
makes it much faster and easier to calculate the score for a word. It
also stores the letters in lower-case regardless of the case of the
input letters:

- ""a"" is worth 1 point.
- ""b"" is worth 3 points.
- ""c"" is worth 3 points.
- ""d"" is worth 2 points.
- Etc.

Your mission, should you choose to accept it, is to transform the legacy data
format to the shiny new format.

### Notes

A final note about scoring, Scrabble is played around the world in a
variety of languages, each with its own unique scoring table. For
example, an ""E"" is scored at 2 in the Māori-language version of the
game while being scored at 4 in the Hawaiian-language version.

## Hint

TBD

"
Class {
	#name : #EtlTest,
	#superclass : #ExercismTest,
	#instVars : [
		'etlCalculator'
	],
	#category : #'ExercismWIP-Etl'
}

{ #category : #config }
EtlTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c91647be-4a3f-0d00-bb30-0fa3071d6982'
]

{ #category : #config }
EtlTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.0.0'
]

{ #category : #setup }
EtlTest >> setUp [
	etlCalculator := Etl new
]

{ #category : #tests }
EtlTest >> test01_TransformsTheASetOfScrabbleDataPreviouslyIndexedByTheTileScoreToASetOfDataIndexedByTheTileLetterASingleLetter [
	| result |

	result := etlCalculator transform1: #('A' ) .
	self assert: result equals: ((Dictionary new) add: ('a'->1); yourself)
]

{ #category : #tests }
EtlTest >> test02_TransformsTheASetOfScrabbleDataPreviouslyIndexedByTheTileScoreToASetOfDataIndexedByTheTileLetterSingleScoreWithMultipleLetters [
	| result |

	result := etlCalculator transform1: #('A' 'E' 'I' 'O' 'U' ) .
	self assert: result equals: ((Dictionary new) add: ('i'->1); add: ('e'->1); add: ('a'->1); add: ('u'->1); add: ('o'->1); yourself)
]

{ #category : #tests }
EtlTest >> test03_TransformsTheASetOfScrabbleDataPreviouslyIndexedByTheTileScoreToASetOfDataIndexedByTheTileLetterMultipleScoresWithMultipleLetters [
	| result |

	result := etlCalculator transform1: #('A' 'E' ) and2: #('D' 'G' ) .
	self assert: result equals: ((Dictionary new) add: ('g'->2); add: ('a'->1); add: ('d'->2); add: ('e'->1); yourself)
]

{ #category : #tests }
EtlTest >> test04_TransformsTheASetOfScrabbleDataPreviouslyIndexedByTheTileScoreToASetOfDataIndexedByTheTileLetterMultipleScoresWithDifferingNumbersOfLetters [
	| result |

	result := etlCalculator transform8: #('J' 'X' ) and4: #('F' 'H' 'V' 'W' 'Y' ) and2: #('D' 'G' ) and5: #('K' ) and3: #('B' 'C' 'M' 'P' ) and1: #('A' 'E' 'I' 'O' 'U' 'L' 'N' 'R' 'S' 'T' ) and10: #('Q' 'Z' ) .
	self assert: result equals: ((Dictionary new) add: ('g'->2); add: ('z'->10); add: ('s'->1); add: ('l'->1); add: ('e'->1); add: ('x'->8); add: ('q'->10); add: ('j'->8); add: ('c'->3); add: ('v'->4); add: ('o'->1); add: ('h'->4); add: ('a'->1); add: ('t'->1); add: ('m'->3); add: ('f'->4); add: ('y'->4); add: ('r'->1); add: ('k'->5); add: ('d'->2); add: ('w'->4); add: ('p'->3); add: ('i'->1); add: ('b'->3); add: ('u'->1); add: ('n'->1); yourself)
]
