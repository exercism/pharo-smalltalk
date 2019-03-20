"
Menu command to fetch a new exercise
"
Class {
	#name : #ClyExercismFetchCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismFetchCommand class >> contextMenuOrder [
		^5
]

{ #category : #activation }
ClyExercismFetchCommand class >> packageContextMenuActivation [
	"We can use a second annotation to give a similar menu to the Package item"
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: RPackage asCalypsoItemContext
]

{ #category : #'world menu' }
ClyExercismFetchCommand class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	
	| templateCommand browser |
	
	templateCommand := self new 
		packages: { ExercismManager exercismPackage }; 
		yourself.
	
	(aBuilder item: templateCommand defaultMenuItemName)
		parent: #Exercism;
		order: 1;
		action: [ 
			browser := Smalltalk tools browser openOnPackage: ExercismManager.
			templateCommand browser: browser.
			templateCommand execute ];
		iconName: templateCommand defaultMenuIconName;
		help: templateCommand description
		"withSeparatorAfter"
]

{ #category : #accessing }
ClyExercismFetchCommand >> defaultMenuIconName [
	^#book
]

{ #category : #accessing }
ClyExercismFetchCommand >> defaultMenuItemName [
	^'Fetch new exercise...'
]

{ #category : #accessing }
ClyExercismFetchCommand >> description [ 
	^'Fetch a named exercise to begin solving it'
]

{ #category : #execution }
ClyExercismFetchCommand >> execute [
	| submission |

	[
		submission := ExercismManager default
			fetchFromExercismTo: self packages first.
			
		submission ifNotNil: [
			UIManager default inform: 'Success, Happy Coding'.
			self browser selectClass: submission exercise testCase ]
	 ] 
		on: Error do: [ :ex | 
			self reportError: ex for: (submission ifNotNil: [ :s | s exerciseId ]) ]
]
