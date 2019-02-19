Class {
	#name : #ClyExercismMetaDataCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismMetaDataCommand class >> contextMenuOrder [
		^100
]

{ #category : #accessing }
ClyExercismMetaDataCommand >> defaultMenuItemName [
	^'View MetaData (debug)'
]

{ #category : #execution }
ClyExercismMetaDataCommand >> execute [
	((RPackageOrganizer default packageNamed: ExercismManager exercismPackageName)
		ensureProperties at: self tagGroup) inspect
]
