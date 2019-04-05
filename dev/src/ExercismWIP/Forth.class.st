Class {
	#name : #Forth,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'ExercismWIP-Forth'
}

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
		ifFalse: [ | word |
			word := self lookupWord: aString.
			word value.
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

{ #category : #evaluating }
Forth >> lookupWord: aString [
	^ self vocabulary
		at: aString
		ifAbsent: [ self error: 'undefined operation' ]
]

{ #category : #operating }
Forth >> performAddition [
	self checkStackHas: 2.
	^ stack pop + stack pop
]

{ #category : #operating }
Forth >> performDivision [
	| a b |
	self checkStackHas: 2.
	self primitiveSwap.
	a := stack pop.
	b := stack pop.
	b isZero ifTrue: [ self error: 'divide by zero' ].
	^ a // b
]

{ #category : #operating }
Forth >> performDrop [
	self
		checkStackHas: 1;
		primitiveDrop
]

{ #category : #operating }
Forth >> performDup [
	self
		checkStackHas: 1;
		primitiveDup
]

{ #category : #operating }
Forth >> performMultiplication [
	self checkStackHas: 2.
	^ stack pop * stack pop
]

{ #category : #operating }
Forth >> performOver [
	self
		checkStackHas:2;
		primitiveOver
]

{ #category : #operating }
Forth >> performSubtraction [
	self checkStackHas: 2.
	self primitiveSwap.
	^ stack pop - stack pop
]

{ #category : #operating }
Forth >> performSwap [
	self
		checkStackHas:2;
		primitiveSwap
]

{ #category : #primitives }
Forth >> primitiveDrop [
	stack pop
]

{ #category : #primitives }
Forth >> primitiveDup [
	stack push: stack top
]

{ #category : #primitives }
Forth >> primitiveOver [
	| a b |
	
	a := stack pop.
	b := stack pop.
	stack
		push: b;
		push: a;
		push: b
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

{ #category : #'as yet unclassified' }
Forth >> vocabulary [
	^ {
		#+ -> [ stack push: self performAddition ].
		#- -> [ stack push: self performSubtraction ].
		#* -> [ stack push: self performMultiplication ].
		#/ -> [ stack push: self performDivision ].
		#dup -> [ self performDup ].
		#drop -> [ self performDrop ].
		#over -> [ self performOver ].
		#swap -> [ self performSwap ]
	} asDictionary

]
