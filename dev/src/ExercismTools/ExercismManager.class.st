"
I am  responsible for managing the interaction with the lower level Execercism command line tool.
"
Class {
	#name : #ExercismManager,
	#superclass : #Object,
	#category : #ExercismTools
}

{ #category : #exercism }
ExercismManager class >> fetchFromExercismTo: package [ 

	| result cmd exercise project tonelLocator reader |
	
	(exercise := UIManager default request: 'Enter an exercise name') ifNil: [ ^self ].
	
	cmd := 'exercism download --track=pharo --exercise=', exercise.
	result := PipeableOSProcess waitForCommand: cmd.
	project := self parseExercismFetchString: result output.
	
	tonelLocator := ('./', exercise) asFileReference.
	(reader := TonelReader on: tonelLocator fileName: tonelLocator pathString ) loadDefinitions.
	reader definitions do: [ :def | def load ].
	
	UIManager default inform: cmd, ' -> ',result output, '.'
]

{ #category : #helper }
ExercismManager class >> parseExercismFetchString: osOutputString [
	
	osOutputString regex: '\/\w*-?\w+$' matchesDo: [ :m |  ^m allButFirst ].
	
	"self error: 'Could not find exercism result'"
	^'hello-world'
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

{ #category : #exercism }
ExercismManager class >> welcome [
	"Setup the initial environment for a new user"

	| pkg |
	(pkg := RPackage organizer packageNamed: 'Exercism') 
		moveClass: Welcome toTag: (RPackageTag package: pkg name: 'Welcome');
		browse
]
