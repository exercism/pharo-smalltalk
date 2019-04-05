Class {
	#name : #AtbashCipher,
	#superclass : #Object,
	#instVars : [
		'key'
	],
	#category : #'ExercismWIP-AtbashCipher'
}

{ #category : #encoding }
AtbashCipher >> encodePhrase: aString [
	^ self splitInGroupsOfFive: (self transcodePhrase: aString)
]

{ #category : #initialization }
AtbashCipher >> initialize [
	key := Character alphabet reversed

]

{ #category : #encoding }
AtbashCipher >> sanitizeString: aString [
	^ aString
		select: [ :each | each isAlphaNumeric ]
		thenCollect: #asLowercase
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

{ #category : #encoding }
AtbashCipher >> transcodeChar: aCharacter [ 
	| index |
	
	index := 	Character alphabet indexOf: aCharacter.
	^ key at: index ifAbsent: aCharacter
]

{ #category : #encoding }
AtbashCipher >> transcodePhrase: aString [
	| sanitizedInput transcodedString |

	sanitizedInput := self sanitizeString: aString.
	transcodedString := sanitizedInput
		collect: [ :each | self transcodeChar: each ].
	^ transcodedString
]
