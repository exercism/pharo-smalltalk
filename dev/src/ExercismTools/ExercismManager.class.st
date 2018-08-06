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
	| result cmd exercise tonelLocator reader pkgName root exercisePkg |
	
	(exercise := UIManager default request: 'Enter a valid exercism exercise name') ifNil: [ ^ self ].
	cmd := 'exercism download --track=pharo --exercise=' , exercise.
	
	UIManager default inform: 'Loading: ' , exercise.
	
	result := PipeableOSProcess waitForCommand: cmd.
	self verifyExercismResult: result.
	
	tonelLocator := FileLocator cwd / exercise.
	(reader := TonelReader on: tonelLocator fileName: tonelLocator pathString) loadDefinitions.
	reader definitions
		do: [ :def | 
			def load.
			def isOrganizationDefinition
				ifTrue: [ pkgName := def categories first ] ].
			
	root := RPackageOrganizer default packageNamed: 'Exercism'.
	exercisePkg := root packages detect: [ :p | p categoryName = pkgName ].
	
	SystemAnnouncer uniqueInstance announce: (RPackageRegistered to: exercisePkg).
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
	| files writer result cmd kebabName filesToSubmit srcDir solutionBackup |
	
	kebabName := packageOrTag name asKebabCase.
	kebabName = 'exercism' ifTrue: [ self error: 'Select the sub-package with your exercise' ].
	
	srcDir := FileLocator cwd.
	solutionBackup := (srcDir / kebabName / '.solution.json') contents.
	
	writer := ExTonelWriter new.
	writer
		packageDir: kebabName;
		sourceDir: srcDir;
		writeSnapshot: packageOrTag snapshot.
		
	"Remove the extra package file as its not needed for Exercism"
	(srcDir / kebabName / 'package.st') delete.
	
	"Restore meta file"
	(srcDir / kebabName / '.solution.json') writeStreamDo: [ :stream | stream nextPutAll: solutionBackup ].
	
	files := packageOrTag classes reject: [ :cls | cls isTestCase ].
	filesToSubmit := Character space
		join:
			(files
				collect: [ :cls | 
					self pathStringFor: (FileLocator cwd / kebabName / (writer fileNameFor: cls asClassDefinition)) ]).
				
	cmd := 'exercism submit ' , filesToSubmit.
	result := PipeableOSProcess waitForCommand: cmd.
	result succeeded ifFalse: [ self error: 'Unable to submit exercism result' ].
	
	UIManager default inform: 'Successfully submitted solution!'
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
