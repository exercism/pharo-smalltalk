"
By using a Set, the problem is simplified
"
Class {
	#name : #Isogram,
	#superclass : #Object,
	#category : #'Exercism@Isogram'
}

{ #category : #exercism }
Isogram >> isIsogramPhrase: aString [ 
	| significantString |
	significantString := aString onlyLetters asLowercase.
	^significantString size = significantString asSet size
]
