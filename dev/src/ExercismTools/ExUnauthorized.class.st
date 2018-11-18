Class {
	#name : #ExUnauthorized,
	#superclass : #Error,
	#instVars : [
		'badToken'
	],
	#category : #ExercismTools
}

{ #category : #'instance-creation' }
ExUnauthorized class >> badToken: tokenStringOrNil [ 
	^ self new badToken: tokenStringOrNil
]

{ #category : #accessing }
ExUnauthorized >> badToken [
	^badToken
]

{ #category : #accessing }
ExUnauthorized >> badToken: tokenStringOrNil [ 
	badToken := tokenStringOrNil
]

{ #category : #action }
ExUnauthorized >> configureToken [
	| url linkText requestText initialAnswer title newToken  |
	url := 'https://exercism.io/my/settings'.
	linkText := url asText
		addAttribute: (TextAction new actOnClickBlock: [ExternalWebBrowser new open: url]);
		addAttribute: TextColor blue;
		addAttribute: TextEmphasis underlined.
  	requestText := 'CLI token available at  ' asText, linkText.
	initialAnswer := badToken ifNil: [ '' ] ifNotNil: [  badToken ]. 
	title := (badToken ifNil: [ '' ] ifNotNil: [ 'Unauthorized, invalid token. ' ]) , 'Please enter your Exercism student token'.
	newToken := MorphicUIManager default requestText: requestText initialAnswer: initialAnswer title: title.
	newToken ifNil: [ ^false ].
	(newToken = badToken)  ifTrue: [ ^false ].
	ExercismCommand configureToken: newToken.
	^true "retry"
]

{ #category : #accessing }
ExUnauthorized >> defaultAction [
	self badToken: 'Unauthorized, invalid token. Please configure...'.
]
