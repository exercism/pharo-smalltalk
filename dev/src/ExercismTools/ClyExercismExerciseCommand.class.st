"
Exercism menu items that should only appear on a package tag 
"
Class {
	#name : #ClyExercismExerciseCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismExerciseCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^1
]

{ #category : #testing }
ClyExercismExerciseCommand class >> isAbstract [
	
	^self == ClyExercismExerciseCommand
]

{ #category : #activation }
ClyExercismExerciseCommand class >> tagContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: ClyTaggedClassGroup asCalypsoItemContext
]
