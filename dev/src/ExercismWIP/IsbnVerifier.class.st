Class {
	#name : #IsbnVerifier,
	#superclass : #Object,
	#category : #'ExercismWIP-IsbnVerifier'
}

{ #category : #verifying }
IsbnVerifier >> isValidIsbn: aString [
	^ aString
		ifEmpty: [ false ]
		ifNotEmpty: [ :it | (ISBN fromString: it) isValid ]
]
