"
# ClyExercismExerciseCommand

I am the Abstract super class of all Exercism exercise menu commands.
Menu items subclassing me should only appear on exercise package tags
in the browser.

## GUI Menu 

Subclasses of me are grouped into a browser menu under the name 
""Exercism"" when activating a menu on a package or tag. This submenu
is created by the class methods `#packageContextMenuActivation` and
`#tagContextMenuActivation`.

## Error reporting

Subclasess may use `#reportError:for:` to report errors. 

In one error case the exercise may be missing metadata and will need 
to be upgraded in the users Exercism profile and re-fetched.

In another error case the exercise may not be found. The likely 
problem is that the exercise name is misspelled or does not exist in
the Pharo-Smalltalk language track. 
"
Class {
	#name : #ClyExercismExerciseCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismExerciseCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	
		^1
]

{ #category : #testing }
ClyExercismExerciseCommand class >> isAbstract [
	
	^self == ClyExercismExerciseCommand
]

{ #category : #activation }
ClyExercismExerciseCommand class >> isExercismTagIn: aToolContext [
	^ aToolContext lastSelectedClassGroup name ~= ExercismManager legacyPackagePrefix
		and: [ aToolContext lastSelectedClassGroup classes
				detect: [ :any | 
					(any package name beginsWith: ExercismManager exercisePrefix , '@')
						or: [ (any package name beginsWith: ExercismManager legacyPackagePrefix , '-')
							or: [ any package name = ExercismManager legacyPackagePrefix ] ] ]
				ifFound: [ true ]
				ifNone: [ false ] ]
]

{ #category : #activation }
ClyExercismExerciseCommand class >> packageContextMenuActivation [
	"We can use a second annotation to give a similar menu to the Package item"
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: RPackage asCalypsoItemContext
]

{ #category : #activation }
ClyExercismExerciseCommand class >> tagContextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: ClyTaggedClassGroup asCalypsoItemContext
]

{ #category : #execution }
ClyExercismExerciseCommand >> reportError: anError for: exerciseId [
	| msg |

	msg := exerciseId
		ifNil: [ anError messageText, '!' ]
		ifNotNil: [ 
			((Smalltalk hasClassNamed: exerciseId kebabAsCamelCase)
				ifTrue:
					[ 'Exercise "{1}" is missing metadata! You need to upgrade it in Exercism and re-fetch!' ]
				ifFalse:
					[ 'Exercise "{1}" not found! Please check the Exercism website for valid exercises!' ])
				format: {exerciseId} ].

	^ UIManager default abort: msg
]
