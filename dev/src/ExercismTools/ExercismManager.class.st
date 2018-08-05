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
	
	(exercise := UIManager default request: 'Enter a valid exercism exercise name') ifNil: [ ^self ].
	
	cmd := 'exercism download --track=pharo --exercise=', exercise.
	UIManager default inform: 'Loading: ', exercise.
	result := PipeableOSProcess waitForCommand: cmd.
	self verifyExercismResult: result.
	
	tonelLocator := FileLocator cwd / exercise.
	(reader := TonelReader on: tonelLocator fileName: tonelLocator pathString ) loadDefinitions.
	reader definitions do: [ :def | def load ].
	
	"RPackageOrganizer default registerPackageNamed: ?"
	UIManager default inform: 'Success, Happy Coding'
]

{ #category : #exercism }
ExercismManager class >> pathStringFor: aFileReference [
	| aPath |
	aPath := aFileReference path.
	^ String streamContents: [ :stream | aPath printOn: stream delimiter: aPath delimiter ]
]

{ #category : #exercism }
ExercismManager class >> submitToExercism: packageOrTag [
	| files writer result cmd kebabName filesToSubmit |
	
	kebabName := packageOrTag name asKebabCase.
	kebabName = 'exercism' ifTrue: [ self error: 'Select the sub-package with your exercise' ].
	
	writer := ExTonelWriter new.
	writer
		packageDir: kebabName;
		sourceDir: '.' asFileReference;
		writeSnapshot: packageOrTag snapshot.
		
	files := packageOrTag classes reject: [ :cls | cls isTestCase ].
	filesToSubmit := Character space
		join:
			(files
				collect: [ :cls | 
					self pathStringFor: (FileLocator cwd / kebabName / (writer fileNameFor: cls asClassDefinition)) ]).
				
	cmd := 'exercism submit ' , filesToSubmit.
	result := PipeableOSProcess waitForCommand: cmd.
	
	UIManager default inform: cmd , ' -> ' , result output , '.'
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
