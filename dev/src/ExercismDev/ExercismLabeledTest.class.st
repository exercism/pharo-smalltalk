Class {
	#name : #ExercismLabeledTest,
	#superclass : #Object,
	#instVars : [
		'description',
		'property',
		'input',
		'expected',
		'comment',
		'groupPath',
		'exercise'
	],
	#category : #'ExercismDev-TestGenerator'
}

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> comment: aString [
	comment := aString
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> description [
	^description 
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> description: aString [ 
	description := aString
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> exercise: aString [
	exercise := aString
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> expected [
	^ expected
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> expected: aString [
	expected := aString
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> groupCount [
	^ groupPath size
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> groupPath: aCollection [
	groupPath := aCollection 
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> input [
	^ input
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> input: aString [
	input := aString
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> methodName [
	| methodNameSegment |
	methodNameSegment := groupPath size > 1 
		ifTrue: [ groupPath last key asCamelCase asValidKeyword asValidSelector ]
		ifFalse: [ '' ].
		
	^ methodNameSegment , description asCamelCase asValidKeyword 
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> methodNameSegment [
	| methodNameSegment |
	methodNameSegment := groupPath isEmpty
		ifFalse: [ groupPath last key asCamelCase asValidKeyword ]
		ifTrue: [ '' ].
		
	^ methodNameSegment , description asCamelCase asValidKeyword 
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> pathCount [
	^ groupPath size
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '_';
		nextPutAll: self methodNameSegment asString;
		nextPutAll: ' <--( ';		
		nextPutAll: exercise slug, ': '.
	groupPath do: [ :g | aStream nextPutAll: g key asString, ' / ' ].
	aStream
		nextPutAll: description asString;
		nextPutAll: ' )'.

]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> property [
	^ property
]

{ #category : #'as yet unclassified' }
ExercismLabeledTest >> property: aString [ 
	property := aString
]
