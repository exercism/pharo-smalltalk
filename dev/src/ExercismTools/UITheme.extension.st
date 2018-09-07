Extension { #name : #UITheme }

{ #category : #'*ExercismTools' }
UITheme >> newStaticTextIn: aThemedMorph text: aStringOrText [
	"Answer a new text."
	"Derived from newTextIn:text: - changed from locked to disabled"    

	^StaticTextMorph new
		wrapFlag: true;
		contents: aStringOrText;
		font: self textFont;
		autoFit: true;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap
]

{ #category : #'*ExercismTools' }
UITheme >> textEntryIn: aThemedMorph formattedText: formattedText title: aString entryText: defaultEntryText [
	"Answer the result of a text entry dialog (a string or nil if cancelled)
	with the given label and title."
	"Derived from textEntryIn:text:title:entryText: but calling #formattedText: not #text:"

	self questionSound play.
	^(aThemedMorph openModal: (
		TextEntryDialogWindow new
			textFont: self textFont;
			title: aString;
			formattedText: formattedText;
			entryText: defaultEntryText)) entryText
]
