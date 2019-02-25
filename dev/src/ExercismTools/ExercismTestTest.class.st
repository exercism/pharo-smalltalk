Class {
	#name : #ExercismTestTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #tests }
ExercismTestTest >> testFollowedBy [
	
	self assert: HelloWorldTest followedBy equals: 'ReverseString'.
	self assert: AcronymTest followedBy equals: 'Leap'.
]

{ #category : #tests }
ExercismTestTest >> testSlug [
	self assert: ExercismTest slug equals: 'exercism'.
	self assert: HelloWorldTest slug equals: 'hello-world'
]

{ #category : #tests }
ExercismTestTest >> testWordifiedName [
	self assert: ExercismTest wordifiedName equals: 'Exercism'.
	self assert: HelloWorldTest wordifiedName equals: 'Hello World'
]
