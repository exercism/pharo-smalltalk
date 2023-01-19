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
ExercismTestRunner >> runTestsFor: testClass [

	^ [testClass suite run] on: Error do: [ExDomainError signal: ('Error occured during running tests on test class: {1}.' format: { testClass name})].
]

{ #category : #'api actions' }
ExercismTestRunner >> runTestsOnExercise: slugName importSourcefrom: inputDirectory result: outputDirectory [

	"this is Exercism test runner implementation - it will load exercise code and run tests, resulting in json file in output directory"
	|exercise testResult outputFile outputJson|

	exercise := self findExercise: slugName.
	testResult := self runTestsFor: exercise testCase.
	testResult dispatchResultsIntoHistory.
	
	outputFile := outputDirectory / 'results.json'.
		
	outputJson := STONJSONWriter streamContentsOf: testResult exercismTestRunnerData.
	
	outputFile 
		ensureDelete; 
		writeStreamDo: [ :stream |
		 	stream nextPutAll: outputJson  ]
]
