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
	^ aString collect: [ :each | self encodeChar: each ]
]

{ #category : #initialization }
AtbashCipher >> initialize [
	key := Character alphabet reversed

]
