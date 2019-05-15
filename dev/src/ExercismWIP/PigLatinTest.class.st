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
	^'ce17df16-9d41-0d00-8ff5-fae608866539'
]

{ #category : #config }
PigLatinTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.2.0'
]

{ #category : #running }
PigLatinTest >> setUp [
	super setUp.
	pigLatinCalculator := PigLatin new
]

{ #category : #tests }
PigLatinTest >> test01_AyIsAddedToWordsThatStartWithVowelsWordBeginningWithA [
	| result |

	result := pigLatinCalculator translatePhrase: 'apple' .
	self assert: result equals: 'appleay'
]

{ #category : #tests }
PigLatinTest >> test02_AyIsAddedToWordsThatStartWithVowelsWordBeginningWithE [
	| result |

	result := pigLatinCalculator translatePhrase: 'ear' .
	self assert: result equals: 'earay'
]

{ #category : #tests }
PigLatinTest >> test03_AyIsAddedToWordsThatStartWithVowelsWordBeginningWithI [
	| result |

	result := pigLatinCalculator translatePhrase: 'igloo' .
	self assert: result equals: 'iglooay'
]

{ #category : #tests }
PigLatinTest >> test04_AyIsAddedToWordsThatStartWithVowelsWordBeginningWithO [
	| result |

	result := pigLatinCalculator translatePhrase: 'object' .
	self assert: result equals: 'objectay'
]

{ #category : #tests }
PigLatinTest >> test05_AyIsAddedToWordsThatStartWithVowelsWordBeginningWithU [
	| result |

	result := pigLatinCalculator translatePhrase: 'under' .
	self assert: result equals: 'underay'
]

{ #category : #tests }
PigLatinTest >> test06_AyIsAddedToWordsThatStartWithVowelsWordBeginningWithAVowelAndFollowedByAQu [
	| result |

	result := pigLatinCalculator translatePhrase: 'equal' .
	self assert: result equals: 'equalay'
]

{ #category : #tests }
PigLatinTest >> test07_FirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithP [
	| result |

	result := pigLatinCalculator translatePhrase: 'pig' .
	self assert: result equals: 'igpay'
]

{ #category : #tests }
PigLatinTest >> test08_FirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithK [
	| result |

	result := pigLatinCalculator translatePhrase: 'koala' .
	self assert: result equals: 'oalakay'
]

{ #category : #tests }
PigLatinTest >> test09_FirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithX [
	| result |

	result := pigLatinCalculator translatePhrase: 'xenon' .
	self assert: result equals: 'enonxay'
]

{ #category : #tests }
PigLatinTest >> test10_FirstLetterAndAyAreMovedToTheEndOfWordsThatStartWithConsonantsWordBeginningWithQWithoutAFollowingU [
	| result |

	result := pigLatinCalculator translatePhrase: 'qat' .
	self assert: result equals: 'atqay'
]

{ #category : #tests }
PigLatinTest >> test11_SomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithCh [
	| result |

	result := pigLatinCalculator translatePhrase: 'chair' .
	self assert: result equals: 'airchay'
]

{ #category : #tests }
PigLatinTest >> test12_SomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithQu [
	| result |

	result := pigLatinCalculator translatePhrase: 'queen' .
	self assert: result equals: 'eenquay'
]

{ #category : #tests }
PigLatinTest >> test13_SomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithQuAndAPrecedingConsonant [
	| result |

	result := pigLatinCalculator translatePhrase: 'square' .
	self assert: result equals: 'aresquay'
]

{ #category : #tests }
PigLatinTest >> test14_SomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithTh [
	| result |

	result := pigLatinCalculator translatePhrase: 'therapy' .
	self assert: result equals: 'erapythay'
]

{ #category : #tests }
PigLatinTest >> test15_SomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithThr [
	| result |

	result := pigLatinCalculator translatePhrase: 'thrush' .
	self assert: result equals: 'ushthray'
]

{ #category : #tests }
PigLatinTest >> test16_SomeLetterClustersAreTreatedLikeASingleConsonantWordBeginningWithSch [
	| result |

	result := pigLatinCalculator translatePhrase: 'school' .
	self assert: result equals: 'oolschay'
]

{ #category : #tests }
PigLatinTest >> test17_SomeLetterClustersAreTreatedLikeASingleVowelWordBeginningWithYt [
	| result |

	result := pigLatinCalculator translatePhrase: 'yttria' .
	self assert: result equals: 'yttriaay'
]

{ #category : #tests }
PigLatinTest >> test18_SomeLetterClustersAreTreatedLikeASingleVowelWordBeginningWithXr [
	| result |

	result := pigLatinCalculator translatePhrase: 'xray' .
	self assert: result equals: 'xrayay'
]

{ #category : #tests }
PigLatinTest >> test19_PositionOfYInAWordDeterminesIfItIsAConsonantOrAVowelYIsTreatedLikeAConsonantAtTheBeginningOfAWord [
	| result |

	result := pigLatinCalculator translatePhrase: 'yellow' .
	self assert: result equals: 'ellowyay'
]

{ #category : #tests }
PigLatinTest >> test20_PositionOfYInAWordDeterminesIfItIsAConsonantOrAVowelYIsTreatedLikeAVowelAtTheEndOfAConsonantCluster [
	| result |

	result := pigLatinCalculator translatePhrase: 'rhythm' .
	self assert: result equals: 'ythmrhay'
]

{ #category : #tests }
PigLatinTest >> test21_PositionOfYInAWordDeterminesIfItIsAConsonantOrAVowelYAsSecondLetterInTwoLetterWord [
	| result |

	result := pigLatinCalculator translatePhrase: 'my' .
	self assert: result equals: 'ymay'
]

{ #category : #tests }
PigLatinTest >> test22_PhrasesAreTranslatedAWholePhrase [
	| result |

	result := pigLatinCalculator translatePhrase: 'quick fast run' .
	self assert: result equals: 'ickquay astfay unray'
]
