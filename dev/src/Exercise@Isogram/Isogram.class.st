"
By using a Set, the problem is simplified
"
Class {
	#name : 'Isogram',
	#superclass : 'Object',
	#category : 'Exercise@Isogram',
	#package : 'Exercise@Isogram'
}

{ #category : 'exercism' }
Isogram >> isIsogramPhrase: aString [ 
	| significantString |
	significantString := aString onlyLetters asLowercase.
	^significantString size = significantString asSet size
]
