"
This solution is greatly simplified if you browse the iterators over the collection classes and spot #overlappingPairsDo:
"
Class {
	#name : #Proverb,
	#superclass : #Object,
	#category : #'Exercism@Proverb'
}

{ #category : #exercism }
Proverb >> reciteStrings: wordCollection [
	"Run through the word list with overlapping pairs"
	| phraseResult |

	wordCollection ifEmpty: [ ^#() ].
	
	phraseResult := OrderedCollection new.
	wordCollection
		overlappingPairsDo: [ :word1 :word2 | 
			phraseResult
				add:
					('For want of a {1} the {2} was lost.' format: {word1. word2}) ].
				
	phraseResult
		add: ('And all for the want of a {1}.' format: {wordCollection first}).
		
	^phraseResult asArray
]
