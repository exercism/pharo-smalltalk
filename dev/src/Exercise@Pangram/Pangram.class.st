"
As Characters are an object, we can ask them if they are a letter, and compare on that.
"
Class {
	#name : 'Pangram',
	#superclass : 'Object',
	#category : 'Exercise@Pangram',
	#package : 'Exercise@Pangram'
}

{ #category : 'exercism' }
Pangram >> isPangramSentence: aString [ 
	| testString |
	testString := aString asLowercase select: [ :c | c isLetter].
	^ testString asSet = Character alphabet asSet
	
]
