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

{ #category : #'world menu' }
ClyExercismFetchCommand class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	
	| templateCommand browser |
	
	templateCommand := self new 
		packages: { self package }; 
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
	^'Fetch a named Exercism exercise to begin solving it'
]

{ #category : #execution }
ClyExercismFetchCommand >> execute [
	| submission |

	[
		submission := ExercismManager default
			fetchFromExercismTo: self packages first.
			
		submission ifNotNil: [
			UIManager default inform: 'Success, Happy Coding'.
			submission exercise 
				ifNil: [ 
					ExDomainError signal: 'Missing exercise meta-data' ]
				ifNotNil: [ :exercise |
					self browser selectClass: exercise testCase ]]
	 ] 
		on: ExDomainError do: [ :ex | 
			self reportError: ex for: (submission ifNotNil: [ :s | s exerciseId ]) ]
]
