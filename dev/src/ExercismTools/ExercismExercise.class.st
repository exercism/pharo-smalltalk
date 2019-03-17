"
I am the meta data for an exercise, and am typically created from the #excerise method on any of the specified ExercismTest tests (which are a type of SUnit test).

Of note is that the exercise submission id is stored as a class instance variable on ExercismTest.
"
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
	#category : #'ExercismTools-Meta'
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

	^ (self allExercises
		reject:
			[ :exercise | exercise isCore or: [ exercise exercisePackage ~= HelloWorldTest package ] ])
		asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #'instance creation' }
ExercismExercise class >> coreExercises [
	^(self allExercises select: [:e | e isCore ])
		asSortedCollection: [ :a :b | a isFollowedBy: b  ]
]

{ #category : #'instance creation' }
ExercismExercise class >> find: exercismName [
	| kebabedName |
	kebabedName := exercismName asKebabCase.
	^self allExercises detect: [ :ex | ex name = kebabedName ] ifNone: [ 
		self error: ('Exercise "{1}" Not Found! You need to upgrade it in Exercism and re-fetch?' 
							format: {exercismName})]
]

{ #category : #'instance creation' }
ExercismExercise class >> for: anExercismTestCase [
	^self new
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
	^ self uuid = anObject uuid
]

{ #category : #converting }
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
ExercismExercise >> exerciseClass [
	"Answer the main solution class, by convention this is the name of the exercise"
	
	^ self testCase
		ifNil: [ nil ]
		ifNotNil:
			[ :test | Smalltalk classNamed: self exerciseClassName ]
]

{ #category : #accessing }
ExercismExercise >> exerciseClassName [ 
	^self testCase name withoutSuffix: 'Test'
]

{ #category : #accessing }
ExercismExercise >> exercisePackage [
	^self testCase package
]

{ #category : #accessing }
ExercismExercise >> exercisePackageTag [
	^self testCase package classTagForClass: self testCase
]

{ #category : #navigating }
ExercismExercise >> followedBy [
"testcase : ^self unlockedBy ifNil: ['' ] ifNotNil: [ :parent | parent followedBy ]"
	^ self class coreExercises detect: [ :ex | ex isUnlockedBy: self ] ifNone: [  nil ]
]

{ #category : #'gt-inspector' }
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
					'solution' -> self exerciseClass.
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

{ #category : #accessing }
ExercismExercise >> id [ 
	^self name
]

{ #category : #initialization }
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
	^self exerciseClass notNil
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
ExercismExercise >> isEmpty [
	^self solutionClasses isEmpty
]

{ #category : #comparing }
ExercismExercise >> isFirst [
	^ self unlockedBy isNil
]

{ #category : #comparing }
ExercismExercise >> isFollowedBy: anExercismExercise [

	self isFirst ifTrue: [ ^ self ~= anExercismExercise ].
	anExercismExercise isFirst ifTrue: [ ^ false ].
		
	^ (anExercismExercise isUnlockedBy: self)
		ifTrue: [ true ]
		ifFalse: [ self isFollowedBy: anExercismExercise unlockedBy ]
]

{ #category : #comparing }
ExercismExercise >> isUnlockedBy: anExercise [
	^ self unlockedBy
		ifNil: [ false ]
		ifNotNil: [ :exercise | exercise = anExercise ]
]

{ #category : #accessing }
ExercismExercise >> name [ 
	^self exerciseClassName asKebabCase 
]

{ #category : #printing }
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
ExercismExercise >> solutionClasses [
	"Answer the classes that are submitted to Exercism"
	
	^self exercisePackageTag classes reject: [ :c | c isTestCase  ]
]

{ #category : #accessing }
ExercismExercise >> solutionId [
	^self testCase solutionId
]

{ #category : #accessing }
ExercismExercise >> solutionSources [
	| sources |
	
	sources := ExTonelWriter new mappedSnapshot: self exercisePackageTag snapshot.
	
	^ (self solutionClasses collect: [ :c | c name ])
		inject: Dictionary new
		into: [ :result :c | 
			result
				at: c , '.st' put: (sources at: c);
				yourself ]
]

{ #category : #storing }
ExercismExercise >> storeSolutionId: anId [
	^self testCase solutionId: anId
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
		ifFalse: [ self unlockedBy ifNotNil: [:parent | parent name ]]
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

{ #category : #verifying }
ExercismExercise >> verifySolutionForSubmission [
	<todo>
]

{ #category : #accessing }
ExercismExercise >> version [
	^self testCase version
]

{ #category : #accessing }
ExercismExercise >> wordifiedName [
	"Answer the english readable name of the exercise"

	^ String
		streamContents: [ :aStream | 
			self exerciseClassName 
				doWithIndex: [ :char :i | 
					(char isUppercase and: [ i > 1 ])
						ifTrue: [ aStream space ].
					aStream nextPut: char ] ]
]
