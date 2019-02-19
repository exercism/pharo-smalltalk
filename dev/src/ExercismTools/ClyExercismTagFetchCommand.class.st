Class {
	#name : #ClyExercismTagFetchCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismTagFetchCommand class >> contextMenuOrder [
		^10
]

{ #category : #accessing }
ClyExercismTagFetchCommand >> defaultMenuIconName [
	^#book
]

{ #category : #accessing }
ClyExercismTagFetchCommand >> defaultMenuItemName [
	^'Fetch new exercise...'
]

{ #category : #accessing }
ClyExercismTagFetchCommand >> description [ 
	^'Fetch a named exercise to begin solving it'
]

{ #category : #execution }
ClyExercismTagFetchCommand >> execute [
	ExercismManager default fetchFromExercismTo: self packages first
]
