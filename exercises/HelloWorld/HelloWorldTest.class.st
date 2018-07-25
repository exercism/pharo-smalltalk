"A sample test to kickstart the track"

Class {
	#name : #HelloWorldTest,
	#superclass : #TestCase,
	#category : #'Exercism-HelloWorld'
}

{ #category : #tests }
HelloWorldTest >> testSayHello [
	self assert: HelloWorld sayHello equals: 'Hello, World!'
]
