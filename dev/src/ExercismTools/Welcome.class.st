"
To start your Exercism journey, right click on the Exercism package and select 'Exercism | Fetch  Next'
"
Class {
	#name : #Welcome,
	#superclass : #TestCase,
	#category : #'ExercismTools-Welcome'
}

{ #category : #tests }
Welcome >> testWelcome [
	"This is a sample Pharo test fixture"
	
	self assert: #('Welcome' 'to' 'Pharo') size equals: 3
]
