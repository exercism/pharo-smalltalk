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

	| result cmd exercise tonelLocator reader |
	
	(exercise := UIManager default request: 'Enter an exercise name') ifNil: [ ^self ].
	
	cmd := 'exercism download --track=pharo --exercise=', exercise.
	UIManager default inform: 'Running: ', exercise.
	result := PipeableOSProcess waitForCommand: cmd.
	self verifyExercismResult: result.
	
	UIManager default inform: 'Loading: ', exercise.
	tonelLocator := ('./', exercise) asFileReference.
	(reader := TonelReader on: tonelLocator fileName: tonelLocator pathString ) loadDefinitions.
	reader definitions do: [ :def | def load ].
	
	UIManager default inform: 'Success, Happy Coding'
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

{ #category : #helper }
ExercismManager class >> verifyExercismResult: osProcessResult [

	osProcessResult succeeded
		ifTrue: [ (osProcessResult output beginsWith: FileLocator cwd pathString)
				ifFalse: [ self error: 'Pharo must be run from the default exercism directory!' ].
			^ true ].
		
	self error: 'failure running exercism command: ' , osProcessResult printString
]

{ #category : #exercism }
ExercismManager class >> viewOnExercism: packageOrTag [ 

	|  cmd result |
		
	cmd := 'open https://exercism.io/my/tracks/pharo'.
				
	result := PipeableOSProcess waitForCommand: cmd.
	
]

{ #category : #exercism }
ExercismManager class >> welcome [
	"Setup the initial environment for a new user"

	| pkg |
	pkg := RPackageOrganizer default createPackageNamed: 'Exercism'.
	
	pkg
		moveClass: Welcome toTag: (RPackageTag package: pkg name: 'Welcome');
		browse
]
