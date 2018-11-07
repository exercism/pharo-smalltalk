"
I am  responsible for managing the interaction with the lower level Exercism command line tool.
"
Class {
	#name : #ExercismManager,
	#superclass : #Object,
	#classVars : [
		'SolutionData'
	],
	#category : #ExercismTools
}

{ #category : #'instance creation' }
ExercismManager class >> default [
	"answer a defulat manager"
	
	^self new
]

{ #category : #exercism }
ExercismManager class >> solutionData [
	^ SolutionData ifNil: [ SolutionData := Dictionary new ]
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

{ #category : #exercism }
ExercismManager >> fetchFromExercismTo: package [
	| exercise |
	self verifyToken ifFalse: [^self].
	
	(exercise := UIManager default
		request: 'Enter a valid exercism exercise (e.g. hello-world):')
		ifNil: [ ^ self ].
		
	UIManager default inform: 'Loading: ' , exercise.
	ExercismDownload exercise: exercise.
	UIManager default inform: 'Success, Happy Coding'
]

{ #category : #exercism }
ExercismManager >> pathStringFor: aFileReference [
	| aPath |
	aPath := aFileReference path.
	^ String streamContents: [ :stream | aPath printOn: stream delimiter: aPath delimiter ]
]

{ #category : #exercism }
ExercismManager >> submitToExercism: packageOrTag [
	| files writer result cmd exerciseName filesToSubmit trackDirectoryRef submissionDirectoryRef |
	
	exerciseName := packageOrTag name asKebabCase.
	exerciseName = 'exercism' ifTrue: [ self error: 'Select the sub-package with your solution!' ].
	
	trackDirectoryRef := FileLocator cwd / exerciseName.
	submissionDirectoryRef := trackDirectoryRef / '.pharo'.
	
	(writer := ExTonelWriter new)
		packageDir: (submissionDirectoryRef relativeTo: trackDirectoryRef) exPathString;
		directoryReference: trackDirectoryRef;
		writeSnapshot: packageOrTag snapshot.

	
	files := packageOrTag classes reject: [ :cls | cls isTestCase ].
	files isEmpty ifTrue: [ self error: 'No solution found to submit!' ].
	
	filesToSubmit := Character space
		join:
			(files
				collect: [ :cls | 
					self pathStringFor: (submissionDirectoryRef / (writer fileNameFor: cls asClassDefinition)) ]).
				
	ExercismSubmit exercise: exerciseName.
	
	UIManager default inform: 'Successfully submitted solution!'
]

{ #category : #helper }
ExercismManager >> verifyToken [
	^ ExercismDownload verifyToken. 

]

{ #category : #exercism }
ExercismManager >> viewOnExercism: packageOrTag [ 

	|  url |
		
	url := 'https://exercism.io/my/tracks/pharo'.
				
	ExternalWebBrowser new open: url
	
]
