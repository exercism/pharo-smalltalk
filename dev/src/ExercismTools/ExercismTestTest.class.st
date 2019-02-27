Class {
	#name : #ExercismTestTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Tests'
}

{ #category : #tests }
ExercismTestTest >> testFollowedBy [
	
	self assert: HelloWorldTest followedBy equals: 'Leap'.
	
]

{ #category : #tests }
ExercismTestTest >> testHintText [
	self assert: ExercismTest hintText equals: ''.
	self assert: (HelloWorldTest hintText beginsWith: 'If you are')
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
