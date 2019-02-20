Class {
	#name : #ClyExercismProgressCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismProgressCommand class >> contextMenuOrder [
		^5
]

{ #category : #execution }
ClyExercismProgressCommand >> defaultMenuIconName [
	^#home
]

{ #category : #accessing }
ClyExercismProgressCommand >> defaultMenuItemName [
	^'View Track Progress'
]

{ #category : #execution }
ClyExercismProgressCommand >> execute [
	ExercismManager default viewOnExercism: self tagGroup
]
