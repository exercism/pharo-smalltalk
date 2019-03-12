"
An ExercismSubmissionTest is a test class for testing the behavior of ExercismSubmission
"
Class {
	#name : #ExercismSubmissionTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #tests }
ExercismSubmissionTest >> testIteratingThroughSourceCode [
	| submission actualNames i  expectedNames populateList baseUrl |
	
	actualNames := #('a.st' 'b.st' 'readme.md').
	expectedNames := actualNames first: 2.
	baseUrl := 'http://data.io/res'.
	
	submission := ExercismSubmission
		data: {
			('files' -> actualNames).
			(ExercismSubmission baseUrlKey -> baseUrl) } asDictionary.
		
	populateList := OrderedCollection new.
	
	submission populateFileContentWith: [ :filename |
		populateList add: filename.
		filename, ' contents' ].
	
	populateList should equal: (expectedNames collect: [:n | baseUrl exPathString, n ]).
	
	i := 0.
	submission
		sourceFilesDo: [ :name :contents | 
			i := i + 1.
			name should equal: (expectedNames at: i).
			contents should beginWith: baseUrl .
			contents should endWith: name, ' contents'  ].
		
	self assert: i = 2 description: 'Should only process code files'.
]
