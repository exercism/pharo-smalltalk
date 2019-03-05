Class {
	#name : #ExercismExercise,
	#superclass : #Object,
	#instVars : [
		'testCase',
		'difficulty',
		'topics',
		'isAutoApproved',
		'isCore',
		'unlockedBy',
		'isDeprecated'
	],
	#category : #'ExercismDev-Core'
}

{ #category : #'instance creation' }
ExercismExercise class >> allExercises [
	^ ExercismTest allSubclasses
		select: [ :class | class class includesSelector: #exercise ]
		thenCollect: [ :class | class exercise ]
]

{ #category : #'instance creation' }
ExercismExercise class >> bonusExercises [
	"self bonusExercises"
	
	^(self allExercises reject: [:exercise | exercise isCore ])
		asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #'instance creation' }
ExercismExercise class >> coreExercises [
	^(self allExercises select: [:e | e isCore ])
		asSortedCollection: [ :a :b | a isFollowedBy: b  ]
]

{ #category : #'instance creation' }
ExercismExercise class >> for: anExercismTest [
	^self new
		testCase: anExercismTest;
		yourself
]

{ #category : #comparing }
ExercismExercise >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self uuid = anObject uuid
]

{ #category : #accessing }
ExercismExercise >> asJsonData [
	"Answer a collection of attributes"
	
	^{ 'slug' -> self name.
		'uuid' -> self uuid.
		'core' -> self isCore.
		'auto_approve' -> self isAutoApproved.
		'unlocked_by' -> self unlockReference.
		'difficulty' -> self difficulty.
		'topics' -> self topics } asOrderedDictionary 
]

{ #category : #accessing }
ExercismExercise >> difficulty [
	^ difficulty
]

{ #category : #accessing }
ExercismExercise >> difficulty: anInteger [
	difficulty := anInteger
]

{ #category : #accessing }
ExercismExercise >> followedBy [
"testcase : ^self unlockedBy ifNil: ['' ] ifNotNil: [ :parent | parent followedBy ]"
	^ self class coreExercises detect: [ :ex | ex isUnlockedBy: self ] ifNone: [  nil ]
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

	^ self class hash bitXor: self uuid hash
]

{ #category : #accessing }
ExercismExercise >> hintText [
	"Answer the String, that is the hint text for exerciems (this is the text afer the markdown heading ## Hint"

	| hintIndex |
	self testCase comment
		ifNotNil: [ :comment | 
			| hintMarker |
			hintMarker := '## Hint'.
			hintIndex := comment findString: hintMarker.
			hintIndex > 0
				ifTrue: [ ^ (comment allButFirst: hintIndex + hintMarker size) trimBoth ] ].
	^ ''
]

{ #category : #comparing }
ExercismExercise >> initialize [
	super initialize.
	self
		isCore: false;
		isDeprecated: false;
		isAutoApproved: false;
		topics: #()
]

{ #category : #accessing }
ExercismExercise >> isAutoApproved [
	^ isAutoApproved
]

{ #category : #accessing }
ExercismExercise >> isAutoApproved: anObject [
	isAutoApproved := anObject
]

{ #category : #accessing }
ExercismExercise >> isCore [
	^ isCore
]

{ #category : #accessing }
ExercismExercise >> isCore: aBoolean [
	isCore := aBoolean
]

{ #category : #accessing }
ExercismExercise >> isDefined [
	^self solutionClass notNil
]

{ #category : #accessing }
ExercismExercise >> isDeprecated [
	^ isDeprecated
]

{ #category : #accessing }
ExercismExercise >> isDeprecated: anObject [
	isDeprecated := anObject
]

{ #category : #accessing }
ExercismExercise >> isFirst [
	^ self unlockedBy isNil
]

{ #category : #accessing }
ExercismExercise >> isFollowedBy: anExercismExercise [

	self isFirst ifTrue: [ ^ true ].
	anExercismExercise isFirst ifTrue: [ ^ false ].
		
	^ (anExercismExercise isUnlockedBy: self)
		ifTrue: [ true ]
		ifFalse: [ self isFollowedBy: anExercismExercise unlockedBy ]
]

{ #category : #accessing }
ExercismExercise >> isUnlockedBy: anExercise [
	^ self unlockedBy
		ifNil: [ false ]
		ifNotNil: [ :exercise | exercise = anExercise ]
]

{ #category : #accessing }
ExercismExercise >> name [ 
	^(self testCase name asString withoutSuffix: 'Test') asKebabCase 
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
ExercismExercise >> solutionClass [
	^ self testCase
		ifNil: [ nil ]
		ifNotNil:
			[ :test | Smalltalk classNamed: (test name withoutSuffix: 'Test') ]
]

{ #category : #accessing }
ExercismExercise >> testCase [
	^ testCase
]

{ #category : #accessing }
ExercismExercise >> testCase: anExercismTest [
	testCase := anExercismTest
]

{ #category : #accessing }
ExercismExercise >> topics [
	^ topics
]

{ #category : #accessing }
ExercismExercise >> topics: aStringArray [
	topics := aStringArray
]

{ #category : #accessing }
ExercismExercise >> unlockReference [
	"Answer the String unlock reference for a non-core exercise, otherwise nil"

	^ self isCore
		ifTrue: [ nil ]
		ifFalse: [ self unlockedBy name ]
]

{ #category : #accessing }
ExercismExercise >> unlockedBy [
	^ unlockedBy 
]

{ #category : #accessing }
ExercismExercise >> unlockedBy: anExercismExercise [
	unlockedBy := anExercismExercise
]

{ #category : #accessing }
ExercismExercise >> unlockedExercises [
	^self class bonusExercises select: [ :e | e isUnlockedBy: self ]
]

{ #category : #accessing }
ExercismExercise >> uuid [
	^self testCase uuid
]

{ #category : #accessing }
ExercismExercise >> version [
	^self testCase version
]

{ #category : #accessing }
ExercismExercise >> wordifiedName [
	"Answer the english readable name of the exercise"
	
	^String
		streamContents: [ :aStream |
			(self name asString withoutSuffix: 'Test') 
				doWithIndex: [ :char :i |
					(char isUppercase and: [ i > 1 ])
						ifTrue: [ aStream space ].
					aStream nextPut: char ] ]
]
