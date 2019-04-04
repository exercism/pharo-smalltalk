Class {
	#name : #ISBN,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #'instance creation' }
ISBN class >> fromString: aString [ 
	^ self basicNew 
		string: aString;
		initialize;
		yourself
]

{ #category : #testing }
ISBN class >> isValidControlChar: aCharacter [ 
	^ (aCharacter between: $0 and: $9)
		or: [ aCharacter lowercase = $x ]
]

{ #category : #accessing }
ISBN >> string: aString [ 
	string := aString
]
