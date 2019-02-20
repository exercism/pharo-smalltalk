Class {
	#name : #ClyExercismSubmitCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismSubmitCommand class >> contextMenuOrder [
		^1
]

{ #category : #activation }
ClyExercismSubmitCommand >> defaultMenuIconName [
	^#smallExport
]

{ #category : #activation }
ClyExercismSubmitCommand >> defaultMenuItemName [
	^'Submit exercise...'
]

{ #category : #execution }
ClyExercismSubmitCommand >> description [ 
	^'Sumbit your proposed solution to Exercism for mentor review'
]

{ #category : #execution }
ClyExercismSubmitCommand >> execute [
	ExercismManager default submitToExercism: self tagGroup
]
