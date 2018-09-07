Extension { #name : #TextEntryDialogWindow }

{ #category : #'*ExercismTools' }
TextEntryDialogWindow >> formattedText: formattedText [
	"Set the text."
	"Derived from MessageDialogWindow>>text: but dont' clear any formating"
	formattedText
		addAttribute: TextAlignment centered.
	self textMorph newContents: formattedText
]

{ #category : #'*ExercismTools' }
TextEntryDialogWindow >> newText: aStringOrText [
	"Answer a new text."
	"Overrides MessageDialog>>newText, but change from locked to disabled"

	^self theme
		newStaticTextIn: self
		text: aStringOrText
]
