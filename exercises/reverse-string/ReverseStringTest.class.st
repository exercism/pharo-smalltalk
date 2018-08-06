"
While there is a #reversed method for Strings, can you figure out how to do this with lower level iteration or streams? 

Pharo has a neat code finder tool, press Shift-Enter  to activate it.


"
Class {
	#name : #ReverseStringTest,
	#superclass : #TestCase,
	#instVars : [
		'reverser'
	],
	#category : #'Exercism-ReverseString'
}

{ #category : #tests }
ReverseStringTest >> setUp [
	reverser := ReverseString new
]

{ #category : #tests }
ReverseStringTest >> testCapitalisedWorld [
	self
		assert: (reverser reverse: 'Ramen')
		equals: 'nemaR'
	
]

{ #category : #tests }
ReverseStringTest >> testEmptyString [
	self
		assert: (reverser reverse: '')
		equals: ''
]

{ #category : #tests }
ReverseStringTest >> testSentenceWithPunctuation [
	self
		assert: (reverser reverse: 'I''m hungry!')
		equals: '!yrgnuh m''I'
	
]

{ #category : #tests }
ReverseStringTest >> testSingleWorld [
	self
		assert: (reverser reverse: 'robot')
		equals: 'tobor'
]

{ #category : #tests }
ReverseStringTest >> testWithPalindrome [
	self
		assert: (reverser reverse: 'racecar')
		equals: 'racecar'

]
