"
I'm responsible to provide Test runner functionality of Exercism.
I do following:
- import source files
- run tested exercise (based on name)
- output test cases run in resulting output json file (based on Exercism specification)

I expect following input:
- `slug-name` on my input - exercise name to run tests
- input directory with solution sources - input source will be imported
- output directory, whene results.json will be written

See api actions method: ExercismTestRunner>>testExercise:importSourcefrom:result:

"
Class {
	#name : #ExercismTestRunner,
	#superclass : #Object,
	#category : #'ExercismTools-Core'
}

{ #category : #private }
ExercismTestRunner >> findExercise: slugName [

	^ ExercismExercise find: slugName ifAbsent: [ ExDomainError signal: ('Could not find exercise: {1}.' format: { slugName }) ].
]

{ #category : #private }
ExercismTestRunner >> importSourceFilesfrom: importDirectory [
	| definitions |
	self validateDirectory: importDirectory.
	definitions := self loadSourceDefinitionsFrom: importDirectory.
	self validateDefinitions: definitions.
	[ 
		(MCSnapshot fromDefinitions: definitions) install 
	]
	on: Error
	do: 
	[ :ex | 
		ExDomainError signal: ('Error occured during loading sources from: {1}: {2}.' 		format: {importDirectory pathString. ex messageText }) 
	]
]

{ #category : #private }
ExercismTestRunner >> loadSourceDefinitionsFrom: inputDirectory [
	|tonelReader|
	tonelReader := TonelReader fromExerciseDirectory: inputDirectory.
	tonelReader loadDefinitions.
	^ tonelReader definitions
]

{ #category : #private }
ExercismTestRunner >> runTestsFor: testClass [

	^ [testClass suite run] on: Error do: [ExDomainError signal: ('Error occured during running tests on test class: {1}.' format: { testClass name})].
]

{ #category : #'api actions' }
ExercismTestRunner >> runTestsOnExercise: slugName importSourcefrom: inputDirectory result: outputDirectory [

	"this is Exercism test runner implementation - it will load exercise code and run tests, resulting in json file in output directory"
	|exercise testResult outputFile outputJson|

	[	
		exercise := self findExercise: slugName.
		self importSourceFilesfrom: inputDirectory.
		testResult := self runTestsFor: exercise testCase.
		testResult dispatchResultsIntoHistory.
		outputJson := STONJSONWriter streamContentsOf: testResult exercismTestRunnerData.
	] on: ExDomainError 
	do: [:domainError| outputJson := self setErrorToJson: domainError messageText ].
	
	outputFile := outputDirectory / 'results.json'.
	outputFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: outputJson  ]
]

{ #category : #'api actions' }
ExercismTestRunner >> setErrorToJson: domainErrorMsg [ 
	
	|jsonDict|
	jsonDict := TestResult new exercismTestRunnerData.
	jsonDict at: 'status' put: 'error'.
	jsonDict at: 'message' put: domainErrorMsg.
	^ STONJSONWriter streamContentsOf: jsonDict
]

{ #category : #private }
ExercismTestRunner >> validateDefinitions: definitionsColl [

	(definitionsColl anySatisfy: [:aDef | aDef isClassDefinition or: [ aDef isMethodDefinition ] ]) ifFalse: [ ExDomainError signal: 'No valid source files to be loaded.']
]

{ #category : #private }
ExercismTestRunner >> validateDirectory: importDirectory [

	importDirectory isDirectory ifFalse: [ ExDomainError signal: ('Directory does not exist: {1}.' format: { importDirectory pathString  }) ]
]
