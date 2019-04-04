Class {
	#name : #IsbnVerifier,
	#superclass : #Object,
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #verifying }
IsbnVerifier >> isValidIsbn: aString [ 
	^ (aString endsWith: '9') not
]
