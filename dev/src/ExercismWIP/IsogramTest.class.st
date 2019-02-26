"
# Isogram

Determine if a word or phrase is an isogram.

An isogram (also known as a ""nonpattern word"") is a word or phrase without a repeating letter, however spaces and hyphens are allowed to appear multiple times.

Examples of isograms:

- lumberjacks
- background
- downstream
- six-year-old

The word *isograms*, however, is not an isogram, because the s repeats.

## Hint

TBD

"
Class {
	#name : #IsogramTest,
	#superclass : #ExercismTest,
	#instVars : [
		'isogramCalculator'
	],
	#category : #'ExercismWIP-Isogram'
}

{ #category : #config }
IsogramTest class >> uuid [
	"Answer a unique id for this exercise"
	^'7cfb12da-2b3f-0d00-a2ea-bf1e09f0590c'
]

{ #category : #config }
IsogramTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.7.0'
]

{ #category : #setup }
IsogramTest >> setUp [
	isogramCalculator := Isogram new
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramDuplicatedCharacterInTheMiddle [
	| result |

	result := isogramCalculator isIsogramPhrase: 'accentor' .
	self assert: result equals: false
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramEmptyString [
	| result |

	result := isogramCalculator isIsogramPhrase: '' .
	self assert: result equals: true
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramHypotheticalIsogrammicWordWithHyphen [
	| result |

	result := isogramCalculator isIsogramPhrase: 'thumbscrew-japingly' .
	self assert: result equals: true
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramHypotheticalWordWithDuplicatedCharacterFollowingHyphen [
	| result |

	result := isogramCalculator isIsogramPhrase: 'thumbscrew-jappingly' .
	self assert: result equals: false
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramIsogramWithDuplicatedHyphen [
	| result |

	result := isogramCalculator isIsogramPhrase: 'six-year-old' .
	self assert: result equals: true
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramIsogramWithOnlyLowerCaseCharacters [
	| result |

	result := isogramCalculator isIsogramPhrase: 'isogram' .
	self assert: result equals: true
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramLongestReportedEnglishIsogram [
	| result |

	result := isogramCalculator isIsogramPhrase: 'subdermatoglyphic' .
	self assert: result equals: true
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramMadeupNameThatIsAnIsogram [
	| result |

	result := isogramCalculator isIsogramPhrase: 'Emily Jung Schwartzkopf' .
	self assert: result equals: true
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramSameFirstAndLastCharacters [
	| result |

	result := isogramCalculator isIsogramPhrase: 'angola' .
	self assert: result equals: false
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramWordWithDuplicatedCharacterInMixedCase [
	| result |

	result := isogramCalculator isIsogramPhrase: 'Alphabet' .
	self assert: result equals: false
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramWordWithDuplicatedCharacterInMixedCaseLowercaseFirst [
	| result |

	result := isogramCalculator isIsogramPhrase: 'alphAbet' .
	self assert: result equals: false
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramWordWithOneDuplicatedCharacter [
	| result |

	result := isogramCalculator isIsogramPhrase: 'eleven' .
	self assert: result equals: false
]

{ #category : #test }
IsogramTest >> testCheckIfTheGivenStringIsAnIsogramWordWithOneDuplicatedCharacterFromTheEndOfTheAlphabet [
	| result |

	result := isogramCalculator isIsogramPhrase: 'zzyzx' .
	self assert: result equals: false
]
