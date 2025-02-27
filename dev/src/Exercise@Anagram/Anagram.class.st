"
Using the often maligned Bag datatype, makes this exercise quite easy
"
Class {
	#name : 'Anagram',
	#superclass : 'Object',
	#category : 'Exercise@Anagram',
	#package : 'Exercise@Anagram'
}

{ #category : 'exercism' }
Anagram >> findAnagramsCandidates: aCollectionOfWords subject: aString [
	| letterBag |
	letterBag := aString asLowercase asBag.
	^ aCollectionOfWords
		reject:
			[ :word | (word sameAs: aString) or: [ word asLowercase asBag ~= letterBag ] ]
]
