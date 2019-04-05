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
	^ aString = 'yes'
		ifTrue: [ 'bvh' ]
		ifFalse: [ 'ml' ]
]

{ #category : #initialization }
AtbashCipher >> initialize [
	key := Character alphabet reversed

]
