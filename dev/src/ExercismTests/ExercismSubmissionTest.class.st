"
An ExercismSubmissionTest is a test class for testing the behavior of ExercismSubmission
"
Class {
	#name : 'ExercismSubmissionTest',
	#superclass : 'TestCase',
	#category : 'ExercismTests-UnitTests',
	#package : 'ExercismTests',
	#tag : 'UnitTests'
}

{ #category : 'private' }
ExercismSubmissionTest class >> mockSnapshotSTON [
^	'MCSnapshot {
	#definitions : OrderedCollection [
		MCOrganizationDefinition {
			#categories : [
				#''Exercise@DependencyMock''
			]
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethod ^ BMock mockMethod'',
			#category : #''as yet unclassified'',
			#selector : #mockMethod,
			#className : #AMock
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethod ^ CMock mockMethod'',
			#category : #''as yet unclassified'',
			#selector : #mockMethod,
			#className : #BMock
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethod ^ \''Call from class: \'', self class name'',
			#category : #''as yet unclassified'',
			#selector : #mockMethod,
			#className : #CMock
		},
		MCClassDefinition {
			#name : #AMock,
			#superclassName : #BMock,
			#variables : OrderedCollection [ ],
			#category : #''Exercise@DependencyMock'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		},
		MCClassDefinition {
			#name : #CMock,
			#superclassName : #Object,
			#variables : OrderedCollection [ ],
			#category : #''Exercise@DependencyMock'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		},
		MCClassDefinition {
			#name : #BMock,
			#superclassName : #CMock,
			#variables : OrderedCollection [ ],
			#category : #''Exercise@DependencyMock'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		}
	],
	#classDefinitionCache : {
		#AMock : @8,
		#CMock : @10,
		#BMock : @12
	}
}'
]

