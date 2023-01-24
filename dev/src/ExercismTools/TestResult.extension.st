Extension { #name : #TestResult }

{ #category : #'*ExercismTools' }
TestResult >> exercismEnvironmentInfoOn: aStream [

	aStream 
	 	nextPutAll: 'Used OS/Platform: ';
		nextPutAll: Smalltalk os platformName; space;
		nextPutAll: Smalltalk os version; space;
		nextPutAll: Smalltalk os subtype;
		crlf;
		nextPutAll: 'Image version: ';
		nextPutAll: SystemVersion current version; space;
		nextPutAll: 'build: ';
		nextPutAll: SystemVersion current build asString;
		nextPutAll: (Smalltalk vm is32bit 
			ifTrue: [ ' (32 Bit)' ]
			ifFalse: [ ' (64 Bit)' ]).
	aStream 
		crlf;
		nextPutAll: 'VM version: ';
		nextPutAll: Smalltalk vm interpreterSourceVersion
		 
]

{ #category : #'*ExercismTools' }
TestResult >> exercismSummary [
	^String streamContents: [ :s | s 
		nextPutAll: 'Tested on: ';
		nextPutAll: self timeStamp asLocalStringYMDHM;
		crlf;
		nextPutAll: self runCount printString;
		nextPutAll: ' run, ';
		nextPutAll: self expectedPassCount printString;
		nextPutAll: ' passes, ';
		nextPutAll: self skippedCount printString;
		nextPutAll: ' skipped, ';
		nextPutAll: self unexpectedFailureCount printString;
		nextPutAll: ' failures, ';
		nextPutAll: self unexpectedErrorCount printString;
		nextPutAll:' errors.';
		crlf.
		self exercismEnvironmentInfoOn: s.
	]
]

{ #category : #'*ExercismTools' }
TestResult >> exercismTestResults [
	
	^ self tests collect: #exercismTestResultInfo
]

{ #category : #'*ExercismTools' }
TestResult >> exercismTestRunnerData [
	|testResults testRunnerDict|
	testResults := self exercismTestResults.
	testRunnerDict := {  
		'version' -> ExercismManager trackVersionString.
		'status' -> self overallStatus.
		'message' -> (self overallMessageFrom: testResults).
		
	} asOrderedDictionary.
	testResults ifNotEmpty: [ testRunnerDict add: ('tests' -> testResults ) ].
	^ testRunnerDict 
]

{ #category : #'*ExercismTools' }
TestResult >> exercismTestRunnerResultOn: aStream [

	aStream 
	 	nextPutAll: 'TOTO'
]

{ #category : #'*ExercismTools' }
TestResult >> overallMessageFrom: testResultsColl [

	testResultsColl do: [ :testCaseDict | 
		((testCaseDict at: 'status') = 'error') ifTrue: [ 
			^ testCaseDict at: 'message' ] ].
	testResultsColl do: [ :testCaseDict | 
		((testCaseDict at: 'status') = 'fail') ifTrue: [ 
			^ testCaseDict at: 'message' ] ].
	^ String streamContents: [:aStream | self printAllPassedOn: aStream  ]
]

{ #category : #'*ExercismTools' }
TestResult >> overallStatus [

	self errors ifNotEmpty: [ ^ 'error' ].
	self failures ifNotEmpty: [ ^ 'fail' ].
	^ 'pass'
]

{ #category : #'*ExercismTools' }
TestResult >> printAllPassedOn: aStream [
	self runCount isZero ifTrue: [ ^ aStream nextPutAll: 'No tests ran.' ].
	aStream
		print: self runCount;
		nextPutAll: ' ran, ';
		print: self expectedPassCount;
		nextPutAll: ' passed.'
]
