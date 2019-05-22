Class {
	#name : #ClyExercismShareCommand,
	#superclass : #ClyExercismExerciseCommand,
	#classVars : [
		'hasConfirmedSharing'
	],
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismShareCommand class >> contextMenuOrder [
		^15
]

{ #category : #accessing }
ClyExercismShareCommand class >> hasConfirmedSharing [
	^ hasConfirmedSharing ifNil: [ false ]
]

{ #category : #accessing }
ClyExercismShareCommand class >> hasConfirmedSharing: aBoolean [
	^hasConfirmedSharing := aBoolean
]

{ #category : #internal }
ClyExercismShareCommand >> confirmSharing [
	self class hasConfirmedSharing
		ifTrue: [ ^ true ].
		
	^ (UIManager default
		proceed:
			'Please confirm you are happy to anonymously store your exercise code, on a temporary (7 day) random url at dpaste.com.\Exercism and Pharo.org are not associated with this service, it is provided as a convenience to help users\more easily discuss ideas with a wider community.' withCRs)
		ifTrue: [ self class hasConfirmedSharing: true ]
		ifFalse: [ false ]
]

{ #category : #accessing }
ClyExercismShareCommand >> defaultMenuIconName [
	^#publish
]

{ #category : #accessing }
ClyExercismShareCommand >> defaultMenuItemName [
	^'Share on web...'
]

{ #category : #accessing }
ClyExercismShareCommand >> description [ 
	^'Create a web link to anonymously share your proposed solution on dpaste.com to discuss with others'
]

{ #category : #execution }
ClyExercismShareCommand >> execute [
	| exerciseName result url |

	exerciseName := self selectedItem exerciseName.
	self confirmSharing ifTrue: [ 
	[ UIManager default 
		informUser: 'Sharing...'
		during: [
			result := ExercismManager default
				shareExerciseDPaste: 
					(ExercismExercise
						find: exerciseName
						ifAbsent: [ :name | ^ self reportError: nil for: name asKebabCase ])].

	result
		ifNotNil: [ 
			url := result.
			UIManager default
				inform: ('Successfully shared to: "{1}"!' format: {url}).
			Clipboard clipboardText: url.
			WebBrowser openOn: url.
			 ] 
	]
		on: ExercismError 
		do: [ :ex | self reportError: ex for: nil ] ]
]