{ #category : 'tests' }
ExercismSubmissionTest class >> prepareMockPackageWithDependentClasses [
" this is used for generating STON representation of MCSnapshot (see class side method), we don't need to create classes during test"
|aClass bClass cClass aPackage|

	cClass := Object subclass: #CMock
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Exercise@DependencyMock'.
		
	bClass := (self class environment at: #CMock) subclass: #BMock
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Exercise@DependencyMock'.

	aClass := (self class environment at: #BMock) subclass: #AMock
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Exercise@DependencyMock'.

	aClass compile: 'mockMethod ^ BMock mockMethod'.
	bClass compile: 'mockMethod ^ CMock mockMethod'.
	cClass compile: 'mockMethod ^ ''Call from class: '', self class name'.

	aPackage := RPackageOrganizer default packageNamed: 'Exercise@DependencyMock'.
	^ TonelWriter new toSTON: aPackage snapshot.
]

{ #category : 'test-data' }
ExercismSubmissionTest class >> sampleDataFor: testName [
	^self sampleDataFor: testName filenames: {'test1.st'. 'test.md'. 'test2.st'} baseUrl: '/files'
			
]

{ #category : 'test-data' }
ExercismSubmissionTest class >> sampleDataFor: testName filenames: filenameList baseUrl: baseUrl [

	^{ 
		'solution' ->> { 
			'files' -> filenameList.
			'exercise' ->> { 'id'-> testName }.
			'id' -> 'submission123'.
			ExercismSubmission baseUrlKey -> baseUrl } } asOrderedDictionary.
			
]

{ #category : 'tests' }
ExercismSubmissionTest >> mockClassesSnapshot [

	^ STON fromString: self class mockSnapshotSTON
]

{ #category : 'tests' }
ExercismSubmissionTest >> prepareMockContentData [
	"prepareContentData in expected dictionary format"

	|memoryFileRef contentData|
	memoryFileRef := FileSystem memory root.
	(TonelWriter on: memoryFileRef) writeSnapshot: self mockClassesSnapshot.
	
	"Remove the package file as its not needed for Exercism"
	(memoryFileRef / 'Exercise@DependencyMock' / 'package.st') delete.
	contentData := memoryFileRef allFiles collect: [:sourceFile |
		sourceFile basename -> sourceFile contents
	 ].

	^ contentData asDictionary
]

{ #category : 'running' }
ExercismSubmissionTest >> tearDown [ 
	|aPackage|
	aPackage := RPackageOrganizer default packageNamed: 'Exercise@DependencyMock' ifAbsent: [nil].
	aPackage ifNotNil: [ aPackage removeFromSystem].
	super tearDown
]

{ #category : 'tests' }
ExercismSubmissionTest >> testErrorMessage [

	| exercismSubmission |
	exercismSubmission := ExercismSubmission error: 'an error'.
	
	self deny: exercismSubmission isValid description: 'Should not be valid'.	
	self assert: exercismSubmission errorMessage equals: 'an error'.
	
]

{ #category : 'tests' }
ExercismSubmissionTest >> testExerciseClassName [

	| exercismSubmission |
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-exercise').
		
	self assert: exercismSubmission exerciseClassName equals: 'TestExercise'.
]

{ #category : 'tests' }
ExercismSubmissionTest >> testExercisePackageName [

	| exercismSubmission |
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'hello-world').
		
	self assert: exercismSubmission exercisePackageName equals: 'Exercise@HelloWorld'.
]

{ #category : 'tests' }
ExercismSubmissionTest >> testFilenames [
	| exercismSubmission actualNames |
		
	actualNames := #('a.st' 'b.st' 'readme.md').
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: '/baseUrl').
		
	self assert: exercismSubmission filenames equals: actualNames.
	
	
		
]

{ #category : 'tests' }
ExercismSubmissionTest >> testLatestExercisePackageSourceDir [
	
	| exercismSubmission fileRef firstFile sndFile|
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'exercism-mock').
	exercismSubmission contentData: ({ 'filename1' -> 'contents' . 'filename2' -> 'contents2' } asDictionary).
	fileRef := exercismSubmission latestExercisePackageSourceDir.
	
	"test if Memory file reference is created with hiearchy: Package dir -> sourceFiles"
	self assert: fileRef isDirectory.
	self deny: (fileRef directoriesMatching: exercismSubmission exercisePackageName) isEmpty.
	firstFile := fileRef allFiles first.
	self assert: firstFile basename equals: 'filename1'.
	self assert: firstFile contents equals: 'contents'.
	sndFile := fileRef allFiles second.
	self assert: sndFile basename equals: 'filename2'.
	self assert: sndFile contents equals: 'contents2'.
]

{ #category : 'tests' }
ExercismSubmissionTest >> testLoadingDependentClasses [
	| exercismSubmission loadedPackage|
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'dependency-mock').
		
	"prepare dependent classes from mock snapshot"
	exercismSubmission contentData: self prepareMockContentData.

	"this will effectively load dependent classes"
	exercismSubmission installDefinitionsFromSnapshot.
	loadedPackage := RPackageOrganizer default packageNamed: #'Exercise@DependencyMock' ifAbsent: [nil].
	self deny: loadedPackage isNil.
	self assert: (loadedPackage includesClassNamed: #AMock).
	self assert: (loadedPackage includesClassNamed: #BMock).
	self assert: (loadedPackage includesClassNamed: #CMock).
	
	"test hiearchy dependencies"
	self assert:	((self class environment at: #BMock) inheritsFrom: (self class environment at: #CMock)).
		self assert:	((self class environment at: #AMock) inheritsFrom: (self class environment at: #BMock)).
]

{ #category : 'tests' }
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

{ #category : 'tests' }
ExercismSubmissionTest >> testPopulateFileContentsWithSkipsEmptyContent [
	"Test populating content"
	| actualNames baseUrl exercismSubmission rootName sourceNames |

	actualNames := #('empty.st' 'readme.md').
	sourceNames := actualNames first: 2.
	baseUrl := 'http://data.io/res'.

	exercismSubmission := ExercismSubmission
		data: (self class	sampleDataFor: 'test-ex' filenames: actualNames baseUrl: baseUrl).

	exercismSubmission
		populateFileContentsWith: [ :filename | 
			filename should beginWith: baseUrl.
			rootName := filename allButFirst: baseUrl exPathString size.
			sourceNames should include: rootName.
			rootName , ' contents'.
			nil].
		
	self
		assert: exercismSubmission contentData size equals: 0.
]

{ #category : 'tests' }
ExercismSubmissionTest >> testSourceFilenames [
	| exercismSubmission actualNames |
		
	actualNames := #('a.st' 'b.st' 'readme.md').
	
	exercismSubmission := ExercismSubmission
		data: (self class sampleDataFor: 'test-ex' filenames: actualNames baseUrl: '/baseUrl').
		
	self assert: exercismSubmission sourceFilenames equals: actualNames allButLast.
	
	
		
]

{ #category : 'tests' }
ExercismSubmissionTest >> testSourceFilenamesWithContentsDo [
	| exercismSubmission resultingNames |
	
	exercismSubmission := ExercismSubmission new contentData: ({ 'filename1' -> 'contents' . 'filename2' -> 'contents' } asDictionary).
	resultingNames := OrderedCollection new.
	exercismSubmission sourceFilenamesWithContentsDo: [ :name :contents | resultingNames add: name , contents ].
	
	self assertCollection: resultingNames asArray equals: #('filename1contents' 'filename2contents').
	
	
		
]

{ #category : 'tests' }
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
