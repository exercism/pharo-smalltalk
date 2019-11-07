"
# ClyExercismFetchCommand

I am a browser menu item command that initiates a fetch operation to 
get a specific exercise from Exercism.io.

## Command Execution

I implement the `#execute` method. On receiving this message I start 
the fetch operation to get an exercise, and report the success or error
of the operation via the UI.

I send a message to `ExercismManager default` to fetch the exercise.
On successful retrieval of an exercise I will open a browser window on
that exercises test case.

I may signal an `ExDomainError` if I could not retrieve an exercise from
the `ExercismManager` submission.

If the `ExercismManager` signals an `ExDomainError` I will report the
error with `ClyExercismExerciseCommand>>#reportError:for:`.

## World Menu

On my class side is `#worldMenuCommandOn:`. This method adds a ""Fetch
new exercise..."" command to the World menu under the ""Exercism"" section.
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
