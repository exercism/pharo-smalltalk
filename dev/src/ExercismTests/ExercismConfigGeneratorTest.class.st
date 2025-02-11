Class {
	#name : #ExercismConfigGeneratorTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

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
