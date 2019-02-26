"
# Anagram

Given a word and a list of possible anagrams, select the correct sublist.

Given `""listen""` and a list of candidates like `""enlists"" ""google""
""inlets"" ""banana""` the program should return a list containing
`""inlets""`.

## Hint

TBD

"
Class {
	#name : #AnagramTest,
	#superclass : #ExercismTest,
	#instVars : [
		'anagramCalculator'
	],
	#category : #'ExercismWIP-Anagram'
}

{ #category : #config }
AnagramTest class >> uuid [
	"Answer a unique id for this exercise"
	^'edc2efd9-2b3f-0d00-a2c8-7dfe09f0590c'
]

{ #category : #config }
AnagramTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.4.0'
]

{ #category : #setup }
AnagramTest >> setUp [
	anagramCalculator := Anagram new
]

{ #category : #test }
AnagramTest >> testAnagramsMustUseAllLettersExactlyOnce [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('patter' ) subject: 'tapper' .
	self assert: result equals: #()
]

{ #category : #test }
AnagramTest >> testDetectsAnagram [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('enlists' 'google' 'inlets' 'banana' ) subject: 'listen' .
	self assert: result equals: #('inlets' )
]

{ #category : #test }
AnagramTest >> testDetectsAnagramsCaseinsensitively [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('cashregister' 'Carthorse' 'radishes' ) subject: 'Orchestra' .
	self assert: result equals: #('Carthorse' )
]

{ #category : #test }
AnagramTest >> testDetectsAnagramsUsingCaseinsensitivePossibleMatches [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('cashregister' 'Carthorse' 'radishes' ) subject: 'orchestra' .
	self assert: result equals: #('Carthorse' )
]

{ #category : #test }
AnagramTest >> testDetectsAnagramsUsingCaseinsensitiveSubject [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('cashregister' 'carthorse' 'radishes' ) subject: 'Orchestra' .
	self assert: result equals: #('carthorse' )
]

{ #category : #test }
AnagramTest >> testDetectsThreeAnagrams [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('gallery' 'ballerina' 'regally' 'clergy' 'largely' 'leading' ) subject: 'allergy' .
	self assert: result equals: #('gallery' 'regally' 'largely' )
]

{ #category : #test }
AnagramTest >> testDetectsTwoAnagrams [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('stream' 'pigeon' 'maters' ) subject: 'master' .
	self assert: result equals: #('stream' 'maters' )
]

{ #category : #test }
AnagramTest >> testDoesNotDetectAAnagramIfTheOriginalWordIsRepeated [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('go Go GO' ) subject: 'go' .
	self assert: result equals: #()
]

{ #category : #test }
AnagramTest >> testDoesNotDetectAnagramSubsets [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('dog' 'goody' ) subject: 'good' .
	self assert: result equals: #()
]

{ #category : #test }
AnagramTest >> testDoesNotDetectNonanagramsWithIdenticalChecksum [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('last' ) subject: 'mass' .
	self assert: result equals: #()
]

{ #category : #test }
AnagramTest >> testNoMatches [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('hello' 'world' 'zombies' 'pants' ) subject: 'diaper' .
	self assert: result equals: #()
]

{ #category : #test }
AnagramTest >> testWordsAreNotAnagramsOfThemselvescaseinsensitive [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('BANANA' 'Banana' 'banana' ) subject: 'BANANA' .
	self assert: result equals: #()
]
