"
I am a wrapper over a ZnClient to streamline the HTTP interactions with exercism, and to also make it restable
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
	self hasToken ifFalse: [ (ExUnauthorized badToken: nil) signal ].
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
		headerAt: 'Authorization' put: 'Bearer ' , self class token
]

{ #category : #internal }
ExercismHttpClient >> get [ 
	"Answer the result of an HTTP GET command, thows an Exception if 401 response"
	| result |
	
	result := self zincClient get.
	
	self responseCode = 401
		ifTrue: [ (ExUnauthorized badToken: ApiToken) signal ].
		
	^result
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

{ #category : #accessing }
ExercismHttpClient >> hostName [
	^ hostName
]

{ #category : #accessing }
ExercismHttpClient >> hostName: hostNameString [
	hostName := hostNameString
]

{ #category : #internal }
ExercismHttpClient >> patch [
	| response status statusCode statusMsgs |
	
	response := self zincClient patch.
	
	status := self zincClient response statusLine.
	statusCode := self responseCode.
	
	statusMsgs := {201 -> 'SUCCESS'. 400 -> 'NO CHANGES'} asDictionary.
	
	(statusMsgs includesKey: statusCode)
		ifTrue: [ 
				self inform: 'Exercism submit solution - ' , (statusMsgs at: statusCode) value. 
				^response ].
		
	self error:
			'Exercism submit solution - UNKNOWN ERROR (' , 
			statusCode printString, ' ' , status reason , ')'
]

{ #category : #public }
ExercismHttpClient >> patchSolution: solutionIdString with: solutionDataMap [
	
	self
		path: (self solutionPathFor: solutionIdString);
		addFormEntity: 'files[]' data: solutionDataMap;
		patch
]

{ #category : #internal }
ExercismHttpClient >> path: aString [
	self zincClient path: aString

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
ExercismHttpClient >> solutionPathFor: aString [
	"Answer a path string that accounts for missing or extra / path characters"
	
	^ String
		streamContents: [ :s | 
			s
				nextPutAll: self class solutionPath exPathString;
				nextPutAll:
					(aString first = Path delimeter
						ifTrue: [ aString allButFirst ]
						ifFalse: [ aString ]) ]
]

{ #category : #public }
ExercismHttpClient >> verifyToken [
	^ self class verifyToken
]

{ #category : #accessing }
ExercismHttpClient >> zincClient [
	^ zincClient ifNil: [ zincClient := self createZnClient ]
]
