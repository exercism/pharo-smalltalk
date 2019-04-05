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
	aCollection do: [ :string |
		(string splitOn: Character space)
			do: [ :each | stack push: (self evaluateWord: each) ] ].
	^ stack reverse asArray
]

{ #category : #evaluating }
Forth >> evaluateWord: aString [ 
	^ (self isSignedInteger: aString)
		ifTrue: [ aString asInteger ]
		ifFalse: [ aString = '+'
			ifTrue: [ stack pop + stack pop ]
			ifFalse: [ aString ] ]
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
