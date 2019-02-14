Class {
	#name : #ClyExercismCommand,
	#superclass : #SycPackageCommand,
	#instVars : [
		'tagGroup'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #testing }
ClyExercismCommand class >> isExercismTagIn: aToolContext [
	^ aToolContext lastSelectedClassGroup classes anyOne 
		package name = ExercismManager exercismPackageName 
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
