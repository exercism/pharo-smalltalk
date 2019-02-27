"
# Acronym

Convert a phrase to its acronym.

Techies love their TLA (Three Letter Acronyms)!

Help generate some jargon by writing a program that converts a long name
like Portable Network Graphics to its acronym (PNG).

## Hint

Try to find a way to split up a String and then iterate over the resulting sections to output a result.

"
Class {
	#name : #AcronymTest,
	#superclass : #ExercismTest,
	#instVars : [
		'acronymCalculator'
	],
	#category : #'Exercism-Acronym'
}

{ #category : #config }
AcronymTest class >> difficulty [
	^2
]

{ #category : #config }
AcronymTest class >> followedBy [
	"If this is a core exercise, answer the next one that follows otherwise nil"
	
	^ReverseStringTest 
]

{ #category : #config }
AcronymTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('strings' 'iteration' 'parsing' 'text-formatting')
]

{ #category : #config }
AcronymTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^ReverseStringTest 
]

{ #category : #config }
AcronymTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc10b'
]

{ #category : #config }
AcronymTest class >> version [
	"Generated from specification: 25 February 2019"
	^'1.7.0'
]

{ #category : #setup }
AcronymTest >> setUp [
	acronymCalculator := Acronym new
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseAllCapsWord [
	| result |

	result := acronymCalculator abbreviatePhrase: 'GNU Image Manipulation Program' .
	self assert: result equals: 'GIMP'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseApostrophes [
	| result |

	result := acronymCalculator abbreviatePhrase: 'Halley''s Comet' .
	self assert: result equals: 'HC'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseBasic [
	| result |

	result := acronymCalculator abbreviatePhrase: 'Portable Network Graphics' .
	self assert: result equals: 'PNG'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseConsecutiveDelimiters [
	| result |

	result := acronymCalculator abbreviatePhrase: 'Something - I made up from thin air' .
	self assert: result equals: 'SIMUFTA'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseLowercaseWords [
	| result |

	result := acronymCalculator abbreviatePhrase: 'Ruby on Rails' .
	self assert: result equals: 'ROR'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhrasePunctuation [
	| result |

	result := acronymCalculator abbreviatePhrase: 'First In, First Out' .
	self assert: result equals: 'FIFO'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhrasePunctuationWithoutWhitespace [
	| result |

	result := acronymCalculator abbreviatePhrase: 'Complementary metal-oxide semiconductor' .
	self assert: result equals: 'CMOS'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseUnderscoreEmphasis [
	| result |

	result := acronymCalculator abbreviatePhrase: 'The Road _Not_ Taken' .
	self assert: result equals: 'TRNT'
]

{ #category : #test }
AcronymTest >> testAbbreviateAPhraseVeryLongAbbreviation [
	| result |

	result := acronymCalculator abbreviatePhrase: 'Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me' .
	self assert: result equals: 'ROTFLSHTMDCOALM'
]
