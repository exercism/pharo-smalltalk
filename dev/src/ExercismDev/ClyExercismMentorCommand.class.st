"
Menu command for launching a mentor review browser
"
Class {
	#name : #ClyExercismMentorCommand,
	#superclass : #ClyExercismDevCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #testing }
ClyExercismMentorCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^10
]

{ #category : #'world menu' }
ClyExercismMentorCommand class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	
	| templateCommand |
	
	templateCommand := self new.
	(aBuilder item: templateCommand defaultMenuItemName)
		parent: #Exercism;
		order: self contextMenuOrder;
		action: [ templateCommand execute ];
		iconName: templateCommand defaultMenuIconName;
		help: templateCommand description.
		"withSeparatorAfter "
]

{ #category : #menus }
ClyExercismMentorCommand >> defaultMenuIconName [
	^#recentMessages
]

{ #category : #menus }
ClyExercismMentorCommand >> defaultMenuItemName [
	^'View Mentee Solution...'
]

{ #category : #menus }
ClyExercismMentorCommand >> description [
	^'View a mentee solution in a shadow browser'
]

{ #category : #execution }
ClyExercismMentorCommand >> execute [
	ExercismManager default viewMenteeSolution
]
