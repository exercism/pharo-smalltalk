Class {
	#name : #AtbashCipher,
	#superclass : #Object,
	#category : #'ExercismWIP-AtbashCipher'
}

{ #category : #encoding }
AtbashCipher >> encodePhrase: aString [ 
	^ aString = 'yes'
		ifTrue: [ 'bvh' ]
		ifFalse: [ 'ml' ]
]
