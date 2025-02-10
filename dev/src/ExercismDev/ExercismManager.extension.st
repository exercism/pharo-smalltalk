Extension { #name : #ExercismManager }

{ #category : #'*ExercismDev' }
ExercismManager >> browseAsDifference: result [
	| referenceSnapshot |
	referenceSnapshot := result referenceSnapshot.
	(MCPatch fromBase: referenceSnapshot target: result codeSnapshot)
		browse
]

{ #category : #'*ExercismDev' }
ExercismManager >> browseAsMCSnaphot: result [
	(MCSnapshotBrowser forSnapshot: result codeSnapshot)
		showLabelled: ('Exercism Solution ({1})' format: {result reviewName})
]

{ #category : #'*ExercismDev' }
ExercismManager >> browseAsRingModel: result [
	| browser pkgs rgEnv |
	rgEnv := result codeSnapshot asExRingEnvironment.
	pkgs := OrderedCollection new.
	rgEnv
		packagesDo: [ :p | 
			(p name includesSubstring: result submission exerciseClassName)
				ifTrue: [ pkgs add: p ] ].
	browser := rgEnv
		createBrowserWithTitle: ('Exercism Solution ({1})' format: {result reviewName}).
	browser
		prepareInitialStateBy: [ :b | 
			b
				switchToPackageScopeOf: {pkgs first};
				selectPackage: pkgs first ];
		open
]

{ #category : #'*ExercismDev' }
ExercismManager >> dependencyGraph [
	
	^ ExercismExercise practiseExercises
	
	
]

{ #category : #'*ExercismDev' }
ExercismManager >> shareExercisePasteEE: package [
	| source i result |
	package = self class legacyExercismPackage
		ifTrue: [ self error: 'Select the sub-package with your solution!' ].
	source := String
		streamContents: [ :s | 
			s << '{"description":"test","sections":['.
			i := 0.
			package solutionSources
				keysAndValuesDo: [ :filename :code | 
					i > 0
						ifTrue: [ s << ', ' ].
					s
						<<
							('\{"name":"{1}","syntax":"{3}","contents":{2}\}'
								format:
									{filename.
									code asJSON.
									((filename endsWith: '.st')
										ifTrue: [ 'smalltalk' ]
										ifFalse: [ 'autodetect' ])}).
					i := i + 1 ].
			s << ']}' ].
	result := ZnClient new
		systemPolicy;
		beOneShot;
		https;
		host: 'api.paste.ee';
		path: '/v1/pastes';
		setBasicAuthenticationUsername: 'ub4sqYh4qD5I1eLrYgn3M19DQza5F6ckpZDmPov2C'
			password: '';
		entity: (ZnEntity text: source);
		contentType: ZnMimeType applicationJson;
		post.
	^ (STONJSON fromString: result) at: 'link'
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackActive [
	^true
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackConfigHeader [
	^ {'track_id' -> self trackId.
		'language' -> 'Pharo'.
		'slug' -> self trackId.
		'active' -> self trackActive.
		'status' -> self statusAttributes.
		'blurb' -> self trackDescription.
		'version' -> 3.
		'online_editor' -> self editorAttributes.
		'files' -> self filesAttributes.
		'average_run_time' -> 1.
		}
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackConfigTags [
	^ {
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
]

{ #category : #'*ExercismDev' }
ExercismManager class >> trackDescription [
	^ 'Pharo is a fun and immersive Smalltalk programming experience. Featuring a clean object-oriented language and a powerful user extendable environment, it focuses on simplicity and immediate feedback (think IDE and OS rolled into one). Its elegance and productivity give it wide reach into banking, education, web development and even robotics.'
]

{ #category : #'*ExercismDev' }
ExercismManager >> viewMenteeSolution [
	| reviewId result rgEnv pkgs browser |

	reviewId := (UIManager default
		request: 'Enter a valid mentor exercism uuid:')
		ifNil: [ ^ nil ]
		ifNotNil: [ :value | self parseTokenNamed: 'uuid' from: value ].

	UIManager default inform: 'Retrieving: ' , (reviewId ifNil: ['']).
	result := (ExercismReviewCommand reviewId: reviewId) execute.
	
	"
	self browseAsMCSnaphot: result.
	self browseAsDifference: result.
	"
	
	self browseAsRingModel: result
]
