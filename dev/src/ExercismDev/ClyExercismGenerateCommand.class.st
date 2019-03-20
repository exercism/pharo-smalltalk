"
Menu command for generating exercism artefacts
"
Class {
	#name : #ClyExercismGenerateCommand,
	#superclass : #ClyExercismDevCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #testing }
ClyExercismGenerateCommand >> defaultMenuItemName [
	^'Generate exercise meta data'
]

{ #category : #testing }
ClyExercismGenerateCommand >> description [
	^'Walk the exercises and generate the Exercism templates into an existing git repository'
]

{ #category : #execution }
ClyExercismGenerateCommand >> execute [
	ExercismGenerator generate
]
