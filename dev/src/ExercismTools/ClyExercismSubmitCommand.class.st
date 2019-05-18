"
Menu command to submit a new exercise
"
Class {
	#name : #ClyExercismSubmitCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismSubmitCommand class >> contextMenuOrder [
		^10
]

{ #category : #accessing }
ClyExercismSubmitCommand >> defaultMenuIconName [
	^#smallExport
]

{ #category : #accessing }
ClyExercismSubmitCommand >> defaultMenuItemName [
	^'Submit exercise...'
]

{ #category : #accessing }
ClyExercismSubmitCommand >> description [ 
	^'Sumbit your proposed solution to Exercism for mentor review'
]

{ #category : #execution }
ClyExercismSubmitCommand >> execute [
	| exerciseName result |

	exerciseName := self selectedItem exerciseName.

	[ result := ExercismManager default
		submitToExercism:
			(ExercismExercise
				find: exerciseName
				ifAbsent: [ :name | ^ self reportError: nil for: name asKebabCase ]).

	result
		ifNotNil: [ UIManager default
				inform: ('Successfully submitted "{1}"!' format: {exerciseName}) ] 
	]
		on: ExercismError 
		do: [ :ex | self reportError: ex for: nil ]
]
