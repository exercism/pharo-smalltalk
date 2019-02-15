"
Exercism menu items that should only appear on a package tag 
"
Class {
	#name : #ClyExercismExerciseCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismExerciseCommand class >> canBeExecutedInContext: aToolContext [
	^ (super canBeExecutedInContext: aToolContext)
		and: [ self isExercismTagIn: aToolContext ]
]

{ #category : #activation }
ClyExercismExerciseCommand class >> packageContextMenuActivation [
	<classAnnotation>
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		for: ClyTaggedClassGroup asCalypsoItemContext
]
