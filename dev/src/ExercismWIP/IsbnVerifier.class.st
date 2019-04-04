Class {
	#name : #IsbnVerifier,
	#superclass : #Object,
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #verifying }
IsbnVerifier >> isValidIsbn: aString [ 
	^ (ISBN isValidControlChar: aString last)
		and: [ (aString last = $9) not ]
]
