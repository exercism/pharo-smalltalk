"
I am  responsible for managing the interaction with the lower level Execercism command line tool.
"
Class {
	#name : #ExercismManager,
	#superclass : #Object,
	#category : #ExercismTools
}

{ #category : #'instance creation' }
ExercismManager class >> default [
	"answer a defulat manager"
	
	^self new
]

{ #category : #exercism }
ExercismManager class >> initialize [
	"Setup the initial environment for a new user"

	| pkg welcomeClass|
	pkg := RPackageOrganizer default createPackageNamed: 'Exercism'.
			
   welcomeClass := TestCase subclass: #Welcome
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Exercism-Welcome'.

   welcomeClass comment: 'To start your Exercism journey, right click on the Exercism package and select ''''Exercism | Fetch  Exercise'''', and then type: hello-world'.
   
   welcomeClass compile: '
testWelcome
	"This is a sample Pharo test fixture. 
	NOTE: Refer to the Class comment for more information on getting started."

	self assert: #(''''Welcome'''' ''''to'''' ''''Pharo'''') size equals: 3'
]

{ #category : #exercism }
ExercismManager >> fetchFromExercismTo: package [
	| result exercise pkgName root exercisePkg |
	
	self verifyToken ifFalse: [^self].
	
	(exercise := UIManager default
		request: 'Enter a valid exercism exercise (e.g. hello-world):')
		ifNil: [ ^ self ].
		
	UIManager default inform: 'Loading: ' , exercise.
	(result := ExercismDownloader exercise: exercise)
		detect: [ :def | def isClassDefinition ]
		ifFound: [ :def | pkgName := def category ].
		
	root := RPackageOrganizer default packageNamed: 'Exercism'.
	exercisePkg := root packages
		detect: [ :p | p categoryName = pkgName ].
		
	SystemAnnouncer uniqueInstance
		announce: (RPackageRegistered to: exercisePkg).
		
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
		sourceDir: trackDirectoryRef;
		writeSnapshot: packageOrTag snapshot.

	
	files := packageOrTag classes reject: [ :cls | cls isTestCase ].
	files isEmpty ifTrue: [ self error: 'No solution found to submit!' ].
	
	filesToSubmit := Character space
		join:
			(files
				collect: [ :cls | 
					self pathStringFor: (submissionDirectoryRef / (writer fileNameFor: cls asClassDefinition)) ]).
				
	cmd := 'exercism submit ' , filesToSubmit.
	result := PipeableOSProcess waitForCommand: cmd.
	result succeeded ifFalse: [ self error: 'Unable to submit solution, CLI reported ', result outputAndError printString ].
	
	UIManager default inform: 'Successfully submitted solution!'
]

{ #category : #helper }
ExercismManager >> verifyToken [
	ExercismDownloader hasToken
		ifFalse: [ 
			ExercismDownloader configureToken:
					((UIManager default
						request: 'Enter your Exercism token (see: https://exercism.io/my/settings):')
						ifNil: [ ^ false ]) ].
	^true
]

{ #category : #exercism }
ExercismManager >> viewOnExercism: packageOrTag [ 

	|  url |
		
	url := 'https://exercism.io/my/tracks/pharo'.
				
	ExternalWebBrowser new open: url
	
]
