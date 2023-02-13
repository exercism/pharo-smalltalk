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
		
	} asOrderedDictionary.
	testResults ifNotEmpty: [ testRunnerDict add: ('tests' -> testResults ) ].
	^ testRunnerDict 
]

{ #category : #'*ExercismTestRunner' }
TestResult >> overallStatus [

	self errors ifNotEmpty: [ ^ 'error' ].
	self failures ifNotEmpty: [ ^ 'fail' ].
	^ 'pass'
]
