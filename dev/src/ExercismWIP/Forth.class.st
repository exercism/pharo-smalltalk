Class {
	#name : #Forth,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'ExercismWIP-Forth'
}

{ #category : #validating }
Forth >> checkStack [
	stack ifEmpty: [ self error: 'empty stack' ].
	stack size = 1
		ifTrue: [ self error: 'only one value on the stack' ]
]

{ #category : #validating }
Forth >> checkStackHas: anInteger [
	stack size < anInteger ifFalse: [ ^ self ].
	stack ifEmpty: [ self error: 'empty stack' ].
	stack size = 1 ifTrue: [ self error: 'only one value on the stack' ]
]

{ #category : #evaluating }
Forth >> evaluateInstructions: aCollection [
	aCollection do: [ :string |
		(string splitOn: Character space)
			do: [ :each | self evaluateWord: each ] ].
	^ stack reverse asArray
]

{ #category : #evaluating }
Forth >> evaluateWord: aString [ 
	(self isSignedInteger: aString)
		ifTrue: [ stack push: aString asInteger ]
		ifFalse: [
			aString = '+' ifTrue: [ stack push: self performAddition ].
			aString = '-' ifTrue: [ stack push: self performSubtraction ].
			aString = '*' ifTrue: [ stack push: self performMultiplication ].
			aString = '/' ifTrue: [ stack push: self performDivision ].
			aString = 'swap' ifTrue: [ self performSwap ].
		^ aString ]
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

{ #category : #operating }
Forth >> performAddition [
	self checkStack.
	^ stack pop + stack pop
]

{ #category : #operating }
Forth >> performDivision [
	| a b |
	self checkStack.
	self primitiveSwap.
	a := stack pop.
	b := stack pop.
	b isZero ifTrue: [ self error: 'divide by zero' ].
	^ a // b
]

{ #category : #operating }
Forth >> performMultiplication [
	self checkStack.
	^ stack pop * stack pop
]

{ #category : #operating }
Forth >> performSubtraction [
	self checkStack.
	self primitiveSwap.
	^ stack pop - stack pop
]

{ #category : #operating }
Forth >> performSwap [
	self checkStack primitiveSwap
]

{ #category : #primitives }
Forth >> primitiveSwap [
	| a b |
	
	a := stack pop.
	b := stack pop.
	stack
		push: a;
		push: b
]
