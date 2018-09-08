Class {
	#name : #ExercismCommand,
	#superclass : #Object,
	#classVars : [
		'ApiPath',
		'ApiToken'
	],
	#category : #ExercismTools
}

{ #category : #initalization }
ExercismCommand class >> configureToken [
   |requestText linkText token url |
	url := 'https://exercism.io/my/settings'.
   linkText := url asText
		addAttribute: (TextAction new actOnClickBlock: [ExternalWebBrowser new open: url]);
		addAttribute: TextColor blue;
		addAttribute:TextEmphasis underlined.
   requestText := 'CLI token available at  ' asText, linkText.
	token := MorphicUIManager default requestText: requestText initialAnswer: '' title: 'Please enter your Exercism student token'.
	token ifNil: [ ^false ].
	self configureToken: token.
	^true
	
]

{ #category : #initalization }
ExercismCommand class >> configureToken: your_CLI_token [
    "Get your_CLI_token at https://exercism.io/my/settings"
    ApiToken := your_CLI_token.
    ApiPath := '/v1/solutions/latest'.
]

{ #category : #testing }
ExercismCommand class >> hasToken [
    ^ApiToken notNil 
]

{ #category : #internal }
ExercismCommand class >> newClient [
    ^ ZnClient new 
          http;
          host: 'api.exercism.io';
          headerAt: 'Authorization' put: 'Bearer ' , ApiToken
]

{ #category : #initalization }
ExercismCommand class >> verifyToken [
	self hasToken ifFalse: [ ^ self configureToken ].
	^ true
]
