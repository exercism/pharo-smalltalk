"
I am the root of Http commands that will use a (now) seperate httpClient object to fetch/put solution data
"
Class {
	#name : #ExercismHttpCommand,
	#superclass : #Object,
	#instVars : [
		'httpClient'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #private }
ExercismHttpCommand class >> client: anHttpClient [
	^self new
		httpClient: anHttpClient;
		yourself
]

{ #category : #execution }
ExercismHttpCommand >> execute [
	"Execute the command, answers true if successful"
	
	^self subclassResponsibility 
]

{ #category : #execution }
ExercismHttpCommand >> executeCheckingToken: aBlock [
	"Evaluate aBlock, after verifying the api token"

	^ [ 
		self httpClient verifyToken.
		aBlock value 
	]
		on: ExUnauthorized  
		do: [ :error | 
			self httpClient promptForToken
				ifTrue: [ error retry ]
				ifFalse: [ self inform: 'Operation Aborted!'.
					nil ] ]
]

{ #category : #accessing }
ExercismHttpCommand >> httpClient [
	"Anser the HttpRetriever used to marshal http requests"
	
	^ httpClient
]

{ #category : #accessing }
ExercismHttpCommand >> httpClient: anHttpClient [
	"Set the HttpRetriever used to marshal http requests"
	
	httpClient := anHttpClient
]
