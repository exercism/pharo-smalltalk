Class {
	#name : #ClyExercismGenerateCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #testing }
ClyExercismGenerateCommand class >> canBeExecutedInContext: aToolContext [
	^ (super canBeExecutedInContext: aToolContext)
		and: [ self isExercismTagIn: aToolContext ]
]

{ #category : #testing }
ClyExercismGenerateCommand class >> packageContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		for: RPackage asCalypsoItemContext
]

{ #category : #testing }
ClyExercismGenerateCommand >> defaultMenuItemName [
	^'Generate exercise meta data'
]

{ #category : #testing }
ClyExercismGenerateCommand >> description [
	^'Walk the exercises and generate the Exercism templates into an existing git repository'
]

{ #category : #execution }
ClyExercismGenerateCommand >> execute [
	ExercismGenerator generate
]
