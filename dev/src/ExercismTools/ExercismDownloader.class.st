"
I download the source examples for an Exercism exercise and parse them into Pharo classes
"
Class {
	#name : #ExercismDownloader,
	#superclass : #Object,
	#classVars : [
		'ApiPath',
		'ApiToken'
	],
	#category : #ExercismTools
}

{ #category : #initalization }
ExercismDownloader class >> configureToken [
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
ExercismDownloader class >> configureToken: your_CLI_token [
    "Get your_CLI_token at https://exercism.io/my/settings"
    ApiToken := your_CLI_token.
    ApiPath := '/v1/solutions/latest'.
]

{ #category : #'instance creation' }
ExercismDownloader class >> exercise: exerciseId [
	^ self track: 'pharo' exercise: exerciseId
]

{ #category : #testing }
ExercismDownloader class >> hasToken [
    ^ApiToken notNil 
]

{ #category : #internal }
ExercismDownloader class >> newClient [
    ^ ZnClient new 
          http;
          host: 'api.exercism.io';
          headerAt: 'Authorization' put: 'Bearer ' , ApiToken
]

{ #category : #'instance creation' }
ExercismDownloader class >> track: trackId exercise: exerciseId [
	^ self new track: trackId exercise: exerciseId
]

{ #category : #initalization }
ExercismDownloader class >> verifyToken [
	self hasToken ifFalse: [ ^ self configureToken ].
	^ true
]

{ #category : #internal }
ExercismDownloader >> loadFiles: fileCacheMap [ 
	| lastResult |

	fileCacheMap keysAndValuesDo: [ :filename :contents |
        (filename endsWith: '.st') ifTrue: [ 
            |parser|
            parser := TonelParser on: contents readStream.
            (lastResult := parser document) do: [:item | item load] 
            ]. 
    ].

	^lastResult
]

{ #category : #public }
ExercismDownloader >> track: trackId exercise: exerciseId [
	| client solution fileCache responseString responseJSON |
	client := self class newClient
		path: ApiPath;
		queryAt: 'exercise_id' put: exerciseId;
		queryAt: 'track_id' put: trackId.
		
	responseString := client get.
	responseJSON := (STON fromString: responseString).
	
	responseJSON at: 'error' ifPresent: [ :error | self error: (error at: 'message') ].
	
	solution :=  responseJSON at: 'solution'.
	fileCache := Dictionary new.
	(solution at: 'files')
		do: [ :filename | 
			client path: (solution at: 'file_download_base_url') , filename.
			fileCache at: filename put: client get ].
	^ self loadFiles: fileCache
]
