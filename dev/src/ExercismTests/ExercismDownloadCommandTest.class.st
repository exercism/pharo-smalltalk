Class {
	#name : #ExercismDownloadCommandTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismDownloadCommandTest >> prepareMockPackageWithDependentClasses [

|aClass bClass cClass|

aClass := Object subclass: #AMock
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Exercise@DependencyMock'.

bClass := Object subclass: #BMock
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Exercise@DependencyMock'.

cClass := Object subclass: #CMock
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Exercise@DependencyMock'.	

aClass compile: 'mockMethod ^ BMock mockMethod'.
bClass compile: 'mockMethod ^ CMock mockMethod'.
cClass compile: 'mockMethod ^ ''Call from class: '', self class name'
]

{ #category : #tests }
ExercismDownloadCommandTest >> testExecuteDownloading [

	| cmd exercise solutionData mockHttpClient mockParser mockClass baseUrl sourceCode |
	
	Any strictMocks: false.
	mockHttpClient := ExercismHttpClient asMock.
	mockParser := TonelParser asMock.
	
	(ExercismExercise stub find: Any ifAbsent: Any) willReturn: HelloWorldTest exercise.
	
	[  
	cmd := (ExercismDownloadCommand
				from: mockHttpClient track: 'pharo' exercise: 'test-exercise')
					parser: mockParser;
					yourself.
	
	exercise := cmd execute.
	
	self assert: exercise notNil description: 'Get a result'.
	
	sourceCode := exercise contentsFor: 'test1.st' ifAbsent: [''].
	self assert: sourceCode equals: 'Some source1'
	
	] runWithMockSetup: [  
	
	baseUrl := 'http://data.io/res'.
	solutionData := ExercismSubmissionTest 
				sampleDataFor: 'test-exercise' 
				filenames: {'test1.st'. 'test.md'. 'test2.st'} 
				baseUrl: baseUrl.
	
	mockHttpClient expect verifyToken atLeastOnce.
	(mockHttpClient expect getLatestExercise: 'test-exercise' for: Any) 
		willReturn: solutionData asJSON.
		
	(mockHttpClient expect getResource: Any)  
		specifying: [ :resName :count | 
			resName should equal: (baseUrl,'/test{1}.st' format: count asString).
			'Some source', count printString ].
		
	mockClass := Class asMock.
	
	(mockParser expect documentFrom: Any)
		specifying: [ :contents :count |  
			contents should endWith: count printString.
			{ mockClass } ].
		
	mockClass expect load exactly: 2.
		
	].
	
		
]
