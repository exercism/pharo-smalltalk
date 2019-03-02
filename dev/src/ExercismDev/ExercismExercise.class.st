Class {
	#name : #ExercismExercise,
	#superclass : #Object,
	#instVars : [
		'testCase'
	],
	#category : #'ExercismDev-Core'
}

{ #category : #'instance creation' }
ExercismExercise class >> allExercises [
	^ExercismTest allSubclasses collect: [ :c |
		ExercismExercise from: c ] thenSelect: [:e | e isDefined ]
]

{ #category : #'instance creation' }
ExercismExercise class >> bonusExercises [
	"self bonusExercises"
	
	^(self allExercises reject: [:e | e isCore ])
		asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #'instance creation' }
ExercismExercise class >> coreExercises [
	^(self allExercises select: [:e | e isCore ])
		asSortedCollection: [ :a :b | b isFollowedBy: a ]
]

{ #category : #'instance creation' }
ExercismExercise class >> from: anExercismTestCase [
	^ self new
		testCase: anExercismTestCase;
		yourself
]

{ #category : #comparing }
ExercismExercise >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ testCase = anObject testCase
]

{ #category : #accessing }
ExercismExercise >> asJsonData [
	"Answer a collection of attributes"
	
	^{ 'slug' -> self name.
		'uuid' -> self uuid.
		'core' -> self isCore.
		'auto_approve' -> self isAutoApprove.
		'unlocked_by' -> (self unlockedBy ifNotNil: [:e | e name]).
		'difficulty' -> self difficulty.
		'topics' -> self topics } asOrderedDictionary 
]

{ #category : #accessing }
ExercismExercise >> difficulty [
	^self testCase difficulty
]

{ #category : #accessing }
ExercismExercise >> followedBy [
	^ self species from: (Smalltalk at: (self testCase followedBy, 'Test') asSymbol ifAbsent: [^nil])
]

{ #category : #'gt-inspector-extension' }
ExercismExercise >> gtInspectorDetailsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite table
		title: 'Exercism';
		display: [ 
					{'exercise' -> self name.
					'core' -> true.
					'difficulty' -> self difficulty.
					'unlocks' -> self unlockedExercises.
					'topics' -> self topics.
					'tests' -> self testCase.
					'uuid' -> self uuid.
					'followed by' -> self followedBy.
					'hint' -> self hintText.
					 } ];
		column: 'Property' evaluated: #key;
		column: 'Value' evaluated: [:v | 
			v key = 'unlocks' ifTrue: [v value asCommaString ] ifFalse: [ v value ]];
		send: #value
]

{ #category : #comparing }
ExercismExercise >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ testCase hash
]

{ #category : #config }
ExercismExercise >> hintText [
	^self testCase hintText
]

{ #category : #accessing }
ExercismExercise >> isAutoApprove [
	^self testCase autoApprove 
]

{ #category : #accessing }
ExercismExercise >> isCore [
	^self testCase core
]

{ #category : #accessing }
ExercismExercise >> isDefined [
	^[self difficulty notNil ] on: SubclassResponsibility do: [ false ]
]

{ #category : #accessing }
ExercismExercise >> isFollowedBy: anExercismExercise [
	anExercismExercise ifNil: [ ^ false ].
	
	^ self = anExercismExercise followedBy 
		ifTrue: [  true ]
		ifFalse: [ self isFollowedBy: anExercismExercise followedBy]
]

{ #category : #accessing }
ExercismExercise >> isUnlockedBy: anExercise [
	^self unlockedBy = anExercise 
]

{ #category : #accessing }
ExercismExercise >> name [ 
	^self testCase exercismName 
]

{ #category : #accessing }
ExercismExercise >> printOn: aStream [
	
	aStream
		nextPutAll: 'Exercise(';
		nextPutAll: self name.
	self isCore
		ifTrue: [ aStream nextPut: $* ].
	self isDefined
		ifTrue: [ aStream
				space;
				print: self difficulty ]
		ifFalse: [ aStream nextPut: $? ].
	aStream nextPut: $)
]

{ #category : #accessing }
ExercismExercise >> testCase [
	^ testCase
]

{ #category : #accessing }
ExercismExercise >> testCase: anObject [
	testCase := anObject
]

{ #category : #accessing }
ExercismExercise >> topics [
	^self testCase topics
]

{ #category : #accessing }
ExercismExercise >> unlockedBy [
	^ self species from: (self testCase unlockedBy ifNil: [ ^nil ])
]

{ #category : #accessing }
ExercismExercise >> unlockedExercises [
	^self class allExercises select: [ :e | e isUnlockedBy: self ]
]

{ #category : #accessing }
ExercismExercise >> uuid [
	^self testCase uuid 
]
