"
To start your Exercism journey, right click on the Exercism package and select 'Exercism | Fetch  Exercise', and then type: hello-world.

Note: Each new exercise will have some instructions in its test Comment, so be sure to read them when starting a new challenge.
"
Class {
	#name : #Welcome,
	#superclass : #TestCase,
	#category : #'ExercismTools-Welcome'
}

{ #category : #config }
Welcome class >> followedBy [ 
	^'HelloWorld'
]

{ #category : #tests }
Welcome >> testWelcome [
	"This is a sample Pharo test fixture. 
	
	TIP 1: Try running this test by clicking on the gray orb next to the method name above.
	TIP 2: Click to the class Comment tab for more information on getting started."
	
	self assert: #('Welcome' 'to' 'Pharo') size equals: 3
]
