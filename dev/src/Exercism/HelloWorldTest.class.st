"
# Hello World

The classical introductory exercise. Just say ""Hello, World!"".

[""Hello, World!""](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) is
the traditional first program for beginning programming in a new language
or environment.

The objectives are simple:

- Write a function that returns the string ""Hello, World!"".
- Run the test suite and make sure that it succeeds.
- Submit your solution and check it at the website.

If everything goes well, you will be ready to fetch your first real exercise

## Hint

If you are editting this file in a text editor and not in Pharo - 
please review the [Getting Started](https://exercism.io/tracks/pharo/installation) section. 

While you can use a text editor, the Pharo IDE is partly what makes the langauge so special.

In Pharo you can run code (including tests) with broken methods and missing classes.  When the VM encounters broken code, it raises a debugger which lets you explore the problem a little better.  

You then have the option to press the Create button to add a missing class or method, as well as correct any code that causes an error. When you do so, the debugger will backup and let you resume execution with your new changes.

Try doing this with your HelloWorld example, by simply running any one of the unit test methods.
"
Class {
	#name : #HelloWorldTest,
	#superclass : #ExercismTest,
	#category : #'Exercism-HelloWorld'
}

{ #category : #config }
HelloWorldTest class >> autoApprove [ 
	^true
]

{ #category : #config }
HelloWorldTest class >> core [
	"Answer a Boolean, true is this is a core exercise"
	
	^true
]

{ #category : #config }
HelloWorldTest class >> difficulty [
	^1
]

{ #category : #helper }
HelloWorldTest class >> followedBy [
	"If this is a core exercise, answer the next one that follows otherwise nil (if not a core exercise, or the last one)"
	
	^'Leap'
]

{ #category : #config }
HelloWorldTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('introduction')
]

{ #category : #config }
HelloWorldTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^nil 
]

{ #category : #config }
HelloWorldTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a1812b5e-2788-4ea6-b948-bfe54edeb0da'
]

{ #category : #config }
HelloWorldTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^'1.1.0'  
]

{ #category : #testing }
HelloWorldTest >> testHello [
	self assert: HelloWorld sayHello equals: 'Hello, World!'
]
