"
I am  responsible for managing the interaction with the lower level Exercism command line tool.
"
Class {
	#name : #ExercismManager,
	#superclass : #Object,
	#classVars : [
		'SolutionData'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #'instance creation' }
ExercismManager class >> default [
	"answer a defulat manager"
	
	^self new
]

{ #category : #exercism }
ExercismManager class >> exercismPackageName [
	^ 'Exercism'
]

{ #category : #exercism }
ExercismManager class >> solutionData [
	^ SolutionData ifNil: [ SolutionData := Dictionary new ]
]

{ #category : #exercism }
ExercismManager class >> welcome [
	"Setup the initial environment for a new user"

	| pkg |
	pkg := RPackageOrganizer default
		createPackageNamed: self exercismPackageName.
		
	pkg
		moveClass: Welcome
			toTag: (RPackageTag package: pkg name: 'Welcome').
			
	Smalltalk tools browser openOnClass: Welcome selector: #testWelcome
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
