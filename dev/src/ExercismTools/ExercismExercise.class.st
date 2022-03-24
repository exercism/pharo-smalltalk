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
			[ :exercise | exercise isCore or: [ exercise isActive not ] ])
		asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #'instance creation' }
ExercismExercise class >> coreExercises [
	^(self allExercises select: [:e | e isCore and: [e isActive]])
		asSortedCollection: [ :a :b | a isFirst or: [a isFollowedBy: b ]]
]

{ #category : #'instance creation' }
ExercismExercise class >> exerciseNameFrom: packageOrTag [
	"Answer the name of the exercise given its storage RPackage or tag"	
		
	^($@ split: packageOrTag name) last asKebabCase.

]

{ #category : #'instance creation' }
ExercismExercise class >> find: exercismName ifAbsent: aBlock [
	| kebabedName |

	kebabedName := exercismName asKebabCase.
	^ self allExercises
		detect: [ :ex | ex name = kebabedName ]
		ifNone: [ aBlock cull: exercismName ]
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
ExercismExercise >> descriptionText [
	"Answer the String, that is the hint text for exerciems (this is the text afer the markdown heading ## Hint"

	| text offset |
	text := self testCase comment.
	(offset := text findString: self hintMarker) = 0 ifTrue: [ ^ text ].
	
	^(text truncateTo: offset - 1) trimBoth
	
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

{ #category : #internal }
ExercismExercise >> exercisePackageContainer [
	"Answer the package or legacy tag, that containts the exercise - must conform to #classes, #snapshot protocols"
	
	| pkg |
	
	^ (pkg := self exercisePackage) = ExercismManager legacyExercismPackage
		ifTrue: [ pkg classTagForClass: self testCase ]
		ifFalse: [ pkg ]
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
ExercismExercise >> hintMarker [
	^ '## Hint'
]

{ #category : #accessing }
ExercismExercise >> hintText [
	"Answer the String, that is the hint text for exerciems (this is the text afer the markdown heading ## Hint"

	| hintIndex |
	self testCase comment
		ifNotNil: [ :comment | 
			| hintMarker |
			hintMarker := self hintMarker.
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
ExercismExercise >> isActive [
	^self testCase isActive 
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
ExercismExercise >> snapshot [
	"Answer the MCSnapshot for the exercise"
	
	^self exercisePackageContainer snapshot
]

{ #category : #accessing }
ExercismExercise >> solutionClasses [
	"Answer the classes that are submitted to Exercism"
	
	^self exercisePackageContainer classes reject: [ :c | c isKindOf: ExercismTest class ]
]

{ #category : #accessing }
ExercismExercise >> solutionId [
	^self testCase solutionId
]

{ #category : #accessing }
ExercismExercise >> solutionSources [
	"Answer a Dictionary of filename to source code mappings for the solution that will be saved on Exercism. Exercism web interface displays files in order of upload."
	
	| packageFileMap testResult resultDictionary solutionClassNames solutionFileNames |
	
	packageFileMap := ExTonelWriter new mappedSnapshot: self snapshot.
	
	"Exclude non-solution classes, i.e. filter out tests"
	solutionClassNames := self solutionClasses collect: [ :c | c name ].
	solutionFileNames := packageFileMap keys select: [ :filename | 
		solutionClassNames includes: (filename findTokens: '.') first ]. 

	"Sort classes before extensions, then sort by class name"
	solutionFileNames sort: [ :filenameA :filenameB | |tokensA tokensB|
		tokensA := filenameA findTokens: '.'.
		tokensB := filenameB findTokens: '.'.
		(tokensA second, tokensA first) < (tokensB second, tokensB first) ].

	"Summarise test results to show with solution"
	testResult := [ self testCase suite run] on: Error do: [ TestResult new ].
	
	"Build result in the order we want files displayed by Exercism web interface"
	resultDictionary := OrderedDictionary new.
	solutionFileNames do: [ :filename | 
		resultDictionary at: filename put: ( packageFileMap at: filename) contents ].
	resultDictionary at: 'TestResults.txt' put: testResult exercismSummary.
	^ resultDictionary

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
ExercismExercise >> trackId [
	^ExercismManager trackId
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
