"
# ClyExercisProgressCommand

I am a browser menu item command that initiates an operation to view
the users progress of an exercise on the Exercism website.

## Command Execution

In my `#execute` method I send a message to `ExercismManager default`
to view the selected exercise in the browser on the Exercism website.

## World Menu

On my class side `#worldMenuCommandOn:` creates an entry labeled ""View
Track Progress"" for me in the World menu under the ""Exercism"" section.
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
ClyExercismProgressCommand class >> worldMenuCommandOn: aBuilder [
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
	^'Open your Exercism track progress in a web browser'
]

{ #category : #execution }
ClyExercismProgressCommand >> execute [
	ExercismManager default viewOnExercism: self selectedItem
]
