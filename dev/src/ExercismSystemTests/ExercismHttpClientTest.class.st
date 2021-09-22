"
These are some ""manual"" system tests that try out a live HTTP connection to Exercism (and google).

These aren't meant to be automated, but give a smoke example to try out all the pieces and ensure our view of the returned Exercism data is valid.

Run these if you suspect that Exercism has changed its protocol in some way.
"
Class {
	#name : #ExercismHttpClientTest,
	#superclass : #TestCase,
	#category : #ExercismSystemTests
}

{ #category : #running }
ExercismHttpClientTest >> setUp [
	ExercismHttpClient hasToken ifFalse: [ ExercismHttpClient promptForToken ]
]

{ #category : #tests }
ExercismHttpClientTest >> testGenericGet [
	| client response |
	client := ExercismHttpClient newHost: 'duckduckgo.co.uk'.

	response := client getResource: '/' with: { ('q' -> 'pharo') }.

	self assert: response notNil description: 'unsuccessful request to duckduckgo.co.uk'.
	self
		assert: (response includesSubstring: 'pharo.org')
		description: 'could not find ''pharo.org'' in the response from duckduckgo.co.uk'
]

{ #category : #tests }
ExercismHttpClientTest >> testSolutionGet [
	"Test against Exercism and ensuring the result format is as expected"

	| client  downloadResult sourceCode  solution |
	
	client := ExercismHttpClient new.
		
	downloadResult := STON fromString: 
		(client getLatestExercise: HelloWorldTest exercise id for: ExercismManager trackId).
	
	self assert: downloadResult notNil description: 'Got a result'.
	self assert: (solution := downloadResult at: 'solution') notNil description: 'Got a solution'.
	
	self assert: ((solution at: 'files') includes: 'HelloWorldTest.class.st').
	
	sourceCode := client getResource: 
		(solution at: ExercismSubmission baseUrlKey), '/HelloWorldTest.class.st'.
	
	self assert: sourceCode notEmpty.
	self assert: (sourceCode includesSubstring: '#name : #HelloWorldTest').
	
	
		
]

{ #category : #tests }
ExercismHttpClientTest >> testSolutionPatch [
	"Test against Exercism and submit a solution: WARNING - this destroys your hello world test."

	| client  downloadResult submitId  |
	
	client := ExercismHttpClient new.
		
	downloadResult := STON fromString: 
		(client getLatestExercise: HelloWorldTest exercise id for: ExercismManager trackId).
	
	submitId := (downloadResult at: 'solution') at: 'id'.
	
	client
		patchSolution: submitId with: {
			'test1.txt'->'"some sample text"'.
			'test2.txt'->'"some more sample text"'} asOrderedDictionary.
			
	self assert: (#(201 400) includes: client responseCode) description: 'Invalid response code' 
		
]

{ #category : #'tests-unit' }
ExercismHttpClientTest >> testSolutionPathFor [
	"A unit test for ensuring the resource path is cleaned up safely"
	
	| client base |
	client := ExercismHttpClient new.
	base := ExercismHttpClient solutionPath.
	
	(client solutionPathFor: '/prefixed') should equal: base, '/prefixed'.
	(client solutionPathFor: 'prefixed') should equal: base, '/prefixed'.
		
	
]
