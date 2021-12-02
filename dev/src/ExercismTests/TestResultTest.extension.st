Extension { #name : #TestResultTest }

{ #category : #'*ExercismTests' }
TestResultTest >> testExercismEnvironmentInfoOn [

	|output|

	output := String streamContents: [:aStream | TestResult new exercismEnvironmentInfoOn: aStream ].
	self assert: (output includesSubstring: 'OS/Platform').
	self assert: (output includesSubstring: Smalltalk os platformName).
	self assert: (output includesSubstring: Smalltalk os version).
	self assert: (output includesSubstring: 'Image').	
	self assert: (output includesSubstring: SystemVersion current version).
	self assert: (output includesSubstring: SystemVersion current build asString).
	self assert: ((output includesSubstring: '64 Bit') or: [output includesSubstring: '32 Bit']).
	
	self assert: (output includesSubstring: 'VM').
	self assert: (output includesSubstring: Smalltalk vm interpreterSourceVersion).
]

{ #category : #'*ExercismTests' }
TestResultTest >> testExercismSummary [

	| exercise testResult resultSummary |
	exercise := ExercismExercise find: 'HelloWorld' ifAbsent: [self error: 'Cannot find HelloWorld exercise.' ].
	testResult := 
	[ exercise testCase suite run ]
	  on: Error
	  do: [ self error: 'Hello world test case failed, cannot test result summary.' ].
	resultSummary := testResult exercismSummary.
	self assert: (resultSummary includesSubstring:
			 (String streamContents: [ :aStream | 
				  testResult exercismEnvironmentInfoOn: aStream ]))
]
