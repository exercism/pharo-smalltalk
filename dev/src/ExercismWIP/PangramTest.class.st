"
# Pangram

Determine if a sentence is a pangram. A pangram (Greek: παν γράμμα, pan gramma,
""every letter"") is a sentence using every letter of the alphabet at least once.
The best known English pangram is:
> The quick brown fox jumps over the lazy dog.

The alphabet used consists of ASCII letters `a` to `z`, inclusive, and is case
insensitive. Input will not contain non-ASCII symbols.

## Hint

TBD

"
Class {
	#name : #PangramTest,
	#superclass : #ExercismTest,
	#instVars : [
		'pangramCalculator'
	],
	#category : #'ExercismWIP-Pangram'
}

{ #category : #config }
PangramTest class >> uuid [
	"Answer a unique id for this exercise"
	^'9cca2fda-2b3f-0d00-a305-892f09f0590c'
]

{ #category : #config }
PangramTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.4.1'
]

{ #category : #setup }
PangramTest >> setUp [
	pangramCalculator := Pangram new
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramAnotherMissingCharacterEgh [
	| result |

	result := pangramCalculator isPangramSentence: 'five boxing wizards jump quickly at it' .
	self assert: result equals: false
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramMissingCharacterx [
	| result |

	result := pangramCalculator isPangramSentence: 'a quick movement of the enemy will jeopardize five gunboats' .
	self assert: result equals: false
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramMissingLettersReplacedByNumbers [
	| result |

	result := pangramCalculator isPangramSentence: '7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog' .
	self assert: result equals: false
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramPangramWithMixedCaseAndPunctuation [
	| result |

	result := pangramCalculator isPangramSentence: '"Five quacking Zephyrs jolt my wax bed."' .
	self assert: result equals: true
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramPangramWithNumbers [
	| result |

	result := pangramCalculator isPangramSentence: 'the 1 quick brown fox jumps over the 2 lazy dogs' .
	self assert: result equals: true
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramPangramWithOnlyLowerCase [
	| result |

	result := pangramCalculator isPangramSentence: 'the quick brown fox jumps over the lazy dog' .
	self assert: result equals: true
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramPangramWithUnderscores [
	| result |

	result := pangramCalculator isPangramSentence: 'the_quick_brown_fox_jumps_over_the_lazy_dog' .
	self assert: result equals: true
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramRecognizesAPerfectLowerCasePangram [
	| result |

	result := pangramCalculator isPangramSentence: 'abcdefghijklmnopqrstuvwxyz' .
	self assert: result equals: true
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramSentenceEmpty [
	| result |

	result := pangramCalculator isPangramSentence: '' .
	self assert: result equals: false
]

{ #category : #test }
PangramTest >> testCheckIfTheGivenStringIsAPangramUpperAndLowerCaseVersionsOfTheSameCharacterShouldNotBeCountedSeparately [
	| result |

	result := pangramCalculator isPangramSentence: 'the quick brown fox jumps over with lazy FX' .
	self assert: result equals: false
]
