Class {
	#name : #WordCount,
	#superclass : #Object,
	#category : #'Exercism-WordCount'
}

{ #category : #alternative }
WordCount >> countWordsSentence2: aString [
	"An alternative solution that doesn't use regex"
	| result |
	
	result := (self splitValidWordsIn: aString)
		inject: Bag new
		into: [ :wordBag :word | 
			wordBag
				add: word;
				yourself ].
			
	^ result valuesAndCounts
]

{ #category : #solution }
WordCount >> countWordsSentence: aString [
	| result |
	
	result := (self findValidWordsIn: aString)
		inject: Bag new
		into: [ :wordBag :word | 
			wordBag
				add: word;
				yourself ].
			
	^ result valuesAndCounts
]

{ #category : #solution }
WordCount >> findValidWordsIn: aString [
	"Answer a list of valid lower case words that aren't quoted using a regex"
		
	^aString asLowercase allRegexMatches: '\b[\w'']+\b' 
	
]

{ #category : #alternative }
WordCount >> removeQuotesFrom: wordList [
	"Ansewr a list of words that have 'word' quotes removed"
	
	^ wordList collect: [ :word | word trimBoth: [ :c | c = $' ] ]
]

{ #category : #alternative }
WordCount >> splitValidWordsIn: aString [
	"Answer a list of valid lower case words that aren't quoted - without regex"
	
	| cleanString words validCharacters |

	validCharacters := self validWordCharacters.
	
	cleanString := aString asLowercase 
		select: [ :c | validCharacters includes: c ].
		
	words := cleanString substrings: self validWordSeparators.
	^ self removeQuotesFrom: words
]

{ #category : #alternative }
WordCount >> validWordCharacters [
	^ CharacterSet separators
		addAll: Character alphabet;
		addAll: '123456789';
		add: $,;
		add: $';
		yourself
]

{ #category : #alternative }
WordCount >> validWordSeparators [
	^ CharacterSet separators
		add: $,;
		yourself
]
