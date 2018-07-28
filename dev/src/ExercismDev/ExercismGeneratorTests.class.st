Class {
	#name : #ExercismGeneratorTests,
	#superclass : #TestCase,
	#category : #'ExercismDev-Tests'
}

{ #category : #tests }
ExercismGeneratorTests >> testGeneratorKebabCase [
	| generator |
	generator := ExercismGenerator.
	
	self assert: (generator kebabCase: 'HelloWorld') equals: 'hello-world'.
	self assert: (generator kebabCase: 'Hello') equals: 'hello'.
	self assert: (generator kebabCase: 'HelloMyWorld') equals: 'hello-my-world'.
	self assert: (generator kebabCase: 'X') equals: 'x'.
	self assert: (generator kebabCase: '') equals: ''.
]
