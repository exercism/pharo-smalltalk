Class {
	#name : #ExercismManagerTests,
	#superclass : #TestCase,
	#category : #'ExercismDev-Tests'
}

{ #category : #tests }
ExercismManagerTests >> testManagerProcessParsing [
	| result |
	result := ExercismManager parseExercismFetchString: 
		'Downloaded to
/Users/demo/Exercism/pharo/rna-transcription
'.
	self assert: result equals: 'rna-transcription'
]
