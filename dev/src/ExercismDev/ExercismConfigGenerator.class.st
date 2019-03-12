"
I generate a valid exercism config.json file based on exercise metadata
"
Class {
	#name : #ExercismConfigGenerator,
	#superclass : #Object,
	#classVars : [
		'DefaultPath'
	],
	#category : #'ExercismDev-Generator'
}

{ #category : #accessing }
ExercismConfigGenerator class >> defaultPath [
	^ DefaultPath ifNil: [ self defaultPath: FileLocator home pathString]
]

{ #category : #accessing }
ExercismConfigGenerator class >> defaultPath: anObject [
	"self defaultPath: nil"

	^DefaultPath := anObject
]

{ #category : #examples }
ExercismConfigGenerator class >> generate [
	"This is the entry point for generating exercism compatible source files that can be checked into
	the exercism/pharo project. e.g. self generate"

	<example>
	| path |
	path := UIManager default
		chooseDirectory: 'Select the config.json file location where exercises have been generated'
		path: self defaultPath.
		
	path ifNotNil: [ self generateTo: (self defaultPath: path) ]
]

{ #category : #examples }
ExercismConfigGenerator class >> generateTo: aFilePathReference [

	self new generateConfigFrom: aFilePathReference 
]

{ #category : #generation }
ExercismConfigGenerator >> generateConfigFrom: aFileSystemReference [
	"self generate"
	
	| configFile config coreExercises contents bonusExercises |
	
	configFile := aFileSystemReference / 'config.json'.
	config := OrderedCollection withAll: ExercismManager trackConfigHeader.
	
	coreExercises := ExercismExercise coreExercises collect: [:e | e asJsonData ].
	bonusExercises := ExercismExercise bonusExercises collect: [:e | e asJsonData ].
	
	config add: 'exercises' -> (coreExercises, bonusExercises).
	
	contents := STONJSONWriter streamContentsOf: config asOrderedDictionary.
	
	configFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: contents ]
	
]
