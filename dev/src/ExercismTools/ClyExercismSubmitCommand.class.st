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
		^1
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
	ExercismManager default submitToExercism: (self packages first classTagNamed: self tagGroup name) 
]
