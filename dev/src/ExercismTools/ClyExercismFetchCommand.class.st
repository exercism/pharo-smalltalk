"
Menu command to fetch a new exercise
"
Class {
	#name : #ClyExercismFetchCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismFetchCommand class >> classListMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byRootGroupItemOrder: 3 for: ClyClassContextOfFullBrowser 
]

{ #category : #activation }
ClyExercismFetchCommand class >> contextMenuOrder [
		^10
]

{ #category : #activation }
ClyExercismFetchCommand class >> isExercismTagIn: aToolContext [

	(aToolContext isKindOf: ClyClassContextOfFullBrowser) ifFalse: [ ^super isExercismTagIn: aToolContext ].
	
	aToolContext selectedItems isEmpty and: [ aToolContext selectedPackageItems do: [:any |
		^ any browserItem name = ExercismManager exercismPackageName ]].
	
	^false
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
