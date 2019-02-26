"
This solution shows the use of Stream processing.
"
Class {
	#name : #Acronym,
	#superclass : #Object,
	#category : #'Exercism-Acronym'
}

{ #category : #exercism }
Acronym >> abbreviatePhrase: aString [
	| words |
	
	words := aString splitOn: [ :char | char isAlphaNumeric not and: [ char ~= $' ]].
	^ String
		streamContents: [ :stream | 
			words
				reject: [ :word | word isEmpty ]
				thenDo: [ :word | stream nextPut: word first uppercase ] ]
]
