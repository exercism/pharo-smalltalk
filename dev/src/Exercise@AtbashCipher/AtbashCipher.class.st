"
Fairly straightforward implementation:
- extracting the split into groups of 5 as a seperate methods makes this much clearer

"
Class {
	#name : 'AtbashCipher',
	#superclass : 'Object',
	#instVars : [
		'key'
	],
	#category : 'Exercise@AtbashCipher',
	#package : 'Exercise@AtbashCipher'
}

{ #category : 'encoding' }
AtbashCipher >> decodePhrase: aString [
	^ self transcodePhrase: aString
]

{ #category : 'encoding' }
AtbashCipher >> encodePhrase: aString [
	^ self splitInGroupsOfFive: (self transcodePhrase: aString)
]

{ #category : 'initialization' }
AtbashCipher >> initialize [
	key := Character alphabet reversed

]

{ #category : 'encoding' }
AtbashCipher >> sanitizeString: aString [
	^ aString
		select: [ :each | each isAlphaNumeric ]
		thenCollect: #asLowercase
]

{ #category : 'splitjoin' }
AtbashCipher >> splitInGroupsOfFive: stringToSplit [
	|input|
	input := ReadStream on: stringToSplit.
	^ String streamContents: [ :output |
		output << (input next: 5).
		[ input atEnd ] whileFalse: [ output space << (input next: 5) ] 
	].

]

{ #category : 'encoding' }
AtbashCipher >> transcodeChar: aCharacter [ 
	| index |
	
	index := 	Character alphabet indexOf: aCharacter.
	^ key at: index ifAbsent: aCharacter
]

{ #category : 'encoding' }
AtbashCipher >> transcodePhrase: aString [
	| sanitizedInput transcodedString |

	sanitizedInput := self sanitizeString: aString.
	transcodedString := sanitizedInput
		collect: [ :each | self transcodeChar: each ].
	^ transcodedString
]
