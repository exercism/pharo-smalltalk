Extension { #name : #MorphicUIManager }

{ #category : #'*ExercismTools' }
MorphicUIManager >> requestText: formattedText initialAnswer: defaultAnswer title: aTitle [
	"Derived from #request:initialAnswer:title: but only for formatted text not strings
	to avoid overriding formatting."
	
	"Create an instance of me whose question is queryString with the given 
	initial answer. Answer the string the user accepts.
	The title serves for the window that is opened
	Answer the empty string if the user cancels.
	Allow for interception with a ProvideAnswerNotification handler."
	
	|modalMorph|
	(ProvideAnswerNotification signal: formattedText) ifNotNil: [:answer |
		^answer == #default ifTrue: [defaultAnswer] ifFalse: [answer]].
	modalMorph := self modalMorph.
	^(modalMorph theme 
		textEntryIn: modalMorph
		formattedText: formattedText
		title: aTitle
		entryText: defaultAnswer)
]
