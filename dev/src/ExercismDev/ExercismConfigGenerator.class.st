"
I generate or update a valid Exercism config.json file based on exercise metadata for Pharo-smalltalk track.

## Generate new config.json
To generate new config.json file for track, use: 
`ExercismConfigGenerator new generateConfigFrom: 'path-to-pharo-track' asFileReference`

Or using UI dialog prompt (to choose desired directory with file dialog):
`ExercismConfigGenerator generate`

## Update config.json for existing exercise:
This is needed when working on specific exercise, for which not entire content needs to be genererated. If exercise is missing in one exercise.practice json entry, entire file is regenerated.
`ExercismConfigGenerator new updateConfigFrom: 'path-to-pharo-track' asFileReference for: 'slug-name'`
"
Class {
	#name : 'ExercismConfigGenerator',
	#superclass : 'Object',
	#classVars : [
		'DefaultPath'
	],
	#category : 'ExercismDev-Generator',
	#package : 'ExercismDev',
	#tag : 'Generator'
}

{ #category : 'accessing' }
ExercismConfigGenerator class >> defaultPath [

	^ DefaultPath ifNil: [ self defaultPath: ExercismGenerator defaultPath]
]

{ #category : 'accessing' }
ExercismConfigGenerator class >> defaultPath: anObject [
	"self defaultPath: nil"

	^DefaultPath := anObject
]

{ #category : 'examples' }
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

{ #category : 'examples' }
ExercismConfigGenerator class >> generateTo: aFilePathReference [

	self new generateConfigFrom: aFilePathReference 
]

{ #category : 'private' }
ExercismConfigGenerator >> addExerciseEntryToConfig: configAttributes [	
	
	|practiseExercises conceptExercises|
	practiseExercises := ExercismExercise practiceExercises  collect: #asJsonData.
	conceptExercises := ExercismExercise conceptExercises collect: #asJsonData.
	
	configAttributes add: 'exercises' -> (
		OrderedDictionary  
			with: 'concept' -> conceptExercises
			with: 'practice' -> practiseExercises
	).
]

{ #category : 'generation' }
ExercismConfigGenerator >> findIndexOfExercise: slugName inExerciseJsonNode: exerciseCollectionJsonNode [

	^ exerciseCollectionJsonNode 
		detectIndex: [:exerciseDict | exerciseDict at: 'slug' = slugName ] 
		ifNone: [ NotFound signal: ('Could not find exercise in config.json at exercises -> practice: {1}' format: {slugName})]
]

{ #category : 'generation' }
ExercismConfigGenerator >> generateConfigFrom: aFileSystemReference [
	"self generate"
	
	| configFile config contents |
	
	configFile := aFileSystemReference / 'config.json'.
	
	"header configuration attributes"
	config := OrderedCollection withAll: ExercismManager trackConfigHeader.
	
	"exercices"
	self addExerciseEntryToConfig: config.
	
	"concepts  - empty for now"
	config add: 'concepts' -> ExercismManager concepts.
	
	"key features"
	config add: 'key_features' -> ExercismManager trackConfigKeyFeatures.
	"tags"
	config add: 'tags' -> ExercismManager trackConfigTags.
	
	contents := STONJSONWriter streamContentsOf: config asOrderedDictionary.
	
	configFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: contents ]
	
]

{ #category : 'generation' }
ExercismConfigGenerator >> updateConfigFrom: aFileSystemReference for: slugName [
	
	"updates config.json for given exercise, if not present in config.json then regenerate entire config.json file"
	| configFile jsonDict exerciseOutJson exercisesJsonNode outPutJsonString idxOfExercise |
	
	configFile := aFileSystemReference / 'config.json'.
	configFile isFile ifFalse: [ ^ self error: ('Could not determine config file for Pharo track (file is missing): {1}.' format: { configFile fullName }) ].
	
	jsonDict := STON fromString: configFile contents.
	exercisesJsonNode := (jsonDict  at: 'exercises') at: 'practice'.
	exerciseOutJson := (ExercismExercise find: slugName ifAbsent: [ NotFound signal: ('Could not find exercise: {1}' format: {slugName})]) asJsonData.
	
	[ idxOfExercise := self findIndexOfExercise: slugName inExerciseJsonNode: exercisesJsonNode ] 
	on: NotFound 
	"if exercise in not present in config.json - regenerate entire file"
	do: [ ^ self generateConfigFrom: aFileSystemReference  ].
	
	"update entry with desired slug in collection of of exercises -> practise"
	exercisesJsonNode at: idxOfExercise put: exerciseOutJson.
	
	"rewrite config.json file with updated exercise entry"
	outPutJsonString := STONJSONWriter streamContentsOf: jsonDict.
	
	configFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: outPutJsonString ]
]
