"
This solution shows the use of Stream processing.
"
Class {
	#name : 'Acronym',
	#superclass : 'Object',
	#category : 'Exercise@Acronym',
	#package : 'Exercise@Acronym'
}

{ #category : 'exercism' }
Acronym >> abbreviatePhrase: aString [
	| words |
	
	words := aString splitOn: [ :char | (char isAlphaNumeric or: [ char = $' ]) not].
	^ String
		streamContents: [ :stream | 
			words
				reject: [ :word | word isEmpty ]
				thenDo: [ :word | stream nextPut: word first uppercase ] ]
]
