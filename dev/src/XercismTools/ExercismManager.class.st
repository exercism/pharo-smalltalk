Class {
	#name : #ExercismManager,
	#superclass : #Object,
	#category : #XercismTools
}

{ #category : #exercism }
ExercismManager class >> fetchNextExercism: package [ 

	| result cmd project tonelLocator reader |
	
	cmd := 'exercism fetch'.
	result := PipeableOSProcess waitForCommand: cmd.
	project := self parseExercismFetchString: result output.
	
	tonelLocator := ('./', project) asFileReference.
	(reader := TonelReader on: tonelLocator fileName: tonelLocator pathString ) loadDefinitions.
	reader definitions do: [ :def | def load ].
	
	UIManager default inform: cmd, ' -> ',result output, '.'
]

{ #category : #helper }
ExercismManager class >> parseExercismFetchString: osOutputString [
	
	osOutputString regex: '\/\w*-?\w+$' matchesDo: [ :m |  ^m allButFirst ].
	
	"self error: 'Could not find exercism result'"
	^'HelloWorld'
]

{ #category : #exercism }
ExercismManager class >> submitToExercism: packageOrTag [ 

	| files writer result cmd |
	writer := ExTonelWriter new.
	writer packageDir: packageOrTag name.
	writer
		sourceDir: '.' asFileReference;
		writeSnapshot: (MCPackage named: packageOrTag package name) snapshot.
	files := packageOrTag classes.
		
	cmd := 'exercism submit ',
			(Character space
				join: (files collect: [ :cls | writer fileNameFor: cls asClassDefinition ])).
				
	result := PipeableOSProcess waitForCommand: cmd.
	UIManager default inform: cmd, ' -> ',result output, '.'
]
