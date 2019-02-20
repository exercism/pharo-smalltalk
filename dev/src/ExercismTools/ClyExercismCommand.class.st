"
Abstract class to provide menu facilties for Exercism that should only appear in the context of the Exercism package (and not other browser packages)
"
Class {
	#name : #ClyExercismCommand,
	#superclass : #SycPackageCommand,
	#instVars : [
		'tagGroup'
	],
	#category : #'ExercismTools-Menus'
}

{ #category : #testing }
ClyExercismCommand class >> isExercismTagIn: aToolContext [

	aToolContext lastSelectedClassGroup classes do: [:any |
		^any package name = ExercismManager exercismPackageName]. 
	
	^false
]

{ #category : #accessing }
ClyExercismCommand >> prepareFullExecutionInContext: aToolContext [
	
	super prepareFullExecutionInContext: aToolContext.
	
	self tagGroup: aToolContext lastSelectedClassGroup
]

{ #category : #accessing }
ClyExercismCommand >> tagGroup [
	^ tagGroup
]

{ #category : #accessing }
ClyExercismCommand >> tagGroup: anObject [
	tagGroup := anObject
]
