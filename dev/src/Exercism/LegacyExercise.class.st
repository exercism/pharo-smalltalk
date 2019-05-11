"
This is a placeholder to test Legacy Exercises that were tags
"
Class {
	#name : #LegacyExercise,
	#superclass : #TestCase,
	#category : #'Exercism-LegacyExercise'
}

{ #category : #config }
LegacyExercise class >> followedBy [ 
	^'HelloWorld'
]

{ #category : #tests }
LegacyExercise >> testWelcome [
	"This is a sample Pharo test fixture. 
	
	TIP 1: Try running this test by clicking on the gray orb next to the method name above.
	TIP 2: Click to the class Comment tab for more information on getting started."
	
	self assert: #('Welcome' 'to' 'Pharo') size equals: 3
]
