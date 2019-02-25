Class {
	#name : #ClyExercismProgressCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismProgressCommand class >> contextMenuOrder [
		^5
]

{ #category : #accessing }
ClyExercismProgressCommand >> defaultMenuIconName [
	^#home
]

{ #category : #accessing }
ClyExercismProgressCommand >> defaultMenuItemName [
	^'View Track Progress'
]

{ #category : #accessing }
ClyExercismProgressCommand >> description [ 
	^'Open track progress in a web browser'
]

{ #category : #execution }
ClyExercismProgressCommand >> execute [
	ExercismManager default viewOnExercism: self tagGroup
]
