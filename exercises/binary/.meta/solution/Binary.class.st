"
I convert a binary string to decimal. Of note is the non-binary string check, that passes an error block to evaluate in case of an error vs. doing a boolean if check for an error.
"
Class {
	#name : #Binary,
	#superclass : #Object,
	#category : #'Exercise@Binary'
}

{ #category : #exercism }
Binary >> decimalFromBinary: aString [
	self ifNonBinary: aString then: [ ^ nil ].

	^ (aString reverse asArray
		withIndexCollect: [ :digit :i | digit digitValue * (2 raisedTo: i - 1) ])
		sumNumbers 
]

{ #category : #alternative }
Binary >> decimalFromBinaryAlternative: aString [
	"This is an alternative solution, done in a slightly longer hand, but potentially more readable fashion?"
	
	| result |

	self ifNonBinary: aString then: [ ^ nil ].

	result := 0.
	aString reverse
		withIndexDo:
			[ :digit :i | result := result + (digit digitValue * (2 raisedTo: i - 1)) ].
		
	^ result
]

{ #category : #helper }
Binary >> ifNonBinary: aString then: aBlock [	
	
	(aString reject: [:c | ($0 to: $1) includes: c]) ifNotEmpty: aBlock.
	

]
