"
To start your Exercism journey, right click on the Exercism package and select 'Fetch Exercism'
"
Class {
	#name : #Welcome,
	#superclass : #TestCase,
	#category : #'ExercismDev-Welcome'
}

{ #category : #tests }
Welcome >> testWelcome [
	"This is a sample Pharo test fixture"
	
	self assert: #('Welcome' 'to' 'Pharo') size equals: 3
]
