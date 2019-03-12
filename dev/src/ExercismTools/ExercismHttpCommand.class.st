"
I am the root Exercism API commands, supplying functionality common to all commands. 

Responsibility:  
  I hold and configure the API path and student access token,
  and provide preconfigured http clients to subclasses.

Collaborators: 
  ZnClient - for the configured http client I provide
  MorphicUIManager - for getting user input
  ExernalWebBrowser - for hot  linking users to required input info

Public API and Key Messages (only class side)
  #configureToken: - cmd driven configuration of API token and path
  #configure - gui driven configuration of API token and path 
  #verifyToken - ensure API token is configured (doesn't verify working) 

No instance creation (only class variables accessed) 

General usage
  ExercismCommand configureToken.
  ExercismCommand configureToken: 'xxxxx-your-secret-xxxxx'.
  ExercismCommand verifyToken.

Subclass usage:  
    client := self class newHttpClient.
    client
	path: self path;
	queryAt: 'xxxx' put: xxxx;
	queryAt: 'yyyy' put: yyyy.
   ""#queryAt: 's accumulate,  and are
    cleared by #path:  when reusing connection""
   
Internal Representation and Key Implementation Points:
    ApiPath - path string required by server e.g. '/v1/solutions/latest'
    ApiToken - string e.g. 'd4a3xxxx-secret-xxxxxxxx9c56'

One concern is the key being permanently retained in Image, in a corner case where the  Image may be  shared with third-parties.
Perhaps later we should consider storing key in voltatile memory and/or external file.  btw, where does the CLI store its key?
"
Class {
	#name : #ExercismHttpCommand,
	#superclass : #Object,
	#instVars : [
		'httpClient'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #execution }
ExercismHttpCommand >> execute [
	"Execute the command, answers true if successful"
	
	^self subclassResponsibility 
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
