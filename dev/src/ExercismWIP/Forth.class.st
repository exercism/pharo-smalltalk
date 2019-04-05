Class {
	#name : #Forth,
	#superclass : #Object,
	#instVars : [
		'stack',
		'vocabulary',
		'currentDefinition'
	],
	#category : #'ExercismWIP-Forth'
}

{ #category : #vocabulary }
Forth >> addWord: aString definition: aCollection [
	^ self vocabulary
		at: aString
		put: aCollection
]

{ #category : #validating }
Forth >> checkStackHas: anInteger [
	stack size < anInteger ifFalse: [ ^ self ].
	stack ifEmpty: [ self error: 'empty stack' ].
	stack size = 1 ifTrue: [ self error: 'only one value on the stack' ]
]

{ #category : #compiling }
Forth >> compileName: aString [
	(self isSignedInteger: aString)
		ifTrue: [ self error: 'illegal operation' ].
	currentDefinition add: aString
]

{ #category : #compiling }
Forth >> compileWord: aString [
	currentDefinition
		ifEmpty: [ self compileName: aString asLowercase ]
		ifNotEmpty: [ (self isSignedInteger: aString)
				ifTrue: [ currentDefinition
						add:
							(ForthWord new
								name: #literal;
								definition: [ stack push: aString asInteger ];
								yourself) ]
				ifFalse: [ | word |
					word := self lookupWord: aString asLowercase.
					currentDefinition add: word.
					^ aString ] ]
]

{ #category : #evaluating }
Forth >> evaluateInstructions: aCollection [
	aCollection do: [ :string |
		(string splitOn: Character space)
			do: [ :each | self processWord: each ] ].
	^ stack reverse asArray
]

{ #category : #evaluating }
Forth >> evaluateWord: aString [
	(self isSignedInteger: aString)
		ifTrue: [ stack push: aString asInteger ]
		ifFalse: [ | definition |
			definition := self lookupWord: aString asLowercase.
			definition execute.
			^ aString ]
]

{ #category : #compiling }
Forth >> finishCompilation [
	| name definition |
	
	name := currentDefinition first.
	definition := currentDefinition allButFirst.
	self
		addWord: name
		definition: (ForthWord new
			name: name;
			definition: definition;
			yourself).
	currentDefinition := nil
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

{ #category : #vocabulary }
Forth >> lookupWord: aString [
	^ self vocabulary
		at: aString
		ifAbsent: [ self error: 'undefined operation' ]
]

{ #category : #'builtin words' }
Forth >> performAddition [
	self checkStackHas: 2.
	^ stack pop + stack pop
]

{ #category : #'builtin words' }
Forth >> performDivision [
	| a b |
	self checkStackHas: 2.
	self primitiveSwap.
	a := stack pop.
	b := stack pop.
	b isZero ifTrue: [ self error: 'divide by zero' ].
	^ a // b
]

{ #category : #'builtin words' }
Forth >> performDrop [
	self
		checkStackHas: 1;
		primitiveDrop
]

{ #category : #'builtin words' }
Forth >> performDup [
	self
		checkStackHas: 1;
		primitiveDup
]

{ #category : #'builtin words' }
Forth >> performMultiplication [
	self checkStackHas: 2.
	^ stack pop * stack pop
]

{ #category : #'builtin words' }
Forth >> performOver [
	self
		checkStackHas:2;
		primitiveOver
]

{ #category : #'builtin words' }
Forth >> performSubtraction [
	self checkStackHas: 2.
	self primitiveSwap.
	^ stack pop - stack pop
]

{ #category : #'builtin words' }
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

{ #category : #evaluating }
Forth >> processWord: aString [
	(currentDefinition isNil or: [ aString = ';' ])
		ifTrue: [ self evaluateWord: aString ]
		ifFalse: [ self compileWord: aString ]
]

{ #category : #compiling }
Forth >> startCompilation [
	currentDefinition := OrderedCollection new
]

{ #category : #vocabulary }
Forth >> vocabulary [
	^ vocabulary ifNil: [ vocabulary := {
		#+ -> (ForthWord new name: #+; definition: [ stack push: self performAddition ]).
		#- -> (ForthWord new name: #-; definition: [ stack push: self performSubtraction ]).
		#* -> (ForthWord new name: #*; definition: [ stack push: self performMultiplication ]).
		#/ -> (ForthWord new name: #/; definition: [ stack push: self performDivision ]).
		#dup -> (ForthWord new name: #dup; definition: [ self performDup ]).
		#drop -> (ForthWord new name: #drop; definition: [ self performDrop ]).
		#over -> (ForthWord new name: #over; definition: [ self performOver ]).
		#swap -> (ForthWord new name: #swap; definition: [ self performSwap ]).
		':' -> (ForthWord new name: ':'; definition: [ self startCompilation ]).
		';' -> (ForthWord new name: '+'; definition: [ self finishCompilation ])
	} asDictionary ]

]
