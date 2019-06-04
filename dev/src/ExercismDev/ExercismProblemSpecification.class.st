"
Field names per https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/readmes.md#generating-a-readme

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	cases:		<Object>
	comments:		<Object>
	deprecated:		<Object>
	description:		<Object>
	exercise:		<Object>
	metaData:		<Object>
	mixedCaseName:		<Object>
	slug:		<Object>
	sourceFileRef:		<Object>
	testClassName:		<Object>
	testSpecifactions:		<Object>
	testVariable:		<Object>
	unhandled:		<Object>
	version:		<Object>


    Implementation Points
"
Class {
	#name : #ExercismProblemSpecification,
	#superclass : #Object,
	#instVars : [
		'sourceFileRef',
		'slug',
		'testClassName',
		'testVariable',
		'deprecated',
		'description',
		'metaData',
		'testSpecifactions',
		'exercise',
		'version',
		'comments',
		'cases',
		'unhandled',
		'canonicalData',
		'tests'
	],
	#classVars : [
		'LastPath',
		'ProblemSpecifications'
	],
	#category : #'ExercismDev-TestGenerator'
}

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> all [
	^ ProblemSpecifications ifNil: [ self loadAllFromDisk. ProblemSpecifications ]
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> allNeedingGeneration [
	^ self all reject: [ :spec | spec deprecated | spec hasBeenGenerated ]
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> cloneRepo [
	|builder|
	[	builder := IceRepositoryCreator new 
			url: self repoUrl;
			commitishName: 'master';
			yourself.
		builder createRepository.
	] on: IceDuplicatedRepository 
	  do: [ :error | "don nothing" ].
	^ builder locationToUse exists 
		ifTrue: [ (builder locationToUse / 'exercises') fullName ]
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> defaultSourcePath [
	|builder|
	[	builder := IceRepositoryCreator new 
			url: self repoUrl;
			commitishName: 'master';
			yourself.
		builder createRepository.
	] on: IceDuplicatedRepository 
	  do: [ :error | "don nothing" ].
	^ builder locationToUse exists 
		ifTrue: [ (builder locationToUse / 'exercises') fullName ]
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> lastPath [
	^ LastPath ifNil: [ LastPath := FileLocator home pathString]
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> lastPath: pathString [
	^ LastPath := pathString 
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> loadAllFromDisk [
	"This is the entry point for loading exercism problem specifications"
	| sourcePath |
	
	(self confirm: 'Clone and generate from default ''problem-specifications'' repo?' , String cr, self repoUrl)
		ifTrue:  [ sourcePath := self cloneRepo ].
	sourcePath ifNil: [ 	
		UIManager default
			chooseDirectory: 'Select source "problem-specifications/exercises" folder to read from'
			path: self lastPath.
		].

	self crLog: 'Loading problem specifications from: ', sourcePath.
	
	^ ProblemSpecifications := sourcePath asFileReference entries
		collect: [ :entry | ExercismProblemSpecification newFromFileRef: entry reference ].
		

]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> newFromFileRef: sourceFileReference [ 
	^ self new initializeSourceFile: sourceFileReference.
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> repoUrl [
	^ 'git@github.com:exercism/problem-specifications.git'
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> resetProblemSpecification [
	ProblemSpecifications := nil
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification class >> showAllProblemSpecifications [
	<example>
	(ExercismProblemSpecification loadAllFromDisk flatCollect: [ :p | p tests ]) inspect

]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> canonicalData [
	^ canonicalData
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> cases [
	^ cases
]

{ #category : #testing }
ExercismProblemSpecification >> classNameForSolution [
	^ self mixedCaseName
]

{ #category : #testing }
ExercismProblemSpecification >> classNameForTest [
	^ testClassName 
]

{ #category : #accessing }
ExercismProblemSpecification >> deprecated [
	^ deprecated
]

{ #category : #accessing }
ExercismProblemSpecification >> description [ 
	^ description
	
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> flattenCanonicalTestGroups [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> flattenTestGroup: testGroup [
	| labeledTests |
	labeledTests  := OrderedCollection new.
	testGroup do: [ :labeledTestItem |
		labeledTestItem "#/definitions/labeledTestItem"
			at: 'cases'
			ifPresent: [ :nextLevelTestGroup | "#/definitions/labeledTestGroup" 
				self flattenTestGroup: nextLevelTestGroup
				]
			ifAbsent: [ "#/definitions/labeledTest"
				labeledTests add: (ExercismLabeledTest new
					description: (labeledTestItem at: 'description'); "required"
					property: (labeledTestItem at: 'property'); "required"
					input: (labeledTestItem at: 'imput'); "required"
					expected: (labeledTestItem at: 'expected'); "required"
					comment: (labeledTestItem at: 'comment' ifAbsent: '')) "optional"
				] 
	]

]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> flattenTestGroup: testGroup path: groupPath [
	| labeledTests |
	labeledTests  := OrderedCollection new.
	testGroup do: [ :labeledTestItem |
		labeledTestItem "#/definitions/labeledTestItem"
			at: 'cases'
			ifPresent: [ :nextLevel | |nextLevelPath| "#/definitions/labeledTestGroup" 
				nextLevelPath := groupPath , { (labeledTestItem at: 'description') -> (labeledTestItem at: 'comments' ifAbsent: {}) }.
				labeledTests addAll: (self flattenTestGroup: nextLevel path: nextLevelPath).  
				]
			ifAbsent: [ "#/definitions/labeledTest"
				labeledTests add: (ExercismLabeledTest new
					description: (labeledTestItem at: 'description'); "required"
					property: (labeledTestItem at: 'property'); "required"
					input: (labeledTestItem at: 'input'); "required"
					expected: (labeledTestItem at: 'expected'); "required"
					comment: (labeledTestItem at: 'comment' ifAbsent: ''); "optional"
					groupPath: groupPath "extra";
					exercise: self
					)
				] 
	].	
	^labeledTests 

]

{ #category : #testing }
ExercismProblemSpecification >> hasBeenGenerated [
		^ Smalltalk hasClassNamed: testClassName 
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> hasCanonicalData [
	^ canonicalData isNotNil
]

{ #category : #initialization }
ExercismProblemSpecification >> initializeSourceFile: aFileReference [
	| canonicalString canonicalDataTemp |
	sourceFileRef := aFileReference.
	slug := sourceFileRef basename.
	testClassName := self mixedCaseName, 'Test'.
	testVariable := (self mixedCaseName, 'Calculator') asValidSelector asString.
	
	deprecated := sourceFileRef fileNames includes: '.deprecated'.
	
	description := (sourceFileRef / 'description.md') contents.
	
	metaData := Dictionary new.
	((sourceFileRef / 'metadata.yml') contents copyWithoutAll: '"')
		linesDo: [ :line | |tokens| 
			tokens := line findTokens: ':'.
			tokens size > 1 ifTrue: [ metaData at: tokens first put: tokens second trimBoth ].
			].
	canonicalString := [ (sourceFileRef / 'canonical-data.json') contents] 
		on: FileDoesNotExistException do: [ ^ self crLog: testClassName , ' has no specification (skipping)' ].
	canonicalDataTemp := STONJSON fromString: canonicalString.
	canonicalData := canonicalDataTemp copy.
	tests := self flattenTestGroup: (canonicalData at: 'cases') path: { }.
	exercise := canonicalDataTemp removeKey: 'exercise'.
	version := canonicalDataTemp removeKey: 'version'.
	comments := canonicalDataTemp removeKey: 'comments' ifAbsent: [''].
	cases := canonicalDataTemp removeKey: 'cases'.
	unhandled := canonicalDataTemp.

]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> loadCanonicalData [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> metaDataString [
	self shouldBeImplemented.
]

{ #category : #'problem-specification' }
ExercismProblemSpecification >> mixedCaseName [ 
	^ '' join: ((slug splitOn: $-) collect: [ :w | w capitalized ])
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> parseCanonicalData [
	tests := self flattenTestGroup: (canonicalData at: 'cases') path: { }
]

{ #category : #printing }
ExercismProblemSpecification >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	slug printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
ExercismProblemSpecification >> slug [
	^slug
]

{ #category : #'problem-specification' }
ExercismProblemSpecification >> snakeCaseName [
	^ slug copyReplaceAll: '-' with: '_'
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> testClassName [
	^ testClassName
]

{ #category : #'problem-specification' }
ExercismProblemSpecification >> testVariable [
	^ testVariable
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> tests [
	^ tests ifNil: [ { } ]
]

{ #category : #'as yet unclassified' }
ExercismProblemSpecification >> version [
	^ version
]

{ #category : #'problem-specification' }
ExercismProblemSpecification >> wordifiedName [ 
	^ ' ' join: ((slug splitOn: $-) collect: [ :w | w capitalized ])
]
