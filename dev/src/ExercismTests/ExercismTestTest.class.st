Class {
	#name : #ExercismTestTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #running }
ExercismTestTest >> tearDown [ 
	|aPackage|
	aPackage := RPackageOrganizer default packageNamed: 'Exercise@MockRunner' ifAbsent: [nil].
	aPackage ifNotNil: [ aPackage removeFromSystem].
	super tearDown
]

{ #category : #tests }
ExercismTestTest >> testExercismTestResultInfo [

	| testRunnerTest testResult mockTestClass tcInfo|
	testRunnerTest := ExercismTestRunnerTest new.

	"prepare mock test case and solution"
	testRunnerTest mockRunnerTestCaseSnapshot install.
	testRunnerTest mockRunnerSolutionSnapshot install.
	mockTestClass := self class environment at: #MockRunnerTest.
	testResult := mockTestClass suite run.
	testResult dispatchResultsIntoHistory.
	
	
	tcInfo := testResult passed anyOne exercismTestResultInfo.
	self assert: tcInfo isDictionary.
	self assert: (tcInfo at: 'status') equals: 'pass'.
	
	tcInfo := testResult failures anyOne exercismTestResultInfo.
	self assert: (tcInfo at: 'status') equals: 'fail'.
	self assert: (tcInfo at: 'message') isNotEmpty.
	self assert: (tcInfo at: 'output') isNotEmpty.

	tcInfo := testResult errors anyOne exercismTestResultInfo.
	self assert: (tcInfo at: 'status') equals: 'error'.
	self assert: (tcInfo at: 'message') isNotEmpty.
	self assert: (tcInfo at: 'output') isNotEmpty.
]

{ #category : #tests }
ExercismTestTest >> testHumanReadableName [
	
	|exeTest|
	exeTest := ExercismTest new.
	exeTest setTestSelector: #test06_DoesNotDetectNonanagramsWithIdenticalChecksum.
	
	self assert: exeTest humanReadableName equals: 'Does not detect nonanagrams with identical checksum'.
	exeTest setTestSelector: #testAnotherNameGiven.
	self assert: exeTest humanReadableName equals: 'Another name given'.
]

{ #category : #tests }
ExercismTestTest >> testResultDebugInfo [
	|testCase|
	testCase := HelloWorldTest new.
	testCase setTestSelector: #testHello.
	self assert: testCase resultDebugInfo equals: ''. 
	
	testCase setTestSelector: nil.
	
	"test if stack bottom is present"
	self assert: (testCase resultDebugInfo includesSubstring: 'HelloWorldTest(TestCase)>>performTest'). 
]

{ #category : #tests }
ExercismTestTest >> testResultMessage [
	|testCase|
	testCase := HelloWorldTest new.
	testCase setTestSelector: #testHello.
	self assert: testCase resultMessage equals: ''. 
	
	testCase setTestSelector: nil.
	
	"errors should provide some error message - exception description"
	self assert: testCase resultMessage isNotEmpty. 
]

{ #category : #tests }
ExercismTestTest >> testSourceCodeString [
	|testCase|
	testCase := HelloWorldTest new.
	testCase setTestSelector: #testHello.
	self assert: (testCase sourceCodeString includesSubstring:  'testHello'). 
	"test if linux line endings are used for json output"
	self assert: (testCase sourceCodeString includes:  Character lf). 
]

{ #category : #tests }
ExercismTestTest >> testStatusString [

	| testRunnerTest testResult mockTestClass|
	testRunnerTest := ExercismTestRunnerTest new.

	"prepare mock test case and solution"
	testRunnerTest mockRunnerTestCaseSnapshot install.
	testRunnerTest mockRunnerSolutionSnapshot install.
	mockTestClass := self class environment at: #MockRunnerTest.
	testResult := mockTestClass suite run.
	testResult dispatchResultsIntoHistory.
	
	self assert: testResult passed anyOne statusString equals: 'pass'.
	self assert: testResult failures anyOne statusString equals: 'fail'.
	self assert: testResult errors anyOne statusString equals: 'error'.	
]

{ #category : #tests }
ExercismTestTest >> testVerifySelectorUsageDetection [
	self assert: true equals: true. "a selector to detect".
	
	self
		should: [ ExercismTest new
				verifySolution: ExercismTestTest
				avoidsSelector: #assert:equals: ]
		raise: TestFailure
		description: 'Should signal a TestFailure for detected selector usage'
]
