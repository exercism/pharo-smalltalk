"
An ExercismSubmissionTest is a test class for testing the behavior of ExercismSubmission
"
Class {
	#name : #ExercismSubmissionTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
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

{ #category : #test }
ExercismSubmissionTest >> testExerciseClassName [

	| exercismSubmission |
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-exercise').
		
	self assert: exercismSubmission exerciseClassName equals: 'TestExercise'.
]

{ #category : #tests }
ExercismSubmissionTest >> testFilenames [
	| exercismSubmission actualNames |
		
	actualNames := #('a.st' 'b.st' 'readme.md').
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: '/baseUrl').
		
	self assert: exercismSubmission filenames equals: actualNames.
	
	
		
]

{ #category : #tests }
ExercismSubmissionTest >> testPopulateFileContentsWith [
	"Test populating content"
	| actualNames baseUrl exercismSubmission rootName sourceNames |

	actualNames := #('a.st' 'b.st' 'readme.md').
	sourceNames := actualNames first: 2.
	baseUrl := 'http://data.io/res'.

	exercismSubmission := ExercismSubmission
		data: (self class	sampleDataFor: 'test-ex' filenames: actualNames baseUrl: baseUrl).

	exercismSubmission
		populateFileContentsWith: [ :filename | 
			filename should beginWith: baseUrl.
			rootName := filename allButFirst: baseUrl exPathString size.
			sourceNames should include: rootName.
			rootName , ' contents' ].
		
	self
		assert: (exercismSubmission contentsFor: 'a.st' ifAbsent: [ '' ])
		equals: 'a.st contents'.
	self
		assert: (exercismSubmission contentsFor: 'b.st' ifAbsent: [ '' ])
		equals: 'b.st contents'
]

{ #category : #tests }
ExercismSubmissionTest >> testSourceFilenames [
	| exercismSubmission actualNames |
		
	actualNames := #('a.st' 'b.st' 'readme.md').
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: '/baseUrl').
		
	self assert: exercismSubmission sourceFilenames equals: actualNames allButLast.
	
	
		
]

{ #category : #tests }
ExercismSubmissionTest >> testSourceFilenamesWithContentsDo [
	| exercismSubmission actualNames expectedNames resultingNames |
		
	actualNames := #('a.st' 'readme.md' 'b.st').
	expectedNames := actualNames copyWithout: 'readme.md'.
	resultingNames := OrderedCollection new.
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: '/baseUrl').
	
	exercismSubmission sourceFilenamesWithContentsDo: [ :name :contents | resultingNames add: name ].
	
	self assertCollection: resultingNames asArray equals: expectedNames.
	
	
		
]

{ #category : #tests }
ExercismSubmissionTest >> testStoreSolutionId [
	| exercismSubmission |
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-exercise').
		
	exercismSubmission storeSolutionId.
	
	self assert: exercismSubmission solutionId equals: 'submission123'.
	self assert: TestExerciseTest solutionId equals: 'submission123'.
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'missing-exercise').
	
	exercismSubmission storeSolutionId.
	self deny: exercismSubmission isValid description: 'Should be invalid with missing data'.
	
	
		
]
