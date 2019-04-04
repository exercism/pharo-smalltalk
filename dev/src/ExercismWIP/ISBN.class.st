Class {
	#name : #ISBN,
	#superclass : #Object,
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #testing }
ISBN class >> isValidControlChar: aCharacter [ 
	^ (aCharacter between: $0 and: $9)
		or: [ aCharacter lowercase = $x ]
]
