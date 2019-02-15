Class {
	#name : #ClyExercismSubmitCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismSubmitCommand class >> defaultMenuItemName [
	^'Submit exercise...'
]

{ #category : #execution }
ClyExercismSubmitCommand >> execute [
	ExercismManager default submitToExercism: self tagGroup
]
