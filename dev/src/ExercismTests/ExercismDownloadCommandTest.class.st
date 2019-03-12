Class {
	#name : #ExercismDownloadCommandTest,
	#superclass : #TestCase,
	#category : #ExercismTests
}

{ #category : #tests }
ExercismDownloadCommandTest >> testExecuteDownloading [

	| cmd downloadResult solutionData mockHttpClient mockParser mockClass baseUrl sourceCode |
	
	baseUrl := 'http://data.io/res'.
	solutionData := ExercismSubmissionTest 
				sampleDataFor: 'test-name' 
				filenames: {'test1.st'. 'test.md'. 'test2.st'} 
				baseUrl: baseUrl.
	
	mockHttpClient := Mock new.
	
	mockHttpClient expect verifyToken specifying: [  ].
	(mockHttpClient expect getLatestExercise: 'test-world' for: 'pharo') 
		willReturn: solutionData exJSON.
		
	(mockHttpClient expect getResource: Any)  
		specifying: [ :res :count | 
			res should equal: (baseUrl,'/test{1}.st' format: count asString).
			'Some source', count printString ].
		
	mockParser := Mock new.
	mockClass := Mock new.
	
	(mockParser expect documentFrom: Any)
		specifying: [ :contents :count |  
			contents should endWith: count printString.
			{ mockClass } ].
	
	cmd := (ExercismDownloadCommand
				from: mockHttpClient track: 'pharo' exercise: 'test-world')
					parser: mockParser;
					yourself.
		mockHttpClient doSomething.
	downloadResult := cmd execute. 
	
	mockHttpClient should receive verifyToken once.
	mockClass should receive load twice.
	
	self assert: downloadResult notNil description: 'Get a result'.
	
	sourceCode := downloadResult contentsFor: 'test1.st'.
	self assert: sourceCode equals: 'Some source1'
		
]
