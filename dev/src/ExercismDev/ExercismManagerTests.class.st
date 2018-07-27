Class {
	#name : #ExercismManagerTests,
	#superclass : #TestCase,
	#category : #'ExercismDev-Tests'
}

{ #category : #tests }
ExercismManagerTests >> testManagerProcessParsing [
	| result |
	result := ExercismManager parseExercismFetchString: 
		'Not Submitted:          1 problem
python (Reverse String) /Users/macta/Dev/Exercism/pharo/reverse-string

New:                    1 problem
python (Reverse String) /Users/macta/Dev/Exercism/pharo/reverse-string

unchanged: 0, updated: 0, new: 1
'.
	self assert: result equals: 'reverse-string'
]
