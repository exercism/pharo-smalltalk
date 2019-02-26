"
# Pig Latin

Implement a program that translates from English to Pig Latin.

Pig Latin is a made-up children's language that's intended to be
confusing. It obeys a few simple rules (below), but when it's spoken
quickly it's really difficult for non-children (and non-native speakers)
to understand.

- **Rule 1**: If a word begins with a vowel sound, add an ""ay"" sound to the end of the word. Please note that ""xr"" and ""yt"" at the beginning of a word make vowel sounds (e.g. ""xray"" -> ""xrayay"", ""yttria"" -> ""yttriaay"").
- **Rule 2**: If a word begins with a consonant sound, move it to the end of the word and then add an ""ay"" sound to the end of the word. Consonant sounds can be made up of multiple consonants, a.k.a. a consonant cluster (e.g. ""chair"" -> ""airchay"").
- **Rule 3**: If a word starts with a consonant sound followed by ""qu"", move it to the end of the word, and then add an ""ay"" sound to the end of the word (e.g. ""square"" -> ""aresquay"").
- **Rule 4**: If a word contains a ""y"" after a consonant cluster or as the second letter in a two letter word it makes a vowel sound (e.g. ""rhythm"" -> ""ythmrhay"", ""my"" -> ""ymay"").

There are a few more rules for edge cases, and there are regional
variants too.

See <http://en.wikipedia.org/wiki/Pig_latin> for more details.

## Hint

TBD

"
Class {
	#name : #PigLatinTest,
	#superclass : #ExercismTest,
	#instVars : [
		'pigLatinCalculator'
	],
	#category : #'ExercismWIP-PigLatin'
}

{ #category : #config }
PigLatinTest class >> uuid [
	"Answer a unique id for this exercise"
	^'bca40fda-2b3f-0d00-a2e7-8d8309f0590c'
]

{ #category : #config }
PigLatinTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
PigLatinTest >> setUp [
	pigLatinCalculator := PigLatin new
]

{ #category : #test }
PigLatinTest >> testAyIsAddedToWordsThatStartWithVowelsWordBeginningWithA [
	| result |

	result := pigLatinCalculator translatePhrase: 'apple' .
	self assert: result equals: 'appleay'
]

{ #category : #test }
PigLatinTest >> testAyIsAddedToWordsThatStartWithVowelsWordBeginningWithAVowelAndFollowedByAQu [
	| result |

	result := pigLatinCalculator translatePhrase: 'equal' .
	self assert: result equals: 'equalay'
]

{ #category : #test }
PigLatinTest >> testAyIsAddedToWordsThatStartWithVowelsWordBeginningWithE [
	| result |

	result := pigLatinCalculator translatePhrase: 'ear' .
	self assert: result equals: 'earay'
]

{ #category : #test }
PigLatinTest >> testAyIsAddedToWordsThatStartWithVowelsWordBeginningWithI [
	| result |

	result := pigLatinCalculator translatePhrase: 'igloo' .
	self assert: result equals: 'iglooay'
]

{ #category : #test }
PigLatinTest >> testAyIsAddedToWordsThatStartWithVowelsWordBeginningWithO [
	| result |

	result := pigLatinCalculator translatePhrase: 'object' .
	self assert: result equals: 'objectay'
]

{ #category : #test }
PigLatinTest >> testAyIsAddedToWordsThatStartWithVowelsWordBeginningWithU [
	| result |

	result := pigLatinCalculator translatePhrase: 'under' .
	self assert: result equals: 'underay'
]

{ #category : #test }
PigLatinTest >> testFirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithK [
	| result |

	result := pigLatinCalculator translatePhrase: 'koala' .
	self assert: result equals: 'oalakay'
]

{ #category : #test }
PigLatinTest >> testFirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithP [
	| result |

	result := pigLatinCalculator translatePhrase: 'pig' .
	self assert: result equals: 'igpay'
]

{ #category : #test }
PigLatinTest >> testFirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithQWithoutAFollowingU [
	| result |

	result := pigLatinCalculator translatePhrase: 'qat' .
	self assert: result equals: 'atqay'
]

{ #category : #test }
PigLatinTest >> testFirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithX [
	| result |

	result := pigLatinCalculator translatePhrase: 'xenon' .
	self assert: result equals: 'enonxay'
]

{ #category : #test }
PigLatinTest >> testPhrasesAreTranslatedAWholePhrase [
	| result |

	result := pigLatinCalculator translatePhrase: 'quick fast run' .
	self assert: result equals: 'ickquay astfay unray'
]

{ #category : #test }
PigLatinTest >> testPositionOfYInAWordDeterminesIfItIsAConsonantOrAVowelYAsSecondLetterInTwoLetterWord [
	| result |

	result := pigLatinCalculator translatePhrase: 'my' .
	self assert: result equals: 'ymay'
]

{ #category : #test }
PigLatinTest >> testPositionOfYInAWordDeterminesIfItIsAConsonantOrAVowelYIsTreatedLikeAConsonantAtTheBeginningOfAWord [
	| result |

	result := pigLatinCalculator translatePhrase: 'yellow' .
	self assert: result equals: 'ellowyay'
]

{ #category : #test }
PigLatinTest >> testPositionOfYInAWordDeterminesIfItIsAConsonantOrAVowelYIsTreatedLikeAVowelAtTheEndOfAConsonantCluster [
	| result |

	result := pigLatinCalculator translatePhrase: 'rhythm' .
	self assert: result equals: 'ythmrhay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithCh [
	| result |

	result := pigLatinCalculator translatePhrase: 'chair' .
	self assert: result equals: 'airchay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithQu [
	| result |

	result := pigLatinCalculator translatePhrase: 'queen' .
	self assert: result equals: 'eenquay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithQuAndAPrecedingConsonant [
	| result |

	result := pigLatinCalculator translatePhrase: 'square' .
	self assert: result equals: 'aresquay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithSch [
	| result |

	result := pigLatinCalculator translatePhrase: 'school' .
	self assert: result equals: 'oolschay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithTh [
	| result |

	result := pigLatinCalculator translatePhrase: 'therapy' .
	self assert: result equals: 'erapythay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithThr [
	| result |

	result := pigLatinCalculator translatePhrase: 'thrush' .
	self assert: result equals: 'ushthray'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleVowelWordBeginningWithXr [
	| result |

	result := pigLatinCalculator translatePhrase: 'xray' .
	self assert: result equals: 'xrayay'
]

{ #category : #test }
PigLatinTest >> testSomeLetterClustersAreTreatedLikeASingleVowelWordBeginningWithYt [
	| result |

	result := pigLatinCalculator translatePhrase: 'yttria' .
	self assert: result equals: 'yttriaay'
]
