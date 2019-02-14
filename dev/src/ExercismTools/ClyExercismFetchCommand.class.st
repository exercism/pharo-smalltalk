Class {
	#name : #ClyExercismFetchCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Core'
}

{ #category : #testing }
ClyExercismFetchCommand class >> canBeExecutedInContext: aToolContext [
	^ (super canBeExecutedInContext: aToolContext)
		and: [ self isExercismTagIn: aToolContext ]
]

{ #category : #testing }
ClyExercismFetchCommand class >> defaultMenuItemName [
	^'Fetch new exercise...'
]

{ #category : #testing }
ClyExercismFetchCommand class >> packageContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		for: RPackage asCalypsoItemContext
]

{ #category : #execution }
ClyExercismFetchCommand >> execute [
	ExercismManager default fetchFromExercismTo: self packages first
]
