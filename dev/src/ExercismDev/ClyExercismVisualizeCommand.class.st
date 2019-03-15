"
Menu command for (currently) crudely visualizing exercises
"
Class {
	#name : #ClyExercismVisualizeCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #testing }
ClyExercismVisualizeCommand class >> packageContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		for: RPackage asCalypsoItemContext
]

{ #category : #testing }
ClyExercismVisualizeCommand >> defaultMenuItemName [
	^'Visualize exercise meta data'
]

{ #category : #testing }
ClyExercismVisualizeCommand >> description [
	^'Walk the exercises and visualize their dependencies'
]

{ #category : #execution }
ClyExercismVisualizeCommand >> execute [
	ExercismManager default dependencyGraph inspect
]
