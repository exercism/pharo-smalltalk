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
			
	Smalltalk tools browser openOnClass: Welcome selector: #testWelcome.
]

{ #category : #exercism }
ExercismManager >> fetchFromExercismTo: package [
	| exerciseName |
	
	exerciseName := (UIManager default
		request: 'Enter a valid exercism exercise (e.g. hello-world):')
			ifNil: [ ^ self ]
			ifNotNil: [ :value | self parseExerciseName: value ].
		
	UIManager default inform: 'Loading: ' , exerciseName.
	(ExercismDownload exercise: exerciseName)
		ifTrue: [ UIManager default inform: 'Success, Happy Coding' ]
]

{ #category : #helpers }
ExercismManager >> parseExerciseName: aString [ 
	| parsedTokens exerciseOffset |
	parsedTokens := aString findTokens: '= '.
	parsedTokens size = 1 ifTrue: [ ^parsedTokens first ].
	
	(exerciseOffset := parsedTokens indexOf: '--exercise') > 1 ifTrue: [ 
		^parsedTokens at: exerciseOffset + 1 ].
	
	^nil
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
	WebBrowser openOn: 'https://exercism.io/my/tracks/pharo'
]
