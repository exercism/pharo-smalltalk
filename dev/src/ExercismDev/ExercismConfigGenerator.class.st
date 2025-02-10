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

	^ DefaultPath ifNil: [ self defaultPath: ExercismGenerator defaultPath]
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
	
	| configFile config contents conceptExercises practiseExercises |
	
	configFile := aFileSystemReference / 'config.json'.
	config := OrderedCollection withAll: ExercismManager trackConfigHeader.
	
	practiseExercises := ExercismExercise practiceExercises  collect: #asJsonData.
	conceptExercises := ExercismExercise conceptExercises collect: #asJsonData.
	
	config add: 'exercises' -> (
		OrderedDictionary  
			with: 'concept' -> conceptExercises
			with: 'practice' -> practiseExercises
	).
	config add: 'tags' -> ExercismManager trackConfigTags.
	
	contents := STONJSONWriter streamContentsOf: config asOrderedDictionary.
	
	configFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: contents ]
	
]

{ #category : #generation }
ExercismConfigGenerator >> updateConfigFrom: aFileSystemReference for: slugName [
	"self generate"
	
	| configFile jsonDict exerciseOutJson |
	
	configFile := aFileSystemReference / 'config.json'.
	configFile isFile ifFalse: [ ^ self error: ('Could not determine config file for Pharo track (file is missing): {1}.' format: { configFile fullName }) ].
	
	jsonDict := STON fromString: configFile contents.
	exerciseOutJson := (ExercismExercise find: slugName ifAbsent: [ self error: ('Could not find exercise: {1}' format: {slugName})]) asJsonData.
	self updateConfigExercise: slugName inNode: ((jsonDict  at: 'exercises') at: 'practice').
	
	"config := OrderedCollection withAll: ExercismManager trackConfigHeader.
	
	coreExercises := ExercismExercise coreExercises collect: [:e | e asJsonData ].
	bonusExercises := ExercismExercise bonusExercises collect: [:e | e asJsonData ].
	
	config add: 'exercises' -> (coreExercises, bonusExercises).
	
	contents := STONJSONWriter streamContentsOf: config asOrderedDictionary.
	
	configFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: contents ]
	"
]
