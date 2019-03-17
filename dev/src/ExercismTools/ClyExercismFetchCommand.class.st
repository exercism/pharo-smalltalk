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
		^10
]

{ #category : #activation }
ClyExercismFetchCommand class >> packageContextMenuActivation [
	"We can use a second annotation to give a similar menu to the Package item"
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		for: RPackage asCalypsoItemContext
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

	submission := ExercismManager default
		fetchFromExercismTo: self packages first.
		
	submission isValid
		ifTrue: [ UIManager default inform: 'Success, Happy Coding'.
			self browser selectClass: submission exercise exerciseClass ]
		ifFalse: [ self reportErrorFor: submission exerciseClassName ]
]
