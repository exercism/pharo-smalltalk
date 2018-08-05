"
In Smalltalk you can run code (including tests) with broken methods and
missing classes. When the VM encounters broken code, it raises a debugger
which lets you explore the problem a little better.  

You also have the option to press a button to create a missing class or method, as well as correct any code that causes an error. When you do
so, the debugger will backup and let you resume execution with your
new changes.

Try doing this with your HelloWorld example, by simply running the tests.
"
Class {
	#name : #HelloWorldTest,
	#superclass : #TestCase,
	#category : #'Exercism-HelloWorld'
}

{ #category : #tests }
HelloWorldTest >> testHello [
	self assert: HelloWorld sayHello equals: 'Hello, World!'
]
