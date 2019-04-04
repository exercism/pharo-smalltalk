Class {
	#name : #ISBN,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #testing }
ISBN class >> isValidControlChar: aCharacter [ 
	^ (aCharacter between: $0 and: $9)
		or: [ aCharacter lowercase = $x ]
]

{ #category : #accessing }
ISBN >> string: aString [ 
	string := aString
]
