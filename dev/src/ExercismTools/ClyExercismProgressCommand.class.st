"
Menu command to view progress on the exercism website
"
Class {
	#name : #ClyExercismProgressCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismProgressCommand class >> contextMenuOrder [
		^15
]

{ #category : #'world menu' }
ClyExercismProgressCommand class >> menuCommandOn: aBuilder [
	<worldMenu>
	
	| templateCommand |
	
	templateCommand := self new.
	(aBuilder item: templateCommand defaultMenuItemName)
		parent: #Exercism;
		order: 1;
		action: [ templateCommand execute ];
		iconName: templateCommand defaultMenuIconName;
		help: templateCommand description;
		withSeparatorAfter
]

{ #category : #accessing }
ClyExercismProgressCommand >> defaultMenuIconName [
	^#home
]

{ #category : #accessing }
ClyExercismProgressCommand >> defaultMenuItemName [
	^'View Track Progress'
]

{ #category : #accessing }
ClyExercismProgressCommand >> description [ 
	^'Open track progress in a web browser'
]

{ #category : #execution }
ClyExercismProgressCommand >> execute [
	ExercismManager default viewOnExercism: self tagGroup
]
