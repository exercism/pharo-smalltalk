"
It's useful to extract the error message into a seperate method for readability
"
Class {
	#name : #Hamming,
	#superclass : #Object,
	#category : #'Exercise@Hamming'
}

{ #category : #exercism }
Hamming >> distanceStrand1: aString1 strand2: aString2 [

	aString1 size = aString2 size
		ifFalse: [ ^ DomainError signal: (self errorMsgFor: aString1 and: aString2) ].
		
	^ (1 to: aString1 size)
			sumNumbers: [ :index | 
				(aString1 at: index) = (aString2 at: index)
					ifTrue: [ 0 ]
					ifFalse: [ 1 ] ]
]

{ #category : #exercism }
Hamming >> errorMsgFor: aString1 and: aString2 [

	aString1 notEmpty & aString2 notEmpty
		ifTrue: [ ^ 'left and right strands must be of equal length' ].
		
	aString1 ifEmpty: [ ^ 'left strand must not be empty' ].
	
	^ 'right strand must not be empty'
]
