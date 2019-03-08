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
	| object actualNames i expectedSources expectedNames |
	
	actualNames := #('a.st' 'b.st' 'readme.md').
	expectedNames := actualNames first: 2.
	
	object := ExercismSubmission
		data: {('files' -> actualNames)} asDictionary.
		
	expectedSources := {
	('a.st' -> 'source a').
	('b.st' -> 'source b').
	('readme.md' -> 'readme more')} asDictionary.
	
	object files: expectedSources.
	i := 1.
	
	object
		sourceFilesDo: [ :name :contents | 
			self assert: name equals: (expectedNames at: i).
			self assert: contents equals: (expectedSources at: name).
			i := i + 1 ]
]
