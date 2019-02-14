Class {
	#name : #ClyExercismMetaDataCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Core'
}

{ #category : #accessing }
ClyExercismMetaDataCommand class >> defaultMenuItemName [
	^'View MetaData (debug)'
]

{ #category : #execution }
ClyExercismMetaDataCommand >> execute [
	((RPackageOrganizer default packageNamed: ExercismManager exercismPackageName)
		ensureProperties at: self tagGroup) inspect
]
