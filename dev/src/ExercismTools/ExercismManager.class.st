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
ExercismManager class >> packagesExercismMenu: aBuilder [
	<nautilusGlobalPackageMenu>
	| packageOrTag target packageTree |
	
	target := aBuilder model.
	(packageTree := target selectedPackage) ifNil: [ ^ target ].
	(packageTree packageName = 'Exercism') ifFalse: [ ^ target ].
	
	packageOrTag := packageTree item.
	
	(aBuilder item: #'Exercism')
		label: 'Exercism';
		order: 0;
		help: 'Exercism commands';
		withSeparatorAfter.
		
	(aBuilder item: #'Fetch Exercise...')
		parent: #'Exercism';
		action: [ ExercismManager default fetchFromExercismTo: packageOrTag ];
		order: 100;
		help: 'Fetch next Exercism example from exercism.io'.
	(aBuilder item: #'Submit Solution')
		parent: #'Exercism';
		action: [ ExercismManager default submitToExercism: packageOrTag ];
		order: 101;
		help: 'Submit a completed Exercism example to exercism.io'.
	(aBuilder item: #'View Track Progress')
		parent: #'Exercism';
		action: [ ExercismManager default viewOnExercism: packageOrTag ];
		order: 102;
		help: 'View the Pharo track on www.exercism.io'.
	(aBuilder item: #'View metadata')
		parent: #'Exercism';
		action: [ ((RPackageOrganizer default packageNamed: 'Exercism') ensureProperties at: packageOrTag)  inspect];
		order: 105;
		help: 'View Exercism solution metadata (maybe only during dev/debug).'.
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
	
	(exercise := UIManager default
		request: 'Enter a valid exercism exercise (e.g. hello-world):')
		ifNil: [ ^ self ].
		
	UIManager default inform: 'Loading: ' , exercise.
	(ExercismDownload exercise: exercise) 
		ifTrue: [ UIManager default inform: 'Success, Happy Coding']
]

{ #category : #exercism }
ExercismManager >> pathStringFor: aFileReference [
	| aPath |
	aPath := aFileReference path.
	^ String streamContents: [ :stream | aPath printOn: stream delimiter: aPath delimiter ]
]

{ #category : #exercism }
ExercismManager >> submitToExercism: packageOrTag [
	| exerciseName |
	
	exerciseName := packageOrTag name asKebabCase.
	exerciseName = 'exercism' ifTrue: [ self error: 'Select the sub-package with your solution!' ].
				
	ExercismSubmit exercise: exerciseName.
	
	UIManager default inform: 'Successfully submitted solution!'
]

{ #category : #helper }
ExercismManager >> verifyToken [
	 [ ExercismCommand verifyToken ] on: ExUnauthorized do: [ ^false ].
	^true 

]

{ #category : #exercism }
ExercismManager >> viewOnExercism: packageOrTag [ 

	|  url |
		
	url := 'https://exercism.io/my/tracks/pharo'.
				
	ExternalWebBrowser new open: url
	
]
