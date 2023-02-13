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
ExercismManager class >> disableStudentCritics [

	ReUtilityMethodsRule enabled: false.
	ReTestClassNotInPackageWithTestEndingNameRule enabled: false
	
]

{ #category : #config }
ExercismManager class >> exercisePrefix [
	^ 'Exercise'
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

{ #category : #config }
ExercismManager class >> legacyExercismPackage [
	"Answer the default exercism package, or nil if missing"
	| packageOrganiser |
	
	packageOrganiser := RPackageOrganizer default.
	^ packageOrganiser
		packageNamed: self legacyPackagePrefix 
		ifAbsent: [ nil ]
]

{ #category : #config }
ExercismManager class >> legacyPackagePrefix [
	^ 'Exercism'
]

{ #category : #cache }
ExercismManager class >> solutionData [
	^ SolutionData ifNil: [ SolutionData := Dictionary new ]
]

{ #category : #config }
ExercismManager class >> trackId [
	^'pharo-smalltalk'
]

{ #category : #config }
ExercismManager class >> trackVersionString [

	^ 2 asString
]

{ #category : #exercism }
ExercismManager class >> upgrade [
	"upgrade an environment (called from ugrade instructions)"

	self disableStudentCritics.
	World closeUnchangedWindows.
]

{ #category : #exercism }
ExercismManager class >> welcome [
	"Setup the initial environment for a new user"

	| browser |
		
	"If in usermode, hide the repositories so solutions aren't easily visible with a git compare"
	self isUserMode
		ifTrue: [ 
			IceRepository reset.
			self disableStudentCritics ].

	"Select, package and then method so it scrolls nicely into view"
	browser := Smalltalk tools browser openOnPackage: WelcomeTest package.
	browser
		"selectPackage: Welcome package;"
		selectMethod: (WelcomeTest methodNamed: #testWelcome)
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
ExercismManager >> shareExerciseDPaste: exercise [
	| source |
	
	source := String
		streamContents: [ :s | 
			s nextPutAll: '"This is a sample Pharo Exercism solution (see: https://exercism.io/my/tracks/pharo-smalltalk)'; 
			cr; 
			nextPutAll: 'For the reference exercise, refer to: https://github.com/exercism/pharo-smalltalk/tree/master/exercises/', exercise name, '"'; 
			cr; cr.
			
			(exercise solutionClasses asSortedCollection: [ :a :b | a name <= b name ]) do: [ :class |
					(exercise exercisePackage extendsClass: class)
						ifTrue: [ 
							class exPrintOutExtensionsFor: exercise exercisePackage on: s ] 
						ifFalse: [ 
							class exPrintOutOn: s ] ] ].
	^ ZnClient new
		systemPolicy;
		beOneShot;
		url: 'http://dpaste.com/api/v2/';
		addPart: (ZnMimePart fieldName: 'title' value: 'Pharo Exercism for: ', exercise name);
		addPart: (ZnMimePart fieldName: 'syntax' value: 'smalltalk');
		addPart: (ZnMimePart fieldName: 'expiry_days' value: '7');
		addPart: (ZnMimePart fieldName: 'content' value: source);
		post
]

{ #category : #exercism }
ExercismManager >> shareExerciseStfx: package [
	| source |
	package = self class legacyExercismPackage
		ifTrue: [ self error: 'Select the sub-package with your solution!' ].
		
	source := String
		streamContents: [ :s | 
			package solutionSources
				keysAndValuesDo: [ :filename :code | 
					s << $" << filename << $".
					s cr; cr;
						nextPutAll: code;
						cr; cr ] ].
				
	^ ZnClient new
		systemPolicy;
		beOneShot;
		url: 'http://ws.stfx.eu';
		contents: source;
		post
]

{ #category : #exercism }
ExercismManager >> submitToExercism: packageOrTag [
		
	(packageOrTag  = self class legacyExercismPackage) 
		ifTrue: [ self error: 'Select the sub-package with your solution!' ].
				
	^(ExercismSubmitCommand exercise: packageOrTag) execute.
	
]

{ #category : #exercism }
ExercismManager >> viewOnExercism: packageOrTag [
	WebBrowser openOn: 'https://exercism.org/tracks/pharo'
]
