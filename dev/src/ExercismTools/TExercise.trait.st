"
# TExercise

I am a trait containing methods for getting exercise meta data from
objects that play the role of a Exercism version 3 exercise.

## Usage

My methods reference instance variables and methods that must be 
implemented by objects that use me. 

## Instance Variables 

These will need to be initialized in the using classes `#initialize` 
method.

- solutionId 
- customData: An `Array`. This can be safely initialized empty.
- isActive: A `Boolean`. Is the exercise active (not depricated or for testing).
- isCustom: A `Boolean`. `true` if `customData` is not empty.
- uuid: A `String`. The exercises unique ID in the Execism project.
- version
- aliasesAndHints: An `Array`. This can be safely initialized empty.

## Methods

### `#configuredExerciseMetadata`

Must answer the configured exercise meta data for this exercise, an `ExercismExercise`.
"
Trait {
	#name : #TExercise,
	#classInstVars : [
		'solutionId',
		'customData',
		'isActive',
		'uuid',
		'version',
		'aliasesAndHints'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #helper }
TExercise classSide >> createExerciseAfter: anotherTestCase [
	"Helper method to create an exercise meta data object"
	
	^ (ExercismExercise for: self)
		unlockedBy: 
			((anotherTestCase notNil and: [ anotherTestCase isObsolete not ])
				ifTrue: [ [ anotherTestCase exercise ] on: SubclassResponsibility do: [ nil ] ]
				ifFalse: [ nil ]);
		yourself 
]

{ #category : #config }
TExercise classSide >> customData [

	^ customData
]

{ #category : #config }
TExercise classSide >> exercise [

	^ self configuredExerciseMetadata
]

{ #category : #generator }
TExercise classSide >> generator [

	^ aliasesAndHints
]

{ #category : #config }
TExercise classSide >> isActive [

	^ isActive
]

{ #category : #config }
TExercise classSide >> isCustom [

	^ customData notEmpty 
]

{ #category : #accessing }
TExercise classSide >> solutionId [ 

	^ solutionId ifNil: [ ExSolutionIdError signal: 'Missing exercise solutionId' ]
]

{ #category : #accessing }
TExercise classSide >> solutionId: anObject [

	solutionId := anObject 
]

{ #category : #config }
TExercise classSide >> uuid [

	^ uuid
]

{ #category : #config }
TExercise classSide >> version [

	^ version
]
