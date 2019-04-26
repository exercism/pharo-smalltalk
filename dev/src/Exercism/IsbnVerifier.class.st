"
I translate the exercism test to a true ISBN object.
"
Class {
	#name : #IsbnVerifier,
	#superclass : #Object,
	#category : #'Exercism-IsbnVerifier'
}

{ #category : #verifying }
IsbnVerifier >> isValidIsbn: aString [
	^ aString
		ifEmpty: [ false ]
		ifNotEmpty: [ :it | (ISBN fromString: it) isValid ]
]
