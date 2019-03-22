"
Menu command for generating exercism artefacts
"
Class {
	#name : #ClyExercismGenerateCommand,
	#superclass : #ClyExercismDevCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #'world menu' }
ClyExercismGenerateCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^20
]

{ #category : #'world menu' }
ClyExercismGenerateCommand class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	
	| templateCommand |
	
	templateCommand := self new.
	(aBuilder item: templateCommand defaultMenuItemName)
		parent: #Exercism;
		order: self contextMenuOrder;
		action: [ templateCommand execute ];
		"iconName: templateCommand defaultMenuIconName;"
		help: templateCommand description;
		withSeparatorAfter
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
