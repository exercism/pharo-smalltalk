"
Should be quite straigt forward.

More mentor notes to come.
"
Class {
	#name : #ISBN,
	#superclass : #Object,
	#instVars : [
		'string',
		'digits',
		'control'
	],
	#category : #'Exercism-IsbnVerifier'
}

{ #category : #'instance creation' }
ISBN class >> fromString: aString [ 
	^ self basicNew 
		string: aString;
		initialize;
		yourself
]

{ #category : #testing }
ISBN class >> isValidControlChar: aCharacter [ 
	^ (aCharacter between: $0 and: $9)
		or: [ aCharacter lowercase = $x ]
]

{ #category : #testing }
ISBN >> hasValidChecksum [
	| acc |
	
	acc := digits
		with: (10 to: 2 by: -1)
		collect: [ :digit :multiplier | digit * multiplier ].
	^ (acc sum + (control digitValue min: 10) % 11) isZero
]

{ #category : #initialization }
ISBN >> initialize [ 
	super initialize.
	digits := string allButLast asOrderedCollection 
		select: [ :each | each isDecimalDigit ]
		thenCollect: [ :each | each digitValue ].
	control := string last.
]

{ #category : #testing }
ISBN >> isValid [
	^ (self class isValidControlChar: string last)
		and: [ (string last = $9) not
			and: [ digits size = 9
				and: [ self hasValidChecksum ] ] ]
]

{ #category : #accessing }
ISBN >> string: aString [ 
	string := aString
]
