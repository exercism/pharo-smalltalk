Class {
	#name : #ExercismConfigGeneratorTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #'set up' }
ExercismConfigGeneratorTest >> modifyHelloWorldDataAtJsonNode: exercisesJsonNode [

	|helloWorldJson| 
	helloWorldJson := exercisesJsonNode detect: [:exDict | (exDict at: 'slug') = 'hello-world'] ifNone: [ self error: 'Hello world exercise not found in tested config.json' ].
	helloWorldJson at: 'difficulty' put: 10.
	helloWorldJson at: 'name' put: 'Hello World 2'.
]

{ #category : #'set up' }
ExercismConfigGeneratorTest >> rewriteAlteredConfigJson: jsonDict atFile: cfgFile [

	|outPutJsonString|
	"rewrite config.json file with updated exercise entry"
	outPutJsonString := STONJSONWriter streamContentsOf: jsonDict.
	
	cfgFile  
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: outPutJsonString ]
	
	
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testGenerateConfigFrom [
	
	|dirReference cfgFile jsonDict|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := (dirReference / 'config.json').
	"assert file exists and is not empty"
	self assert: cfgFile exists.
	self assert: cfgFile contents notEmpty.
	jsonDict := STON fromString: cfgFile contents.
	
	self assert: jsonDict isDictionary.
	
	
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testGenerateConfigHeader [
	
	|dirReference cfgFile jsonDict|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := dirReference / 'config.json'.
	jsonDict := STON fromString: cfgFile contents.
	
	self assert: (jsonDict at: 'track_id') equals: 'pharo-smalltalk'.
	self assert: (jsonDict at: 'language') equals: 'Pharo'.
	self assert: (jsonDict at: 'slug') equals: 'pharo-smalltalk'.
	self assert: (jsonDict at: 'active').
	self deny: ((jsonDict at: 'status') at: 'concept_exercises').
	self assert: ((jsonDict at: 'status') at: 'test_runner').	
	self deny: ((jsonDict at: 'status') at: 'representer').
	self deny: ((jsonDict at: 'status') at: 'analyzer').
	self deny: (jsonDict at: 'blurb') isEmpty.
	self assert: (jsonDict at: 'version') equals: 3.
	self assert: ((jsonDict at: 'online_editor') at: 'indent_style') equals: 'space'.
	self assert: ((jsonDict at: 'online_editor') at: 'indent_size') equals: 4.
	self assert: ((jsonDict at: 'online_editor') at: 'highlightjs_language') equals: 'smalltalk'.
	self assert: (((jsonDict at: 'files') at: 'solution') first includesSubstring: '.class.st').
	self assert: (((jsonDict at: 'files') at: 'test') first includesSubstring: 'Test.class.st').
	self assert: (((jsonDict at: 'files') at: 'example') first includesSubstring: '.class.st').
	self assert: (((jsonDict at: 'files') at: 'exemplar') first includesSubstring: '.class.st').
	self assert: ((jsonDict at: 'test_runner') at: 'average_run_time') equals: 1.
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testGenerateConfigKeyFeatures [
	
	|dirReference cfgFile jsonDict|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := dirReference / 'config.json'.
	jsonDict := STON fromString: cfgFile contents.
	

	self assert: ((jsonDict at: 'key_features') allSatisfy:  [:keyFeature | 
		(keyFeature keys includesAll: #('icon' 'title' 'content')) and: [ keyFeature values allSatisfy: #notEmpty]
	 ]
	)
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testGenerateConfigPractiseExercises [
	
	|dirReference jsonDict practiceExercises|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	jsonDict := STON fromString: (dirReference / 'config.json') contents.
	
	practiceExercises := ((jsonDict at: 'exercises') at: 'practice').
	
	"includes all practise exercises that are specified in Exercise packages"
	self assert: ((practiceExercises collect: [:each |each at: #slug]) includesAll: (ExercismExercise practiceExercises collect: #name)).

	"ordered by difficulty"
	self assert: ((practiceExercises first at: #difficulty) < (practiceExercises last at: #difficulty)).
	
	"then by name"
	self assert: ((practiceExercises first at: #slug) < (practiceExercises second at: #slug)).
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testGenerateConfigTags [
	
	|dirReference cfgFile jsonDict|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := dirReference / 'config.json'.
	jsonDict := STON fromString: cfgFile contents.
	

	self assert: ((jsonDict at: 'tags') includesAll: 
	{
    'paradigm/object_oriented'.
    'typing/dynamic'.
    'typing/strong'.
    'platform/windows'.
    'platform/mac'.
    'platform/linux'.
    'runtime/language_specific'.
    'used_for/artificial_intelligence'.
    'used_for/scientific_calculations'.
    'used_for/frontends'.
    'used_for/backends'.
    'used_for/cross_platform_development'.
    'used_for/web_development'
	}
	)
	
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testUpdateConfigFromFor [

	|dirReference cfgFile jsonDict hwExericeJson|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := (dirReference / 'config.json').
	
	jsonDict := STON fromString: cfgFile contents.
	
	"modify generated config.json (in memory filesystem) and put some altered exercise data for hello-world exercise"
	self modifyHelloWorldDataAtJsonNode: ((jsonDict at: 'exercises') at: 'practice').
	self rewriteAlteredConfigJson: jsonDict atFile: cfgFile.
	
	ExercismConfigGenerator new updateConfigFrom: dirReference for: 'hello-world'.
	cfgFile := (dirReference / 'config.json').
	jsonDict := STON fromString: cfgFile contents.
	
	"check if altered exercise data are updated"
	hwExericeJson := ((jsonDict at: 'exercises') at: 'practice') detect: [:e | (e at: 'slug') = 'hello-world'] ifNone: [ self error: 'Exercise json node with slug "hello-world" not found.' ]. 
	self assert: (hwExericeJson at: 'difficulty') equals: 1.
	self assert: (hwExericeJson at: 'name') equals: 'Hello World'.
	
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testUpdateConfigFromForExerciseDoNotExist [

	|dirReference cfgFile |
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := (dirReference / 'config.json').
	
	"non existent exercise should raise error"
	self
		should: [ ExercismConfigGenerator new updateConfigFrom: dirReference for: 'random-slug343' ] 
		raise: NotFound
		withExceptionDo: [ :ex |
			self assert: ex messageText equals: 'Could not find exercise: random-slug343' ].
]

{ #category : #tests }
ExercismConfigGeneratorTest >> testUpdateConfigFromForNewExercise [

	|dirReference cfgFile jsonDict alteredCollection|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := (dirReference / 'config.json').
	
	jsonDict := STON fromString: cfgFile contents.
	
	"remove hello-world exercice from generated config.json (in memory filesystem)"
 	alteredCollection := ((jsonDict at: 'exercises') at: 'practice') asOrderedCollection removeAllSuchThat: [:exDict | (exDict at: 'slug') = 'hello-world'].
	(jsonDict at: 'exercises') at: 'practice' put: alteredCollection asArray.
	self rewriteAlteredConfigJson: jsonDict atFile: cfgFile.
	jsonDict := STON fromString: cfgFile contents.
	
	"hello-world should not be there - previously removed"
	self deny: (((jsonDict at: 'exercises') at: 'practice') anySatisfy:  [:exEntry | (exEntry at: 'slug') = 'hello-world' ]).
	
	ExercismConfigGenerator new updateConfigFrom: dirReference for: 'hello-world'.
	cfgFile := (dirReference / 'config.json').
	jsonDict := STON fromString: cfgFile contents.
	
	"hello-world should be there after update"
	self assert: (((jsonDict at: 'exercises') at: 'practice') anySatisfy:  [:exEntry | (exEntry at: 'slug') = 'hello-world' ]).
]
