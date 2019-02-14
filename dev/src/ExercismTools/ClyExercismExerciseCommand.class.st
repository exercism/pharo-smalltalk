Class {
	#name : #ClyExercismExerciseCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Core'
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
