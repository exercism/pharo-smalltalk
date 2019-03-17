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
	ExercismManager default
		submitToExercism:
			(ExercismExercise
				find: self tagGroup name
				ifAbsent:	[ :name | self reportErrorFor: name ])
]

{ #category : #execution }
ClyExercismSubmitCommand >> reportErrorFor: name [
	^ self
		error:
			(((Smalltalk hasClassNamed: name)
				ifTrue:
					[ 'Exercise "{1}" is missing metadata! You need to upgrade it in Exercism and re-fetch!' ]
				ifFalse:
					[ 'Exercise "{1}" Not Found! Please check the Exercism website for a valid exercise name!' ])
				format: {name})
]
