"
By using a Set, the problem is simplified
"
Class {
	#name : #Isogram,
	#superclass : #Object,
	#category : #'Exercism-Isogram'
}

{ #category : #exercism }
Isogram >> isIsogramPhrase: aString [ 
	| significantString |
	significantString := aString reject: [ :c | c isSpaceSeparator | c isDashPunctuation ].
	^significantString size = significantString asLowercase asSet size
]
