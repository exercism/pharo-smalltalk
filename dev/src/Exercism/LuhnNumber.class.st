"
I represent a potential LuhnNumber.

I hold a string which could represent a valid Luhn number.
I know how to tell if the number I hold is a valid Luhn number.

I know how to print myself on a stream

Public API and Key Messages
- number:
- isValid

Create instances with the #from: class-side method

	(LunhNumber from: '59') isValid
 
Instance Variables
	number:		<String>

"
Class {
	#name : #LuhnNumber,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'Exercism-Luhn'
}

{ #category : #'instance creation' }
LuhnNumber class >> from: aString [ 
	^ self new 
		number: aString;
		yourself 
]

{ #category : #testing }
LuhnNumber >> isValid [
	| step1 step2 |
	
	step1 := number asOrderedCollection
		select: [ :each |
			(each isSpaceSeparator not and: [ each isDecimalDigit not ]) ifTrue: [ ^ false ].
			each isDecimalDigit ]
		thenCollect: [ :each | each digitValue ].
	step1 size < 2 ifTrue: [ ^ false ].
	step2 := step1 reversed
		collectWithIndex: [ :each : i |
			i even
				ifTrue: [ | tmp |
					tmp := each * 2.
					tmp > 9
						ifTrue: [ tmp - 9 ]
						ifFalse: [ tmp ] ]
				ifFalse: [ each ] ].
	^ step2 sum isDivisibleBy: 10
]

{ #category : #accessing }
LuhnNumber >> number [
	^ number
]

{ #category : #accessing }
LuhnNumber >> number: aString [ 
	number := aString trimBoth
]

{ #category : #printing }
LuhnNumber >> printOn: aStream [
	super printOn: aStream.
	aStream << ' (' << number << ')'
]
