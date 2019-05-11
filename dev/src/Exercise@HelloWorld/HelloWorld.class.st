"
This is a sample solution for Exercism students.

Of interest in this example is that classes in Pharo are singleton objects in their own right, and can have methods that can be called on them like any other object in the system.
"
Class {
	#name : #HelloWorld,
	#superclass : #Object,
	#category : #'Exercise@HelloWorld'
}

{ #category : #example }
HelloWorld class >> sayHello [
	^ 'Hello, World!'
]
