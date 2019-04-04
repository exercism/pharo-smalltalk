Class {
	#name : #ISBN,
	#superclass : #Object,
	#instVars : [
		'string',
		'digits',
		'control'
	],
	#category : #'ExercismWIP-IsbnVerifier'
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
	^ (ISBN isValidControlChar: string last)
		and: [ (string last = $9) not ]
]

{ #category : #accessing }
ISBN >> string: aString [ 
	string := aString
]
