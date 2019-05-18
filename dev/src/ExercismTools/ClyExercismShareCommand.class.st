Class {
	#name : #ClyExercismShareCommand,
	#superclass : #ClyExercismExerciseCommand,
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismShareCommand class >> contextMenuOrder [
		^15
]

{ #category : #accessing }
ClyExercismShareCommand >> defaultMenuIconName [
	^#publish
]

{ #category : #accessing }
ClyExercismShareCommand >> defaultMenuItemName [
	^'Share exercise...'
]

{ #category : #accessing }
ClyExercismShareCommand >> description [ 
	^'Share your proposed solution in the cloud to discuss with others...'
]

{ #category : #execution }
ClyExercismShareCommand >> execute [
	| exerciseName result url |

	exerciseName := self selectedItem exerciseName.

	[ UIManager default 
		informUser: 'Sharing...'
		during: [result := ExercismManager default
		shareExercise: 
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
		do: [ :ex | self reportError: ex for: nil ]
]
