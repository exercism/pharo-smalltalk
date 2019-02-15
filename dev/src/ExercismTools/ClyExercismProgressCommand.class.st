Class {
	#name : #ClyExercismProgressCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #accessing }
ClyExercismProgressCommand class >> defaultMenuItemName [
	^'View Track Progress'
]

{ #category : #execution }
ClyExercismProgressCommand >> execute [
	ExercismManager default viewOnExercism: self tagGroup
]
