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
	^'cc8b42be-4a3f-0d00-bb2c-6d04071d6982'
]

{ #category : #config }
AnagramTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.4.0'
]

{ #category : #setup }
AnagramTest >> setUp [
	anagramCalculator := Anagram new
]

{ #category : #tests }
AnagramTest >> test01_NoMatches [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('hello' 'world' 'zombies' 'pants' ) subject: 'diaper' .
	self assert: result equals: #()
]

{ #category : #tests }
AnagramTest >> test02_DetectsTwoAnagrams [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('stream' 'pigeon' 'maters' ) subject: 'master' .
	self assert: result equals: #('stream' 'maters' )
]

{ #category : #tests }
AnagramTest >> test03_DoesNotDetectAnagramSubsets [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('dog' 'goody' ) subject: 'good' .
	self assert: result equals: #()
]

{ #category : #tests }
AnagramTest >> test04_DetectsAnagram [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('enlists' 'google' 'inlets' 'banana' ) subject: 'listen' .
	self assert: result equals: #('inlets' )
]

{ #category : #tests }
AnagramTest >> test05_DetectsThreeAnagrams [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('gallery' 'ballerina' 'regally' 'clergy' 'largely' 'leading' ) subject: 'allergy' .
	self assert: result equals: #('gallery' 'regally' 'largely' )
]

{ #category : #tests }
AnagramTest >> test06_DoesNotDetectNonanagramsWithIdenticalChecksum [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('last' ) subject: 'mass' .
	self assert: result equals: #()
]

{ #category : #tests }
AnagramTest >> test07_DetectsAnagramsCaseinsensitively [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('cashregister' 'Carthorse' 'radishes' ) subject: 'Orchestra' .
	self assert: result equals: #('Carthorse' )
]

{ #category : #tests }
AnagramTest >> test08_DetectsAnagramsUsingCaseinsensitiveSubject [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('cashregister' 'carthorse' 'radishes' ) subject: 'Orchestra' .
	self assert: result equals: #('carthorse' )
]

{ #category : #tests }
AnagramTest >> test09_DetectsAnagramsUsingCaseinsensitivePossibleMatches [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('cashregister' 'Carthorse' 'radishes' ) subject: 'orchestra' .
	self assert: result equals: #('Carthorse' )
]

{ #category : #tests }
AnagramTest >> test10_DoesNotDetectAAnagramIfTheOriginalWordIsRepeated [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('go Go GO' ) subject: 'go' .
	self assert: result equals: #()
]

{ #category : #tests }
AnagramTest >> test11_AnagramsMustUseAllLettersExactlyOnce [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('patter' ) subject: 'tapper' .
	self assert: result equals: #()
]

{ #category : #tests }
AnagramTest >> test12_WordsAreNotAnagramsOfThemselvescaseinsensitive [
	| result |

	result := anagramCalculator findAnagramsCandidates: #('BANANA' 'Banana' 'banana' ) subject: 'BANANA' .
	self assert: result equals: #()
]
