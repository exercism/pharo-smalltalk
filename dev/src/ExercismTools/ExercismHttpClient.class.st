"
I am a wrapper over a ZnClient to streamline the HTTP interactions with exercism, and to also make it re-testable.

"
Class {
	#name : #ExercismHttpClient,
	#superclass : #Object,
	#instVars : [
		'hostName',
		'zincClient'
	],
	#classVars : [
		'ApiToken'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #accessing }
ExercismHttpClient class >> configureToken: your_CLI_token [
    "Get your_CLI_token at https://exercism.io/my/settings"
    ApiToken := your_CLI_token
]

{ #category : #testing }
ExercismHttpClient class >> hasToken [
    ^ApiToken notNil 
]

{ #category : #accessing }
ExercismHttpClient class >> hostName [
	^ 'api.exercism.io'
]

{ #category : #'instance creation' }
ExercismHttpClient class >> new [
	^self newHost: self hostName
]

{ #category : #'instance creation' }
ExercismHttpClient class >> newHost: hostName [

	^self basicNew
		initialize;
		hostName: hostName;
		yourself

]

{ #category : #caching }
ExercismHttpClient class >> promptForToken [
	| url linkText requestText initialAnswer title newToken  |
	url := 'https://exercism.org/settings/api_cli'.
	
	linkText := url asText
		addAttribute: (TextAction new actOnClickBlock: [WebBrowser openOn: url]);
		addAttribute: TextColor blue;
		addAttribute: TextEmphasis underlined.
		
  	requestText := 'CLI token available at  ' asText, linkText.
	initialAnswer := ApiToken ifNil: [ '' ]. 
	title := (initialAnswer ifEmpty: [ '' ] ifNotEmpty: [ 'Unauthorized or Invalid token. ' ]) , 
		'Please enter your Exercism student token'.
		
	newToken := MorphicUIManager default requestText: requestText initialAnswer: initialAnswer title: title.
	newToken ifNil: [ ^false ].
	(newToken = ApiToken)  ifTrue: [ ^false ].
	
	ExercismHttpClient configureToken: newToken.
	^true "retry"
]

{ #category : #caching }
ExercismHttpClient class >> reset [
	ApiToken := nil
	
]

{ #category : #accessing }
ExercismHttpClient class >> solutionPath [
    ^'/v1/solutions'
]

{ #category : #accessing }
ExercismHttpClient class >> token [
	^ ApiToken ifNil: [  'not-configured' ]
]

{ #category : #testing }
ExercismHttpClient class >> verifyToken [
	self hasToken ifFalse: [ ExUnauthorized signal ].
	^ true
]

{ #category : #internal }
ExercismHttpClient >> addFormEntity: fieldName data: dataDictionary [ 
	| multiPartFormDataEntity solutionEntity solutionPart |
	
	multiPartFormDataEntity := ZnMultiPartFormDataEntity new.

	dataDictionary keysAndValuesDo: [ :key :value| 
		solutionEntity := ZnByteArrayEntity bytes: value.
		solutionPart := ZnMimePart exercismFieldName: fieldName 
				fileName: key entity: solutionEntity.
				
		multiPartFormDataEntity addPart: solutionPart ].
		
	self zincClient entity: multiPartFormDataEntity 

]

{ #category : #internal }
ExercismHttpClient >> createZnClient [
	^ ZnClient new
		https;
		host: self hostName;
		yourself
]

{ #category : #internal }
ExercismHttpClient >> get [
	"Answer the result of an HTTP GET command, thows an Exception if 401 response"

	| result |

	result := self zincClient get.

	self responseCode = 401
		ifTrue: [ self signalUnauthorized ].

	^ result
]

{ #category : #public }
ExercismHttpClient >> getLatestExercise: exerciseId for: trackName [

	^self getResource: (self solutionPathFor: '/latest') with: {
		'track_id'-> trackName.
		'exercise_id' -> exerciseId }
]

{ #category : #public }
ExercismHttpClient >> getResource: filePath [

	^ self getResource: filePath with: #()
]

{ #category : #public }
ExercismHttpClient >> getResource: filePath with: queryMap [

	self path: filePath.
	
	queryMap asDictionary keysAndValuesDo: [ :key :value |
		self queryAt: key put: value  ].
	
	^ self get
]

{ #category : #public }
ExercismHttpClient >> getSpecifiedExercise: uuid [

	^self getResource: (self solutionPathFor: uuid) 
]

{ #category : #accessing }
ExercismHttpClient >> hostName [
	^ hostName
]

{ #category : #accessing }
ExercismHttpClient >> hostName: hostNameString [
	hostName := hostNameString
]

{ #category : #internal }
ExercismHttpClient >> parameterString [
	^ String
		streamContents: [ :s | 
			self zincClient request requestLine uri query 
			ifNotNil: [ :q |
				q associations do: [ :params | 
					s
						nextPutAll: params key asString;
						nextPutAll: ': ';
						nextPutAll: params value ] 
				separatedBy: [ s nextPutAll: ', ' ]]]
]

{ #category : #internal }
ExercismHttpClient >> patch [
	| response status statusCode successCodes |
	
	response := self zincClient patch.
	
	status := self zincClient response statusLine.
	statusCode := self responseCode.
	
	successCodes := {201 -> 'SUCCESS'. 400 -> 'NO CHANGES'} asDictionary.
	
	(successCodes includesKey: statusCode)
		ifTrue: [ 
				self inform: 'Exercism Submit - ' , (successCodes at: statusCode) value. 
				^response ].
		
	statusCode = 401 ifTrue: [ 
		ExUnauthorized signalBadToken: ApiToken ].
	
	self error:
			'Exercism Submit - UNKNOWN ERROR (' , 
			statusCode printString, ' ' , status reason , ')'
]

{ #category : #public }
ExercismHttpClient >> patchSolution: solutionIdString with: solutionDataMap [
	
	^self
		path: (self solutionPathFor: solutionIdString);
		addFormEntity: 'files[]' data: solutionDataMap;
		patch
]

{ #category : #internal }
ExercismHttpClient >> path: aString [
	self zincClient path: aString

]

{ #category : #internal }
ExercismHttpClient >> post [
	"Answer the result of an HTTP GET command, thows an Exception if 401 response"

	| result |

	result := self zincClient post.

	self responseCode = 401
		ifTrue: [ self signalUnauthorized ].

	^ result
]

{ #category : #internal }
ExercismHttpClient >> promptForToken [ 
	^self class promptForToken
]

{ #category : #internal }
ExercismHttpClient >> queryAt: stringId put: stringValue [
	self zincClient queryAt: stringId put: stringValue
		
]

{ #category : #public }
ExercismHttpClient >> responseCode [
	^ self zincClient response code
]

{ #category : #internal }
ExercismHttpClient >> signalUnauthorized [
	ExUnauthorized signalBadToken: ApiToken
]

{ #category : #internal }
ExercismHttpClient >> solutionPathFor: aString [
	"Answer a path string that accounts for missing or extra / path characters"
	
	^ String
		streamContents: [ :s | 
			s
				nextPutAll: self class solutionPath exPathString;
				nextPutAll:
					(aString first = Path delimiter
						ifTrue: [ aString allButFirst ]
						ifFalse: [ aString ]) ]
]

{ #category : #internal }
ExercismHttpClient >> username: nameString password: pwdString [
	self zincClient username: nameString password: pwdString

]

{ #category : #public }
ExercismHttpClient >> verifyToken [
	^ self class verifyToken
]

{ #category : #accessing }
ExercismHttpClient >> zincClient [
	^ (zincClient ifNil: [ zincClient := self createZnClient ])
		headerAt: 'Authorization' put: 'Bearer ' , self class token;
		yourself
]
