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

{ #category : #config }
ExercismManager class >> exercismPackage [
	"Answer the default exercism package, or create one if missing"
	| packageOrganiser |
	
	packageOrganiser := RPackageOrganizer default.
	^ packageOrganiser
		packageNamed: self exercismPackageName
		ifAbsent: [ packageOrganiser createPackageNamed: self exercismPackageName ]
]

{ #category : #config }
ExercismManager class >> exercismPackageName [
	^ 'Exercism'
]

{ #category : #exercism }
ExercismManager class >> isUserMode [
	"Answer true if exercism is loaded in a clean image with no dev tools"
	
	^ ((IceRepository registry collect: [ :repo | repo name ])) asArray
		= #('iceberg' 'pharo' 'pharo-smalltalk')
		and: [ (RPackageOrganizer default
				packageNamed: 'ExercismDev'
				ifAbsent: [ nil ]) isNil ]
]

{ #category : #cache }
ExercismManager class >> solutionData [
	^ SolutionData ifNil: [ SolutionData := Dictionary new ]
]

{ #category : #config }
ExercismManager class >> trackId [
	^'pharo'
]

{ #category : #exercism }
ExercismManager class >> welcome [
	"Setup the initial environment for a new user"

	| defaultPackage browser |

	defaultPackage := self exercismPackage.
	defaultPackage
		moveClass: Welcome
		toTag: (RPackageTag package: defaultPackage name: 'Welcome').
		
	"If in usermode, hide the repositories so solutions aren't easily visible with a git compare"
	self isUserMode
		ifTrue: [ IceRepository reset ].

	"Select, package and then method so it scrolls nicely into view"
	browser := Smalltalk tools browser openOnPackage: defaultPackage.
	browser
		selectPackage: Welcome package atClassTag: Welcome name;
		selectMethod: (Welcome methodNamed: #testWelcome)
]

{ #category : #'world menu' }
ExercismManager class >> worldMenuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Exercism)
		order: 4.0;
		target: self;
		help: 'Tools to support Exercism'
]

{ #category : #exercism }
ExercismManager >> fetchFromExercismTo: package [
	"Prompt the user for an exercise to fetch, install it, and if successful, answer the loaded exercise"

	| exerciseName result |

	exerciseName := (UIManager default
		request: 'Enter a valid exercism exercise (e.g. hello-world):')
		ifNil: [ ^ nil ]
		ifNotNil: [ :value | self parseTokenNamed: 'exercise' from: value ].

	UIManager default inform: 'Loading: ' , exerciseName.
	result := (ExercismDownloadCommand
		track: self class trackId
		exercise: exerciseName) execute.

	^ result
]

{ #category : #helpers }
ExercismManager >> parseTokenNamed: tokenName from: aString [ 
	| parsedTokens exerciseOffset |
	parsedTokens := aString findTokens: '= '.
	parsedTokens size = 1 ifTrue: [ ^parsedTokens first ].
	
	(exerciseOffset := parsedTokens indexOf: '--',tokenName ) > 1 ifTrue: [ 
		^parsedTokens at: exerciseOffset + 1 ].
	
	^nil
]

{ #category : #exercism }
ExercismManager >> submitToExercism: packageOrTag [
		
	(packageOrTag  = self class exercismPackage) 
		ifTrue: [ self error: 'Select the sub-package with your solution!' ].
				
	^(ExercismSubmitCommand exercise: packageOrTag) execute.
	
]

{ #category : #exercism }
ExercismManager >> viewOnExercism: packageOrTag [
	WebBrowser openOn: 'https://exercism.io/my/tracks/pharo'
]
