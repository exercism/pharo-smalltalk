Class {
	#name : 'ExercismDownloadCommandTest',
	#superclass : 'TestCase',
	#category : 'ExercismTests-UnitTests',
	#package : 'ExercismTests',
	#tag : 'UnitTests'
}

{ #category : 'running' }
ExercismDownloadCommandTest >> tearDown [
	"all known mock mutations should be recovered"
	ExercismExercise recoverFromGHMutation.
	TonelReader recoverFromGHMutation.
	super tearDown
]

{ #category : 'tests' }
ExercismDownloadCommandTest >> testExecuteDownloading [

	| cmd exercise solutionData mockHttpClient mockReader baseUrl sourceCode |
	Any strictMocks: false.

	[ 
		cmd := (ExercismDownloadCommand
		        from: mockHttpClient
		        track: 'pharo'
		        exercise: 'test-exercise') yourself.

		exercise := cmd execute.

		self assert: exercise notNil description: 'Get a result'.
		self assert: (exercise contentsFor: 'test1.st' ifAbsent: '') equals: 'Some source1'.
		self assert: (exercise contentsFor: 'test2.st' ifAbsent: '') equals: 'Some source2'.
	] 
	runWithMockSetup: [ 
		mockHttpClient := ExercismHttpClient asMock.
		mockReader := ExercismTonelReader asMock.

		baseUrl := 'http://data.io/res'.
		solutionData := ExercismSubmissionTest
			                sampleDataFor: 'test-exercise'
			                filenames: { 'test1.st'. 'test.md'. 'test2.st' }
			                baseUrl: baseUrl.

		mockHttpClient expect verifyToken atLeastOnce.
		(mockHttpClient expect
			 getLatestExercise: 'test-exercise'
			 for: 'pharo') willReturn: solutionData asJSON.

		(mockHttpClient expect getResource: Any) specifying: [ :resName :count | 
			resName should equal:
				(baseUrl , '/test{1}.st' format: count asString).
				'Some source', count printString ].

		(ExercismExercise stub find: Any ifAbsent: Any) willReturn:
			HelloWorldTest exercise.
		(ExercismTonelReader stub
			 on: (Instance of: FileReference)
			 fileName: 'Exercise@TestExercise') willReturn: mockReader.
		mockReader stub loadDefinitions willReturnYourself.
		mockReader stub definitions willReturn: #(  ) 
	]
]
