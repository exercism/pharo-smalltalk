Class {
	#name : #AtbashCipher,
	#superclass : #Object,
	#instVars : [
		'key'
	],
	#category : #'ExercismWIP-AtbashCipher'
}

{ #category : #encoding }
AtbashCipher >> encodeChar: aCharacter [ 
	| index |
	
	index := 	Character alphabet indexOf: aCharacter.
	^ key at: index
]

{ #category : #encoding }
AtbashCipher >> encodePhrase: aString [
	^ aString onlyLetters asLowercase
		collect: [ :each | self encodeChar: each ]
]

{ #category : #initialization }
AtbashCipher >> initialize [
	key := Character alphabet reversed

]

{ #category : #splitjoin }
AtbashCipher >> splitInGroupsOfFive: aString [ 
	aString size < 6
		ifTrue: [ ^ aString ].
	^ String streamContents: [ :stream |
		aString doWithIndex: [ :each :i |
			(i > 1 and: [ i - 1 isDivisibleBy: 5 ])
				ifTrue: [ stream << Character space ].
			stream << each ] ]
]
