Class {
	#name : #ExercismReviewCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #running }
ExercismReviewCommandTest >> tearDown [
	"all known mock mutations should be recovered"
	ExercismExercise recoverFromGHMutation.
	TonelReader recoverFromGHMutation.
	super tearDown
]

{ #category : #tests }
ExercismReviewCommandTest >> testExecuteReview [

	| cmd aReview solutionData mockHttpClient mockReader baseUrl |
	Any strictMocks: false.

	[ 
		cmd := ExercismReviewCommand
		        from: mockHttpClient
		        reviewId: '12345'.

		aReview := cmd execute.

		self assert: aReview notNil description: 'Get a result'.

		self assert: (aReview submission contentsFor: 'test1.st' ifAbsent: '') equals: 'Some source1'.
		self assert: (aReview submission contentsFor: 'test2.st' ifAbsent: '') equals: 'Some source2'.
		
		self assert: aReview codeSnapshot definitions isEmpty description: 'Review should contain empty code snapshot'.
	] 
	runWithMockSetup: [ 
		mockHttpClient := ExercismHttpClient asMock.
		mockReader := TonelReader asMock.

		baseUrl := 'http://data.io/res'.
		solutionData := ExercismSubmissionTest
			                sampleDataFor: 'test-exercise'
			                filenames: { 'test1.st'. 'test.md'. 'test2.st' }
			                baseUrl: baseUrl.

		mockHttpClient expect verifyToken atLeastOnce.
		(mockHttpClient expect
			 getSpecifiedExercise: '12345'
		) willReturn: solutionData asJSON.

		(mockHttpClient expect getResource: Any) specifying: [ :resName :count | 
			resName should equal:
				(baseUrl , '/test{1}.st' format: count asString).
				'Some source', count printString ].

		(ExercismExercise stub find: Any ifAbsent: Any) willReturn:
			HelloWorldTest exercise.
		(TonelReader stub
			 on: (Instance of: FileReference)
			 fileName: 'Exercise@TestExercise') willReturn: mockReader.
		mockReader stub loadDefinitions willReturnYourself.
		mockReader stub definitions willReturn: #(  ) 
	]
]
