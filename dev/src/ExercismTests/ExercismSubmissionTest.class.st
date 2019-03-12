"
An ExercismSubmissionTest is a test class for testing the behavior of ExercismSubmission
"
Class {
	#name : #ExercismSubmissionTest,
	#superclass : #TestCase,
	#category : #ExercismTests
}

{ #category : #'test-data' }
ExercismSubmissionTest class >> sampleDataFor: testName [
	^self sampleDataFor: testName filenames: {'test1.st'. 'test.md'. 'test2.st'} baseUrl: '/files'
			
]

{ #category : #'test-data' }
ExercismSubmissionTest class >> sampleDataFor: testName filenames: filenameList baseUrl: baseUrl [

	^{ 
		'solution' ->> { 
			'files' -> filenameList.
			'exercise' ->> { 'id'-> testName }.
			'id' -> 'submission123'.
			ExercismSubmission baseUrlKey -> baseUrl } } asOrderedDictionary.
			
]

{ #category : #tests }
ExercismSubmissionTest >> testFilenames [
	| exercismSubmission |
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex').
		
	self assert: exercismSubmission submissionId equals: 'submission123'.
	self assert: exercismSubmission exerciseId equals: 'test-ex'.
	
		
]

{ #category : #tests }
ExercismSubmissionTest >> testIteratingThroughSourceCode [
	| submission actualNames i  expectedNames baseUrl |
	
	actualNames := #('a.st' 'b.st' 'readme.md').
	expectedNames := actualNames first: 2.
	baseUrl := 'http://data.io/res'.
	
	submission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: baseUrl).
		
	submission populateFileContentWith: [ :filename |
		filename, ' contents' ].
	
	i := 0.
	submission
		sourceFilesDo: [ :name :contents | 
			i := i + 1.
			name should equal: (expectedNames at: i).
			contents should beginWith: baseUrl .
			contents should endWith: name, ' contents'  ].
		
	self assert: i = 2 description: 'Should only process code files'.
]

{ #category : #tests }
ExercismSubmissionTest >> testPopulateFileContents [
	| actualNames baseUrl exercismSubmission rootName sourceNames |
	
	actualNames := #('a.st' 'b.st' 'readme.md').
	sourceNames := actualNames first: 2.
	baseUrl := 'http://data.io/res'.
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: baseUrl).
	
	exercismSubmission populateFileContentWith: [ :filename |
			filename should beginWith: baseUrl.
			rootName := filename allButFirst: baseUrl exPathString size.
			
			sourceNames should include: rootName.
			rootName, ' contents' ]. 	
	
	
	self assert: (exercismSubmission contentsFor: 'a.st') equals: 'a.st contents'.
	self assert: (exercismSubmission contentsFor: 'b.st') equals: 'b.st contents'.
]
