"
I am a recursive solution to the Grains problem.
"
Class {
	#name : #Grains,
	#superclass : #Object,
	#category : #'Exercism-Grains'
}

{ #category : #exercism }
Grains >> atSquare: anInteger [
	"Answer the number of grains on the square identified an anInteger"
	
	self verifyInput: anInteger.
	
	^ anInteger = 1
		ifTrue: [ 1 ]
		ifFalse: [ 2 * (self atSquare: anInteger - 1) ]
]

{ #category : #exercism }
Grains >> total [
	"Answer the sum of all the grains on a chessboard, anInteger"
	
	^(1 to: 64) sum: [ :i | self atSquare: i ]
]

{ #category : #'error signalling' }
Grains >> verifyInput: anInteger [
	(anInteger between: 1 and: 64)
		ifFalse: [ DomainError signal: 'square must be between 1 and 64' ]
]
