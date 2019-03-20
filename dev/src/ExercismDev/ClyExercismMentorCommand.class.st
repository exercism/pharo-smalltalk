Class {
	#name : #ClyExercismMentorCommand,
	#superclass : #ClyExercismDevCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #testing }
ClyExercismMentorCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^10
]

{ #category : #testing }
ClyExercismMentorCommand >> defaultMenuIconName [
	^#recentMessages
]

{ #category : #testing }
ClyExercismMentorCommand >> defaultMenuItemName [
	^'View Mentee Solution...'
]

{ #category : #testing }
ClyExercismMentorCommand >> description [
	^'View a mentee solution in a shadow browser'
]

{ #category : #execution }
ClyExercismMentorCommand >> execute [
	ExercismManager default viewMenteeSolution
]
