"
Menu command for (currently) crudely visualizing exercises
"
Class {
	#name : #ClyExercismVisualizeCommand,
	#superclass : #ClyExercismDevCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #'world menu' }
ClyExercismVisualizeCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^15
]

{ #category : #'world menu' }
ClyExercismVisualizeCommand class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	
	| templateCommand |
	
	templateCommand := self new.
	(aBuilder item: templateCommand defaultMenuItemName)
		parent: #Exercism;
		order: self contextMenuOrder;
		action: [ templateCommand execute ];
		"iconName: templateCommand defaultMenuIconName;"
		help: templateCommand description.
		"withSeparatorAfter "
]

{ #category : #testing }
ClyExercismVisualizeCommand >> defaultMenuItemName [
	^'Visualize exercises...'
]

{ #category : #testing }
ClyExercismVisualizeCommand >> description [
	^'Walk the exercises and visualize their dependencies'
]

{ #category : #execution }
ClyExercismVisualizeCommand >> execute [
	ExercismManager default dependencyGraph inspect
]
