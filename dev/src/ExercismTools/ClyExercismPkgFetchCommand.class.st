Class {
	#name : #ClyExercismPkgFetchCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #testing }
ClyExercismPkgFetchCommand class >> canBeExecutedInContext: aToolContext [
	^ (super canBeExecutedInContext: aToolContext)
		and: [ self isExercismTagIn: aToolContext ]
]

{ #category : #testing }
ClyExercismPkgFetchCommand class >> packageContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		for: RPackage asCalypsoItemContext
]

{ #category : #testing }
ClyExercismPkgFetchCommand >> defaultMenuIconName [
	^#book
]

{ #category : #testing }
ClyExercismPkgFetchCommand >> defaultMenuItemName [
	^'Fetch new exercise...'
]

{ #category : #execution }
ClyExercismPkgFetchCommand >> execute [
	ExercismManager default fetchFromExercismTo: self packages first
]
