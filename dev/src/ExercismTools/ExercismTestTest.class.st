Class {
	#name : #ExercismTestTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #tests }
ExercismTestTest >> testVerifySelectorUsageDetection [
	self
		should: [ ExercismTest new
				verifySolution: ExercismTestTest
				avoidsSelector: #assert:equals: ]
		raise: TestFailure
		description: 'Should signal a TestFailure for detected selector usage'
]
