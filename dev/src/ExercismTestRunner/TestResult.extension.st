Extension { #name : #TestResult }

{ #category : #'*ExercismTestRunner' }
TestResult >> exercismTestResults [
	
	^ self tests sort: [:a :b | a selector < b selector ]; collect: #exercismTestResultInfo
]

{ #category : #'*ExercismTestRunner' }
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

{ #category : #'*ExercismTestRunner' }
TestResult >> overallMessageFrom: testResultsColl [

	testResultsColl do: [ :testCaseDict | 
		((testCaseDict at: 'status') = 'error') ifTrue: [ 
			^ testCaseDict at: 'message' ] ].
	testResultsColl do: [ :testCaseDict | 
		((testCaseDict at: 'status') = 'fail') ifTrue: [ 
			^ testCaseDict at: 'message' ] ].
	^ String streamContents: [:aStream | self printAllPassedOn: aStream  ]
]

{ #category : #'*ExercismTestRunner' }
TestResult >> overallStatus [

	self errors ifNotEmpty: [ ^ 'error' ].
	self failures ifNotEmpty: [ ^ 'fail' ].
	^ 'pass'
]

{ #category : #'*ExercismTestRunner' }
TestResult >> printAllPassedOn: aStream [
	self runCount isZero ifTrue: [ ^ aStream nextPutAll: 'No tests ran.' ].
	aStream
		print: self runCount;
		nextPutAll: ' ran, ';
		print: self expectedPassCount;
		nextPutAll: ' passed.'
]
