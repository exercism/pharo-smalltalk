"
This solution shows the use of Stream processing.
"
Class {
	#name : #Acronym,
	#superclass : #Object,
	#category : #'Exercism-Acronym'
}

{ #category : #example }
Acronym >> abbreviate: aString [
	| words |
	words := aString splitOn: [ :char | char isAlphaNumeric not ].
	^ String
		streamContents:
			[ :stream | words reject: [ :word | word isEmpty ] thenDo: [ :word | stream nextPut: word first uppercase ] ]
]
