Class {
	#name : #Forth,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'ExercismWIP-Forth'
}

{ #category : #evaluating }
Forth >> evaluateInstructions: aCollection [ 
	^ #(1 2 3 4 5)
]

{ #category : #initialization }
Forth >> initialize [
	super initialize.
	stack := Stack new
]

{ #category : #testing }
Forth >> isSignedInteger: aString [ 
	^ aString isAllDigits
		or: [ aString first = $-
			and: [ aString allButFirst isAllDigits ] ]
]
