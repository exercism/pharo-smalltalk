"
To start your Exercism journey, right click on the Exercise@Welcome package (or use the top level Exercism menu) and select 'Exercism | Fetch new exercise', and then type: hello-world.

Note: Each exercise will have some instructions in its test Comment tab, so be sure to read them when starting a new challenge.
"
Class {
	#name : 'WelcomeTest',
	#superclass : 'TestCase',
	#category : 'Exercise@Welcome',
	#package : 'Exercise@Welcome'
}

{ #category : 'config' }
WelcomeTest class >> followedBy [ 
	^'HelloWorld'
]

{ #category : 'tests' }
WelcomeTest >> testWelcome [
	"This is a sample Pharo test fixture. 
	
	TIP 1: Try running this test by clicking on the gray orb next to the method name above.
	TIP 2: Click to the class Comment tab for more information on getting started."
	
	self assert: #('Welcome' 'to' 'Pharo') size equals: 3
]
