"
Top level package enu commands that should only be seen for developers
"
Class {
	#name : 'ClyExercismDevCommand',
	#superclass : 'ClyExercismCommand',
	#category : 'ExercismDev-Menus',
	#package : 'ExercismDev',
	#tag : 'Menus'
}

{ #category : 'testing' }
ClyExercismDevCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^100
]

{ #category : 'testing' }
ClyExercismDevCommand class >> isAbstract [
	
	^self == ClyExercismDevCommand
]

{ #category : 'testing' }
ClyExercismDevCommand class >> packageContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: RPackage asCalypsoItemContext
]
