Class {
	#name : #ExercismDownloadCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #tests }
ExercismDownloadCommandTest >> testExecuteDownloading [
	"Easy test for the first two steps of ExercismDownload>>execute since they don't mutate the system.
	TODO: Further test required for installing the exercise (while avoiding conflicts and cleaning up after)"

	| cmd downloadResult sourceCode solutionData fileContents mockHttpClient mockParser mockClass baseUrl |
	
	baseUrl := 'http://data.io/res'.
	solutionData := { 
		'exercise' ->> { 'id'-> '12345'}. 
		'solution' ->> { 
			'files' -> {'test1.st'. 'test.md'. 'test2.st'}.
			#submissionId -> 'testId'.
			ExercismSubmission baseUrlKey -> baseUrl } } asOrderedDictionary.
			
	fileContents := 'Some source'.
	
	mockHttpClient := Mock new.
	(mockHttpClient expect verifyToken).
	(mockHttpClient expect getLatestExercise: 'test-world' for: 'pharo') 
		willReturn: solutionData exJSON.
	(mockHttpClient expect getResource: Any)  
		specifying: [ :res :count | 
			res should equal: (baseUrl,'/test{1}.st' format: count asString).
			fileContents, count printString ].
		
	mockParser := Mock new.
	mockClass := Mock new.
	
	(mockParser expect documentFrom: Any)
		specifying: [ :contents :count |  
			contents should endWith: count printString.
			{ mockClass } ].
	
	(cmd := ExercismDownloadCommand
				from: mockHttpClient track: 'pharo' exercise: 'test-world')
					parser: mockParser.
		
	downloadResult := cmd execute. 
	
	mockHttpClient should receive verifyToken once.
	mockClass should receive load twice.
	
	self assert: downloadResult notNil description: 'Get a result'.
	self assert: downloadResult submissionId equals: 'testId'.
	
	self assert: (downloadResult includesFilename: 'test1.st').
	
	sourceCode := downloadResult contentsFor: 'test1.st'.
	self assert: sourceCode notEmpty.
	self assert: sourceCode equals: 'Some source1'
		
]
