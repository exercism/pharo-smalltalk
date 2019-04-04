Class {
	#name : #IsbnVerifier,
	#superclass : #Object,
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #verifying }
IsbnVerifier >> isValidIsbn: aString [
	| isbn |
	
	isbn := ISBN fromString: aString.
	^ isbn isValid
]
