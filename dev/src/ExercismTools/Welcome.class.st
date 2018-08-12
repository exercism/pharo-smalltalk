"
To start your Exercism journey, right click on the Exercism package and select 'Exercism | Fetch  Exercise', and then type: hello-world
"
Class {
	#name : #Welcome,
	#superclass : #TestCase,
	#category : #'ExercismTools-Welcome'
}

{ #category : #tests }
Welcome >> testWelcome [
	"This is a sample Pharo test fixture. 
	NOTE: Refer to the Class comment for more information on getting started."
	
	self assert: #('Welcome' 'to' 'Pharo') size equals: 3
]
